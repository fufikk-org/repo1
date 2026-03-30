namespace Weibel.Inventory.Item;

using Microsoft.Purchases.Vendor;
using Microsoft.Inventory.Item;

table 70126 "COL Manufacturer"
{
    Caption = 'Manufacturer';
    DataClassification = CustomerContent;
    LookupPageId = "COL Manufacturers";
    DrillDownPageId = "COL Manufacturers";

    fields
    {
        field(1; "Code"; Code[30])
        {
            Caption = 'Code';
            ToolTip = 'Specifies the manufacturer code.';
        }
        field(2; Name; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the manufacturer description.';
        }
        field(3; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            ToolTip = 'Specifies the vendor number.';
            TableRelation = Vendor;
        }
        field(4; Website; Text[100])
        {
            Caption = 'Website';
            ToolTip = 'Specifies the manufacturer website.';
            ExtendedDatatype = URL;
        }
        field(5; "No. of Items"; Integer)
        {
            Caption = 'No. of Items';
            ToolTip = 'Specifies the number of items associated with this manufacturer.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count(Item where("COL Manufacturer" = field(Code)));
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
        fieldgroup(DropDown; Code, Name) { }
    }
}