namespace Weibel.Service.History;

using Microsoft.Service.History;

pageextension 70185 "COL Posted Service Shipments" extends "Posted Service Shipments"
{
    layout
    {
        addlast(Control1)
        {
            field("COL Shipping Status"; Rec."COL Shipping Status")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}