namespace Weibel.Warehouse.Document;

using Microsoft.Warehouse.Document;

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
    }

    keys
    {
        key(COLGTINKey; "COL Print GTIN Label")
        {
        }
    }
}