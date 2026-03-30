namespace Weibel.Sales.Document;

using Microsoft.Sales.Document;

pageextension 70182 "COL Sales Invoice Subform" extends "Sales Invoice Subform"
{
    layout
    {
        addafter(Description)
        {
            field("COL Assembly BOM"; Rec."COL Assembly BOM")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
