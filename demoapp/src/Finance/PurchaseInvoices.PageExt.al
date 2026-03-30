namespace Weibel.Finance;

using Microsoft.Purchases.Document;

pageextension 70276 "COL Purchase Invoices" extends "Purchase Invoices"
{
    layout
    {
        addlast(Control1)
        {
            field("COL Finance Approval Blocked"; Rec."COL Finance Approval Blocked")
            {
                ApplicationArea = All;
            }
            field("COL Finance Approval Resolved"; Rec."COL Finance Approval Resolved")
            {
                ApplicationArea = All;
            }
        }
    }
}
