namespace Weibel.Inventory.Transfer;

using Microsoft.Inventory.Transfer;

pageextension 70155 "COL Transfer Orders" extends "Transfer Orders"
{
    layout
    {
        addlast(Control1)
        {
            field("COL Shipping Status"; Rec."COL Shipping Status")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }
}