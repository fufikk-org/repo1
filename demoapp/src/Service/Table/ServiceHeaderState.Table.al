namespace Weibel.Service.Document;

table 70100 "COL Service Header State"
{
    Caption = 'Service Header State';
    DataClassification = CustomerContent;
    LookupPageId = "COL Service Order States";
    DrillDownPageId = "COL Service Order States";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            ToolTip = 'Specifies order state code.';
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies description of the order state code.';
        }
    }

    keys
    {
        key(PK; "Code") { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description) { }
    }
}