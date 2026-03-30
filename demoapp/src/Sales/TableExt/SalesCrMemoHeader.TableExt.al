namespace Weibel.Sales.History;
using Weibel.Foundation.SalesResponsibilityGroup;
using Microsoft.Sales.History;
using Weibel.Common;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.Address;
using Weibel.Foundation.FinanceCategory;
using Weibel.Foundation.SalesOrderCategory;
using System.Environment;
using Microsoft.CRM.Team;

tableextension 70121 "COL Sales Cr.Memo Header" extends "Sales Cr.Memo Header"
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
        field(70140; "COL Project Name"; Text[70])
        {
            Caption = 'Project Name';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies project name.';
        }
        field(70151; "COL Sales Resp. Group"; Code[20])
        {
            Caption = 'Sales Responsibility Group';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the sales responsibility group for the sales document.';
            TableRelation = "COL Sales Resp. Group";
            ValidateTableRelation = false;
        }
        field(70152; "COL Order No."; Code[20])
        {
            Caption = 'Order No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the order number for the sales document.';
        }
        field(70154; "COL GS. Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
            ToolTip = 'Specifies the salesperson code.';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser" where(Blocked = const(false));
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(COL_1; "COL Sales Finance Category") { }
        key(COL_2; "COL Sales Order Category") { }
    }
}
