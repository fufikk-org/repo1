namespace Weibel.Foundation.SalesOrderCategory;

table 70122 "COL Sales Order Category"
{
    Caption = 'Sales Order Category';
    DataCaptionFields = "Code", Description;
    DataClassification = CustomerContent;
    LookupPageId = "COL Sales Order Categories";

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
