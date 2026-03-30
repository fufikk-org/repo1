namespace Weibel.Warehouse.Document;

using Microsoft.Warehouse.Document;
using Microsoft.Inventory.Item;

tableextension 70105 "COL Warehouse Receipt Line" extends "Warehouse Receipt Line"
{
    fields
    {
        field(70100; "COL Print GTIN Label"; Boolean)
        {
            Caption = 'Print GTIN Label';
            ToolTip = 'Specifies if the GTIN label should be printed for the item';
            DataClassification = CustomerContent;
        }
        field(70101; "COL Serial No."; Code[50])
        {
            Caption = 'Serial No.';
            ToolTip = 'Specifies the serial number for the item.';
            DataClassification = CustomerContent;
        }
        field(70102; "COL Serial No. Required"; Boolean)
        {
            Caption = 'Serial No. Required';
            ToolTip = 'Specifies whether a serial number is required for the item.';
            FieldClass = FlowField;
            CalcFormula = Exist("Item" Where("No." = field("Item No."), "Item Tracking Code" = const('1')));
        }
    }

    keys
    {
        key(COLGTINKey; "COL Print GTIN Label")
        {
        }
    }
}