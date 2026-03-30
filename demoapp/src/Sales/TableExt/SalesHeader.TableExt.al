namespace Weibel.Sales.Document;

using Microsoft.Sales.Document;
using System.Utilities;
using Weibel.Shipping;
using Weibel.Common;
using Microsoft.Sales.Customer;
using Weibel.Intercompany;
using Microsoft.Foundation.Address;
using Weibel.Packaging;
using Microsoft.Warehouse.Activity;
using System.Email;
using Weibel.Inventory.Item;
using System.Environment;
using Weibel.Foundation.QuoteDeliveryCodes;
using Microsoft.Sales.Setup;
using Weibel.Foundation.FinanceCategory;
using Weibel.Foundation.SalesOrderCategory;
using Weibel.Foundation.TermsAndConditions;
using Weibel.Foundation.OrderCategoryOld;

tableextension 70113 "COL Sales Header" extends "Sales Header"
{
    fields
    {
        modify("Quote Valid Until Date")
        {
            trigger OnAfterValidate()
            begin
                if (xRec."Quote Valid Until Date" <> Rec."Quote Valid Until Date") then
                    this.COLCheckIfQuoteValidToDateIsEmpty();
            end;
        }
        field(70100; "COL Shipping Status"; Code[20])
        {
            Caption = 'Shipping Status';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies shipping status of the document.';
            TableRelation = "COL Shipping Status";
        }
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

            trigger OnValidate()
            var
                CommonAddress: Codeunit "COL Common Cust. Mgt";
            begin
                if Rec."COL End User Type" <> xRec."COL End User Type" then
                    CommonAddress.SetCustomerEndUser(Rec);
            end;
        }
        field(70103; "COL Existing End User No."; Code[20])
        {
            Caption = 'Existing End User No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Existing End User No.';
            TableRelation = "Customer"."No." where("COL End User" = Const(True));

            trigger OnValidate()
            var
                CommonAddress: Codeunit "COL Common Cust. Mgt";
            begin
                if Rec."COL Existing End User No." <> xRec."COL Existing End User No." then
                    CommonAddress.SetCustomerEndUser(Rec);
            end;
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

            trigger OnLookup()
            begin
#pragma warning disable AA0139
                PostCode.LookupPostCode("COL End User City", "COL End User Post Code", "COL End User County", "COL End User Country/Region");
#pragma warning restore AA0139                
            end;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(
                    "COL End User City", "COL End User Post Code", "COL End User County", "COL End User Country/Region", (CurrFieldNo <> 0) and GuiAllowed);
            end;
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

            trigger OnLookup()
            begin
#pragma warning disable AA0139
                PostCode.LookupPostCode("COL End User City", "COL End User Post Code", "COL End User County", "COL End User Country/Region");
#pragma warning restore AA0139
            end;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(
                    "COL End User City", "COL End User Post Code", "COL End User County", "COL End User Country/Region", (CurrFieldNo <> 0) and GuiAllowed);
            end;
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

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                if "COL End User E-Mail" = '' then
                    exit;
                MailManagement.CheckValidEmailAddresses("COL End User E-Mail");
            end;
        }
        //Tech field
        field(70113; "COL Old Project Code"; Code[20])
        {
            Caption = 'Old Project Code';
            ToolTip = 'Specifies the Old Project Code.';
            DataClassification = CustomerContent;
        }
        field(70114; "COL No. of Packages"; Integer)
        {
            Caption = 'No. of Packages';
            ToolTip = 'Specifies no. of packages.';
            BlankZero = true;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("COL Package Dimension" where("Document Type" = const("Sales Order"), "Document No." = field("No.")));
        }
#pragma warning disable AA0232
        field(70115; "COL Total Gross Weight"; Decimal)
        {
            Caption = 'Total Gross Weight';
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            ToolTip = 'Specifies total gross weight of packages.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("COL Package Dimension"."Gross Shipment Weight" where("Document Type" = const("Sales Order"), "Document No." = field("No.")));
        }
#pragma warning restore AA0232
        field(70116; "COL No. of Packages Manual"; Integer)
        {
            Caption = 'No. of Packages';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies no. of packages defined by user.';
            BlankZero = true;
            MinValue = 0;
        }
        field(70117; "COL Total Gross Weight Manual"; Decimal)
        {
            Caption = 'Total Gross Weight';
            DataClassification = CustomerContent;
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            ToolTip = 'Specifies total gross weight of packages defined by user.';
            MinValue = 0;
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

            trigger OnLookup()
            begin
#pragma warning disable AA0139
                PostCode.LookupPostCode("COL GS. City", "COL GS. Post Code", "COL GS. County", "COL GS. Country/Region");
#pragma warning restore AA0139                
            end;
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

            trigger OnLookup()
            begin
#pragma warning disable AA0139
                PostCode.LookupPostCode("COL GS. City", "COL GS. Post Code", "COL GS. County", "COL GS. Country/Region");
#pragma warning restore AA0139
            end;
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

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                if "COL GS. E-Mail" = '' then
                    exit;
                MailManagement.CheckValidEmailAddresses("COL GS. E-Mail");
            end;
        }
        field(70129; "COL GS. Company"; Text[30])
        {
            Caption = 'Company';
            ToolTip = 'Specifies the Company.';
            DataClassification = CustomerContent;
            TableRelation = "Company";

            trigger OnValidate()
            var
                SalesSetup: Record "Sales & Receivables Setup";
                ICBankInformation: Record "COL I/C Bank Information";
                CommonCustMgt: Codeunit "COL Common Cust. Mgt";
                NoValidSetupErr: Label 'There is no valid setup in company ''%1'' for intercompany transactions in %2. Details: %3', Comment = '%1 = company name; %2 = setup table name; %3 = error message';
            begin
                if (Rec."COL GS. Company" <> xRec."COL GS. Company") then
                    CommonCustMgt.ClearGs(Rec);

                if Rec."COL GS. Company" <> '' then begin
                    SalesSetup.ChangeCompany(Rec."COL GS. Company");
                    if not SalesSetup.Get() then
                        SalesSetup.Init();
                    ClearLastError();
                    if not SalesSetup.HasValidIntercompanySetup() then
                        Error(NoValidSetupErr, Rec."COL GS. Company", SalesSetup.TableCaption(), GetLastErrorText());
                end;

                if ICBankInformation.Get(Rec."COL GS. Company") then begin
                    Rec."COL I/C Bank Name" := ICBankInformation."I/C Bank Name";
                    Rec."COL I/C SWIFT" := ICBankInformation."I/C SWIFT";
                    Rec."COL I/C IBAN" := ICBankInformation."I/C IBAN";
                end
                else begin
                    Rec."COL I/C Bank Name" := '';
                    Rec."COL I/C SWIFT" := '';
                    Rec."COL I/C IBAN" := '';
                end;

            end;
        }
        field(70130; "COL GS. Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            ToolTip = 'Specifies the Customer No.';
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                CommonCustMgt: Codeunit "COL Common Cust. Mgt";
            begin
                Rec.TestField("COL GS. Company");
                CommonCustMgt.PickCompanyCustomer(Rec."COL GS. Company", Rec);
            end;
        }
        field(70131; "COL Warranty Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Warranty Code';
            ToolTip = 'Specifies the value of the Warranty Code field.';
            TableRelation = "COL Weibel Warranties";

            trigger OnValidate()
            var
                WeibelWarranties: Record "COL Weibel Warranties";
            begin
                if WeibelWarranties.Get(Rec."COL Warranty Code") then
                    Rec."COL Warranty Description" := WeibelWarranties."Warranty Description"
                else
                    Rec."COL Warranty Description" := '';
            end;
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
        field(70134; "COL Quote Delivery Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Quote Delivery Code';
            ToolTip = 'Specifies the value of the Quote Delivery Code field.';
            TableRelation = "COL Quote Delivery Code";

            trigger OnValidate()
            var
                QuoteDeliveryCode: Record "COL Quote Delivery Code";
            begin
                Clear(Rec."COL Quote Delivery Description");
                if Rec."COL Quote Delivery Code" <> '' then
                    if QuoteDeliveryCode.Get(Rec."COL Quote Delivery Code") then
                        Rec."COL Quote Delivery Description" := QuoteDeliveryCode.Description;
            end;
        }
        field(70135; "COL Quote Delivery Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Quote Delivery Description';
            ToolTip = 'Specifies the value of the Quote Delivery description.';
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
        field(70141; "COL Order Information"; Text[50])
        {
            Caption = 'Order Information';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies order information';
        }
        field(70142; "COL Responsibility Group"; Enum "COL Resp. Group Option")
        {
            Caption = 'Responsibility Group';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies responsibility group.';
        }
        field(70143; "COL Order Value G/L Acc.Filter"; Code[20])
        {
            Caption = 'Order Value G/L Acc.Filter';
            FieldClass = FlowFilter;
        }
        field(70144; "COL Order Value"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line".Amount where("Document Type" = field("Document Type"),
                                                         "Document No." = field("No."),
                                                         "Type" = const("G/L Account"),
                                                         "No." = field("COL Order Value G/L Acc.Filter")));
            Caption = 'Order Value';
            ToolTip = 'Specifies order value from related document G/L lines.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70145; "COL Prep.Value G/L Acc.Filter"; Code[20])
        {
            Caption = 'Prepayment Value G/L Acc.Filter';
            FieldClass = FlowFilter;
        }
        field(70146; "COL Prepayment Value"; Decimal)
        {
            AutoFormatExpression = Rec."Currency Code";
            AutoFormatType = 1;
            CalcFormula = sum("Sales Line".Amount where("Document Type" = field("Document Type"),
                                                         "Document No." = field("No."),
                                                         "Type" = const("G/L Account"),
                                                         "No." = field("COL Prep.Value G/L Acc.Filter")));
            Caption = 'Prepayment Value';
            ToolTip = 'Specifies prepayment value from related document G/L lines.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70147; "COL Order Category (Old)"; Code[20])
        {
            Caption = 'Order Category (Old)';
            ToolTip = 'Specifies order category from NAV.';
            DataClassification = CustomerContent;
            TableRelation = "COL Order Category (Old)".Code;
        }
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

    trigger OnDelete()
    var
        PackageDimension: Record "COL Package Dimension";
    begin
        if Rec."Document Type" = Enum::"Sales Document Type"::Order then begin
            PackageDimension.SetRange("Document Type", Enum::"Warehouse Activity Source Document"::"Sales Order");
            PackageDimension.SetRange("Document No.", Rec."No.");
            if not PackageDimension.IsEmpty() then
                PackageDimension.DeleteAll(true);
        end;
    end;

    var
        PostCode: Record "Post Code";

    procedure COLChangeOriginalPromDate()
    var
        ChangeDatePage: Page "COL Date Change";
    begin
        ChangeDatePage.SetOldDate(Rec."COL Original Promised Date");
        if ChangeDatePage.RunModal() = Action::OK then begin
            Rec."COL Original Promised Date" := ChangeDatePage.GetNewDate();
            Rec.Modify();
        end;
    end;

    procedure COLGetHighestPriority(): Text
    var
        SalesLine: Record "Sales Line";
        LicenseRequired: Enum "COL Item Export Classification";
        LineFound: Boolean;
    begin
        SalesLine.SetRange("Document No.", Rec."No.");
        SalesLine.SetRange("Document Type", Rec."Document Type");
        if SalesLine.FindSet() then
            repeat
                LineFound := true;
                COLGetIfHigherPriority(LicenseRequired, SalesLine);
            until SalesLine.Next() = 0;

        if LineFound then
            exit(Format(LicenseRequired))
        else
            exit('');
    end;

    local procedure COLGetIfHigherPriority(var LicenseRequired: Enum "COL Item Export Classification"; var SalesLine: Record "Sales Line")
    begin
        if LicenseRequired = Enum::"COL Item Export Classification"::Unknown then begin
            LicenseRequired := SalesLine."COL Export Classification Code";
            exit;
        end;

        if SalesLine."COL Export Classification Code" = Enum::"COL Item Export Classification"::Unknown then
            exit;

        if LicenseRequired.AsInteger() > SalesLine."COL Export Classification Code".AsInteger() then
            LicenseRequired := SalesLine."COL Export Classification Code";
    end;

    /// <summary>
    /// Checks if the "Quote Valid Until Date" is empty and prompts the user for confirmation if it is being set to empty.
    /// </summary>
    procedure COLCheckIfQuoteValidToDateIsEmpty()
    var
        ConfirmManagement: Codeunit "Confirm Management";
        EmptyQuoteValidToQst: Label 'You have removed the Quote Valid Until Date. Do you want to continue?';
    begin
        if Rec."Document Type" <> Rec."Document Type"::Quote then
            exit;

        if not GuiAllowed() then
            exit;

        if (Rec."Quote Valid Until Date" = 0D) then
            if not ConfirmManagement.GetResponseOrDefault(EmptyQuoteValidToQst, true) then
                Error('');
    end;
}