namespace Weibel.Purchases.Archive;

using Microsoft.Purchases.Archive;

pageextension 70244 "COL Purchase Line Archive List" extends "Purchase Line Archive List"
{
    layout
    {
        addlast(Control14)
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
