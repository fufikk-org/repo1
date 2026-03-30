codeunit 70135 "COLG Order Tracking Subs."
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::OrderTrackingManagement, 'OnDrillOrdersUpCaseElse', '', false, false)]
    local procedure OnDrillOrdersUpCaseElse(var ReservationEntry3: Record "Reservation Entry"; var ReservationEntry2: Record "Reservation Entry"; SearchUp: Boolean; var ContinueDrillUp: Boolean; var IncludePlanningFilter: Boolean)
    begin
        if ReservationEntry3."Source Type" in [Database::"Prod. Order Component", Database::"Prod. Order Line"] then begin
            ContinueDrillUp := true;
            IncludePlanningFilter := true;
        end;
    end;
}