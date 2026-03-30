namespace Weibel.Manufacturing.BlockProduction;

using Microsoft.Inventory.Requisition;
using Microsoft.Manufacturing.Document;

codeunit 70156 "COL Block Prod. Plan. Events"
{
    EventSubscriberInstance = Manual;

    var
        TempProductionOrder: Record "Production Order" temporary;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Mfg. Carry Out Action", OnAfterInsertProdOrder, '', false, false)]
    local procedure "Carry Out Action_OnAfterInsertProdOrder"(var ProductionOrder: Record "Production Order"; ProdOrderChoice: Integer; var RequisitionLine: Record "Requisition Line")
    begin
        TempProductionOrder := ProductionOrder;
        TempProductionOrder.Insert(false);
    end;

    internal procedure ShowBlockedProductionWarning()
    var
        BlockProductionMgt: Codeunit "COL Block Production Mgt.";
        BlockedProdOrdersMsg: Label 'The following production orders are blocked for production, it will not be possible to release these production orders: %1', Comment = '%1 = nos. of prod. orders';
        ErrMsg: Text;
        OrderNos: TextBuilder;
        OrderNo: Code[20];
        BlockedOrders: List of [Code[20]];
    begin
        if TempProductionOrder.FindSet() then
            repeat
                if not BlockProductionMgt.CheckProductionOrder(TempProductionOrder, false, ErrMsg) then
                    BlockedOrders.Add(TempProductionOrder."No.");
            until TempProductionOrder.Next() = 0;
        if BlockedOrders.Count() > 0 then begin
            foreach OrderNo in BlockedOrders do begin
                if OrderNos.Length > 0 then
                    OrderNos.Append(', ');
                OrderNos.Append(OrderNo);
            end;
            Message(BlockedProdOrdersMsg, OrderNos.ToText());
        end;
    end;
}