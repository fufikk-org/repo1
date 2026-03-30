namespace Weibel.Inventory.Setup;

using Microsoft.Inventory.Setup;

tableextension 70174 "COL Inventory Setup" extends "Inventory Setup"
{
    fields
    {
        field(70119; "COL SKU Prevent Negative Inv."; Boolean)
        {
            Caption = 'SKU Prevent Negative Inventory';
            ToolTip = 'Specifies whether to prevent negative inventory for SKUs.';
            DataClassification = CustomerContent;
        }
    }
}
