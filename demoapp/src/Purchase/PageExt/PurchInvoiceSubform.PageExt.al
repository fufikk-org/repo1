namespace Weibel.Purchases.Document;

using Microsoft.Purchases.Document;

pageextension 70234 "COL Purch. Invoice Subform" extends "Purch. Invoice Subform"
{
    layout
    {
        addlast(PurchDetailLine)
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
