namespace Weibel.Sales.Document;

using Microsoft.Sales.Document;

pageextension 70141 "COL Sales Hist. Bill-to F.Box" extends "Sales Hist. Bill-to FactBox"
{
    layout
    {
        addlast(Control23)
        {
            field("COL Ongoing Jobs (BillTo)"; Rec."COL Ongoing Jobs (BillTo)")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
