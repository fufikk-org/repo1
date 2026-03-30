namespace Weibel.Purchases.Document;

using Microsoft.Purchases.Document;

pageextension 70233 "COL Purchase Order Subform" extends "Purchase Order Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("COL Purchaser Code"; Rec."COL Purchaser Code")
            {
                Visible = false;
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
}
