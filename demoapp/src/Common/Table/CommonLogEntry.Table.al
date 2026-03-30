namespace Weibel.Common;

table 70145 "COL Common Log Entry"
{
    Caption = 'Common Log Entry';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Call Stack"; Blob)
        {
            Caption = 'Call Stack';
        }
        field(3; "Created At"; DateTime)
        {
            Caption = 'Created At';
        }
        field(4; "User Id"; Text[50])
        {
            Caption = 'User Id';
        }
        field(5; "Operation Source"; enum "COL Operation Source")
        {
            Caption = 'Operation Source';
        }
        field(100; "Old Serial No."; Code[50])
        {
            Caption = 'Old Serial No.';
        }
        field(101; "Serial No."; Code[50])
        {
            Caption = 'Serial No.';
        }
        field(103; "Prod Order No."; Code[20])
        {
            Caption = 'Prod Order No.';
        }
        field(104; "Prod Order Line"; Integer)
        {
            Caption = 'Prod Order Line';
        }
        field(105; Quantity; decimal)
        {
            Caption = 'Quantity';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(SK; "Prod Order No.", "Operation Source")
        {
        }
    }

    procedure SetRawMessage(RawMessage: Text)
    var
        lOutStream: OutStream;
    begin
        Clear(Rec."Call Stack");
        Rec."Call Stack".CreateOutStream(lOutStream);
        lOutStream.Write(RawMessage);
        Rec.Modify();
    end;

    procedure LoadRawMessage(var outText: Text)
    var
        lInStream: InStream;
    begin
        outText := '';
        Rec.CalcFields("Call Stack");
        if not Rec."Call Stack".HasValue() then
            exit;
        Rec."Call Stack".CreateInStream(lInStream);
        lInStream.ReadText(outText);
    end;
}
