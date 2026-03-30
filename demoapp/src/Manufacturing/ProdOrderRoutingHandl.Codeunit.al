namespace Weibel.Manufacturing.Planning.Handler;

using Microsoft.Manufacturing.Document;
using Microsoft.Manufacturing.Planning;

codeunit 70101 "COL Prod. Order Routing Handl."
{
    [EventSubscriber(ObjectType::Report, Report::"Calculate Subcontracts", OnBeforeInsertReqWkshLine, '', false, false)]
    local procedure OnBeforeInsertReqWkshLine(var ProdOrderRoutingLine: Record "Prod. Order Routing Line"; var IsHandled: Boolean)
    begin
        // Requirement 244
        // technical field to skip the routing line when calculating subcontracts, because of a bug with report extension (CurrReport.Skip() is not working as expected)
        // https://github.com/microsoft/AL/issues/7039
        // Once the bug is solved, the CurrentReport.Skip() line should be uncommented in the report extension
        // Update 2026-01-05: bug has been closed, "by design". Technical field is needed.
        IsHandled := ProdOrderRoutingLine."COL Skip Routing Line";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Released Production Order", OnBeforeActionEvent, 'RefreshProductionOrder', false, false)]
    local procedure OnBeforeActionEvent(var Rec: Record "Production Order")
    var
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        LineLockedErr: Label 'Routing Line (Operation: %1) is Locked.', Comment = '%1 routing line.';
    begin
        ProdOrderLine.SetRange("Prod. Order No.", Rec."No.");
        ProdOrderLine.SetRange("Status", Rec.Status);
        if ProdOrderLine.FindSet() then
            repeat
                ProdOrderRoutingLine.SetRange("Routing No.", ProdOrderLine."Routing No.");
                ProdOrderRoutingLine.SetRange("Routing Reference No.", ProdOrderLine."Routing Reference No.");
                ProdOrderRoutingLine.SetRange("Status", ProdOrderLine.Status);
                ProdOrderRoutingLine.SetRange("Prod. Order No.", ProdOrderLine."Prod. Order No.");
                if ProdOrderRoutingLine.FindSet() then
                    repeat
                        if ProdOrderRoutingLine."COL Lock" then
                            Error(LineLockedErr, ProdOrderRoutingLine."Operation No.");
                    until ProdOrderRoutingLine.Next() = 0;
            until ProdOrderLine.Next() = 0;
    end;
}