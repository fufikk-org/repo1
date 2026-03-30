
namespace Weibel.Service.History;

using Microsoft.Service.History;

pageextension 70252 "COL Posted Service Invoices" extends "Posted Service Invoices"
{
    layout
    {
        addlast(Control1)
        {
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
}
