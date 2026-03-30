namespace Weibel.Inventory.BOM;

using Microsoft.Inventory.Location;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Manufacturing.Setup;
using Microsoft.Inventory.BOM;
using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.Routing;
using Microsoft.Manufacturing.MachineCenter;
using Microsoft.Manufacturing.Capacity;
using Microsoft.Manufacturing.WorkCenter;

codeunit 70224 "COL Gen. BOM Structure"
{
    var
        ManufacturingSetup: Record "Manufacturing Setup";
        TempProductionBOMHeader: Record "Production BOM Header" temporary;
        TempRoutingHeader: Record "Routing Header" temporary;
        WorkCenterUoMDict: Dictionary of [Code[20], Code[10]];
        WorkCenterCalPrecisionDict: Dictionary of [Code[20], Decimal];
        Window: Dialog;
        ProgressTxt: Label 'Preparing structure entries: #1#\Checking lines: #2#', Comment = '%1 = no. of lines; %2 = no. of lines checked';
        ProgressUpdate: DateTime;

    procedure GetBomDataForSKU(var SKU: Record "Stockkeeping Unit"; var TempBOMStructure: Record "COL BOM Structure" temporary)
    begin
        InitProgressDialog();
        FillOutBOM(SKU, TempBOMStructure, 0, '');
        CloseProgressDialog();
    end;

    procedure GenerateBOMStructure(var SKU: Record "Stockkeeping Unit")
    var
        TempBOMStructure: Record "COL BOM Structure" temporary;
        TempBOMStructureWarning: Record "COL BOM Structure Warning" temporary;
        BOMStructurePage: Page "COL BOM Structure";
    begin
        InitProgressDialog();
        FillOutBOM(SKU, TempBOMStructure, 0, '');
        LogWarnings(TempBOMStructure, TempBOMStructureWarning);
        CloseProgressDialog();
        BOMStructurePage.SetData(SKU, TempBOMStructure, TempBOMStructureWarning);
        BOMStructurePage.Run();
    end;

    procedure GenerateBOMStructure(var Item: Record Item)
    var
        SKU: Record "Stockkeeping Unit";
        NoOfSKUs, Counter, SuggestedOption, SelectedSKU : Integer;
        DefaultLocationCode: Code[10];
        SKUsBuilder: TextBuilder;
        ListOfSKUs: List of [Guid];
        InstructionLbl: Label 'Select SKU for which the structure should be shown';
        MenuOptionLbl: Label 'Variant: %1 - Location: %2', Comment = '%1 = variant code; %2 = location code';
    begin
        SKU.SetRange("Item No.", Item."No.");
        NoOfSKUs := SKU.Count();
        case NoOfSKUs of
            0:
                SKU.FindFirst(); // throw an error
            1:
                begin
                    SKU.FindFirst();
                    GenerateBOMStructure(SKU);
                end;
            else begin
                DefaultLocationCode := GetDefaultLocationCode();
                Counter := 0;
                SuggestedOption := 0;
                if SKU.FindSet() then
                    repeat
                        if Counter > 0 then
                            SKUsBuilder.Append(',');
                        Counter += 1;
                        SKUsBuilder.Append(StrSubstNo(MenuOptionLbl, SKU."Variant Code", SKU."Location Code"));
                        ListOfSKUs.Add(SKU.SystemId);
                        if SuggestedOption = 0 then
                            if (DefaultLocationCode <> '') and (DefaultLocationCode = SKU."Location Code") then
                                SuggestedOption := Counter;
                    until SKU.Next() = 0;

                if SuggestedOption = 0 then
                    SuggestedOption := 1;

                SelectedSKU := StrMenu(SKUsBuilder.ToText(), SuggestedOption, InstructionLbl);

                if SelectedSKU > 0 then begin
                    SKU.GetBySystemId(ListOfSKUs.Get(SelectedSKU));
                    GenerateBOMStructure(SKU);
                end
            end;
        end;
    end;

    local procedure FillOutBOM(var SKU: Record "Stockkeeping Unit"; var TempBOMStructure: Record "COL BOM Structure" temporary; QtyPer: Decimal; ProductionBOMNo: Code[20])
    begin
        case SKU."Replenishment System" of
            Enum::"Replenishment System"::" ", Enum::"Replenishment System"::Purchase, Enum::"Replenishment System"::Transfer:
                AddItemLine(SKU, TempBOMStructure, QtyPer, ProductionBOMNo);
            Enum::"Replenishment System"::Assembly, Enum::"Replenishment System"::"Prod. Order":
                ExplodeLine(SKU, TempBOMStructure, QtyPer);
        end;
    end;

    local procedure AddItemLine(var SKU: Record "Stockkeeping Unit"; var TempBOMStructure: Record "COL BOM Structure" temporary; QtyPer: Decimal; ProductionBOMNo: Code[20])
    begin
        InitNewLine(TempBOMStructure);
        TempBOMStructure.Type := Enum::"COL BOM Element Type"::Item;
        TempBOMStructure."No." := SKU."Item No.";
        TempBOMStructure."Variant Code" := SKU."Variant Code";
        TempBOMStructure."Location Code" := SKU."Location Code";
        TempBOMStructure."Qty. per Parent" := QtyPer;
        TempBOMStructure.CopyFromItemVariant();
        TempBOMStructure.CopyFromSKU(SKU);
        TempBOMStructure."Is Leaf" := true;
        if ProductionBOMNo <> '' then
            TempBOMStructure."Production BOM No." := ProductionBOMNo;
        TempBOMStructure.Insert();
    end;

    local procedure ExplodeLine(var SKU: Record "Stockkeeping Unit"; var TempBOMStructure: Record "COL BOM Structure" temporary; QtyPer: Decimal)
    var
        PhantomBOM: Boolean;
    begin
        InitNewLine(TempBOMStructure);
        case SKU."Replenishment System" of
            SKU."Replenishment System"::"Prod. Order":
                if SKU."Production BOM No." = '' then begin
                    TempBOMStructure.Type := Enum::"COL BOM Element Type"::Item;
                    TempBOMStructure."No." := SKU."Item No.";
                    TempBOMStructure."Variant Code" := SKU."Variant Code";
                    TempBOMStructure."Location Code" := SKU."Location Code";
                    TempBOMStructure."Production BOM No." := '';
                    TempBOMStructure.CopyFromItemVariant();
                    TempBOMStructure.CopyFromSKU(SKU);
                    TempBOMStructure."Qty. per Parent" := QtyPer;
                    TempBOMStructure.Insert();
                end else begin
                    PhantomBOM := IsPhantomBOM(SKU."Production BOM No.");
                    if PhantomBOM or (SKU."Item No." = '') then begin // item no. is empty when line comes from a bom line which is another bom
                        TempBOMStructure.Type := Enum::"COL BOM Element Type"::"Production BOM";
                        TempBOMStructure."No." := SKU."Production BOM No.";
                        TempBOMStructure."Phantom BOM" := true;
                        TempBOMStructure."Production BOM No." := SKU."Production BOM No.";
                        TempBOMStructure.CopyFromProductionBOM(SKU."Production BOM No.");
                        TempBOMStructure.CopyFromSKU(SKU);
                        TempBOMStructure."Qty. per Parent" := QtyPer;
                        TempBOMStructure."Phantom BOM" := PhantomBOM;
                        TempBOMStructure.Insert();
                    end else begin
                        TempBOMStructure.Type := Enum::"COL BOM Element Type"::Item;
                        TempBOMStructure."No." := SKU."Item No.";
                        TempBOMStructure."Variant Code" := SKU."Variant Code";
                        TempBOMStructure."Location Code" := SKU."Location Code";
                        TempBOMStructure."Production BOM No." := SKU."Production BOM No.";
                        TempBOMStructure.CopyFromItemVariant();
                        TempBOMStructure.CopyFromSKU(SKU);
                        TempBOMStructure."Qty. per Parent" := QtyPer;
                        TempBOMStructure.Insert();
                    end;
                    ExplodeProdBOMLines(SKU, TempBOMStructure);
                end;

            SKU."Replenishment System"::Assembly:
                begin
                    TempBOMStructure.Type := Enum::"COL BOM Element Type"::Assembly;
                    TempBOMStructure."No." := SKU."Item No.";
                    TempBOMStructure."Variant Code" := SKU."Variant Code";
                    TempBOMStructure."Location Code" := SKU."Location Code";
                    TempBOMStructure.CopyFromItemVariant();
                    TempBOMStructure.CopyFromSKU(SKU);
                    TempBOMStructure."Qty. per Parent" := QtyPer;
                    TempBOMStructure.Insert();
                    ExplodeAssemblyLines(SKU, TempBOMStructure);
                end;
        end;
    end;

    local procedure ExplodeProdBOMLines(var SKU: Record "Stockkeeping Unit"; var TempBOMStructure: Record "COL BOM Structure" temporary)
    var
        ProductionBOMLine: Record "Production BOM Line";
        ComponentSKU, ProdBOMSKU : Record "Stockkeeping Unit";
        Indentation: Integer;
    begin
        if SKU."Production BOM No." = '' then
            exit;

        Indentation := TempBOMStructure.Indentation + 1;

        ComponentSKU.ReadIsolation := IsolationLevel::ReadUncommitted;

        ProductionBOMLine.ReadIsolation := IsolationLevel::ReadUncommitted;
        ProductionBOMLine.SetLoadFields("No.", Type, "Variant Code", "Quantity per", Description);
        ProductionBOMLine.SetRange("Production BOM No.", SKU."Production BOM No.");
        ProductionBOMLine.SetRange("Version Code", '');
        ProductionBOMLine.SetFilter("No.", '<>%1', '');
        ProductionBOMLine.SetFilter(Type, '<>%1', Enum::"Production BOM Line Type"::" ");

        if ProductionBOMLine.FindSet() then
            repeat
                TempBOMStructure.Indentation := Indentation;
                case ProductionBOMLine.Type of
                    Enum::"Production BOM Line Type"::Item:
                        begin
                            if not ComponentSKU.Get(GetDefaultLocationCode(), ProductionBOMLine."No.", ProductionBOMLine."Variant Code") then begin
                                ComponentSKU.Init();
                                ComponentSKU."Location Code" := GetDefaultLocationCode();
                                ComponentSKU."Item No." := ProductionBOMLine."No.";
                                ComponentSKU."Variant Code" := ProductionBOMLine."Variant Code";
                            end;
                            ComponentSKU.Description := ProductionBOMLine.Description;
                            FillOutBOM(ComponentSKU, TempBOMStructure, ProductionBOMLine."Quantity per", ProductionBOMLine."Production BOM No.");
                        end;
                    Enum::"Production BOM Line Type"::"Production BOM":
                        begin
                            ProdBOMSKU.Init();
                            ProdBOMSKU."Production BOM No." := ProductionBOMLine."No.";
                            ProdBOMSKU."Replenishment System" := Enum::"Replenishment System"::"Prod. Order";
                            ProdBOMSKU.Description := ProductionBOMLine.Description;
                            ExplodeLine(ProdBOMSKU, TempBOMStructure, ProductionBOMLine."Quantity per");
                        end;
                end;
            until ProductionBOMLine.Next() = 0;

        TempBOMStructure.Indentation := Indentation;
        AddRoutingLines(SKU, TempBOMStructure);
    end;

    local procedure ExplodeAssemblyLines(var SKU: Record "Stockkeeping Unit"; var TempBOMStructure: Record "COL BOM Structure" temporary)
    var
        BOMComponent: Record "BOM Component";
        ComponentSKU: Record "Stockkeeping Unit";
        Indentation: Integer;
    begin

        Indentation := TempBOMStructure.Indentation + 1;

        ComponentSKU.ReadIsolation := IsolationLevel::ReadUncommitted;
        BOMComponent.ReadIsolation := IsolationLevel::ReadUncommitted;

        BOMComponent.SetRange("Parent Item No.", SKU."Item No.");
        BOMComponent.SetRange(Type, Enum::"BOM Component Type"::Item);
        BOMComponent.SetFilter("No.", '<>%1', '');
        BOMComponent.SetLoadFields("No.", "Variant Code", "Quantity per", Description);
        if BOMComponent.FindSet() then
            repeat
                if not ComponentSKU.Get(GetDefaultLocationCode(), BOMComponent."No.", BOMComponent."Variant Code") then begin
                    ComponentSKU.Init();
                    ComponentSKU."Location Code" := GetDefaultLocationCode();
                    ComponentSKU."Item No." := BOMComponent."No.";
                    ComponentSKU."Variant Code" := BOMComponent."Variant Code";
                end;
                ComponentSKU.Description := BOMComponent.Description;
                TempBOMStructure.Indentation := Indentation;
                FillOutBOM(ComponentSKU, TempBOMStructure, BOMComponent."Quantity per", '');
            until BOMComponent.Next() = 0;
    end;

    local procedure InitNewLine(var TempBOMStructure: Record "COL BOM Structure" temporary)
    var
        EntryNo, Indentation : Integer;
    begin
        EntryNo := TempBOMStructure."Entry No.";
        Indentation := TempBOMStructure.Indentation;
        Clear(TempBOMStructure);
        TempBOMStructure.Init();
        TempBOMStructure."Entry No." := EntryNo + 1;
        TempBOMStructure.Indentation := Indentation;

        UpdateProgress(1, EntryNo, false);
    end;

    local procedure AddRoutingLines(var SKU: Record "Stockkeeping Unit"; var TempBOMStructure: Record "COL BOM Structure" temporary)
    var
        RoutingLine: Record "Routing Line";
        MachineCenter: Record "Machine Center";
        UoM: Code[10];
        RunTimeQty, SetupWaitMoveTimeQty : Decimal;
    begin
        if SKU."Routing No." = '' then
            exit;

        RoutingLine.ReadIsolation := IsolationLevel::ReadUncommitted;
        MachineCenter.ReadIsolation := IsolationLevel::ReadUncommitted;

        RoutingLine.SetBaseLoadFields();
        MachineCenter.SetLoadFields("Work Center No.");

        RoutingLine.SetRange("Routing No.", SKU."Routing No.");
        RoutingLine.SetFilter("No.", '<>%1', '');
        RoutingLine.SetRange("Version Code", '');
        if RoutingLine.FindSet() then
            repeat
                Clear(UoM);
                InitNewLine(TempBOMStructure);
                case RoutingLine.Type of
                    Enum::"Capacity Type Routing"::"Work Center":
                        begin
                            TempBOMStructure.Type := Enum::"COL BOM Element Type"::"Work Center";
                            UoM := GetWorkCenterUoM(RoutingLine."No.");
                        end;
                    Enum::"Capacity Type Routing"::"Machine Center":
                        begin
                            MachineCenter.Get(RoutingLine."No.");
                            if MachineCenter."Work Center No." <> '' then
                                UoM := GetWorkCenterUoM(MachineCenter."Work Center No.");
                            TempBOMStructure.Type := Enum::"COL BOM Element Type"::"Machine Center";
                        end;
                end;
                TempBOMStructure."No." := RoutingLine."No.";
                TempBOMStructure.Description := RoutingLine.Description;
                TempBOMStructure."Unit of Measure Code" := Uom;
                TempBOMStructure."Is Leaf" := true;
                CalcQtyPerParentFromProdRouting(RoutingLine, TempBOMStructure, RunTimeQty, SetupWaitMoveTimeQty);
                TempBOMStructure."Qty. per Parent" := SetupWaitMoveTimeQty + RunTimeQty;
                TempBOMStructure."Routing No." := RoutingLine."Routing No.";
                TempBOMStructure.Insert();
            until RoutingLine.Next() = 0;
    end;

    /// <summary>
    /// Phantom BOM contains lines with other Prod. BOMs only
    /// </summary>
    /// <param name="ProductionBOMNo"></param>
    /// <returns></returns>
    local procedure IsPhantomBOM(ProductionBOMNo: Code[20]): Boolean
    var
        ProductionBOMLine: Record "Production BOM Line";
    begin
        ProductionBOMLine.ReadIsolation := IsolationLevel::ReadUncommitted;

        ProductionBOMLine.SetRange("Production BOM No.", ProductionBOMNo);
        ProductionBOMLine.SetRange("Version Code", '');

        // if bom contains items, it's not a phantom bom
        ProductionBOMLine.SetRange(Type, Enum::"Production BOM Line Type"::Item);
        if not ProductionBOMLine.IsEmpty() then
            exit(false);

        // if there are only bom lines (or comments) it is a phantom bom
        ProductionBOMLine.SetRange(Type, Enum::"Production BOM Line Type"::"Production BOM");
        if not ProductionBOMLine.IsEmpty() then
            exit(true);

        exit(false);
    end;

    /// <summary>
    /// Work Centers appear in bom structure several times. It saves a bit of time to store the Unit of Measure for later use.
    /// </summary>
    local procedure GetWorkCenterUoM(WorkCenterCode: Code[20]): Code[10]
    var
        WorkCenter: Record "Work Center";
        UoM: Code[10];
    begin
        if WorkCenterUoMDict.Get(WorkCenterCode, UoM) then
            exit(UoM);

        WorkCenter.ReadIsolation := IsolationLevel::ReadUncommitted;
        WorkCenter.SetLoadFields("Unit of Measure Code", "Calendar Rounding Precision");
        WorkCenter.Get(WorkCenterCode);
        UoM := WorkCenter."Unit of Measure Code";
        WorkCenterUoMDict.Add(WorkCenterCode, UoM);
        exit(UoM);
    end;

    local procedure GetWorkCenterCalendarRoundingPrecision(WorkCenterCode: Code[20]): Decimal
    var
        WorkCenter: Record "Work Center";
        CalendarRoundingPrecision: Decimal;
    begin
        if WorkCenterCalPrecisionDict.Get(WorkCenterCode, CalendarRoundingPrecision) then
            exit(CalendarRoundingPrecision);

        WorkCenter.ReadIsolation := IsolationLevel::ReadUncommitted;
        WorkCenter.SetLoadFields("Unit of Measure Code", "Calendar Rounding Precision");
        WorkCenter.Get(WorkCenterCode);
        CalendarRoundingPrecision := WorkCenter."Calendar Rounding Precision";
        WorkCenterCalPrecisionDict.Add(WorkCenterCode, CalendarRoundingPrecision);
        exit(CalendarRoundingPrecision);
    end;

    local procedure CalcQtyPerParentFromProdRouting(var RoutingLine: Record "Routing Line"; var TempBOMStructure: Record "COL BOM Structure" temporary; var RunTimeQty: Decimal; var SetupWaitMoveTimeQty: Decimal)
    var
        CalendarMgt: Codeunit "Shop Calendar Management";
        SetupTimeFactor: Decimal;
        RunTimeFactor: Decimal;
        WaitTimeFactor: Decimal;
        MoveTimeFactor: Decimal;
        CurrentTimeFactor: Decimal;
        LotSizeFactor: Decimal;
    begin
        SetupTimeFactor := CalendarMgt.TimeFactor(RoutingLine."Setup Time Unit of Meas. Code");
        RunTimeFactor := CalendarMgt.TimeFactor(RoutingLine."Run Time Unit of Meas. Code");
        WaitTimeFactor := CalendarMgt.TimeFactor(RoutingLine."Wait Time Unit of Meas. Code");
        MoveTimeFactor := CalendarMgt.TimeFactor(RoutingLine."Move Time Unit of Meas. Code");

        if RoutingLine."Lot Size" = 0 then
            LotSizeFactor := 1
        else
            LotSizeFactor := RoutingLine."Lot Size";

        RunTimeQty := RoutingLine."Run Time" * RunTimeFactor / LotSizeFactor;
        SetupWaitMoveTimeQty :=
          (RoutingLine."Setup Time" * SetupTimeFactor + RoutingLine."Wait Time" * WaitTimeFactor +
          RoutingLine."Move Time" * MoveTimeFactor) / LotSizeFactor;

        if TempBOMStructure."Unit of Measure Code" = '' then begin
            // select base UOM from Setup/Run/Wait/Move UOMs
            CurrentTimeFactor := SetupTimeFactor;
            TempBOMStructure."Unit of Measure Code" := RoutingLine."Setup Time Unit of Meas. Code";
            if CurrentTimeFactor > RunTimeFactor then begin
                CurrentTimeFactor := RunTimeFactor;
                TempBOMStructure."Unit of Measure Code" := RoutingLine."Run Time Unit of Meas. Code";
            end;
            if CurrentTimeFactor > WaitTimeFactor then begin
                CurrentTimeFactor := WaitTimeFactor;
                TempBOMStructure."Unit of Measure Code" := RoutingLine."Wait Time Unit of Meas. Code";
            end;
            if CurrentTimeFactor > MoveTimeFactor then begin
                CurrentTimeFactor := MoveTimeFactor;
                TempBOMStructure."Unit of Measure Code" := RoutingLine."Move Time Unit of Meas. Code";
            end;
        end;

        RunTimeQty :=
          Round(RunTimeQty / CalendarMgt.TimeFactor(TempBOMStructure."Unit of Measure Code"), GetWorkCenterCalendarRoundingPrecision(RoutingLine."Work Center No."));
        SetupWaitMoveTimeQty :=
          Round(SetupWaitMoveTimeQty / CalendarMgt.TimeFactor(TempBOMStructure."Unit of Measure Code"), GetWorkCenterCalendarRoundingPrecision(RoutingLine."Work Center No."));
    end;

    local procedure GetDefaultLocationCode(): Code[10]
    begin
        ManufacturingSetup.GetRecordOnce();
        ManufacturingSetup.TestField("COL Def.Loc. for BOM Structure");
        exit(ManufacturingSetup."COL Def.Loc. for BOM Structure");
    end;

    local procedure InitProgressDialog()
    begin
        if not GuiAllowed() then
            exit;
        ProgressUpdate := CurrentDateTime();
        Window.Open(ProgressTxt);
    end;

    local procedure CloseProgressDialog()
    begin
        if not GuiAllowed() then
            exit;
        Window.Close();
    end;

    local procedure UpdateProgress(ControlId: Integer; EntryNo: Integer; ForceUpdate: Boolean)
    begin
        if not GuiAllowed() then
            exit;
        if ForceUpdate then begin
            Window.Update(ControlId, EntryNo);
            exit;
        end;

        if CurrentDateTime() - ProgressUpdate > 900 then begin
            Window.Update(ControlId, EntryNo);
            ProgressUpdate := CurrentDateTime();
        end;
    end;

    local procedure LogWarnings(var TempBOMStructure: Record "COL BOM Structure" temporary; var TempBOMStructureWarning: Record "COL BOM Structure Warning" temporary)
    begin
        UpdateProgress(1, TempBOMStructure."Entry No.", true); // to update previous reporting step

        TempBOMStructure.Reset();
        if TempBOMStructure.FindSet(true) then
            repeat
                CheckLine(TempBOMStructure, TempBOMStructureWarning);
                UpdateProgress(2, TempBOMStructure."Entry No.", false);
            until TempBOMStructure.Next() = 0;
    end;

    local procedure CheckLine(var TempBOMStructure: Record "COL BOM Structure" temporary; var TempBOMStructureWarning: Record "COL BOM Structure Warning" temporary)
    var
        RecordPosition: Text;
        QtyPerWarningTxt: Label 'The Quantity per. field has not been set for %1.', Comment = '%1 = item no.';
        QtyPerWarning2Txt: Label 'The Quantity per. field has not been set for %1 and Production BOM %2.', Comment = '%1 = item no.; %2 = Production Bom No.';
        RoutingNotCertTxt: Label 'Routing %1 is not certified', Comment = '%1 = routing no.';
        ProductionBOMNotCertTxt: Label 'Production BOM %1 is not certified', Comment = '%2 = prod. bom no.';
    begin
        if (TempBOMStructure."Qty. per Parent" = 0) and (TempBOMStructure.Indentation > 0)
            and (not (TempBOMStructure.Type in [Enum::"COL BOM Element Type"::"Machine Center", Enum::"COL BOM Element Type"::"Work Center"])) then
            if TempBOMStructure."Production BOM No." = '' then
                TempBOMStructureWarning.SetWarning(StrSubstNo(QtyPerWarningTxt, TempBOMStructure."No."), TempBOMStructure)
            else begin
                // just to get record position
                CheckProductionBOMCertified(TempBOMStructure."Production BOM No.", RecordPosition);
                TempBOMStructureWarning.SetWarning(StrSubstNo(QtyPerWarning2Txt, TempBOMStructure."No.", TempBOMStructure."Production BOM No."), TempBOMStructure, Database::"Production BOM Header", RecordPosition);
            end;


        if TempBOMStructure."Routing No." <> '' then
            if not CheckRoutingCertified(TempBOMStructure."Routing No.", RecordPosition) then
                TempBOMStructureWarning.SetWarning(StrSubstNo(RoutingNotCertTxt, TempBOMStructure."Routing No."), TempBOMStructure, Database::"Routing Header", RecordPosition);

        if TempBOMStructure."Production BOM No." <> '' then
            if not CheckProductionBOMCertified(TempBOMStructure."Production BOM No.", RecordPosition) then
                TempBOMStructureWarning.SetWarning(StrSubstNo(ProductionBOMNotCertTxt, TempBOMStructure."Production BOM No."), TempBOMStructure, Database::"Production BOM Header", RecordPosition);

        CheckBLockField(TempBOMStructure, TempBOMStructureWarning);

        if TempBOMStructure.Type = TempBOMStructure.Type::Item then
            CheckSKU(TempBOMStructure, TempBOMStructureWarning);

    end;

    local procedure CheckBLockField(var TempBOMStructure: Record "COL BOM Structure" temporary; var TempBOMStructureWarning: Record "COL BOM Structure Warning" temporary)
    var
        ItemVariant: Record "Item Variant";
        FieldBlockedLbl: Label '%1 for %2 - Variant %3.', Comment = '%1 = field name; %2 = item no.; %3 = variant code';
    begin
        ItemVariant.ReadIsolation := IsolationLevel::ReadUncommitted;
        ItemVariant.SetLoadFields(Description, "COL Product Life Cycle", "COL EU REACH Reg. Compliant", "COL EU RoHS Status", "COL EU RoHS Dir. Compliant",
            "COL Project Blocked", "COL Planning Blocked", "COL Production Blocked", Blocked, "Sales Blocked", "Purchasing Blocked", "Service Blocked");

        if ItemVariant.Get(TempBOMStructure."No.", TempBOMStructure."Variant Code") then begin
            if ItemVariant."COL Project Blocked" then
                TempBOMStructureWarning.SetWarning(StrSubstNo(FieldBlockedLbl, ItemVariant.FieldCaption("COL Project Blocked"), TempBOMStructure."No.", TempBOMStructure."Variant Code"), TempBOMStructure);
            if ItemVariant."COL Planning Blocked" then
                TempBOMStructureWarning.SetWarning(StrSubstNo(FieldBlockedLbl, ItemVariant.FieldCaption("COL Planning Blocked"), TempBOMStructure."No.", TempBOMStructure."Variant Code"), TempBOMStructure);
            if ItemVariant."COL Production Blocked" then
                TempBOMStructureWarning.SetWarning(StrSubstNo(FieldBlockedLbl, ItemVariant.FieldCaption("COL Production Blocked"), TempBOMStructure."No.", TempBOMStructure."Variant Code"), TempBOMStructure);
            if ItemVariant.Blocked then
                TempBOMStructureWarning.SetWarning(StrSubstNo(FieldBlockedLbl, ItemVariant.FieldCaption(Blocked), TempBOMStructure."No.", TempBOMStructure."Variant Code"), TempBOMStructure);
            if ItemVariant."Sales Blocked" then
                TempBOMStructureWarning.SetWarning(StrSubstNo(FieldBlockedLbl, ItemVariant.FieldCaption("Sales Blocked"), TempBOMStructure."No.", TempBOMStructure."Variant Code"), TempBOMStructure);
            if ItemVariant."Purchasing Blocked" then
                TempBOMStructureWarning.SetWarning(StrSubstNo(FieldBlockedLbl, ItemVariant.FieldCaption("Purchasing Blocked"), TempBOMStructure."No.", TempBOMStructure."Variant Code"), TempBOMStructure);
            if ItemVariant."Service Blocked" then
                TempBOMStructureWarning.SetWarning(StrSubstNo(FieldBlockedLbl, ItemVariant.FieldCaption("Service Blocked"), TempBOMStructure."No.", TempBOMStructure."Variant Code"), TempBOMStructure);
        end;
    end;

    local procedure CheckRoutingCertified(RoutingNo: Code[20]; var RecordPosition: Text): Boolean
    var
        RoutingHeader: Record "Routing Header";
    begin
        RoutingHeader.ReadIsolation := IsolationLevel::ReadUncommitted;
        RoutingHeader.SetBaseLoadFields();

        if not TempRoutingHeader.Get(RoutingNo) then
            if RoutingHeader.Get(RoutingNo) then begin
                TempRoutingHeader := RoutingHeader;
                TempRoutingHeader.Insert();
            end;
        Clear(RecordPosition);
        if TempRoutingHeader."No." <> '' then
            RecordPosition := TempRoutingHeader.GetPosition(false);

        exit(TempRoutingHeader.Status = TempRoutingHeader.Status::Certified);
    end;

    local procedure CheckProductionBOMCertified(ProductionBOMNo: Code[20]; var RecordPosition: Text): Boolean
    var
        ProductionBOMHeader: Record "Production BOM Header";
    begin
        ProductionBOMHeader.ReadIsolation := IsolationLevel::ReadUncommitted;
        ProductionBOMHeader.SetBaseLoadFields();

        if not TempProductionBOMHeader.Get(ProductionBOMNo) then
            if ProductionBOMHeader.Get(ProductionBOMNo) then begin
                TempProductionBOMHeader := ProductionBOMHeader;
                TempProductionBOMHeader.Insert();
            end;

        Clear(RecordPosition);
        if TempProductionBOMHeader."No." <> '' then
            RecordPosition := TempProductionBOMHeader.GetPosition(false);

        exit(TempProductionBOMHeader.Status = TempProductionBOMHeader.Status::Certified);
    end;

    local procedure CheckSKU(var TempBOMStructure: Record "COL BOM Structure" temporary; var TempBOMStructureWarning: Record "COL BOM Structure Warning" temporary)
    var
        SKU: Record "Stockkeeping Unit";
        MissingSKUTxt: Label 'SKU for %1 - %2 - %3 is missing.', Comment = '%1 = Location Code, %2 = Item No.; %3 = Variant Code';
        MissingAssemblyBOMLbl: Label 'Replenishment System for Item %1 is Assembly, but the item does not have an assembly BOM. Verify that this is correct.', Comment = '%1 = Item No.';
        MissingItemVariantProdBOMLbl: Label 'Replenishment System for Item Variant (Item: %1, Variant: %2) at SKU is Prod. Order, but the item does not have a production BOM. Verify that this is correct.', Comment = '%1 = Item No.; %2 = Variant Code';
        CheckReplenishmentLbl: Label 'Replenishment System for Item Variant (Item: %1, Variant: %2) is %3, but item has a Production BOM. Verify that the value is correct.', Comment = '%1 = Item No.; %2 = Variant Code; %3 = replenishment option';
    begin
        SKU.ReadIsolation := IsolationLevel::ReadUncommitted;
        SKU.SetBaseLoadFields();
        SKU.SetAutoCalcFields("Assembly BOM");

        if not SKU.Get(TempBOMStructure."Location Code", TempBOMStructure."No.", TempBOMStructure."Variant Code") then begin
            TempBOMStructureWarning.SetWarning(StrSubstNo(MissingSKUTxt, TempBOMStructure."Location Code", TempBOMStructure."No.", TempBOMStructure."Variant Code"), TempBOMStructure);
            exit;
        end;

        case SKU."Replenishment System" of
            Enum::"Replenishment System"::Assembly:
                if not SKU."Assembly BOM" then
                    TempBOMStructureWarning.SetWarning(StrSubstNo(MissingAssemblyBOMLbl, SKU."Item No."), TempBOMStructure, Database::"Stockkeeping Unit", SKU.GetPosition(false));

            Enum::"Replenishment System"::"Prod. Order":
                if SKU."Production BOM No." = '' then
                    TempBOMStructureWarning.SetWarning(StrSubstNo(MissingItemVariantProdBOMLbl, SKU."Item No.", SKU."Variant Code"), TempBOMStructure, Database::"Stockkeeping Unit", SKU.GetPosition(false));
            else
                if SKU."Production BOM No." <> '' then
                    TempBOMStructureWarning.SetWarning(StrSubstNo(CheckReplenishmentLbl, SKU."Item No.", SKU."Variant Code", SKU."Replenishment System"), TempBOMStructure, Database::"Stockkeeping Unit", SKU.GetPosition(false));
        end;
    end;
}