namespace Weibel.Manufacturing.Document;

using Microsoft.Manufacturing.Document;
using Microsoft.Manufacturing.Routing;

codeunit 70181 "COL Calculate Prod. Order Subs"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calculate Prod. Order", OnAfterTransferRoutingLine, '', false, false)]
    local procedure "Calculate Prod. Order_OnAfterTransferRoutingLine"(var ProdOrderLine: Record "Prod. Order Line"; var RoutingLine: Record "Routing Line"; var ProdOrderRoutingLine: Record "Prod. Order Routing Line")
    begin
        ProdOrderRoutingLine."COL Prod. Order Item No." := ProdOrderLine."Item No.";
        ProdOrderRoutingLine."COL Prod. Order Variant Code" := ProdOrderLine."Variant Code";
    end;
}