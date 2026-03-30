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

                    field(COLCopyExternalDocumentNo; CopyExternalDocumentNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Copy External Document No.';
                        ToolTip = 'Copy the External Document No. from the Source Document to the Target Document.';
                    }

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

                    group(COLGroupSales)
                    {
                        Caption = 'Group Sales';

                        field(COLCopyCompany; CopyCompany)
                        {
                            ApplicationArea = All;
                            Caption = 'Copy Company';
                            ToolTip = 'Copy the Company from the Source Document to the Target Document.';
                        }
                        field(COLCopySalesPersonCode; CopySalespersonCode)
                        {
                            ApplicationArea = All;
                            Caption = 'Copy Salesperson Code';
                            ToolTip = 'Copy the Salesperson Code from the Source Document to the Target Document.';
                        }
                        field(COLCopyAddress; CopyAddress)
                        {
                            ApplicationArea = All;
                            Caption = 'Copy Address';
                            ToolTip = 'Copy the Address from the Source Document to the Target Document.';
                        }
                        field(COLCopyAddress2; CopyAddress2)
                        {
                            ApplicationArea = All;
                            Caption = 'Copy Address 2';
                            ToolTip = 'Copy the Address 2 from the Source Document to the Target Document.';
                        }
                        field(COLCopyCity; CopyCity)
                        {
                            ApplicationArea = All;
                            Caption = 'Copy City';
                            ToolTip = 'Copy the City from the Source Document to the Target Document.';
                        }
                        field(COLCopyCountryRegion; CopyCountryRegion)
                        {
                            ApplicationArea = All;
                            Caption = 'Copy Country/Region';
                            ToolTip = 'Copy the Country/Region from the Source Document to the Target Document.';
                        }
                        field(COLCopyCounty; CopyCounty)
                        {
                            ApplicationArea = All;
                            Caption = 'Copy County';
                            ToolTip = 'Copy the County from the Source Document to the Target Document.';
                        }
                        field(COLCopyPostCode; CopyPostCode)
                        {
                            ApplicationArea = All;
                            Caption = 'Copy Post Code';
                            ToolTip = 'Copy the Post Code from the Source Document to the Target Document.';
                        }
                        field(COLCopyCustomerNo; CopyCustomerNo)
                        {
                            ApplicationArea = All;
                            Caption = 'Copy Customer No.';
                            ToolTip = 'Copy the Customer No. from the Source Document to the Target Document.';
                        }
                        field(COLCopyEmail; CopyEmail)
                        {
                            ApplicationArea = All;
                            Caption = 'Copy Email';
                            ToolTip = 'Copy the Email from the Source Document to the Target Document.';
                        }
                        field(COLCopyName; CopyName)
                        {
                            ApplicationArea = All;
                            Caption = 'Copy Name';
                            ToolTip = 'Copy the Name from the Source Document to the Target Document.';
                        }
                        field(COLCopyName2; CopyName2)
                        {
                            ApplicationArea = All;
                            Caption = 'Copy Name 2';
                            ToolTip = 'Copy the Name 2 from the Source Document to the Target Document.';
                        }
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
            CopyExternalDocumentNo := false;

            CopyAddress := false;
            CopyAddress2 := false;
            CopyCity := false;
            CopyCompany := false;
            CopyCountryRegion := false;
            CopyCounty := false;
            CopyCustomerNo := false;
            CopyEmail := false;
            CopyName := false;
            CopyName2 := false;
            CopyPostCode := false;
            CopySalespersonCode := false;
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
            OldExternalDocumentNo := SalesHeader."External Document No.";

            OldAddress := SalesHeader."COL GS. Address";
            OldAddress2 := SalesHeader."COL GS. Address 2";
            OldCity := SalesHeader."COL GS. City";
            OldCompany := SalesHeader."COL GS. Company";
            OldCounty := SalesHeader."COL GS. County";
            OldCountryRegion := SalesHeader."COL GS. Country/Region";
            OldCustomerNo := SalesHeader."COL GS. Customer No.";
            OldSalespersonCode := SalesHeader."COL GS. Salesperson Code";
            OldPostCode := SalesHeader."COL GS. Post Code";
            OldEmail := SalesHeader."COL GS. E-Mail";
            OldName := SalesHeader."COL GS. Name";
            OldName2 := SalesHeader."COL GS. Name 2";


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

            SalesHeader."External Document No." := '';
            if CopyExternalDocumentNo then
                SalesHeader.Validate("External Document No.", OldExternalDocumentNo);

            SalesHeader."COL GS. Address" := '';
            SalesHeader."COL GS. Address 2" := '';
            SalesHeader."COL GS. City" := '';
            SalesHeader."COL GS. Company" := '';
            SalesHeader."COL GS. Country/Region" := '';
            SalesHeader."COL GS. County" := '';
            SalesHeader."COL GS. Customer No." := '';
            SalesHeader."COL GS. E-Mail" := '';
            SalesHeader."COL GS. Name" := '';
            SalesHeader."COL GS. Name 2" := '';
            SalesHeader."COL GS. Post Code" := '';
            SalesHeader."COL GS. Address" := '';

            if CopyCompany then
                SalesHeader.Validate("COL GS. Company", OldCompany);

            if CopyPostCode then
                SalesHeader."COL GS. Post Code" := OldPostCode;
            if CopyCity then
                SalesHeader."COL GS. City" := OldCity;

            if CopyAddress then
                SalesHeader.Validate("COL GS. Address", OldAddress);
            if CopyAddress2 then
                SalesHeader.Validate("COL GS. Address 2", OldAddress2);

            if CopyCountryRegion then
                SalesHeader.Validate("COL GS. Country/Region", OldCountryRegion);
            if CopyCounty then
                SalesHeader.Validate("COL GS. County", OldCounty);
            if CopyCustomerNo then
                SalesHeader.Validate("COL GS. Customer No.", OldCustomerNo);
            if CopyEmail then
                SalesHeader.Validate("COL GS. E-Mail", OldEmail);
            if CopyName then
                SalesHeader.Validate("COL GS. Name", OldName);
            if CopyName2 then
                SalesHeader.Validate("COL GS. Name 2", OldName2);
            if CopySalespersonCode then
                SalesHeader.Validate("COL GS. Salesperson Code", OldSalespersonCode);

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
        OldExternalDocumentNo: Code[35];
        OldAddress, OldName : Text[100];
        OldAddress2, OldName2 : Text[50];
        OldCity, OldCompany, OldCounty : Text[30];
        OldCountryRegion: Code[10];
        OldCustomerNo, OldPostCode : Code[20];
        OldEmail: Text[80];
        OldSalespersonCode: Code[20];

        CopyDocumentDate: Boolean;
        CopyPostingDate: Boolean;
        CopyOrderDate: Boolean;
        CopyVATDate: Boolean;
        CopyRequestedDeliveryDate: Boolean;
        CopyPromisedDeliveryDate: Boolean;
        CopyOriginalContractualDate: Boolean;
        CopyExternalDocumentNo: Boolean;

        CopyAddress: Boolean;
        CopyAddress2: Boolean;
        CopyCity: Boolean;
        CopyCompany: Boolean;
        CopyCountryRegion: Boolean;
        CopyCounty: Boolean;
        CopyCustomerNo: Boolean;
        CopyEmail: Boolean;
        CopyName: Boolean;
        CopyName2: Boolean;
        CopyPostCode: Boolean;
        CopySalespersonCode: Boolean;

}
