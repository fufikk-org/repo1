namespace Weibel.Common;

table 70117 "COL Weibel Warranties"
{
    Caption = 'Weibel Warranties';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Warranty Code"; Code[20])
        {
            Caption = 'Warranty Code';
            ToolTip = 'Specifies the value of the Warranty Code field.';
        }
        field(2; "Warranty Description"; Text[50])
        {
            Caption = 'Warranty Description';
            ToolTip = 'Specifies the value of the Warranty Description field.';
        }
    }
    keys
    {
        key(PK; "Warranty Code")
        {
            Clustered = true;
        }
    }
}
