namespace Weibel.Purchases.Document;

using Microsoft.Purchases.Document;

pageextension 70239 "COL Purchase Return Order Sub." extends "Purchase Return Order Subform"
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
