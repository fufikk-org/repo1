namespace Weibel.Inventory.BOM.Tree;

using Microsoft.Inventory.Location;
using Microsoft.Inventory.Item;

codeunit 70184 "COL SKU Manual Events"
{
    EventSubscriberInstance = Manual;

    [EventSubscriber(ObjectType::Table, Database::"Stockkeeping Unit", OnAfterCopyFromItem, '', false, false)]
    local procedure "Stockkeeping Unit_OnAfterCopyFromItem"(var StockkeepingUnit: Record "Stockkeeping Unit"; Item: Record Item)
    begin
        StockkeepingUnit."Production BOM No." := Item."Production BOM No.";
        StockkeepingUnit."Routing No." := Item."Routing No.";
    end;
}