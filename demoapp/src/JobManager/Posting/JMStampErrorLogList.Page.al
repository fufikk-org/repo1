namespace Weibel.JobManager;

page 70290 "COL JM Stamp Error Log List"
{
    Caption = 'Stamp Posting Errors';
    PageType = List;
    ApplicationArea = All;
    SourceTable = "COL JM Stamp Error Buf";
    SourceTableTemporary = true;
    Editable = false;
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(LineSequence; Rec."Line Sequence")
                {
                    ApplicationArea = All;
                }
                field(LineSeqJournalLine; Rec."Line Seq. Journal Line")
                {
                    ApplicationArea = All;
                }
                field(EventTimestamp; Rec."Event Timestamp")
                {
                    ApplicationArea = All;
                }
                field(EventType; Rec."Event Type")
                {
                    ApplicationArea = All;
                }
                field(EventStatus; Rec."Event Status")
                {
                    ApplicationArea = All;
                }
                field(EmployeeNo; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field(JobNo; Rec."Job No.")
                {
                    ApplicationArea = All;
                }
                field(ProfileDate; Rec."Profile Date")
                {
                    ApplicationArea = All;
                }
                field(PostingAttempts; Rec."Posting Attempts")
                {
                    ApplicationArea = All;
                }
                field(LogPostingDateTime; Rec."Log Posting Date-Time")
                {
                    ApplicationArea = All;
                }
                field(LogUserId; Rec."Log User ID")
                {
                    ApplicationArea = All;
                }
                field(LogErrorText; Rec."Log Error Text")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(DeleteErrors)
            {
                ApplicationArea = All;
                Caption = 'Delete Errors';
                Image = Delete;
                ToolTip = 'Deletes the related stamp event log entries for the selected lines.';

                trigger OnAction()
                begin
                    DeleteSelectedErrors();
                end;
            }

            action(OpenStampEvent)
            {
                ApplicationArea = All;
                Caption = 'Open Stamp Event';
                Image = Navigate;
                ToolTip = 'Opens the stamp event card for the selected line.';

                trigger OnAction()
                begin
                    OpenSelectedStampEvent();
                end;
            }

            action(ShowStackTrace)
            {
                ApplicationArea = All;
                Caption = 'Show Stack Trace';
                Image = ViewDetails;
                ToolTip = 'Shows the stack trace from the latest stamp event log for the selected line.';

                trigger OnAction()
                begin
                    ShowSelectedStackTrace();
                end;
            }
        }
    }

    local procedure DeleteSelectedErrors()
    var
        JMStampEventPostLog: Record "COL JM Stamp Event Post. Log";
    begin
        JMStampEventPostLog.DeleteAll(false);
        CurrPage.Update(false);
    end;

    local procedure OpenSelectedStampEvent()
    var
        JobManStampEvent: Record JobManStampEvent;
    begin
        if Rec.IsEmpty() then
            exit;

        if JobManStampEvent.Get(Rec."Line Sequence", Rec."Line Seq. Journal Line") then
            Page.Run(Page::JobManStampEvent, JobManStampEvent);
    end;

    local procedure ShowSelectedStackTrace()
    var
        JMStampEventPostLog: Record "COL JM Stamp Event Post. Log";
        NoStackTraceLbl: Label 'No stack trace available.';
        StackTraceText: Text;
    begin
        if Rec.IsEmpty() then
            exit;

        if Rec."Log Entry No." = 0 then
            exit;

        if not JMStampEventPostLog.Get(Rec."Log Entry No.") then
            exit;

        StackTraceText := JMStampEventPostLog.GetStackTrace();
        if StackTraceText = '' then
            Message(NoStackTraceLbl);
        Message(StackTraceText);
    end;
}
