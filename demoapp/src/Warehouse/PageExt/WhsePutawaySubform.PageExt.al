namespace Weibel.Warehouse.Activity;

using Microsoft.Warehouse.Activity;

pageextension 70256 "COL Whse. Put-away Subform" extends "Whse. Put-away Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("COL Print GTIN Label"; Rec."COL Print GTIN Label")
            {
                ApplicationArea = All;
            }
        }
    }
}
