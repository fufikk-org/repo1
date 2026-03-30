namespace Weibel.Sales.Archive;

using Microsoft.Sales.Archive;

pageextension 70207 "COL Sales Order Archives" extends "Sales Order Archives"
{
    layout
    {
        addafter("Version No.")
        {
            field("COL Status"; Rec.Status)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
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