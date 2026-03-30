namespace Weibel.JobManager;

table 70203 "COL JM Stamp Error Buf"
{
    Caption = 'JM Stamp Error Buffer';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            ToolTip = 'Specifies the unique entry number for the buffer record.';
        }
        field(10; "Line Sequence"; Integer)
        {
            Caption = 'Line Sequence';
            ToolTip = 'Specifies the line sequence of the stamp event.';
        }
        field(11; "Line Seq. Journal Line"; Integer)
        {
            Caption = 'Line Seq. Journal Line';
            ToolTip = 'Specifies the journal line sequence of the stamp event.';
        }
        field(20; "Event Timestamp"; DateTime)
        {
            Caption = 'Event Timestamp';
            ToolTip = 'Specifies when the stamp event occurred.';
        }
        field(21; "Event Type"; Text[50])
        {
            Caption = 'Event Type';
            ToolTip = 'Specifies the type of the stamp event.';
        }
        field(22; "Event Status"; Text[30])
        {
            Caption = 'Event Status';
            ToolTip = 'Specifies the status of the stamp event.';
        }
        field(30; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            ToolTip = 'Specifies the employee number linked to the stamp event.';
        }
        field(31; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            ToolTip = 'Specifies the job number linked to the stamp event.';
        }
        field(32; "Profile Date"; Date)
        {
            Caption = 'Profile Date';
            ToolTip = 'Specifies the profile date of the stamp event.';
        }
        field(40; "Posting Attempts"; Integer)
        {
            Caption = 'Posting Attempts';
            ToolTip = 'Specifies how many posting attempts have been made.';
        }
        field(50; "Log Entry No."; Integer)
        {
            Caption = 'Log Entry No.';
            ToolTip = 'Specifies the entry number from the stamp event log.';
        }
        field(51; "Log Posting Date-Time"; DateTime)
        {
            Caption = 'Log Posting Date-Time';
            ToolTip = 'Specifies when the latest log entry was created.';
        }
        field(52; "Log User ID"; Code[50])
        {
            Caption = 'Log User ID';
            ToolTip = 'Specifies the user captured on the latest log entry.';
        }
        field(53; "Log Error Text"; Text[2048])
        {
            Caption = 'Log Error Text';
            ToolTip = 'Specifies the error message from the latest log entry.';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
