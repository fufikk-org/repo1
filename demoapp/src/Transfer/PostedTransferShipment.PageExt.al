namespace Weibel.Inventory.Transfer;

using Microsoft.Inventory.Transfer;

pageextension 70127 "COL Posted Transfer Shipment" extends "Posted Transfer Shipment"
{
    layout
    {
        addlast(General)
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