namespace Weibel.Sales.History;

using Microsoft.Foundation.Reporting;
using Microsoft.Sales.History;
using Weibel.Foundation.Reporting;
pageextension 70148 "COL Posted Sales Invoices" extends "Posted Sales Invoices"
{
    layout
    {
        addafter("No.")
        {
#pragma warning disable AA0218
            // standard field, no custom tooltip added
            field("COL Order No."; Rec."Order No.")
#pragma warning restore AA0218
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
        addlast(Control1)
        {
            field("COL Project No. PGS"; Rec."Project No. PGS")
            {
                ApplicationArea = All;
                ToolTip = 'Project No.';
                Editable = false;
            }
            field("COL Project Manager Code PGS"; Rec."Project Manager Code PGS")
            {
                ApplicationArea = All;
                ToolTip = 'Project Manager Code';
                Editable = false;
            }
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
}