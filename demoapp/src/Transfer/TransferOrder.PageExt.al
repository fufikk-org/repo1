namespace Weibel.Inventory.Transfer;

using Microsoft.Inventory.Transfer;

pageextension 70126 "COL Transfer Order" extends "Transfer Order"
{
    layout
    {
        addlast(General)
        {
            field("COL Shipping Status"; Rec."COL Shipping Status")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }
}
