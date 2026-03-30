namespace Weibel.Inventory.LegacyItems;

using Microsoft.Inventory.Item;

table 70107 "COL Legacy Item"
{
    Caption = 'Legacy Item';
    DataClassification = CustomerContent;
    LookupPageId = "COL Legacy Items";
    DrillDownPageId = "COL Legacy Items";

    fields
    {
        field(1; "NAV Item No."; Code[20])
        {
            Caption = 'NAV Item No.';
            ToolTip = 'Specifies the NAV Item No.';
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
            ToolTip = 'Specifies the Item No. in Business Central.';
        }
        field(3; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."));
            ToolTip = 'Specifies the item''s variant code in Business Central.';
        }
        field(4; "NAV Item Description"; Text[50])
        {
            Caption = 'NAV Item Description';
            ToolTip = 'Specifies the NAV Item Description.';
        }
        field(5; "NAV Item Description 2"; Text[50])
        {
            Caption = 'NAV Item Description 2';
            ToolTip = 'Specifies the NAV Item Description 2.';
        }
        field(6; "Item Description"; Text[100])
        {
            Caption = 'Item Description';
            ToolTip = 'Specifies the item description in Business Central.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup(Item.Description where("No." = field("Item No.")));
        }
        field(7; "Item Description 2"; Text[50])
        {
            Caption = 'Item Description 2';
            ToolTip = 'Specifies the item description 2 in Business Central.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."Description 2" where("No." = field("Item No.")));
        }
        field(8; "Variant Description"; Text[100])
        {
            Caption = 'Variant Description';
            ToolTip = 'Specifies the variant description in Business Central.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Item Variant".Description where("Item No." = field("Item No."), Code = field("Variant Code")));
        }
        field(9; "Variant Description 2"; Text[50])
        {
            Caption = 'Variant Description 2';
            ToolTip = 'Specifies the variant description 2 in Business Central.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Item Variant"."Description 2" where("Item No." = field("Item No."), Code = field("Variant Code")));
        }
    }
    keys
    {
        key(PK; "NAV Item No.")
        {
            Clustered = true;
        }
        key(Key2; "Item No.", "Variant Code") { }
    }
}
