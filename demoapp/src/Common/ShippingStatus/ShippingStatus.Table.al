namespace Weibel.Shipping;

table 70112 "COL Shipping Status"
{
    DataClassification = CustomerContent;
    Caption = 'Shipping Status';
    DrillDownPageId = "COL Shipping Statuses";
    LookupPageId = "COL Shipping Statuses";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            ToolTip = 'Specifies shipping status code.';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies shipping status description.';
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Code, Description) { }
    }
}
