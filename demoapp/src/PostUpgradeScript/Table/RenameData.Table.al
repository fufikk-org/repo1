namespace Weibel.UpgradeScript;

table 70128 "COL Rename Data"
{
    Caption = 'Rename Data';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Rename Type"; enum "COL Rename Type")
        {
            Caption = 'Rename Type';
        }
        field(3; "Old No."; Code[20])
        {
            Caption = 'Old No.';
        }
        field(4; "New No."; Code[20])
        {
            Caption = 'New No.';
        }
        field(5; Processed; Boolean)
        {
            Caption = 'Processed';
        }
        field(6; "Error"; Boolean)
        {
            Caption = 'Error';
        }
        field(7; "Error Description"; Text[250])
        {
            Caption = 'Error Description';
        }
        field(8; Selected; Boolean)
        {
            Caption = 'Selected';
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
