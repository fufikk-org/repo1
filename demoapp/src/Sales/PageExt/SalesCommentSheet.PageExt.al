namespace Weibel.Sales.Comment;

using Microsoft.Sales.Comment;

pageextension 70219 "COL Sales Comment Sheet" extends "Sales Comment Sheet"
{
    layout
    {
        addlast(Control1)
        {
            field("COL Quote"; Rec."COL Quote")
            {
                ApplicationArea = All;
            }
            field("COL Order"; Rec."COL Order")
            {
                ApplicationArea = All;
            }
            field("COL Shipment"; Rec."COL Shipment")
            {
                ApplicationArea = All;
            }
            field("COL Invoice"; Rec."COL Invoice")
            {
                ApplicationArea = All;
            }
        }
    }
}
