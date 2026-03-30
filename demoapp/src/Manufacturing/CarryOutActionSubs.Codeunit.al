namespace Weibel.Inventory.Requisition;

using Microsoft.Inventory.Requisition;
using Microsoft.Manufacturing.Routing;
using Microsoft.Manufacturing.Document;

codeunit 70187 "COL Carry Out Action Subs"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Mfg. Carry Out Action", OnAfterTransferPlanningRtngLine, '', false, false)]
    local procedure "Carry Out Action_OnAfterTransferPlanningRtngLine"(var PlanningRtngLine: Record "Planning Routing Line"; var ProdOrderRtngLine: Record "Prod. Order Routing Line")
    var
        ProdOrderLine: Record "Prod. Order Line";
    begin
        ProdOrderLine.SetCurrentKey(Status, "Prod. Order No.", "Routing No.", "Routing Reference No.");
        ProdOrderLine.SetRange(Status, ProdOrderRtngLine.Status);
        ProdOrderLine.SetRange("Prod. Order No.", ProdOrderRtngLine."Prod. Order No.");
        ProdOrderLine.SetRange("Routing No.", ProdOrderRtngLine."Routing No.");
        ProdOrderLine.SetRange("Routing Reference No.", ProdOrderRtngLine."Routing Reference No.");
        if ProdOrderLine.FindFirst() then begin
            if ProdOrderLine."Item No." <> ProdOrderRtngLine."COL Prod. Order Item No." then
                ProdOrderRtngLine."COL Prod. Order Item No." := ProdOrderLine."Item No.";
            if ProdOrderLine."Variant Code" <> ProdOrderRtngLine."COL Prod. Order Variant Code" then
                ProdOrderRtngLine."COL Prod. Order Variant Code" := ProdOrderLine."Variant Code";
        end;
    end;
}