namespace Weibel.Inventory.Item;

using Weibel.Inventory.Item;
using Microsoft.Inventory.Journal;
using Microsoft.Sales.Document;
using Microsoft.Sales.Posting;
using Microsoft.Inventory.Posting;
using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.Item;

codeunit 70138 "COL Inventory Events Sub"
{
    [EventSubscriber(ObjectType::Table, Database::Item, 'OnBeforeValidateEvent', 'No.', false, false)]
    local procedure OnBeforeValidateEvent_No(var Rec: Record "Item");
    begin
        if not GuiAllowed() then
            exit;

        CheckItemCode(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnBeforeValidateEvent1_No(var Rec: Record "Item");
    begin
        if not GuiAllowed() then
            exit;

        CheckItemCode(Rec);
    end;

    local procedure CheckItemCode(var Rec: Record "Item")
    var
        ItemNoMsg: Label 'Item No. %1 exceed 16 characters. Are You sure You want to continue?.', Comment = '%1 - Item No. Message displayed when item number exceeds 16 characters';
    begin
        if StrLen(Rec."No.") <= 16 then
            exit;

        if Rec.IsTemporary() then
            exit;

        if not Confirm(StrSubstNo(ItemNoMsg, Rec."No."), false) then
            Error('');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnAfterCopyItemJnlLineFromSalesLine, '', false, false)]
    local procedure OnAfterCopyItemJnlLineFromSalesLine(var ItemJnlLine: Record "Item Journal Line"; SalesLine: Record "Sales Line");
    begin
        ItemJnlLine."COL Export Classification Code" := SalesLine."COL Export Classification Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeItemJnlPostLine', '', false, false)]
    local procedure OnBeforeItemJnlPostLine(var ItemJournalLine: Record "Item Journal Line"; SalesLine: Record "Sales Line");
    begin
        ItemJournalLine."COL Export Classification Code" := SalesLine."COL Export Classification Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertItemLedgEntry', '', false, false)]
    local procedure OnBeforeInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line");
    begin
        ItemLedgerEntry."COL Export Classification Code" := ItemJournalLine."COL Export Classification Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnPostItemOnAfterGetSKU, '', false, false)]
    local procedure OnPostItemOnAfterGetSKU(var ItemJnlLine: Record "Item Journal Line"; var SKUExists: Boolean; var IsHandled: Boolean)
    var
        SKU: Record "Stockkeeping Unit";
        QtyToPost: Decimal;
        SKUPreventNegativeInventoryErr: Label 'Negative Inventory for SKU [%1, %2, %3] is forbidden.', Comment = '%1,%2,%3 represent Location Code, Item No., Variant Code respectively';
    begin
        if not SKUExists then
            exit;

        SKU.Get(ItemJnlLine."Location Code", ItemJnlLine."Item No.", ItemJnlLine."Variant Code");
        if not SKU.COL_SkuPreventNegativeInventory() then
            exit;

        if not (ItemJnlLine."Entry Type" in [ItemJnlLine."Entry Type"::"Negative Adjmt.",
                                              ItemJnlLine."Entry Type"::"Positive Adjmt.",
                                              ItemJnlLine."Entry Type"::Consumption,
                                              ItemJnlLine."Entry Type"::"Assembly Consumption",
                                              ItemJnlLine."Entry Type"::Transfer]) then
            exit;

        QtyToPost := ItemJnlLine.Quantity;

        if (ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::"Positive Adjmt.") then
            QtyToPost := QtyToPost * -1;

        if (ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::"Positive Adjmt.") and (ItemJnlLine.Quantity > 0) then
            exit;

        SKU.CalcFields(Inventory);

        if SKU.Inventory - QtyToPost < 0 then
            Error(SKUPreventNegativeInventoryErr,
                  ItemJnlLine."Location Code", ItemJnlLine."Item No.", ItemJnlLine."Variant Code");

    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Ledger Entry", OnBeforeVerifyOnInventory, '', false, false)]
    local procedure OnBeforeVerifyOnInventory(var ItemLedgerEntry: Record "Item Ledger Entry"; var IsHandled: Boolean; ErrorMessageText: Text)
    var
        SKU: Record "Stockkeeping Unit";
        ErrTxt: Text;
        SKUPreventNegativeInventoryErr: Label '\SKU Prevent Negative Inventory is enabled for SKU [%1, %2, %3].', Comment = '%1,%2,%3 represent Location Code, Item No., Variant Code respectively';
    begin
        if not ItemLedgerEntry.Open then
            exit;
        if ItemLedgerEntry.Quantity >= 0 then
            exit;

        ErrTxt := StrSubstNo(SKUPreventNegativeInventoryErr, ItemLedgerEntry."Location Code", ItemLedgerEntry."Item No.", ItemLedgerEntry."Variant Code");
        ErrTxt := ErrorMessageText + ErrTxt;

        if SKU.Get(ItemLedgerEntry."Location Code", ItemLedgerEntry."Item No.", ItemLedgerEntry."Variant Code") then
            if SKU.COL_SkuPreventNegativeInventory() then
                Error(ErrTxt);

    end;

}
