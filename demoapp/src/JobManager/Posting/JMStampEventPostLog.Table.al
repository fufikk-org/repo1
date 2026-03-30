namespace Weibel.JobManager;

table 70201 "COL JM Stamp Event Post. Log"
{
    Caption = 'JM Stamp Event Posting Log';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            ToolTip = 'Specifies the unique entry number for the log record.';
        }
        field(10; "Line Sequence"; Integer)
        {
            Caption = 'Line Sequence';
            ToolTip = 'Specifies the Line Sequence from the JobManStampEvent table.';
        }

        field(11; "Line Seq. Journal Line"; Integer)
        {
            Caption = 'Line Seq. Journal Line';
            ToolTip = 'Specifies the Line Sequence Journal Line from the JobManStampEvent table.';
        }

        field(20; "Posting Date-Time"; DateTime)
        {
            Caption = 'Posting Date-Time';
            ToolTip = 'Specifies when the posting attempt occurred.';
        }
        field(21; "User ID"; Code[50])
        {
            Caption = 'User ID';
            ToolTip = 'Specifies the user who attempted to post the stamp event.';
        }
        field(30; "Error Text"; Text[2048])
        {
            Caption = 'Error Text';
            ToolTip = 'Specifies the error message that occurred during posting.';
        }
        field(31; "Stack Trace"; Blob)
        {
            Caption = 'Stack Trace';
            ToolTip = 'Specifies the full stack trace of the error.';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(LineSeq; "Line Sequence", "Line Seq. Journal Line")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Entry No." = 0 then
            "Entry No." := GetNextEntryNo();

        if "Posting Date-Time" = 0DT then
            "Posting Date-Time" := CurrentDateTime();

        if "User ID" = '' then
            "User ID" := CopyStr(UserId(), 1, MaxStrLen("User ID"));
    end;

    local procedure GetNextEntryNo(): Integer
    var
        JMStampEventPostingLog: Record "COL JM Stamp Event Post. Log";
    begin
        JMStampEventPostingLog.Reset();
        if JMStampEventPostingLog.FindLast() then
            exit(JMStampEventPostingLog."Entry No." + 1);
        exit(1);
    end;

    procedure SetStackTrace(StackTraceText: Text)
    var
        OutStream: OutStream;
    begin
        Clear(Rec."Stack Trace");
        Rec."Stack Trace".CreateOutStream(OutStream, TextEncoding::UTF8);
        OutStream.Write(StackTraceText);
        Rec.Modify();
    end;

    procedure GetStackTrace() StackTraceText: Text
    var
        InStream: InStream;
    begin
        StackTraceText := '';
        Rec.CalcFields("Stack Trace");
        if not Rec."Stack Trace".HasValue() then
            exit('');
        Rec."Stack Trace".CreateInStream(InStream, TextEncoding::UTF8);
        InStream.ReadText(StackTraceText);
    end;

    procedure LogError(JobManStampEventRec: Record JobManStampEvent; ErrorText: Text; StackTraceText: Text)
    var
        JMStampEventPostingLog: Record "COL JM Stamp Event Post. Log";
    begin
        JMStampEventPostingLog.Init();
        JMStampEventPostingLog."Line Sequence" := JobManStampEventRec.LineSequence;
        JMStampEventPostingLog."Line Seq. Journal Line" := JobManStampEventRec.LineSequenceJournalLine;
        JMStampEventPostingLog."Error Text" := CopyStr(ErrorText, 1, MaxStrLen(JMStampEventPostingLog."Error Text"));

        JMStampEventPostingLog.Insert(true);

        if StackTraceText <> '' then
            JMStampEventPostingLog.SetStackTrace(StackTraceText);
    end;

    procedure DeleteByLineSequence(LineSequence: Integer; LineSeqJournalLine: Integer)
    var
        JMStampEventPostingLog: Record "COL JM Stamp Event Post. Log";
    begin
        JMStampEventPostingLog.SetRange("Line Sequence", LineSequence);
        JMStampEventPostingLog.SetRange("Line Seq. Journal Line", LineSeqJournalLine);
        if not JMStampEventPostingLog.IsEmpty() then
            JMStampEventPostingLog.DeleteAll(true);
    end;
}
