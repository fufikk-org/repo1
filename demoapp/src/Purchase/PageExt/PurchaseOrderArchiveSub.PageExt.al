namespace Weibel.Purchases.Archive;

using Microsoft.Purchases.Archive;


pageextension 70245 "COL Purchase Order Archive Sub" extends "Purchase Order Archive Subform"
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
