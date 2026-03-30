namespace Weibel.Warehouse.Document;

using Microsoft.Warehouse.Document;

pageextension 70109 "COL Whse. Receipt Subform" extends "Whse. Receipt Subform"
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