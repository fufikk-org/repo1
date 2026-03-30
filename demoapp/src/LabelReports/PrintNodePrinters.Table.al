table 70127 "COL PrintNode Printers"
{
    Caption = 'PrintNode Printers';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Printer Id"; Integer)
        {
            Caption = 'Printer Id';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the unique identifier for the PrintNode printer.';
            BlankZero = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the description of the printer.';
        }
        field(3; "Default Label Size"; Enum "COL Cable Size")
        {
            Caption = 'Default Label Size';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the default cable label size for this printer.';
        }
    }

    keys
    {
        key(PK; "Printer Id")
        {
            Clustered = true;
        }
    }
}
