namespace Weibel.Purchases.Document;

using Microsoft.Purchases.Document;

pageextension 70232 "COL Purchase Quote Subform" extends "Purchase Quote Subform"
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
