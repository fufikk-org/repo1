namespace Weibel.Sales.History;

using Microsoft.Sales.History;

pageextension 70154 "COL Posted Sales Shipments" extends "Posted Sales Shipments"
{
    layout
    {
        addafter("No.")
        {
#pragma warning disable AA0218
            // standard field, no custom tooltip added
            field("COL Order No."; Rec."Order No.")
#pragma warning restore AA0218
            {
                ApplicationArea = All;
            }
        }
        addlast(Control1)
        {
            field("COL Shipping Status"; Rec."COL Shipping Status")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("COL Original Promised Date"; Rec."COL Original Promised Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
