namespace Weibel.Projects.Project.Job;

using Microsoft.Projects.Project.Job;
using Microsoft.Foundation.Comment;

codeunit 70127 "COL Job Common Method"
{
    procedure FillChangeReason(var Rec: Record "Project Budget Jour Line (PGS)")
    var
        ChangeReasonDialog: Page "COL Change Reason Dialog";
    begin
        if ChangeReasonDialog.RunModal() = Action::OK then
            SetChangeReason(Rec, ChangeReasonDialog.GetInputText())
        else
            Error('');
    end;

    local procedure SetChangeReason(var Rec: Record "Project Budget Jour Line (PGS)"; ChangeReason: Text[100])
    var
        ProjectBudgetJourLine: Record "Project Budget Jour Line (PGS)";
        Job: Record Job;
        TempJob: Record Job temporary;
    begin
        ProjectBudgetJourLine.SetRange("Journal Template Name", Rec."Journal Template Name");
        ProjectBudgetJourLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        if ProjectBudgetJourLine.FindSet() then
            repeat
                if not TempJob.Get(ProjectBudgetJourLine."Project No.") then begin
                    TempJob."No." := ProjectBudgetJourLine."Project No.";
                    TempJob.Insert();
                end;
            until ProjectBudgetJourLine.Next() = 0;

        TempJob.Reset();
        if TempJob.FindSet() then
            repeat
                if Job.Get(TempJob."No.") then begin
                    Job.Validate("COL Change Reason", ChangeReason);
                    Job.Modify();
                end;
            until TempJob.Next() = 0;
    end;

    procedure SetChangeReasonOnComment(var Job: Record Job)
    var
        CommentLine: Record "Comment Line";
        LineNo: Integer;
    begin
        if Job."COL Change Reason" = '' then
            exit;

        CommentLine.Reset();
        CommentLine.SetRange("Table Name", CommentLine."Table Name"::Job);
        CommentLine.SetRange("No.", Job."No.");
        if CommentLine.FindLast() then
            LineNo := CommentLine."Line No." + 1000
        else
            LineNo := 1000;

        CommentLine.Init();
        CommentLine."Table Name" := CommentLine."Table Name"::Job;
        CommentLine."No." := Job."No.";
        CommentLine."Line No." := LineNo;
        CommentLine.Date := WorkDate();
        CommentLine.Comment := Job."COL Change Reason";
        CommentLine."COL Budget Change" := true;
        CommentLine."COL Budget Change By" := CopyStr(UserId(), 1, MaxStrLen(CommentLine."COL Budget Change By"));
        CommentLine.Insert(true);

    end;
}
