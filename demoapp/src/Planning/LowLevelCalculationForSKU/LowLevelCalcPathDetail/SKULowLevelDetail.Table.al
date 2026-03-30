#if not HIDE_LOWLEVEL_SKU
namespace Weibel.Manufacturing.ProductionBOM;

using Microsoft.Inventory.Item;
using Microsoft.Inventory.Location;

table 70132 "COL SKU Low Level Detail"
{
    Caption = 'SKU Low Level Detail';
    DataClassification = SystemMetadata;
    DrillDownPageId = "COL SKU Low Level Detail";
    LookupPageId = "COL SKU Low Level Detail";

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            ToolTip = 'Specifies the value of the Item No. field.';
            TableRelation = Item;
        }
        field(2; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            ToolTip = 'Specifies the value of the Location Code field.';
            TableRelation = Location;
        }
        field(3; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            ToolTip = 'Specifies the value of the Variant Code field.';
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."));
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
            ToolTip = 'Specifies the value of the Line No. field.';
        }
        field(5; "Path Information"; Text[100])
        {
            Caption = 'Path Information';
            ToolTip = 'Specifies the value of the Path Information field.';
        }
        field(6; "Low Level Code"; Integer)
        {
            Caption = 'Low Level Code';
            ToolTip = 'Specifies the value of the Low Level Code field.';
        }
    }
    keys
    {
        key(PK; "Item No.", "Location Code", "Variant Code", "Line No.")
        {
            Clustered = true;
        }
    }
}
#endif