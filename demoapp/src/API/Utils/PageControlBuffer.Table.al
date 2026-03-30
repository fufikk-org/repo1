namespace Weibel.Utilities;

table 70115 "COL Page Control Buffer"
{
    Caption = 'Page Control Buffer';
    DataClassification = SystemMetadata;
    TableType = Temporary;

    fields
    {
        field(1; "Page Id"; Integer)
        {
            Caption = 'Page Id';
        }
        field(2; "Control Id"; Integer)
        {
            Caption = 'Control Id';
        }
        field(3; "Table Id"; Integer)
        {
            Caption = 'Table Id';
        }
        field(4; "Field Id"; Integer)
        {
            Caption = 'Field Id';
        }
        field(5; "Control Name"; Text[120])
        {
            Caption = 'Control Name';
        }
        field(6; "Field Name"; Text[80])
        {
            Caption = 'Field Name';
        }
        field(7; Type; Text[30])
        {
            Caption = 'Type';
        }
        field(8; "Type Name"; Text[30])
        {
            Caption = 'Type Name';
        }
        field(9; "Field Class"; Option)
        {
            Caption = 'Field Class';
            OptionMembers = Normal,FlowField,FlowFilter;
        }
        field(10; "Source Expression"; Text[512])
        {
            Caption = 'Source Expression';
        }
        field(11; "Api Group"; Text[40])
        {
            Caption = 'Api Group';
        }
        field(12; "Api Publisher"; Text[40])
        {
            Caption = 'Api Publisher';
        }
        field(13; "Api Version"; Text[250])
        {
            Caption = 'Api Version';
        }
        field(14; "Entity Set Name"; Text[250])
        {
            Caption = 'Entity Set Name';
        }
        field(16; Url; Text[1024])
        {
            Caption = 'Url';
        }
        field(17; Indentation; Integer)
        {
            Caption = 'Indentation';
        }
        field(18; "Page Info"; Text[250])
        {
            Caption = 'Page Info';
        }
        field(19; "Source Table"; Text[80])
        {
            Caption = 'Source Table';
        }
        field(20; "Source Table View"; Text[250])
        {
            Caption = 'Source Table View';
        }
    }
    keys
    {
        key(PK; "Page Id", "Control Id")
        {
            Clustered = true;
        }
        key(Key2; "Field Id") { }
        key(Key3; "Page Id", "Control Name")
        {
            MaintainSqlIndex = false;
        }
    }
}
