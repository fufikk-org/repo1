namespace Weibel.Inventory.Location;

using Microsoft.Inventory.Location;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Ledger;

codeunit 70227 "COL Calc. SKU Unit Cost Job"
{
    trigger OnRun()
    var
        SKUItem: Record "Stockkeeping Unit";
        CalcSKUUnitCost: Codeunit "COL Calc. SKU Unit Cost";
    begin
#if not HIDE_LOWLEVEL_SKU
        UpdateSKU();
        SKUItem.SetCurrentKey("COL Low-Level Code");
        SKUItem.SetAscending("COL Low-Level Code", false);
#endif
        if SKUItem.FindSet() then
            repeat
                Clear(CalcSKUUnitCost);
                CalcSKUUnitCost.SetCurrSku(SKUItem);
                if CalcSKUUnitCost.Run() then; // ignore if error (no calc will be inserted)

                Commit();
            until SKUItem.Next() = 0;

        UpdateItems();
    end;

    local procedure UpdateItems()
    var
        Item: Record Item;
    begin
        if Item.FindSet() then
            repeat
                if not HasPosting(Item) then
                    UpdateItem(Item);

            until Item.Next() = 0;
    end;

    local procedure UpdateItem(var Item: Record Item)
    var
        SKUItem: Record "Stockkeeping Unit";
        CurrVariant: Code[10];
        VariantInt: Integer;
        OldVariant: Integer;
    begin
        if Item.IsNonInventoriableType() then
            exit;

        VariantInt := -1;
        OldVariant := -1;
        SKUItem.SetRange("Item No.", Item."No.");
        if SKUItem.FindSet() then
            repeat
                if Evaluate(VariantInt, SKUItem."Variant Code") then begin
                    if VariantInt >= OldVariant then
                        CurrVariant := SKUItem."Variant Code";
                end
                else
                    if CurrVariant = '' then
                        CurrVariant := SKUItem."Variant Code";

                OldVariant := VariantInt;
            until SKUItem.Next() = 0;

        SKUItem.Reset();
        SKUItem.SetRange("Item No.", Item."No.");
        SKUItem.SetRange("Variant Code", CurrVariant);
        if SKUItem."Unit Cost" <> 0 then
            if SKUItem.FindFirst() then begin

                if Item."Costing Method" = "Costing Method"::Standard then
                    Item.Validate("Standard Cost", SKUItem."Unit Cost")
                else
                    Item."Unit Cost" := SKUItem."Unit Cost";
                Item.Validate("Price/Profit Calculation");
                Item.Modify();
            end;
    end;

    local procedure HasPosting(var Item: Record Item): Boolean
    var
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        ItemLedgEntry.SetCurrentKey("Item No.");
        ItemLedgEntry.SetRange("Item No.", Item."No.");
        exit(not ItemLedgEntry.IsEmpty());
    end;

#if not HIDE_LOWLEVEL_SKU
    procedure UpdateSKU()
    var
        SKUItem: Record "Stockkeeping Unit";
        RRef: RecordRef;
        FRef: FieldRef;
    begin
        if SKUItem.FindSet() then
            repeat
                RRef.GetTable(SKUItem);
                if RRef.FieldExist(62000) then begin // "WS Low-Level Code ITM8"; to avoid adding app dependency
                    FRef := RRef.Field(62000);
                    if FRef.Type = FRef.Type::Integer then begin
                        SKUItem."COL Low-Level Code" := RRef.Field(62000).Value();
                        SKUItem.Modify();
                    end;
                end;

            until SKUItem.Next() = 0;
    end;
#endif    
}
