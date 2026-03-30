namespace Weibel.Sales.Document;

using Microsoft.Sales.Document;

pageextension 70202 "COL Sales Quotes" extends "Sales Quotes"
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
            field("COL Export Classification Code"; Rec."COL Export Classification Code")
            {
                ApplicationArea = All;
            }
            field("COL Export Permit No."; Rec."COL Export Permit No.")
            {
                ApplicationArea = All;
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