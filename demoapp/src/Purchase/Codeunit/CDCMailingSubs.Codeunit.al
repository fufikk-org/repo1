codeunit 70195 "COL CDC Mailing Subs."
{
    SingleInstance = true;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDC Purch. Approval E-Mail", OnCreateTableRowOnBeforeAppendRow2, '', true, true)]
    local procedure RunOnCreateTableRowOnBeforeAppendRow2(PurchHeader: Record "Purchase Header"; ApprEntry: Record "Approval Entry"; var String: Text)
    var
        ApprovalComment: Record "Approval Comment Line";
        RecentCommentsLbl: Label 'Recent comments:';
        StyledTdLbl: Label '<td colspan="6" style="border-right-width: 1px; border-right-style: solid; border-right-color: #e7e8e6; font-size: 11px; font-family: Tahoma,Verdana;">%1</td>', Locked = true;
        CommentsToSkip, i : Integer;
    begin
        ApprovalComment.SetRange("Table ID", Database::"Purchase Header");
        ApprovalComment.SetRange("Record ID to Approve", PurchHeader.RecordId);

        if ApprovalComment.Count > 5 then begin
            String += '</tr>';
            String += '<tr>';
            String += '<td></td>';
            String += CopyStr(StrSubstNo(StyledTdLbl, RecentCommentsLbl), 1, 1024);
            CommentsToSkip := ApprovalComment.Count - 5;
        end;

        if ApprovalComment.FindSet() then
            repeat
                i += 1;
                if i <= CommentsToSkip then
                    continue;
                String += '</tr>';
                String += '<tr>';
                String += '<td></td>';
                String += CopyStr(StrSubstNo(StyledTdLbl, ApprovalComment.Comment), 1, 1024);
            until ApprovalComment.Next() = 0;
    end;

}