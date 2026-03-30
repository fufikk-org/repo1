namespace Weibel.Inventory.Planning;

table 70123 "COL Planning Error Log Arch."
{
    Caption = 'Planning Error Log Arch.';
    DataClassification = CustomerContent;

    fields
    {
        field(1000; "Arch. Entry No."; Integer)
        {
            Caption = 'Arch. Entry No.';
        }
        field(1; "Worksheet Template Name"; Code[10])
        {
            Caption = 'Worksheet Template Name';
        }
        field(2; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
        }
        field(3; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(4; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(5; "Error Description"; Text[250])
        {
            Caption = 'Error Description';
        }
        field(6; "Table ID"; Integer)
        {
            Caption = 'Table ID';
        }
        field(7; "Table Position"; Text[250])
        {
            Caption = 'Table Position';
        }
    }
    keys
    {
        key(PK; "Arch. Entry No.")
        {
            Clustered = true;
        }
    }
}
