namespace Weibel.Inventory.Transfer;

using Microsoft.Inventory.Transfer;

codeunit 70112 "COL Transfer Post Subs"
{
    [EventSubscriber(ObjectType::Table, Database::"Transfer Shipment Header", OnAfterCopyFromTransferHeader, '', false, false)]
    local procedure "Transfer Shipment Header_OnAfterCopyFromTransferHeader"(var TransferShipmentHeader: Record "Transfer Shipment Header"; TransferHeader: Record "Transfer Header")
    begin
        TransferShipmentHeader."COL Shipping Status" := TransferHeader."COL Shipping Status";
    end;
}