namespace Weibel.Purchases.History;

using Microsoft.Purchases.History;

pageextension 70241 "COL Posted Purch.Invoice Lines" extends "Posted Purchase Invoice Lines"
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
