namespace Weibel.Sales.Document;

using Microsoft.Sales.Document;

pageextension 70203 "COL Sales Invoice List" extends "Sales Invoice List"
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

    views
    {
        addlast
        {
            view("COL Finance Category")
            {
                Caption = 'Finance Category';
                Filters = where("COL Sales Finance Category" = filter(''));
            }
        }
    }
}