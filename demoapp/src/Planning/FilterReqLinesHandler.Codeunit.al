codeunit 70132 "COL Filter Req. Lines Handler"
{
    EventSubscriberInstance = Manual;

    [EventSubscriber(ObjectType::Report, Report::"Carry Out Action Msg. - Plan.", OnAfterSetReqLineFilters, '', false, false)]
    local procedure OnAfterSetReqLineFilters(var RequisitionLine: Record "Requisition Line")
    begin
        RequisitionLine.SetRange("Accept Action Message", true);
        RequisitionLine.SetRange("Replenishment System", RequisitionLine."Replenishment System"::Purchase);
    end;

    [EventSubscriber(ObjectType::Report, Report::"Carry Out Action Msg. - Plan.", OnBeforeRequisitionLineOnAfterGetRecord, '', false, false)]
    local procedure "Carry Out Action Msg. - Plan._OnBeforeRequisitionLineOnAfterGetRecord"(var RequisitionLine: Record "Requisition Line"; var CombineTransferOrders: Boolean)
    var
        Transparency: Codeunit "Planning Transparency";
    begin
        if Transparency.ReqLineWarningLevel(RequisitionLine) <> 0 then // If there's a warning when planning the line using batch planning, then the line should not be planned
            RequisitionLine."Accept Action Message" := false;
    end;
}