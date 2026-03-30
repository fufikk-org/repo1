namespace Weibel.Inventory.Item;

using Microsoft.Inventory.Item;
using System.Utilities;
using Microsoft.Inventory.Location;

codeunit 70159 "COL Copy Item Sub. Auto"
{
    EventSubscriberInstance = StaticAutomatic;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Item", OnAfterCopyItem, '', false, false)]
    local procedure "Copy Item_OnAfterCopyItem"(var CopyItemBuffer: Record "Copy Item Buffer"; SourceItem: Record Item; var TargetItem: Record Item)
    begin
        CopyVariantLinks(CopyItemBuffer, SourceItem, TargetItem);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Stockkeeping Unit", OnAfterCopyFromItem, '', false, false)]
    local procedure "Stockkeeping Unit_OnAfterCopyFromItem"(var StockkeepingUnit: Record "Stockkeeping Unit"; Item: Record Item)
    begin
        StockkeepingUnit."COL Created By User" := CopyStr(UserId, 1, MaxStrLen(StockkeepingUnit."COL Created By User"));
        StockkeepingUnit."COL Creation Date" := Today;
    end;

    local procedure CopyVariantLinks(var CopyItemBuffer: Record "Copy Item Buffer"; SourceItem: Record Item; var TargetItem: Record Item)
    var
        FromItemVariant, ToItemVariant : Record "Item Variant";
        RecordLinkManagement: Codeunit "Record Link Management";
    begin
        if not CopyItemBuffer."Item Variants" then
            exit;

        if not CopyItemBuffer."COL Variant Links" then
            exit;

        FromItemVariant.SetRange("Item No.", SourceItem."No.");
        if FromItemVariant.IsEmpty() then
            exit;

        if FromItemVariant.FindSet() then
            repeat
                ToItemVariant.Get(TargetItem."No.", FromItemVariant.Code);
                RecordLinkManagement.CopyLinks(FromItemVariant, ToItemVariant);
            until FromItemVariant.Next() = 0;
    end;
}