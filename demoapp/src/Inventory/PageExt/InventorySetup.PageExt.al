namespace Weibel.Inventory.Setup;

using Microsoft.Inventory.Setup;

pageextension 70264 "COL Inventory Setup" extends "Inventory Setup"
{
    layout
    {
        addafter("Prevent Negative Inventory")
        {
            field("COL SKU Prevent Negative Inv."; Rec."COL SKU Prevent Negative Inv.")
            {
                ApplicationArea = All;
            }
        }
    }
}
