namespace Weibel.Foundation.TermsAndConditions;

table 70124 "COL Terms and Conditions"
{
    Caption = 'Terms and Conditions';
    DataClassification = CustomerContent;
    LookupPageId = "COL Terms and Conditions";
    DrillDownPageId = "COL Terms and Conditions";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            ToolTip = 'Specifies code for the terms and conditions.';
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Description of the terms and conditions.';
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description)
        {
        }
        fieldgroup(Brick; "Code", Description)
        {
        }
    }
}
