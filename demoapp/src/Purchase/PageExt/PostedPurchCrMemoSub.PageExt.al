namespace Weibel.Purchases.History;

using Microsoft.Purchases.History;

pageextension 70242 "COL Posted Purch. Cr. Memo Sub" extends "Posted Purch. Cr. Memo Subform"
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
