namespace Weibel.Sales.Customer;

using Microsoft.Sales.Customer;

pageextension 70135 "COL Customer Card" extends "Customer Card"
{
    layout
    {
        addlast("General")
        {
            field("COL End User"; Rec."COL End User")
            {
                ApplicationArea = All;
            }
        }
    }
}
