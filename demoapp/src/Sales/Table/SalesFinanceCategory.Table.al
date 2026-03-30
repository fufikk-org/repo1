namespace Weibel.Foundation.FinanceCategory;

table 70121 "COL Sales Finance Category"
{
    Caption = 'Sales Finance Category';
    DataCaptionFields = "Code", Description;
    DataClassification = CustomerContent;
    LookupPageId = "COL Sales Finance Categories";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
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
