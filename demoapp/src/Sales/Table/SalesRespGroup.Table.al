namespace Weibel.Foundation.SalesResponsibilityGroup;

table 70200 "COL Sales Resp. Group"
{
    Caption = 'Sales Responsibility Group';
    DataCaptionFields = "Code", Description;
    DataClassification = CustomerContent;
    LookupPageId = "COL Sales Resp. Groups";
    DrillDownPageId = "COL Sales Resp. Groups";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            ToolTip = 'Specifies the code for the sales responsibility group.';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the sales responsibility group.';
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