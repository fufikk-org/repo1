namespace Weibel.Purchases.History;

using Microsoft.Purchases.History;

pageextension 70240 "COL Posted Purch. Invoice Sub." extends "Posted Purch. Invoice Subform"
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
