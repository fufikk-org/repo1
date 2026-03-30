namespace Weibel.Manufacturing.Planning;

using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.Planning;
codeunit 70161 "COL Job Planning Manual Sub."
{
    EventSubscriberInstance = Manual;

    [EventSubscriber(ObjectType::Report, Report::"Calculate Plan - Plan. Wksh.", OnAfterItemOnPreDataItem, '', false, false)]
    local procedure OnAfterItemOnPreDataItem(var Item: Record Item)
    begin
        Item.SetRange("No.");
    end;
}
