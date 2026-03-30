namespace Weibel.Sales.Archive;

using Microsoft.Sales.Archive;

pageextension 70204 "COL Sales Order Archive" extends "Sales Order Archive"
{
    layout
    {
        addafter("Salesperson Code")
        {
            field("COL Sales Finance Category"; Rec."COL Sales Finance Category")
            {
                ApplicationArea = All;
            }
            field("COL Sales Order Category"; Rec."COL Sales Order Category")
            {
                ApplicationArea = All;
            }
        }
    }
}