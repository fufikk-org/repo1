namespace Weibel.Kardex;

table 70135 "COL Kardex Msg. Header"
{
    Caption = 'Kardex Msg. Header';
    DataClassification = CustomerContent;
    LookupPageId = "COL Kardex Msg. Headers";
    DrillDownPageId = "COL Kardex Msg. Headers";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            ToolTip = 'Specifies the value of the Entry No. field.';
        }
        field(2; "Related Log Line"; Integer)
        {
            Caption = 'Related Log Line';
            ToolTip = 'Specifies the value of the Related Log Line field.';
        }
        field(3; "Order Number 1"; Code[20])
        {
            Caption = 'Order Number 1';
            ToolTip = 'Specifies the value of the Order Number 1 field.';
        }
        field(4; "Order Number 2"; Code[20])
        {
            Caption = 'Order Number 2';
            ToolTip = 'Specifies the value of the Order Number 2 field.';
        }
        field(5; "Order Number 3"; Code[20])
        {
            Caption = 'Order Number 3';
            ToolTip = 'Specifies the value of the Order Number 3 field.';
        }
        field(6; "Kardex Type"; Enum "COL Kardex Type")
        {
            Caption = 'Kardex Type';
            ToolTip = 'Specifies the type of Kardex message.';
        }
        field(7; Response; Boolean)
        {
            Caption = 'Response';
            ToolTip = 'Specifies the value of the Response field.';
        }
        field(8; "Response Type"; Enum "COL Kardex Res. Type")
        {
            Caption = 'Response Type';
            ToolTip = 'Specifies the type of response for the Kardex message.';
        }
        field(9; Processed; Boolean)
        {
            Caption = 'Processed';
            ToolTip = 'Specifies the message was already processed.';
        }
        field(10; "Skip Handling"; Boolean)
        {
            Caption = 'Skip Handling';
            ToolTip = 'Specifies that the Kardex message should be skipped for handling.';
        }
        field(11; "Raw Message"; Blob)
        {
            Caption = 'Raw Message';
            ToolTip = 'Specifies the raw message content of the Kardex message.';
        }
        field(12; "Has Error"; Boolean)
        {
            Caption = 'Has Error';
            ToolTip = 'Specifies whether the Kardex message has an error.';
        }
        field(13; "Error Description"; Text[250])
        {
            Caption = 'Error Description';
            ToolTip = 'Specifies the error message for the Kardex message.';
        }
        field(14; "Delete Req. Message"; Boolean)
        {
            Caption = 'Delete Request Message';
            ToolTip = 'Specifies whether a delete request message has been sent for the Kardex message.';
        }
    }
    keys
    {
        key(PK; "Entry No.", "Related Log Line")
        {
            Clustered = true;
        }
        key(SK; "Entry No.", "Response", "Delete Req. Message", "Related Log Line")
        { }
    }

    trigger OnDelete()
    var
        KardexMsgLine: Record "COL Kardex Msg. Line";
    begin
        KardexMsgLine.SetRange("Entry No.", Rec."Entry No.");
        KardexMsgLine.SetRange("Related Log Line", Rec."Related Log Line");
        KardexMsgLine.DeleteAll(true);
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

    procedure SetRawMessage(var xmlDoc: XmlDocument)
    var
        lOutStream: OutStream;
    begin
        Clear(Rec."Raw Message");
        Rec."Raw Message".CreateOutStream(lOutStream);
        xmlDoc.WriteTo(lOutStream);
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
