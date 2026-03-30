namespace Weibel.Purchases.Document;

using Microsoft.Purchases.Document;

pageextension 70235 "COL Purch. Cr. Memo Subform" extends "Purch. Cr. Memo Subform"
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
