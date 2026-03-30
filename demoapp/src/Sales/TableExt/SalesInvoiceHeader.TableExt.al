namespace Weibel.Sales.History;

using Microsoft.Sales.History;
using Weibel.Common;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.Address;
using Weibel.Inventory.Item;
using System.Environment;
using Weibel.Foundation.FinanceCategory;
using Weibel.Foundation.SalesOrderCategory;
using Weibel.Foundation.TermsAndConditions;
using Microsoft.Foundation.Reporting;

tableextension 70120 "COL Sales Invoice Header" extends "Sales Invoice Header"
{
    fields
    {
        field(70101; "COL Original Contractual Date"; Date)
        {
            Caption = 'Original Contractual Date';
            DataClassification = CustomerContent;
            ToolTip = 'Original Contractual date is the date that the contract was signed by both parties.';
        }
        field(70102; "COL End User Type"; enum "COL End User Type")
        {
            Caption = 'End User Type';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the end user type.';
        }
        field(70103; "COL Existing End User No."; Code[20])
        {
            Caption = 'Existing End User No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Existing End User No.';
            TableRelation = "Customer"."No." where("COL End User" = Const(True));
        }
        field(70104; "COL End User Name"; Text[100])
        {
            Caption = 'End User Name';
            ToolTip = 'Specifies the end user name.';
            DataClassification = CustomerContent;
        }
        field(70105; "COL End User Name 2"; Text[50])
        {
            Caption = 'End User Name 2';
            ToolTip = 'Specifies the end user name 2.';
            DataClassification = CustomerContent;
        }
        field(70106; "COL End User Address"; Text[100])
        {
            Caption = 'End User Address';
            ToolTip = 'Specifies the end user address.';
            DataClassification = CustomerContent;
        }
        field(70107; "COL End User Address 2"; Text[50])
        {
            Caption = 'End User Address 2';
            ToolTip = 'Specifies the end user address 2.';
            DataClassification = CustomerContent;
        }
        field(70108; "COL End User City"; Text[30])
        {
            Caption = 'End User City';
            ToolTip = 'Specifies the end user city.';
            TableRelation = if ("COL End User Country/Region" = const('')) "Post Code".City
            else
            if ("COL End User Country/Region" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("COL End User Country/Region"));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(70109; "COL End User Post Code"; Code[20])
        {
            Caption = 'End User Post Code';
            ToolTip = 'Specifies the end user post code.';
            TableRelation = if ("COL End User Country/Region" = const('')) "Post Code"
            else
            if ("COL End User Country/Region" = filter(<> '')) "Post Code" where("Country/Region Code" = field("COL End User Country/Region"));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(70110; "COL End User County"; Text[30])
        {
            Caption = 'End User County';
            ToolTip = 'Specifies the end user county.';
            DataClassification = CustomerContent;
        }
        field(70111; "COL End User Country/Region"; Code[10])
        {
            Caption = 'End User Country/Region Code';
            ToolTip = 'Specifies the end user country/region code.';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(70112; "COL End User E-Mail"; Text[80])
        {
            Caption = 'End User Email';
            ToolTip = 'Specifies the end user email.';
            ExtendedDatatype = EMail;
            DataClassification = CustomerContent;
        }
        field(70118; "COL Export Classification Code"; Enum "COL Item Export Classification")
        {
            Caption = 'Export Classification Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies export classification.';
        }
        field(70119; "COL Export Permit No."; Text[50])
        {
            Caption = 'Export Permit No.';
            ToolTip = 'Specifies the Export Permit No.';
            DataClassification = CustomerContent;
        }
        field(70120; "COL GS. Name"; Text[100])
        {
            Caption = 'Name';
            ToolTip = 'Specifies the name.';
            DataClassification = CustomerContent;
        }
        field(70121; "COL GS. Name 2"; Text[50])
        {
            Caption = 'Name 2';
            ToolTip = 'Specifies the name 2.';
            DataClassification = CustomerContent;
        }
        field(70122; "COL GS. Address"; Text[100])
        {
            Caption = 'Address';
            ToolTip = 'Specifies the address.';
            DataClassification = CustomerContent;
        }
        field(70123; "COL GS. Address 2"; Text[50])
        {
            Caption = 'Address 2';
            ToolTip = 'Specifies the address 2.';
            DataClassification = CustomerContent;
        }
        field(70124; "COL GS. City"; Text[30])
        {
            Caption = 'City';
            ToolTip = 'Specifies the city.';
            TableRelation = if ("COL GS. Country/Region" = const('')) "Post Code".City
            else
            if ("COL GS. Country/Region" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("COL GS. Country/Region"));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(70125; "COL GS. Post Code"; Code[20])
        {
            Caption = 'Post Code';
            ToolTip = 'Specifies the post code.';
            TableRelation = if ("COL GS. Country/Region" = const('')) "Post Code"
            else
            if ("COL GS. Country/Region" = filter(<> '')) "Post Code" where("Country/Region Code" = field("COL GS. Country/Region"));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(70126; "COL GS. County"; Text[30])
        {
            Caption = 'County';
            ToolTip = 'Specifies the county.';
            DataClassification = CustomerContent;
        }
        field(70127; "COL GS. Country/Region"; Code[10])
        {
            Caption = 'Country/Region Code';
            ToolTip = 'Specifies the country/region code.';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
            ValidateTableRelation = false;
        }
        field(70128; "COL GS. E-Mail"; Text[80])
        {
            Caption = 'Email';
            ToolTip = 'Specifies the email.';
            ExtendedDatatype = EMail;
            DataClassification = CustomerContent;
        }
        field(70129; "COL GS. Company"; Text[30])
        {
            Caption = 'Company';
            ToolTip = 'Specifies the Company.';
            DataClassification = CustomerContent;
            TableRelation = "Company";
        }
        field(70130; "COL GS. Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            ToolTip = 'Specifies the Customer No.';
            DataClassification = CustomerContent;
        }
        field(70131; "COL Warranty Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Warranty Code';
            ToolTip = 'Specifies the value of the Warranty Code field.';
            TableRelation = "COL Weibel Warranties";
        }
        field(70132; "COL Warranty Description"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Warranty Description';
            ToolTip = 'Specifies the value of the Warranty Description field.';
        }
        field(70133; "COL Original Promised Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Original Promised Date';
            ToolTip = 'Specifies the original promised date.';
        }
        field(70136; "COL Sales Finance Category"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Finance Category';
            ToolTip = 'Specifies the value of the sales finance category code.';
            TableRelation = "COL Sales Finance Category";
        }
        field(70137; "COL Sales Order Category"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Order Category';
            ToolTip = 'Specifies the value of the sales order category code.';
            TableRelation = "COL Sales Order Category";
        }
        field(70138; "COL Terms and Cond. Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Terms and Conditions';
            ToolTip = 'Specifies the value of the Terms and Conditions code.';
            TableRelation = "COL Terms and Conditions";
        }
        field(70139; "COL Description"; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies document description.';
        }
        field(70140; "COL Project Name"; Text[70])
        {
            Caption = 'Project Name';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies project name.';
        }
        // reserved from sales header
        // field(70141; "COL Order Information"; Text[50])
        // field(70142; "COL Responsibility Group"; Enum "COL Resp. Group Option")
        // field(70147; "COL Order Category (Old)"; Code[20])
        field(70148; "COL I/C Bank Name"; Text[100])
        {
            Caption = 'I/C Bank Name';
            ToolTip = 'Name of the bank';
            DataClassification = CustomerContent;
        }
        field(70149; "COL I/C SWIFT"; Code[20])
        {
            Caption = 'I/C SWIFT';
            ToolTip = 'SWIFT/BIC Code';
            DataClassification = CustomerContent;
        }
        field(70150; "COL I/C IBAN"; Code[50])
        {
            Caption = 'I/C IBAN';
            ToolTip = 'International Bank Account Number';
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(COL_1; "COL Sales Finance Category") { }
        key(COL_2; "COL Sales Order Category") { }
    }

    procedure COLGetHighestPriority(): Text
    var
        SalesItemLine: Record "Sales Invoice Line";
        LicenseRequired: Enum "COL Item Export Classification";
        LineFound: Boolean;
    begin
        SalesItemLine.SetRange("Document No.", Rec."No.");
        if SalesItemLine.FindSet() then
            repeat
                LineFound := true;
                COLGetIfHigherPriority(LicenseRequired, SalesItemLine);
            until SalesItemLine.Next() = 0;

        if LineFound then
            exit(Format(LicenseRequired))
        else
            exit('');
    end;

    local procedure COLGetIfHigherPriority(var LicenseRequired: Enum "COL Item Export Classification"; var SalesItemLine: Record "Sales Invoice Line")
    begin
        if LicenseRequired = Enum::"COL Item Export Classification"::Unknown then begin
            LicenseRequired := SalesItemLine."COL Export Classification Code";
            exit;
        end;

        if SalesItemLine."COL Export Classification Code" = Enum::"COL Item Export Classification"::Unknown then
            exit;

        if LicenseRequired.AsInteger() > SalesItemLine."COL Export Classification Code".AsInteger() then
            LicenseRequired := SalesItemLine."COL Export Classification Code";
    end;

    internal procedure PrintAsInternalInvoice()
    var
        ReportSelection: Record "Report Selections";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        InternalInvoiceSubs: Codeunit "COL Internal Invoice Subs.";
        ICSalesInvoiceErr: Label 'Report Selection for I/C Sales Invoice not found.';
    begin
        ReportSelection.SetRange(Usage, ReportSelection.Usage::"COL IC Sales Invoice");
        if ReportSelection.FindFirst() then begin
            SalesInvoiceHeader := Rec;
            SalesInvoiceHeader.SetRecFilter();
            BindSubscription(InternalInvoiceSubs);
            Report.Run(ReportSelection."Report ID", true, true, SalesInvoiceHeader);
            UnbindSubscription(InternalInvoiceSubs);
        end else
            Error(ICSalesInvoiceErr);
    end;
}
