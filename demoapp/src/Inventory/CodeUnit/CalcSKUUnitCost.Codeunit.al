namespace Weibel.Inventory.Location;

using Microsoft.Inventory.Location;
using Microsoft.Inventory.Item;
using Weibel.Inventory.BOM;
using Microsoft.Manufacturing.WorkCenter;
using Microsoft.Inventory.Ledger;

codeunit 70226 "COL Calc. SKU Unit Cost"
{
    trigger OnRun()
    begin
        UpdateAllSKUCost();
    end;

    var
        TempCurrSKUItem: Record "Stockkeeping Unit" temporary;

    procedure SetCurrSku(var SKUItem: Record "Stockkeeping Unit")
    begin
        TempCurrSKUItem.Reset();
        TempCurrSKUItem.DeleteAll();
        TempCurrSKUItem.TransferFields(SKUItem);
        TempCurrSKUItem.Insert();
    end;

    procedure UpdateAllSKUCost()
    var
        SKUItem: Record "Stockkeeping Unit";
        uc: Decimal;
    begin
        SKUItem.Get(TempCurrSKUItem."Location Code", TempCurrSKUItem."Item No.", TempCurrSKUItem."Variant Code");
        if HasPosting(SKUItem) then
            exit;

        uc := CalculateSkuUnitCost(SKUItem, false);
        UpdateSKU(SKUItem, uc, false);
    end;

    local procedure HasPosting(var SKUItem: Record "Stockkeeping Unit"): Boolean
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        ItemLedgEntry.SetCurrentKey("Item No.");
        ItemLedgEntry.SetRange("Item No.", SKUItem."Item No.");
        ItemLedgEntry.SetRange("Variant Code", SKUItem."Variant Code");
        ItemLedgEntry.SetRange("Location Code", SKUItem."Location Code");

        exit(not ItemLedgEntry.IsEmpty());
    end;

    procedure UpdateSKU(var SKUItem: Record "Stockkeeping Unit"; uc: Decimal; doCheckPostings: Boolean)
    begin
        if doCheckPostings then
            if HasPosting(SKUItem) then
                exit; // do not update if there are item ledger entries

        if (uc <> 0) then begin
            SKUItem."Unit Cost" := uc;
            SKUItem.Modify();
        end;
    end;

    procedure CalculateSkuUnitCost(var SKUItem: Record "Stockkeeping Unit"; showMsg: Boolean): Decimal
    var
        TempBOMStructure: Record "COL BOM Structure" temporary;
        Item: Record Item;
        WorkCenter: Record "Work Center";
        UnitCost: Decimal;
        CalcDoneMsg: Label 'Calculation Done';
    begin
        GenBOMStructure.GetBomDataForSKU(SKUItem, TempBOMStructure);

#if not HIDE_IT8M_LOW_LEVEL
        TempBOMStructure.SetCurrentKey("Low-Level Code");
#endif          
        TempBOMStructure.SetRange(Indentation, 1); // only first level item Indentation to not dubling counting UC
        if TempBOMStructure.FindSet() then
            repeat
                if TempBOMStructure.Type = TempBOMStructure.Type::Item then begin
                    Item.Get(TempBOMStructure."No.");
                    UnitCost += Item."Unit Cost" * TempBOMStructure."Qty. per Parent";
                end
                else
                    if TempBOMStructure.Type = TempBOMStructure.Type::"Work Center" then begin
                        WorkCenter.Get(TempBOMStructure."No.");
                        UnitCost += WorkCenter."Unit Cost" * TempBOMStructure."Qty. per Parent";
                    end;

            until TempBOMStructure.Next() = 0;

        if showMsg then
            if GuiAllowed() then
                Message(CalcDoneMsg);

        exit(UnitCost);
    end;

    var
        GenBOMStructure: Codeunit "COL Gen. BOM Structure";

}
