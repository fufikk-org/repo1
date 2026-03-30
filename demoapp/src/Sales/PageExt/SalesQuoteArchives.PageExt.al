namespace Weibel.Sales.Archive;

using Microsoft.Sales.Archive;

pageextension 70208 "COL Sales Quote Archives" extends "Sales Quote Archives"
{
    layout
    {
        addlast(Control1)
        {
            field("COL Sales Finance Category"; Rec."COL Sales Finance Category")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("COL Sales Order Category"; Rec."COL Sales Order Category")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}