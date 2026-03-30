namespace Weibel.Sales.Document;

using Microsoft.Sales.Document;

pageextension 70142 "COL Sales Hist. Sell-to F.Box" extends "Sales Hist. Sell-to FactBox"
{
    layout
    {
        addlast(Control2)
        {
            field("COL Ongoing Jobs (SellTo)"; Rec."COL Ongoing Jobs (SellTo)")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
