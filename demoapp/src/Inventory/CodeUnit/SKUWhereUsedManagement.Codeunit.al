namespace Weibel.Manufacturing.ProductionBOM;

using Microsoft.Foundation.UOM;
using Microsoft.Inventory.Costing;
using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Inventory.Location;

codeunit 70183 "COL SKU Where-Used Management"
{
    Permissions = TableData "Production BOM Header" = r,
                  TableData "Production BOM Version" = r,
                  TableData "Where-Used Line" = rimd;

    trigger OnRun()
    begin
    end;

    var
        TempWhereUsedList: Record "Where-Used Line" temporary;
        TempLastProdBOMComponent: Record "Production BOM Line" temporary;
        UOMMgt: Codeunit "Unit of Measure Management";
        VersionMgt: Codeunit VersionManagement;
        MfgCostCalcMgt: Codeunit "Mfg. Cost Calculation Mgt.";
        MultiLevel: Boolean;
        NextWhereUsedEntryNo: Integer;

    procedure FindRecord(Which: Text; var WhereUsedList2: Record "Where-Used Line"): Boolean
    begin
        TempWhereUsedList.Copy(WhereUsedList2);
        if not TempWhereUsedList.Find(Which) then
            exit(false);
        WhereUsedList2 := TempWhereUsedList;

        exit(true);
    end;

    procedure NextRecord(Steps: Integer; var WhereUsedList2: Record "Where-Used Line"): Integer
    var
        CurrentSteps: Integer;
    begin
        TempWhereUsedList.Copy(WhereUsedList2);
        CurrentSteps := TempWhereUsedList.Next(Steps);
        if CurrentSteps <> 0 then
            WhereUsedList2 := TempWhereUsedList;

        exit(CurrentSteps);
    end;

    procedure WhereUsedFromSku(Sku: Record "Stockkeeping Unit"; CalcDate: Date; NewMultiLevel: Boolean)
    begin
        BuildWhereUsedListWithCheck(Enum::"Production BOM Line Type"::Item, Sku, CalcDate, NewMultiLevel);
    end;

    local procedure BuildWhereUsedListWithCheck(BOMLineType: Enum "Production BOM Line Type"; var Sku: Record "Stockkeeping Unit"; CalcDate: Date; IsMultiLevel: Boolean)
    var
        ProdBOMCheck: Codeunit "Production BOM-Check";
        ProdBOMToCheck: Code[20];
    begin
        ProdBOMToCheck := Sku."Production BOM No.";

        ProdBOMCheck.CheckBOM(ProdBOMToCheck, VersionMgt.GetBOMVersion(ProdBOMToCheck, CalcDate, false));

        TempWhereUsedList.DeleteAll();
        NextWhereUsedEntryNo := 1;
        MultiLevel := IsMultiLevel;

        BuildWhereUsedList(BOMLineType, Sku."Item No.", Sku."Variant Code", CalcDate, 1, 1);
    end;

    local procedure BuildWhereUsedList(Type: Enum "Production BOM Line Type"; No: Code[20]; VariantCode: Code[20]; CalcDate: Date; Level: Integer; Quantity: Decimal)
    var
        ItemAssembly: Record Item;
        SkuAssembly: Record "Stockkeeping Unit";
        SkuAssembly2: Record "Stockkeeping Unit";
        ProdBOMComponent: Record "Production BOM Line";
    begin
        if Level > 30 then
            exit;

        if Type = Type::"Production BOM" then begin
            SkuAssembly.SetCurrentKey("Production BOM No.");
            SkuAssembly.SetRange("Production BOM No.", No);
            SkuAssembly.SetAutoCalcFields(Description);
            if SkuAssembly.FindSet() then
                repeat

                    TempWhereUsedList.Init();
                    TempWhereUsedList."Entry No." := NextWhereUsedEntryNo;
                    TempWhereUsedList."Item No." := SkuAssembly."Item No.";
                    TempWhereUsedList.Description := SkuAssembly.Description;
                    TempWhereUsedList."Level Code" := Level;

                    // if TempWhereUsedList."Level Code" <= 2 then begin
                    TempWhereUsedList."COL No." := SkuAssembly."Production BOM No.";
                    TempWhereUsedList."COL Type" := "Production BOM Line Type"::Item;
                    // end
                    // else begin
                    //     TempWhereUsedList."COL No." := No;
                    //     TempWhereUsedList."COL Type" := "Production BOM Line Type"::"Production BOM";
                    // end;

                    ItemAssembly.Get(SkuAssembly."Item No.");
                    TempWhereUsedList."Quantity Needed" :=
                      Quantity *
                      (1 + SkuAssembly."Scrap %" / 100) *
                      UOMMgt.GetQtyPerUnitOfMeasure(ItemAssembly, ItemAssembly."Base Unit of Measure") /
                      UOMMgt.GetQtyPerUnitOfMeasure(
                        ItemAssembly,
                        VersionMgt.GetBOMUnitOfMeasure(
                          SkuAssembly."Production BOM No.",
                          VersionMgt.GetBOMVersion(SkuAssembly."Production BOM No.", CalcDate, false)));
                    TempWhereUsedList."Version Code" := VersionMgt.GetBOMVersion(No, CalcDate, true);
                    TempWhereUsedList.Insert();
                    NextWhereUsedEntryNo := NextWhereUsedEntryNo + 1;
                    if MultiLevel then
                        BuildWhereUsedList(
                          Enum::"Production BOM Line Type"::Item,
                          SkuAssembly."Item No.",
                          SkuAssembly."Variant Code",
                          CalcDate,
                          Level + 1,
                          TempWhereUsedList."Quantity Needed");
                until SkuAssembly.Next() = 0;
        end;

        if Type = Type::Item then begin // Add phantom BOM

            SkuAssembly2.SetRange("Item No.", No);
            SkuAssembly2.SetRange("Variant Code", VariantCode);
            if SkuAssembly2.FindSet() then
                repeat

                    ProdBOMComponent.Reset();
                    ProdBOMComponent.SetCurrentKey(Type, "No.");
                    ProdBOMComponent.SetRange(Type, Type::"Production BOM");
                    ProdBOMComponent.SetRange("No.", SkuAssembly2."Production BOM No.");
                    if CalcDate <> 0D then begin
                        ProdBOMComponent.SetFilter("Starting Date", '%1|..%2', 0D, CalcDate);
                        ProdBOMComponent.SetFilter("Ending Date", '%1|%2..', 0D, CalcDate);
                    end;

                    if ProdBOMComponent.FindSet() then
                        repeat
                            if VersionMgt.GetBOMVersion(
                                 ProdBOMComponent."Production BOM No.", CalcDate, true) =
                               ProdBOMComponent."Version Code"
                            then
                                AddPhantomBom(ProdBOMComponent, CalcDate);

                        until ProdBOMComponent.Next() = 0;

                until SkuAssembly2.Next() = 0;
        end;

        ProdBOMComponent.Reset();
        ProdBOMComponent.SetCurrentKey(Type, "No.");
        ProdBOMComponent.SetRange(Type, Type);
        ProdBOMComponent.SetRange("No.", No);
        if CalcDate <> 0D then begin
            ProdBOMComponent.SetFilter("Starting Date", '%1|..%2', 0D, CalcDate);
            ProdBOMComponent.SetFilter("Ending Date", '%1|%2..', 0D, CalcDate);
        end;

        if ProdBOMComponent.FindSet() then
            repeat
                if VersionMgt.GetBOMVersion(
                     ProdBOMComponent."Production BOM No.", CalcDate, true) =
                   ProdBOMComponent."Version Code"
                then begin
                    OnBuildWhereUsedListOnLoopProdBomComponent(ProdBOMComponent, TempWhereUsedList, NextWhereUsedEntryNo, No, CalcDate, Level);
                    if IsActiveProductionBOM(ProdBOMComponent, VariantCode) then begin
                        TempLastProdBOMComponent.TransferFields(ProdBOMComponent);
                        BuildWhereUsedList(
                            Enum::"Production BOM Line Type"::"Production BOM",
                            ProdBOMComponent."Production BOM No.",
                            VariantCode,
                            CalcDate,
                            Level + 1,
                            MfgCostCalcMgt.CalcCompItemQtyBase(ProdBOMComponent, CalcDate, Quantity, '', false));
                    end;
                end;
            until ProdBOMComponent.Next() = 0;

        OnAfterBuildWhereUsedList(Type.AsInteger(), No, CalcDate, TempWhereUsedList, NextWhereUsedEntryNo, Level, Quantity, MultiLevel);
    end;

    local procedure AddPhantomBom(var ProdBOMComponent: Record "Production BOM Line"; CalcDate: Date)
    var
        SkuAssembly: Record "Stockkeeping Unit";
        ItemAssembly: Record Item;
        Quantity: Decimal;
    begin
        if ProdBOMComponent."No." = '' then
            exit;

        SkuAssembly.SetCurrentKey("Production BOM No.");
        SkuAssembly.SetRange("Production BOM No.", ProdBOMComponent."Production BOM No.");
        SkuAssembly.SetAutoCalcFields(Description);
        if SkuAssembly.FindSet() then
            repeat

                Quantity := MfgCostCalcMgt.CalcCompItemQtyBase(ProdBOMComponent, CalcDate, 1, '', false);

                TempWhereUsedList.Init();
                TempWhereUsedList."Entry No." := NextWhereUsedEntryNo;
                TempWhereUsedList."Item No." := SkuAssembly."Item No.";
                TempWhereUsedList.Description := SkuAssembly.Description;
                TempWhereUsedList."Level Code" := 0;

                TempWhereUsedList."COL No." := SkuAssembly."Production BOM No.";
                TempWhereUsedList."COL Type" := "Production BOM Line Type"::"Production BOM";


                ItemAssembly.Get(SkuAssembly."Item No.");
                TempWhereUsedList."Quantity Needed" :=
                  Quantity *
                  (1 + SkuAssembly."Scrap %" / 100) *
                  UOMMgt.GetQtyPerUnitOfMeasure(ItemAssembly, ItemAssembly."Base Unit of Measure") /
                  UOMMgt.GetQtyPerUnitOfMeasure(
                    ItemAssembly,
                    VersionMgt.GetBOMUnitOfMeasure(
                      SkuAssembly."Production BOM No.",
                      VersionMgt.GetBOMVersion(SkuAssembly."Production BOM No.", CalcDate, false)));
                TempWhereUsedList."Version Code" := VersionMgt.GetBOMVersion(ProdBOMComponent."No.", CalcDate, true);
                TempWhereUsedList.Insert();
                NextWhereUsedEntryNo := NextWhereUsedEntryNo + 1;
            until SkuAssembly.Next() = 0;
    end;

    procedure IsActiveProductionBOM(ProductionBOMLine: Record "Production BOM Line"; VariantCode: Code[20]) Result: Boolean
    begin
        if (ProductionBOMLine.Type = ProductionBOMLine.Type::Item) and (ProductionBOMLine."Variant Code" <> VariantCode) then
            exit(false);

        if ProductionBOMLine."Version Code" = '' then
            exit(not IsProductionBOMClosed(ProductionBOMLine));

        exit(not IsProdBOMVersionClosed(ProductionBOMLine));
    end;

    local procedure IsProductionBOMClosed(ProductionBOMLine: Record "Production BOM Line"): Boolean
    var
        ProdBOMHeader: Record "Production BOM Header";
    begin
        ProdBOMHeader.Get(ProductionBOMLine."Production BOM No.");
        exit(ProdBOMHeader.Status = ProdBOMHeader.Status::Closed);
    end;

    local procedure IsProdBOMVersionClosed(ProductionBOMLine: Record "Production BOM Line"): Boolean
    var
        ProductionBOMVersion: Record "Production BOM Version";
    begin
        ProductionBOMVersion.Get(ProductionBOMLine."Production BOM No.", ProductionBOMLine."Version Code");
        exit(ProductionBOMVersion.Status = ProductionBOMVersion.Status::Closed);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterBuildWhereUsedList(Type: Option " ",Item,"Production BOM"; No: Code[20]; CalcDate: Date; var WhereUsedList: Record "Where-Used Line" temporary; NextWhereUsedEntryNo: Integer; Level: Integer; Quantity: Decimal; MultiLevel: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBuildWhereUsedListOnLoopProdBomComponent(var ProductionBOMLine: Record "Production BOM Line"; var TempWhereUsedLine: Record "Where-Used Line" temporary; var NextWhereUsedEntryNo: Integer; No: Code[20]; CalcDate: Date; var Level: Integer)
    begin
    end;

#pragma warning disable AA0228
    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetItemBOMNo(ItemNo: Code[20]; var Item: Record Item; var IsHandled: Boolean)
    begin
    end;
#pragma warning restore AA0228    
}
