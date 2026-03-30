namespace Weibel.Sales.History;
using Weibel.Foundation.SalesResponsibilityGroup;
using Microsoft.Sales.History;
using Microsoft.Foundation.Address;
using System.Environment;

tableextension 70164 "COL Return Receipt Header" extends "Return Receipt Header"
{
    fields
    {
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
        field(70151; "COL Sales Resp. Group"; Code[20])
        {
            Caption = 'Sales Responsibility Group';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the sales responsibility group for the sales document.';
            TableRelation = "COL Sales Resp. Group";
            ValidateTableRelation = false;
            Editable = false;
        }
    }
}
