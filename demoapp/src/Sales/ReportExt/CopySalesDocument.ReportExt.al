namespace Weibel.Sales.Document;

using Microsoft.Sales.Document;
using Weibel.Inventory.Item;

reportextension 70107 "COL Copy Sales Document" extends "Copy Sales Document"
{

    requestpage
    {
        layout
        {
            addlast(content)
            {
                group("COL Header Fields")
                {
                    Caption = 'Header Fields';
                    Visible = IncludeHeader;

                    field(COLCopyDocumentDate; CopyDocumentDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Copy Document Date';
                        ToolTip = 'Copy the Document Date from the Source Document to the Target Document.';
                    }
                    field(COLCopyPostingDate; CopyPostingDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Copy Posting Date';
                        ToolTip = 'Copy the Posting Date from the Source Document to the Target Document.';
                    }
                    field(COLCopyOrderDate; CopyOrderDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Copy Order Date';
                        ToolTip = 'Copy the Order Date from the Source Document to the Target Document.';
                    }
                    field(COLCopyVATDate; CopyVATDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Copy VAT Date';
                        ToolTip = 'Copy the VAT Date from the Source Document to the Target Document.';
                    }
                    field(COLCopyRequestedDeliveryDate; CopyRequestedDeliveryDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Copy Requested Delivery Date';
                        ToolTip = 'Copy the Requested Delivery Date from the Source Document to the Target Document.';
                    }
                    field(COLCopyPromisedDeliveryDate; CopyPromisedDeliveryDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Copy Promised Delivery Date';
                        ToolTip = 'Copy the Promised Delivery Date from the Source Document to the Target Document.';
                    }
                    field(COLCopyOriginalContractualDate; CopyOriginalContractualDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Copy Original Contractual Date';
                        ToolTip = 'Copy the Original Contractual Date from the Source Document to the Target Document.';
                    }

                }

            }
        }

        trigger OnOpenPage()
        begin
            CopyDocumentDate := false;
            CopyPostingDate := false;
            CopyOrderDate := false;
            CopyVATDate := false;
            CopyRequestedDeliveryDate := false;
            CopyPromisedDeliveryDate := false;
            CopyOriginalContractualDate := false;
        end;
    }
    trigger OnPostReport()
    begin
        if IncludeHeader then begin
            OldDocumentDate := SalesHeader."Document Date";
            OldPostingDate := SalesHeader."Posting Date";
            OldOrderDate := SalesHeader."Order Date";
            OldVATDate := SalesHeader."VAT Reporting Date";
            OldRequestedDeliveryDate := SalesHeader."Requested Delivery Date";
            OldPromisedDeliveryDate := SalesHeader."Promised Delivery Date";
            OldOriginalContractualDate := SalesHeader."COL Original Contractual Date";


            if not CopyPostingDate then
                SalesHeader.Validate("Posting Date", Today());

            SalesHeader."Document Date" := 0D;
            if CopyDocumentDate then
                SalesHeader.Validate("Document Date", OldDocumentDate);

            SalesHeader."Order Date" := 0D;
            if CopyOrderDate then
                SalesHeader.Validate("Order Date", OldOrderDate);

            SalesHeader."VAT Reporting Date" := 0D;
            if CopyVATDate then
                SalesHeader.Validate("VAT Reporting Date", OldVATDate);

            SalesHeader."Requested Delivery Date" := 0D;
            SalesHeader."Promised Delivery Date" := 0D;

            if CopyRequestedDeliveryDate then
                SalesHeader.Validate("Requested Delivery Date", OldRequestedDeliveryDate);

            if CopyPromisedDeliveryDate then
                SalesHeader.Validate("Promised Delivery Date", OldPromisedDeliveryDate);

            SalesHeader."COL Original Contractual Date" := 0D;
            if CopyOriginalContractualDate then
                SalesHeader.Validate("COL Original Contractual Date", OldOriginalContractualDate);

            SalesHeader."COL Export Classification Code" := Enum::"COL Item Export Classification"::Unknown;
            SalesHeader.Modify();
        end;


    end;

    var
        OldPostingDate: Date;
        OldDocumentDate: Date;
        OldOrderDate: Date;
        OldVATDate: Date;
        OldRequestedDeliveryDate: Date;
        OldPromisedDeliveryDate: Date;
        OldOriginalContractualDate: Date;

        CopyDocumentDate: Boolean;
        CopyPostingDate: Boolean;
        CopyOrderDate: Boolean;
        CopyVATDate: Boolean;
        CopyRequestedDeliveryDate: Boolean;
        CopyPromisedDeliveryDate: Boolean;
        CopyOriginalContractualDate: Boolean;

}
