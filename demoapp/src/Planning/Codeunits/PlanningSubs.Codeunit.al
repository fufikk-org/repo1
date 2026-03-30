namespace Weibel.Inventory.Planning;

using Microsoft.Inventory.Planning;
using Microsoft.Inventory.Requisition;
using Microsoft.Manufacturing.Journal;

codeunit 70168 "COL Planning Subs."
{
    [EventSubscriber(ObjectType::Table, DataBase::"Planning Error Log", OnAfterInsertEvent, '', false, false)]
    local procedure OnOnPreDataItemOnAfterCalcShouldSetAtStartPosition(var Rec: Record "Planning Error Log"; RunTrigger: Boolean)
    var
        PlanningErrorLogArch: Record "COL Planning Error Log Arch.";
        EntryNo: Integer;
    begin
        EntryNo := 1;
        if PlanningErrorLogArch.FindLast() then
            EntryNo += PlanningErrorLogArch."Arch. Entry No.";

        PlanningErrorLogArch.TransferFields(Rec);
        PlanningErrorLogArch."Arch. Entry No." := EntryNo;
        PlanningErrorLogArch.Insert();
    end;

    [EventSubscriber(ObjectType::Page, Page::"Req. Worksheet", 'OnOpenPageEvent', '', false, false)]
    local procedure ReqWorksheet_OnOpenPageEvent(var Rec: Record "Requisition Line")
    var
        RequisitionLine: Record "Requisition Line";
    begin
        Rec.FilterGroup(2);
        RequisitionLine.CopyFilters(Rec);
        Rec.FilterGroup(0);

        if RequisitionLine.FindSet() then
            repeat
                if (RequisitionLine."COL First Opr. Work Center" = '') or (RequisitionLine."COL First Opr. Wrk Center Grp" = '') then begin
                    RequisitionLine.COL_FillFromRouting();
                    RequisitionLine.Modify(false);
                end;
            until RequisitionLine.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Planning Worksheet", 'OnOpenPageEvent', '', false, false)]
    local procedure PlanningWorksheet_OnOpenPageEvent(var Rec: Record "Requisition Line")
    var
        RequisitionLine: Record "Requisition Line";
    begin
        Rec.FilterGroup(2);
        RequisitionLine.CopyFilters(Rec);
        Rec.FilterGroup(0);
        RequisitionLine.ModifyAll("Accept Action Message", false);
        if RequisitionLine.FindSet() then
            repeat
                if (RequisitionLine."COL First Opr. Work Center" = '') or (RequisitionLine."COL First Opr. Wrk Center Grp" = '') then begin
                    RequisitionLine.COL_FillFromRouting();
                    RequisitionLine.Modify(false);
                end;
            until RequisitionLine.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Subcontracting Worksheet", 'OnOpenPageEvent', '', false, false)]
    local procedure SubcontractingWorksheet_OnOpenPageEvent(var Rec: Record "Requisition Line")
    var
        RequisitionLine: Record "Requisition Line";
    begin
        Rec.FilterGroup(2);
        RequisitionLine.CopyFilters(Rec);
        Rec.FilterGroup(0);
        RequisitionLine.ModifyAll("Accept Action Message", false);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Requisition Line", OnAfterOnInsert, '', false, false)]
    local procedure OnAfterOnInsert(var RequisitionLine: Record "Requisition Line"; ReqWkshTemplate: Record "Req. Wksh. Template"; RequisitionWkshName: Record "Requisition Wksh. Name")
    begin
        RequisitionLine.COL_FillFromRouting();
    end;

}
