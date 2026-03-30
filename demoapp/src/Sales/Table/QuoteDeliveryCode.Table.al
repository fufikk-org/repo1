namespace Weibel.Foundation.QuoteDeliveryCodes;

table 70119 "COL Quote Delivery Code"
{
    Caption = 'Quote Delivery Code';
    DataCaptionFields = "Code", Description;
    DataClassification = CustomerContent;
    LookupPageId = "COL Quote Delivery Codes";

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
