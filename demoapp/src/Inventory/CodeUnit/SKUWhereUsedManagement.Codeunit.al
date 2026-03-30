namespace Weibel.Manufacturing.ProductionBOM;

using Microsoft.Foundation.UOM;
using Microsoft.Inventory.Costing;
using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Inventory.Location;
using Weibel.Inventory.Item;

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
        this.TempWhereUsedList.Copy(WhereUsedList2);
        if not this.TempWhereUsedList.Find(Which) then
            exit(false);
        WhereUsedList2 := this.TempWhereUsedList;

        exit(true);
    end;

    procedure NextRecord(Steps: Integer; var WhereUsedList2: Record "Where-Used Line"): Integer
    var
        CurrentSteps: Integer;
    begin
        this.TempWhereUsedList.Copy(WhereUsedList2);
        CurrentSteps := this.TempWhereUsedList.Next(Steps);
        if CurrentSteps <> 0 then
            WhereUsedList2 := this.TempWhereUsedList;

        exit(CurrentSteps);
    end;

    procedure WhereUsedFromSku(Sku: Record "Stockkeeping Unit"; CalcDate: Date; NewMultiLevel: Boolean)
    begin
        this.BuildWhereUsedListWithCheck(Enum::"Production BOM Line Type"::Item, Sku, CalcDate, NewMultiLevel);
    end;

    local procedure BuildWhereUsedListWithCheck(BOMLineType: Enum "Production BOM Line Type"; var Sku: Record "Stockkeeping Unit"; CalcDate: Date; IsMultiLevel: Boolean)
    var
        ProdBOMCheck: Codeunit "Production BOM-Check";
        ProdBOMToCheck: Code[20];
    begin
        ProdBOMToCheck := Sku."Production BOM No.";

        ProdBOMCheck.CheckBOM(ProdBOMToCheck, this.VersionMgt.GetBOMVersion(ProdBOMToCheck, CalcDate, false));

        this.TempWhereUsedList.DeleteAll();
        this.NextWhereUsedEntryNo := 1;
        this.MultiLevel := IsMultiLevel;

        this.BuildWhereUsedList(BOMLineType, Sku."Item No.", Sku."Variant Code", CalcDate, 1, 1);
    end;

    local procedure BuildWhereUsedList(Type: Enum "Production BOM Line Type"; No: Code[20]; VariantCode: Code[20]; CalcDate: Date; Level: Integer; Quantity: Decimal)
    begin
        if Level > 30 then
            exit;

        if Type = Type::"Production BOM" then
            this.AddWhereUsedLinesForProductionBOM(No, CalcDate, Level, Quantity);

        if Type = Type::Item then
            this.AddWhereUsedLinesForPhantomBOMs(No, VariantCode, CalcDate);

        this.TraverseParentBOMComponents(Type, No, VariantCode, CalcDate, Level, Quantity);

        this.OnAfterBuildWhereUsedList(Type.AsInteger(), No, CalcDate, this.TempWhereUsedList, this.NextWhereUsedEntryNo, Level, Quantity, this.MultiLevel);
    end;

    local procedure AddWhereUsedLinesForProductionBOM(ProdBOMNo: Code[20]; CalcDate: Date; Level: Integer; Quantity: Decimal)
    var
        SkuAssembly: Record "Stockkeeping Unit";
    begin
        SkuAssembly.SetCurrentKey("Production BOM No.");
        SkuAssembly.SetRange("Production BOM No.", ProdBOMNo);
        SkuAssembly.SetAutoCalcFields(Description);
        if SkuAssembly.FindSet() then
            repeat
                this.InsertItemWhereUsedLine(SkuAssembly, ProdBOMNo, CalcDate, Level, Quantity);
                if this.MultiLevel then
                    this.BuildWhereUsedList(
                      Enum::"Production BOM Line Type"::Item,
                      SkuAssembly."Item No.",
                      SkuAssembly."Variant Code",
                      CalcDate,
                      Level + 1,
                      this.TempWhereUsedList."Quantity Needed");
            until SkuAssembly.Next() = 0
        else
            this.InsertPhantomBOMWhereUsedLine(ProdBOMNo, CalcDate, Level, Quantity);
    end;

    local procedure InsertItemWhereUsedLine(SkuAssembly: Record "Stockkeeping Unit"; ProdBOMNo: Code[20]; CalcDate: Date; Level: Integer; Quantity: Decimal)
    var
        ItemAssembly: Record Item;
        ItemVariant: Record "Item Variant";
    begin
        this.TempWhereUsedList.Init();
        this.TempWhereUsedList."Entry No." := this.NextWhereUsedEntryNo;
        this.TempWhereUsedList."Item No." := SkuAssembly."Item No.";
        this.TempWhereUsedList.Description := SkuAssembly.Description;
        this.TempWhereUsedList."Level Code" := Level;
        this.TempWhereUsedList."COL No." := SkuAssembly."Production BOM No.";
        this.TempWhereUsedList."COL Type" := "Production BOM Line Type"::Item;
        this.TempWhereUsedList."COL Related SKU Item No." := SkuAssembly."Item No.";
        this.TempWhereUsedList."COL Related SKU Variant Code" := SkuAssembly."Variant Code";
        this.TempWhereUsedList."COL Related SKU Location Code" := SkuAssembly."Location Code";
        if ItemVariant.Get(SkuAssembly."Item No.", SkuAssembly."Variant Code") then
            this.TempWhereUsedList."COL Product Life Cycle" := ItemVariant."COL Product Life Cycle";

        ItemAssembly.Get(SkuAssembly."Item No.");
        this.TempWhereUsedList."Quantity Needed" :=
          Quantity *
          (1 + SkuAssembly."Scrap %" / 100) *
          this.UOMMgt.GetQtyPerUnitOfMeasure(ItemAssembly, ItemAssembly."Base Unit of Measure") /
          this.UOMMgt.GetQtyPerUnitOfMeasure(
            ItemAssembly,
            this.VersionMgt.GetBOMUnitOfMeasure(
              SkuAssembly."Production BOM No.",
              this.VersionMgt.GetBOMVersion(SkuAssembly."Production BOM No.", CalcDate, false)));
        this.TempWhereUsedList."Version Code" := this.VersionMgt.GetBOMVersion(ProdBOMNo, CalcDate, true);
        this.TempWhereUsedList.Insert();
        this.NextWhereUsedEntryNo := this.NextWhereUsedEntryNo + 1;
    end;

    local procedure InsertPhantomBOMWhereUsedLine(ProdBOMNo: Code[20]; CalcDate: Date; Level: Integer; Quantity: Decimal)
    var
        ProdBOMHeader: Record "Production BOM Header";
    begin
        ProdBOMHeader.Get(ProdBOMNo);
        this.TempWhereUsedList.Init();
        this.TempWhereUsedList."Entry No." := this.NextWhereUsedEntryNo;
        this.TempWhereUsedList.Description := ProdBOMHeader.Description;
        this.TempWhereUsedList."Level Code" := Level;
        this.TempWhereUsedList."COL No." := ProdBOMNo;
        this.TempWhereUsedList."COL Type" := "Production BOM Line Type"::"Production BOM";
        this.TempWhereUsedList."Version Code" := this.VersionMgt.GetBOMVersion(ProdBOMNo, CalcDate, true);
        this.TempWhereUsedList."Quantity Needed" := Quantity;
        this.TempWhereUsedList.Insert();
        this.NextWhereUsedEntryNo := this.NextWhereUsedEntryNo + 1;
    end;

    local procedure AddWhereUsedLinesForPhantomBOMs(ItemNo: Code[20]; VariantCode: Code[20]; CalcDate: Date)
    var
        SkuAssembly: Record "Stockkeeping Unit";
        ProdBOMComponent: Record "Production BOM Line";
    begin
        SkuAssembly.SetRange("Item No.", ItemNo);
        SkuAssembly.SetRange("Variant Code", VariantCode);
        if SkuAssembly.FindSet() then
            repeat
                ProdBOMComponent.Reset();
                ProdBOMComponent.SetCurrentKey(Type, "No.");
                ProdBOMComponent.SetRange(Type, ProdBOMComponent.Type::"Production BOM");
                ProdBOMComponent.SetRange("No.", SkuAssembly."Production BOM No.");
                if CalcDate <> 0D then begin
                    ProdBOMComponent.SetFilter("Starting Date", '%1|..%2', 0D, CalcDate);
                    ProdBOMComponent.SetFilter("Ending Date", '%1|%2..', 0D, CalcDate);
                end;

                if ProdBOMComponent.FindSet() then
                    repeat
                        if this.VersionMgt.GetBOMVersion(
                             ProdBOMComponent."Production BOM No.", CalcDate, true) =
                           ProdBOMComponent."Version Code"
                        then
                            this.InsertPhantomBomLine(ProdBOMComponent, CalcDate);
                    until ProdBOMComponent.Next() = 0;
            until SkuAssembly.Next() = 0;
    end;

    local procedure InsertPhantomBomLine(var ProdBOMComponent: Record "Production BOM Line"; CalcDate: Date)
    var
        SkuAssembly: Record "Stockkeeping Unit";
        ItemAssembly: Record Item;
        ItemVariant: Record "Item Variant";
        Quantity: Decimal;
    begin
        if ProdBOMComponent."No." = '' then
            exit;

        SkuAssembly.SetCurrentKey("Production BOM No.");
        SkuAssembly.SetRange("Production BOM No.", ProdBOMComponent."Production BOM No.");
        SkuAssembly.SetAutoCalcFields(Description);
        if SkuAssembly.FindSet() then
            repeat
                Quantity := this.MfgCostCalcMgt.CalcCompItemQtyBase(ProdBOMComponent, CalcDate, 1, '', false);

                this.TempWhereUsedList.Init();
                this.TempWhereUsedList."Entry No." := this.NextWhereUsedEntryNo;
                this.TempWhereUsedList."Level Code" := 0;
                this.TempWhereUsedList."COL No." := SkuAssembly."Production BOM No.";
                this.TempWhereUsedList."COL Type" := "Production BOM Line Type"::"Production BOM";
                this.TempWhereUsedList."COL Related SKU Item No." := SkuAssembly."Item No.";
                this.TempWhereUsedList."COL Related SKU Variant Code" := SkuAssembly."Variant Code";
                this.TempWhereUsedList."COL Related SKU Location Code" := SkuAssembly."Location Code";
                if ItemVariant.Get(SkuAssembly."Item No.", SkuAssembly."Variant Code") then
                    this.TempWhereUsedList."COL Product Life Cycle" := ItemVariant."COL Product Life Cycle";

                ItemAssembly.Get(SkuAssembly."Item No.");
                this.TempWhereUsedList."Quantity Needed" :=
                  Quantity *
                  (1 + SkuAssembly."Scrap %" / 100) *
                  this.UOMMgt.GetQtyPerUnitOfMeasure(ItemAssembly, ItemAssembly."Base Unit of Measure") /
                  this.UOMMgt.GetQtyPerUnitOfMeasure(
                    ItemAssembly,
                    this.VersionMgt.GetBOMUnitOfMeasure(
                      SkuAssembly."Production BOM No.",
                      this.VersionMgt.GetBOMVersion(SkuAssembly."Production BOM No.", CalcDate, false)));
                this.TempWhereUsedList."Version Code" := this.VersionMgt.GetBOMVersion(ProdBOMComponent."No.", CalcDate, true);
                this.TempWhereUsedList.Insert();
                this.NextWhereUsedEntryNo := this.NextWhereUsedEntryNo + 1;
            until SkuAssembly.Next() = 0;
    end;

    local procedure TraverseParentBOMComponents(Type: Enum "Production BOM Line Type"; No: Code[20]; VariantCode: Code[20]; CalcDate: Date; Level: Integer; Quantity: Decimal)
    var
        ProdBOMComponent: Record "Production BOM Line";
    begin
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
                if this.VersionMgt.GetBOMVersion(
                     ProdBOMComponent."Production BOM No.", CalcDate, true) =
                   ProdBOMComponent."Version Code"
                then begin
                    this.OnBuildWhereUsedListOnLoopProdBomComponent(ProdBOMComponent, this.TempWhereUsedList, this.NextWhereUsedEntryNo, No, CalcDate, Level);
                    if this.IsActiveProductionBOM(ProdBOMComponent, VariantCode) then begin
                        this.TempLastProdBOMComponent.TransferFields(ProdBOMComponent);
                        this.BuildWhereUsedList(
                            Enum::"Production BOM Line Type"::"Production BOM",
                            ProdBOMComponent."Production BOM No.",
                            VariantCode,
                            CalcDate,
                            Level + 1,
                            this.MfgCostCalcMgt.CalcCompItemQtyBase(ProdBOMComponent, CalcDate, Quantity, '', false));
                    end;
                end;
            until ProdBOMComponent.Next() = 0;
    end;

    procedure IsActiveProductionBOM(ProductionBOMLine: Record "Production BOM Line"; VariantCode: Code[20]) Result: Boolean
    begin
        if (ProductionBOMLine.Type = ProductionBOMLine.Type::Item) and (ProductionBOMLine."Variant Code" <> VariantCode) then
            exit(false);

        if ProductionBOMLine."Version Code" = '' then
            exit(not this.IsProductionBOMClosed(ProductionBOMLine));

        exit(not this.IsProdBOMVersionClosed(ProductionBOMLine));
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
