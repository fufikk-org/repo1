namespace Weibel.Kardex;

table 70141 "COL Kardex Input Log"
{
    Caption = 'Kardex Input Log';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Log Date-Time"; DateTime)
        {
            Caption = 'Log Date-Time';
        }
        field(10; "Raw Message"; Blob)
        {
            Caption = 'Raw Message';
            ToolTip = 'Specifies the raw message content of the Kardex message.';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(LogDateTime; "Log Date-Time")
        {
        }
    }

    procedure CreateLog(InText: Text)
    var
        KardexInputLog: Record "COL Kardex Input Log";
    begin
        KardexInputLog.Reset();
        KardexInputLog.Init();
        if KardexInputLog.FindLast() then
            KardexInputLog."Entry No." := KardexInputLog."Entry No." + 1
        else
            KardexInputLog."Entry No." := 1;

        KardexInputLog."Log Date-Time" := CurrentDateTime();
        KardexInputLog.Insert(true);
        KardexInputLog.SetRawMessage(InText);
    end;

    procedure SetRawMessage(RawMessage: Text)
    var
        lOutStream: OutStream;
    begin
        Clear(Rec."Raw Message");
        Rec."Raw Message".CreateOutStream(lOutStream);
        lOutStream.Write(RawMessage);
        Rec.Modify();
    end;

    procedure LoadRawMessage(var outText: Text)
    var
        lInStream: InStream;
    begin
        outText := '';
        Rec.CalcFields("Raw Message");
        if not Rec."Raw Message".HasValue() then
            exit;
        Rec."Raw Message".CreateInStream(lInStream);
        lInStream.ReadText(outText);
    end;
}
