namespace Weibel.Foundation.OrderCategoryOld;

table 70138 "COL Order Category (Old)"
{
    Caption = 'Order Category (Old)';
    DataCaptionFields = "Code", Description;
    DataClassification = CustomerContent;
    LookupPageId = "COL Order Categories (Old)";

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