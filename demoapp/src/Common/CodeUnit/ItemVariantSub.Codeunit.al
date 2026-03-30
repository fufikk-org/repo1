namespace Weibel.Common;

using Microsoft.Manufacturing.Planning;
using Microsoft.Inventory.Requisition;
using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.WorkCenter;
using Microsoft.Inventory.Tracking;

codeunit 70157 "COL Item Variant Sub."
{
    [EventSubscriber(ObjectType::Report, Report::"Calculate Subcontracts", 'OnBeforeInsertReqWkshLine', '', false, false)]
    local procedure OnBeforeInsertReqWkshLine(var ProdOrderRoutingLine: Record "Prod. Order Routing Line"; var WorkCenter: Record "Work Center"; var ReqLine: Record "Requisition Line"; var IsHandled: Boolean; ProdOrderLine: Record "Prod. Order Line");
    var
        ItemVariant: Record "Item Variant";
        Item: Record "Item";
    begin
        if ItemVariant.Get(ProdOrderLine."Item No.", ProdOrderLine."Variant Code") and ItemVariant."COL Planning Blocked" then begin
            IsHandled := true;
            exit;
        end;

        if Item.Get(ProdOrderLine."Item No.") and Item."COL Planning Blocked" then begin
            IsHandled := true;
            exit;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Inventory Profile Offsetting", 'OnBeforeMaintainPlanningLine', '', false, false)]
    local procedure OnBeforeMaintainPlanningLine(var SupplyInvtProfile: Record "Inventory Profile"; DemandInvtProfile: Record "Inventory Profile"; NewPhase: Option " ","Line Created","Routing Created",Exploded,Obsolete; Direction: Option Forward,Backward; var TrackingReservEntry: Record "Reservation Entry"; var IsHandled: Boolean)
    var
        ItemVariant: Record "Item Variant";
        Item: Record "Item";
    begin
        if ItemVariant.Get(SupplyInvtProfile."Item No.", SupplyInvtProfile."Variant Code") and ItemVariant."COL Planning Blocked" then begin
            IsHandled := true;
            exit;
        end;

        if Item.Get(SupplyInvtProfile."Item No.") and Item."COL Planning Blocked" then begin
            IsHandled := true;
            exit;
        end;
    end;
}
