namespace Weibel.Common;

table 70113 "COL Field Selected"
{
    Caption = 'Field Selected';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Table No."; Integer)
        {
            Caption = 'Table No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(2; "Field No."; Integer)
        {
            Caption = 'Table No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(3; "Code"; Code[50]) // to use if we have more field setup fore one table (like for different customer type etc.)
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Field Name"; Text[50])
        {
            Caption = 'Field Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(5; "Field Value"; Text[250])
        {
            Caption = 'Field Value';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; Selected; Boolean)
        {
            Caption = 'Selected';
            DataClassification = CustomerContent;
        }
        field(7; "Field Caption"; Text[50])
        {
            Caption = 'Field Caption';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Table No.", "Field No.", "Code")
        {
            Clustered = true;
        }
    }
}
