namespace Weibel.Warehouse.Integration;
using Microsoft.Manufacturing.Document;
using Microsoft.Warehouse.Setup;
using Weibel.Manufacturing.Archive;
codeunit 70134 "COL ROB-EX Prod. Order Handler"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"SCB Robex Prod. Order Mgt.", OnAfterHandleProdOrderLine, '', false, false)]
    local procedure "SCB Robex Prod. Order Mgt._OnAfterHandleProdOrderLine"(RoutingLineEntry: Record "SCB Robex Routing Line Entry")
    begin
        this.UpdateRobexReasonCode(RoutingLineEntry);
    end;

    internal procedure UpdateRobexReasonCode(RoutingLineEntry: Record "SCB Robex Routing Line Entry")
    var
        ProdOrderLine: Record "Prod. Order Line";
        ProductionOrder: Record "Production Order";
        WarehouseSetup: Record "Warehouse Setup";
        ProdArchiveManagement: Codeunit "COL Prod. Archive Management";
    begin
        if not ProdOrderLine.GetBySystemId(RoutingLineEntry."Prod. Order Line SystemId") then
            exit;

        if not ProductionOrder.Get(ProdOrderLine.Status, ProdOrderLine."Prod. Order No.") then
            exit;

        WarehouseSetup.Get();
        if WarehouseSetup."COL ROB-EX Reason Code" = '' then
            exit;

        if ProductionOrder."COL Reason Code" <> WarehouseSetup."COL ROB-EX Reason Code" then begin
            ProductionOrder."COL Reason Code" := WarehouseSetup."COL ROB-EX Reason Code";
            ProductionOrder.Modify(true);
            ProdArchiveManagement.StorePurchDocument(ProductionOrder, false);
        end;
    end;
}