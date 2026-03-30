namespace Weibel.Packaging;

table 70102 "COL Package Type"
{
    Caption = 'Package Type';
    DataClassification = CustomerContent;
    LookupPageId = "COL Package Types";
    DrillDownPageId = "COL Package Types";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            ToolTip = 'Specifies the package code.';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies package type description.';
        }
        field(3; Length; Decimal)
        {
            Caption = 'Length';
            MinValue = 0;
            DecimalPlaces = 0 : 2;
            ToolTip = 'Specifies package length.';
        }
        field(4; Width; Decimal)
        {
            Caption = 'Width';
            MinValue = 0;
            DecimalPlaces = 0 : 2;
            ToolTip = 'Specifies package width.';
        }
        field(5; Height; Decimal)
        {
            Caption = 'Height';
            MinValue = 0;
            DecimalPlaces = 0 : 2;
            ToolTip = 'Specifies package height.';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
