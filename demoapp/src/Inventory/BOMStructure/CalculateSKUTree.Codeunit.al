namespace Weibel.Inventory.BOM.Tree;

using Microsoft.Manufacturing.Setup;
using Microsoft.Inventory.Costing;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.Planning;
using Microsoft.Inventory.BOM;
using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Manufacturing.Routing;
using Microsoft.Foundation.UOM;
using Microsoft.Manufacturing.StandardCost;
using Microsoft.Inventory.Setup;

codeunit 70178 "COL Calculate SKU Tree"
{
    var
        ManufacturingSetup: Record "Manufacturing Setup";
        InventorySetup: Record "Inventory Setup";
        TempSKU: Record "Stockkeeping Unit" temporary;
        MfgCostCalcMgt: Codeunit "Mfg. Cost Calculation Mgt.";
        GetPlanningParameters: Codeunit "Planning-Get Parameters";
        TreeType: Option " ",Availability,Cost;
        EntryNo: Integer;
        NoStructureErr: Label 'SKU needs to be for an assembly item or have %1 or %2 specified.', Comment = '%1 = field caption; %2 = field caption';

    procedure OpenSKUStructure(var StockkeepingUnit: Record "Stockkeeping Unit")
    var
        BOMStructure: Page "BOM Structure";
    begin
        if not SKUHasStructure(StockkeepingUnit) then
            Error(NoStructureErr, StockkeepingUnit.FieldCaption("Production BOM No."), StockkeepingUnit.FieldCaption("Routing No."));

        BOMStructure.COLInitFromSKU(StockkeepingUnit);
        BOMStructure.Run();
    end;

    procedure OpenSKUStructure(var Item: Record Item)
    var
        StockkeepingUnit: Record "Stockkeeping Unit";
        NoOfSKUs, SelectedSKU, Counter, SuggestedOption : Integer;
        SKUsBuilder: TextBuilder;
        ListOfSKUs: List of [Guid];
        InstructionLbl: Label 'Select SKU for which the structure should be shown';
        MenuOptionLbl: Label 'Variant: %1 - Location: %2', Comment = '%1 = variant code; %2 = location code';
    begin
        StockkeepingUnit.SetRange("Item No.", Item."No.");
        NoOfSKUs := StockkeepingUnit.Count();
        case NoOfSKUs of
            0:
                StockkeepingUnit.FindFirst(); // throw an error
            1:
                begin
                    StockkeepingUnit.FindFirst();
                    OpenSKUStructure(StockkeepingUnit);
                end;
            else begin
                GetManufacturingSetup();
                Counter := 0;
                SuggestedOption := 0;
                if StockkeepingUnit.FindSet() then
                    repeat
                        if Counter > 0 then
                            SKUsBuilder.Append(',');
                        Counter += 1;
                        SKUsBuilder.Append(StrSubstNo(MenuOptionLbl, StockkeepingUnit."Variant Code", StockkeepingUnit."Location Code"));
                        ListOfSKUs.Add(StockkeepingUnit.SystemId);
                        if SuggestedOption = 0 then
                            if (ManufacturingSetup."COL Def.Loc. for BOM Structure" <> '') and (ManufacturingSetup."COL Def.Loc. for BOM Structure" = StockkeepingUnit."Location Code") then
                                SuggestedOption := Counter;
                    until StockkeepingUnit.Next() = 0;

                if SuggestedOption = 0 then
                    SuggestedOption := 1;

                SelectedSKU := StrMenu(SKUsBuilder.ToText(), SuggestedOption, InstructionLbl);

                if SelectedSKU > 0 then begin
                    StockkeepingUnit.GetBySystemId(ListOfSKUs.Get(SelectedSKU));
                    OpenSKUStructure(StockkeepingUnit);
                end
            end;
        end;

    end;

    local procedure SKUHasStructure(var StockkeepingUnit: Record "Stockkeeping Unit"): Boolean
    begin
        StockkeepingUnit.CalcFields("Assembly BOM");
        if StockkeepingUnit."Assembly BOM" then
            exit(true);

        if (StockkeepingUnit."Production BOM No." <> '') or (StockkeepingUnit."Routing No." <> '') then
            exit(true);
    end;

    procedure GenerateTree(ItemNo: Code[20]; VariantCode: Code[10]; LocationCode: Code[10]; var BOMBuffer: Record "BOM Buffer" temporary)
    var
        SKU: Record "Stockkeeping Unit";
    begin
        if LocationCode = '' then begin
            GetManufacturingSetup();
            ManufacturingSetup.TestField("COL Def.Loc. for BOM Structure");
            LocationCode := ManufacturingSetup."COL Def.Loc. for BOM Structure";
        end;
        SKU.Get(LocationCode, ItemNo, VariantCode);
        GenerateTree(SKU, BOMBuffer);
    end;

    procedure GenerateTree(SKU: Record "Stockkeeping Unit"; var BOMBuffer: Record "BOM Buffer" temporary)
    var
        SKUManualEvents: Codeunit "COL SKU Manual Events";
    begin
        InitBOMBuffer(BOMBuffer);
        // SKU.TestField("Production BOM No.");

        TreeType := TreeType::" ";

        BOMBuffer.COLTransferFromSKU(EntryNo, SKU, WorkDate());
        BindSubscription(SKUManualEvents);
        GenerateItemSubTree(SKU, BOMBuffer);
        UnbindSubscription(SKUManualEvents);
    end;

    local procedure GenerateItemSubTree(SKU: Record "Stockkeeping Unit"; var BOMBuffer: Record "BOM Buffer"): Boolean
    var
        ParentSKU: Record "Stockkeeping Unit";
    begin
        if TempSKU.Get(SKU."Location Code", SKU."Item No.", SKU."Variant Code") then begin
            BOMBuffer."Is Leaf" := false;
            BOMBuffer.Modify(true);
            exit(false);
        end;
        if not ParentSKU.Get(SKU."Location Code", SKU."Item No.", SKU."Variant Code") then
            GetPlanningParameters.AtSKU(ParentSKU, SKU."Item No.", SKU."Variant Code", SKU."Location Code");

        TempSKU := ParentSKU;
        TempSKU.Insert();

        if ParentSKU."Replenishment System" = ParentSKU."Replenishment System"::"Prod. Order" then begin
            BOMBuffer."Is Leaf" := not GenerateProdCompSubTree(ParentSKU, BOMBuffer);
            if BOMBuffer."Is Leaf" then
                BOMBuffer."Is Leaf" := not GenerateBOMCompSubTree(ParentSKU, BOMBuffer);
        end else begin
            BOMBuffer."Is Leaf" := not GenerateBOMCompSubTree(ParentSKU, BOMBuffer);
            if BOMBuffer."Is Leaf" then
                BOMBuffer."Is Leaf" := not GenerateProdCompSubTree(ParentSKU, BOMBuffer);
        end;
        BOMBuffer.Modify(true);

        TempSKU.Get(SKU."Location Code", SKU."Item No.", SKU."Variant Code");
        TempSKU.Delete();
        exit(not BOMBuffer."Is Leaf");
    end;

    local procedure GenerateProdCompSubTree(ParentSKU: Record "Stockkeeping Unit"; var BOMBuffer: Record "BOM Buffer") FoundSubTree: Boolean
    var
        CopyOfParentSKU: Record "Stockkeeping Unit";
        ProdBOMLine: Record "Production BOM Line";
        RoutingLine: Record "Routing Line";
        ParentBOMBuffer: Record "BOM Buffer";
        ParentItem: Record Item;
        Item: Record Item;
        ProdBOMLineSKU: Record "Stockkeeping Unit";
        UOMMgt: Codeunit "Unit of Measure Management";
        VersionMgt: Codeunit VersionManagement;
        LotSize: Decimal;
        BomQtyPerUom: Decimal;
        IsHandled: Boolean;
        RunIteration: Boolean;
    begin
        ParentBOMBuffer := BOMBuffer;
        if not ProdBOMLine.ReadPermission then
            exit;
        ProdBOMLine.SetRange("Production BOM No.", ParentSKU."Production BOM No.");
        ProdBOMLine.SetRange("Version Code", VersionMgt.GetBOMVersion(ParentSKU."Production BOM No.", WorkDate(), true));
        ProdBOMLine.SetFilter("Starting Date", '%1|..%2', 0D, ParentBOMBuffer."Needed by Date");
        ProdBOMLine.SetFilter("Ending Date", '%1|%2..', 0D, ParentBOMBuffer."Needed by Date");
        IsHandled := false;
        // OnBeforeFilterByQuantityPer(ProdBOMLine, IsHandled, ParentBOMBuffer);
        // if not IsHandled then
        //     if TreeType = TreeType::Availability then
        //         ProdBOMLine.SetFilter("Quantity per", '>%1', 0);
        if ProdBOMLine.FindSet() then begin
            if ParentSKU."Replenishment System" <> ParentSKU."Replenishment System"::"Prod. Order" then begin
                FoundSubTree := true;
                // OnGenerateProdCompSubTreeOnBeforeExitForNonProdOrder(ParentItem, BOMBuffer, FoundSubTree);
                exit(FoundSubTree);
            end;
            repeat
                IsHandled := false;
                // OnBeforeTransferProdBOMLine(BOMBuffer, ProdBOMLine, ParentItem, ParentBOMBuffer, EntryNo, TreeType, IsHandled);
                if not IsHandled then
                    if ProdBOMLine."No." <> '' then
                        case ProdBOMLine.Type of
                            ProdBOMLine.Type::Item:
                                begin
                                    Item.Get(ParentSKU."Item No.");
                                    // BOMBuffer.SetLocationVariantFiltersFrom(ItemFilter);
                                    BomQtyPerUom :=
                                    GetQtyPerBOMHeaderUnitOfMeasure(
                                        Item, ParentBOMBuffer."Production BOM No.",
                                        VersionMgt.GetBOMVersion(ParentBOMBuffer."Production BOM No.", WorkDate(), true));

                                    BOMBuffer.COLTransferFromProdCompSKU(
                                        EntryNo, ProdBOMLine, ParentBOMBuffer.Indentation + 1,
                                        Round(
                                            ParentBOMBuffer."Qty. per Top Item" *
                                            UOMMgt.GetQtyPerUnitOfMeasure(Item, ParentBOMBuffer."Unit of Measure Code"), UOMMgt.QtyRndPrecision()),
                                        Round(
                                            ParentBOMBuffer."Scrap Qty. per Top Item" *
                                            UOMMgt.GetQtyPerUnitOfMeasure(Item, ParentBOMBuffer."Unit of Measure Code"), UOMMgt.QtyRndPrecision()),
                                        ParentBOMBuffer."Scrap %", CalcCompDueDate(ParentBOMBuffer."Needed by Date", ParentSKU, ProdBOMLine."Lead-Time Offset"),
                                        ParentBOMBuffer."Location Code", ParentSKU, BomQtyPerUom);

                                    if ParentSKU."Production BOM No." <> ParentBOMBuffer."Production BOM No." then begin
                                        BOMBuffer."Qty. per Parent" := BOMBuffer."Qty. per Parent" * ParentBOMBuffer."Qty. per Parent";
                                        BOMBuffer."Scrap Qty. per Parent" := BOMBuffer."Scrap Qty. per Parent" * ParentBOMBuffer."Qty. per Parent";
                                        BOMBuffer."Qty. per BOM Line" := BOMBuffer."Qty. per BOM Line" * ParentBOMBuffer."Qty. per Parent";
                                    end;
                                    // OnAfterTransferFromProdItem(BOMBuffer, ProdBOMLine, EntryNo);
                                    if not ProdBOMLineSKU.Get(ParentSKU."Location Code", ProdBOMLine."No.", ProdBOMLine."Variant Code") then
                                        GetPlanningParameters.AtSKU(ProdBOMLineSKU, ProdBOMLine."No.", ProdBOMLine."Variant Code", ParentSKU."Location Code");
                                    GenerateItemSubTree(ProdBOMLineSKU, BOMBuffer);
                                    // OnGenerateProdCompSubTreeOnAfterGenerateItemSubTree(ParentBOMBuffer, BOMBuffer);
                                end;
                            ProdBOMLine.Type::"Production BOM":
                                begin
                                    // OnBeforeTransferFromProdBOM(BOMBuffer, ProdBOMLine, ParentItem, ParentBOMBuffer, EntryNo, TreeType);

                                    BOMBuffer := ParentBOMBuffer;
                                    BOMBuffer."Qty. per Top Item" := Round(BOMBuffer."Qty. per Top Item" * ProdBOMLine."Quantity per", UOMMgt.QtyRndPrecision());
                                    if ParentSKU."Production BOM No." <> ParentBOMBuffer."Production BOM No." then
                                        BOMBuffer."Qty. per Parent" := ParentBOMBuffer."Qty. per Parent" * ProdBOMLine."Quantity per"
                                    else
                                        BOMBuffer."Qty. per Parent" := ProdBOMLine."Quantity per";

                                    BOMBuffer."Scrap %" := CombineScrapFactors(BOMBuffer."Scrap %", ProdBOMLine."Scrap %");
                                    if MfgCostCalcMgt.FindRoutingLine(RoutingLine, ProdBOMLine, WorkDate(), ParentSKU."Routing No.") then
                                        BOMBuffer."Scrap %" := CombineScrapFactors(BOMBuffer."Scrap %", RoutingLine."Scrap Factor % (Accumulated)" * 100);
                                    BOMBuffer."Scrap %" := Round(BOMBuffer."Scrap %", 0.00001);

                                    // OnAfterTransferFromProdBOM(BOMBuffer, ProdBOMLine);

                                    CopyOfParentSKU := ParentSKU;
                                    ParentSKU."Routing No." := '';
                                    ParentSKU."Production BOM No." := ProdBOMLine."No.";
                                    GenerateProdCompSubTree(ParentSKU, BOMBuffer);
                                    ParentSKU := CopyOfParentSKU;

                                    // OnAfterGenerateProdCompSubTree(ParentItem, BOMBuffer, ParentBOMBuffer);
                                end;
                        end;
            // OnGenerateProdCompSubTreeOnAfterProdBOMLineLoop(ParentBOMBuffer, BOMBuffer);
            until ProdBOMLine.Next() = 0;
            FoundSubTree := true;
        end;

        ParentItem.Get(ParentSKU."Item No.");
        if RoutingLine.ReadPermission then
            if (TreeType in [TreeType::" ", TreeType::Cost]) and
                   RoutingLine.CertifiedRoutingVersionExists(ParentSKU."Routing No.", WorkDate())
            then begin
                repeat
                    RunIteration := RoutingLine."No." <> '';
                    // OnGenerateProdCompSubTreeOnBeforeRoutingLineLoop(RoutingLine, BOMBuffer, RunIteration);
                    if RunIteration then begin
                        // BOMBuffer.SetLocationVariantFiltersFrom(ItemFilter);
                        BOMBuffer.TransferFromProdRouting(
                          EntryNo, RoutingLine, ParentBOMBuffer.Indentation + 1,
                          ParentBOMBuffer."Qty. per Top Item" *
                          UOMMgt.GetQtyPerUnitOfMeasure(ParentItem, ParentBOMBuffer."Unit of Measure Code"),
                          ParentBOMBuffer."Needed by Date",
                          ParentBOMBuffer."Location Code");
                        // OnAfterTransferFromProdRouting(BOMBuffer, RoutingLine);
                        if TreeType = TreeType::Cost then begin
                            LotSize := ParentBOMBuffer."Lot Size";
                            if LotSize = 0 then
                                if ParentBOMBuffer."Qty. per Top Item" <> 0 then
                                    LotSize := ParentBOMBuffer."Qty. per Top Item"
                                else
                                    LotSize := 1;
                            CalcRoutingLineCosts(RoutingLine, LotSize, ParentBOMBuffer."Scrap %", BOMBuffer);
                            BOMBuffer.RoundCosts(
                              ParentBOMBuffer."Qty. per Top Item" *
                              UOMMgt.GetQtyPerUnitOfMeasure(ParentItem, ParentBOMBuffer."Unit of Measure Code") / LotSize);
                            // OnGenerateProdCompSubTreeOnBeforeBOMBufferModify(BOMBuffer, ParentBOMBuffer, ParentItem);
                            BOMBuffer.Modify();
                        end;
                        // OnGenerateProdCompSubTreeOnAfterBOMBufferModify(BOMBuffer, RoutingLine, LotSize, ParentItem, ParentBOMBuffer, TreeType);
                    end;
                until RoutingLine.Next() = 0;
                FoundSubTree := true;
            end;

        BOMBuffer := ParentBOMBuffer;
    end;

    local procedure GenerateBOMCompSubTree(ParentSKU: Record "Stockkeeping Unit"; var BOMBuffer: Record "BOM Buffer"): Boolean
    var
        BOMComp: Record "BOM Component";
        BOMCompSKU: Record "Stockkeeping Unit";
        ParentBOMBuffer: Record "BOM Buffer";
        ParentItem: Record Item;
        UOMMgt: Codeunit "Unit of Measure Management";
        IsHandled: Boolean;
    begin
        ParentBOMBuffer := BOMBuffer;
        BOMComp.SetRange("Parent Item No.", ParentSKU."Item No.");
        if BOMComp.FindSet() then begin
            if ParentSKU."Replenishment System" <> ParentSKU."Replenishment System"::Assembly then
                exit(true);

            IsHandled := false;
            // OnGenerateBOMCompSubTreeOnBeforeLoopBOMComponents(ParentSKU, IsHandled);
            if IsHandled then
                exit(true);
            repeat
                if (BOMComp."No." <> '') and ((BOMComp.Type = BOMComp.Type::Item) or (TreeType in [TreeType::" ", TreeType::Cost])) then begin
                    // BOMBuffer.SetLocationVariantFiltersFrom(ItemFilter);                    
                    BOMBuffer.COLTransferFromBOMCompSKU(
                      EntryNo, BOMComp, ParentBOMBuffer.Indentation + 1,
                      Round(
                        ParentBOMBuffer."Qty. per Top Item" *
                        UOMMgt.GetQtyPerUnitOfMeasure(ParentItem, ParentBOMBuffer."Unit of Measure Code"), UOMMgt.QtyRndPrecision()),
                      Round(
                        ParentBOMBuffer."Scrap Qty. per Top Item" *
                        UOMMgt.GetQtyPerUnitOfMeasure(ParentItem, ParentBOMBuffer."Unit of Measure Code"), UOMMgt.QtyRndPrecision()),
                      CalcCompDueDate(ParentBOMBuffer."Needed by Date", ParentSKU, BOMComp."Lead-Time Offset"),
                      ParentBOMBuffer."Location Code");
                    if BOMComp.Type = BOMComp.Type::Item then begin
                        BOMCompSKU.Get(ParentSKU."Location Code", BOMComp."No.", BOMComp."Variant Code");
                        GenerateItemSubTree(BOMCompSKU, BOMBuffer);
                    end;
                end;
            until BOMComp.Next() = 0;
            BOMBuffer := ParentBOMBuffer;
            exit(true);
        end;
    end;

    local procedure CalcCompDueDate(DemandDate: Date; ParentSKU: Record "Stockkeeping Unit"; LeadTimeOffset: DateFormula) DueDate: Date
    var
        EndDate: Date;
        StartDate: Date;
    begin
        if DemandDate = 0D then
            exit;

        GetManufacturingSetup();
        GetInventorySetup();

        EndDate := DemandDate;
        if Format(ParentSKU."Safety Lead Time") <> '' then
            EndDate := DemandDate - (CalcDate(ParentSKU."Safety Lead Time", DemandDate) - DemandDate)
        else
            if Format(InventorySetup."Default Safety Lead Time") <> '' then
                EndDate := DemandDate - (CalcDate(InventorySetup."Default Safety Lead Time", DemandDate) - DemandDate);

        if Format(ParentSKU."Lead Time Calculation") = '' then
            StartDate := EndDate
        else
            StartDate := EndDate - (CalcDate(ParentSKU."Lead Time Calculation", EndDate) - EndDate);

        if Format(LeadTimeOffset) = '' then
            DueDate := StartDate
        else
            DueDate := StartDate - (CalcDate(LeadTimeOffset, StartDate) - StartDate);
    end;

    local procedure GetQtyPerBOMHeaderUnitOfMeasure(Item: Record Item; ProdBOMNo: Code[20]; ProdBOMVersionNo: Code[20]): Decimal
    var
        UOMMgt: Codeunit "Unit of Measure Management";
    begin
        if ProdBOMNo = '' then
            exit(1);

        exit(UOMMgt.GetQtyPerUnitOfMeasure(Item, GetBOMUnitOfMeasure(ProdBOMNo, ProdBOMVersionNo)));
    end;

    local procedure GetBOMUnitOfMeasure(ProdBOMNo: Code[20]; ProdBOMVersionNo: Code[20]): Code[10]
    var
        ProdBOMHeader: Record "Production BOM Header";
        ProdBOMVersion: Record "Production BOM Version";
    begin
        if ProdBOMVersionNo <> '' then begin
            ProdBOMVersion.Get(ProdBOMNo, ProdBOMVersionNo);
            exit(ProdBOMVersion."Unit of Measure Code");
        end;

        ProdBOMHeader.Get(ProdBOMNo);
        exit(ProdBOMHeader."Unit of Measure Code");
    end;

    local procedure CombineScrapFactors(LowLevelScrapPct: Decimal; HighLevelScrapPct: Decimal): Decimal
    begin
        exit(LowLevelScrapPct + HighLevelScrapPct + LowLevelScrapPct * HighLevelScrapPct / 100);
    end;

    local procedure CalcRoutingLineCosts(RoutingLine: Record "Routing Line"; LotSize: Decimal; ScrapPct: Decimal; var BOMBuffer: Record "BOM Buffer")
    var
        CalcStdCost: Codeunit "Calculate Standard Cost";
        CapCost: Decimal;
        SubcontractedCapCost: Decimal;
        CapOverhead: Decimal;
    begin
        // OnBeforeCalcRoutingLineCosts(RoutingLine, LotSize, ScrapPct, ParentItem);

        CalcStdCost.SetProperties(WorkDate(), false, false, false, '', false);
        CalcStdCost.CalcRtngLineCost(
        //   RoutingLine, MfgCostCalcMgt.CalcQtyAdjdForBOMScrap(LotSize, ScrapPct), CapCost, SubcontractedCapCost, CapOverhead, ParentItem);
            RoutingLine, MfgCostCalcMgt.CalcQtyAdjdForBOMScrap(LotSize, ScrapPct), CapCost, SubcontractedCapCost, CapOverhead);

        // OnCalcRoutingLineCostsOnBeforeBOMBufferAdd(RoutingLine, LotSize, ScrapPct, CapCost, SubcontractedCapCost, CapOverhead, BOMBuffer);

        BOMBuffer.AddCapacityCost(CapCost, CapCost);
        BOMBuffer.AddSubcontrdCost(SubcontractedCapCost, SubcontractedCapCost);
        BOMBuffer.AddCapOvhdCost(CapOverhead, CapOverhead);
    end;

    local procedure GetManufacturingSetup()
    begin
        ManufacturingSetup.GetRecordOnce();
    end;

    local procedure GetInventorySetup()
    begin
        InventorySetup.GetRecordOnce();
    end;

    local procedure InitBOMBuffer(var BOMBuffer: Record "BOM Buffer" temporary)
    begin
        BOMBuffer.Reset();
        BOMBuffer.DeleteAll();
        EntryNo := 0;
    end;
}