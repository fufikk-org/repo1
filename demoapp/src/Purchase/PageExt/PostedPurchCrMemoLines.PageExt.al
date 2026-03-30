namespace Weibel.Purchases.History;

using Microsoft.Purchases.History;

pageextension 70243 "COL Posted Purch.Cr.Memo Lines" extends "Posted Purchase Cr. Memo Lines"
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
