namespace Weibel.Inventory.Transfer;

using Microsoft.Inventory.Transfer;

pageextension 70156 "COL Posted Transfer Shipments" extends "Posted Transfer Shipments"
{
    layout
    {
        addlast(Control1)
        {
            field("COL Shipping Status"; Rec."COL Shipping Status")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
        }
    }
}