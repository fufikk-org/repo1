namespace Weibel.Intercompany;

using Microsoft.Sales.Receivables;
using Microsoft.Sales.Setup;

pageextension 70270 "COL Cust. Ledger Entries Ext" extends "Customer Ledger Entries"
{
    layout
    {
        addfirst(factboxes)
        {
            part(COLICSourceAttachments; "COL IC Source Doc Attachments")
            {
                ApplicationArea = All;
                Caption = 'Source Company Attachments';
                SubPageLink = "Line No." = field("Entry No.");
                Visible = ShowICAttachments;
            }
        }
    }

    trigger OnOpenPage()
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        if SalesSetup.Get() then
            ShowICAttachments := SalesSetup."COL Show IC Attachments";
    end;

    var
        ShowICAttachments: Boolean;
}
