namespace Weibel.Service.History;

using Microsoft.Service.History;
using Weibel.Shipping;
using Weibel.Common;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.Address;
using Weibel.Packaging;
using Weibel.Inventory.Item;
using Microsoft.CRM.Team;

tableextension 70117 "COL Service Shipment Header" extends "Service Shipment Header"
{
    fields
    {
        field(70102; "COL Shipping Status"; Code[20])
        {
            Caption = 'Shipping Status';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies shipping status of the document.';
            TableRelation = "COL Shipping Status";
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
        field(70113; "COL End User Type"; enum "COL End User Type")
        {
            Caption = 'End User Type';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the end user type.';
        }
        field(70114; "COL Existing End User No."; Code[20])
        {
            Caption = 'Existing End User No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Existing End User No.';
            TableRelation = "Customer"."No." where("COL End User" = Const(True));
        }
        field(70115; "COL End User Name"; Text[100])
        {
            Caption = 'End User Name';
            ToolTip = 'Specifies the end user name.';
            DataClassification = CustomerContent;
        }
        field(70117; "COL No. of Packages"; Integer)
        {
            Caption = 'No. of Packages';
            BlankZero = true;
            ToolTip = 'Specifies no. of packages.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count("COL Posted Package Dimension" where("Table Id" = const(Database::"Service Shipment Header"), "Document No." = field("No.")));
        }
#pragma warning disable AA0232
        field(70118; "COL Total Gross Weight"; Decimal)
        {
            Caption = 'Total Gross Weight';
            DecimalPlaces = 0 : 2;
            BlankZero = true;
            ToolTip = 'Specifies total gross weight of packages.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("COL Posted Package Dimension"."Gross Shipment Weight" where("Table Id" = const(Database::"Service Shipment Header"), "Document No." = field("No.")));
        }
#pragma warning restore AA0232
        field(70119; "COL No. of Packages Manual"; Integer)
        {
            Caption = 'No. of Packages';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies no. of packages defined by user.';
            BlankZero = true;
            MinValue = 0;
        }
        field(70120; "COL Total Gross Weight Manual"; Decimal)
        {
            Caption = 'Total Gross Weight';
            DataClassification = CustomerContent;
            BlankZero = true;
            DecimalPlaces = 0 : 2;
            ToolTip = 'Specifies total gross weight of packages defined by user.';
            MinValue = 0;
        }
        field(70121; "COL Export Classification Code"; Enum "COL Item Export Classification")
        {
            Caption = 'Export Classification Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies export classification.';
        }
        field(70122; "COL Export Permit No."; Text[50])
        {
            Caption = 'Export Permit No.';
            ToolTip = 'Specifies the Export Permit No.';
            DataClassification = CustomerContent;
        }
        field(70123; "COL GS. Name"; Text[100])
        {
            Caption = 'Name';
            ToolTip = 'Specifies the name.';
            DataClassification = CustomerContent;
        }
        field(70124; "COL GS. Name 2"; Text[50])
        {
            Caption = 'Name 2';
            ToolTip = 'Specifies the name 2.';
            DataClassification = CustomerContent;
        }
        field(70125; "COL GS. Address"; Text[100])
        {
            Caption = 'Address';
            ToolTip = 'Specifies the address.';
            DataClassification = CustomerContent;
        }
        field(70126; "COL GS. Address 2"; Text[50])
        {
            Caption = 'Address 2';
            ToolTip = 'Specifies the address 2.';
            DataClassification = CustomerContent;
        }
        field(70127; "COL GS. City"; Text[30])
        {
            Caption = 'City';
            ToolTip = 'Specifies the city.';
            TableRelation = if ("COL GS. Country/Region" = const('')) "Post Code".City
            else
            if ("COL GS. Country/Region" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("COL GS. Country/Region"));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(70128; "COL GS. Post Code"; Code[20])
        {
            Caption = 'Post Code';
            ToolTip = 'Specifies the post code.';
            TableRelation = if ("COL GS. Country/Region" = const('')) "Post Code"
            else
            if ("COL GS. Country/Region" = filter(<> '')) "Post Code" where("Country/Region Code" = field("COL GS. Country/Region"));
            ValidateTableRelation = false;
            DataClassification = CustomerContent;
        }
        field(70129; "COL GS. County"; Text[30])
        {
            Caption = 'County';
            ToolTip = 'Specifies the county.';
            DataClassification = CustomerContent;
        }
        field(70130; "COL GS. Country/Region"; Code[10])
        {
            Caption = 'Country/Region Code';
            ToolTip = 'Specifies the country/region code.';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
            ValidateTableRelation = false;
        }
        field(70131; "COL GS. E-Mail"; Text[80])
        {
            Caption = 'Email';
            ToolTip = 'Specifies the email.';
            ExtendedDatatype = EMail;
            DataClassification = CustomerContent;
        }
        field(70132; "COL GS. Company"; Text[30])
        {
            Caption = 'Company';
            ToolTip = 'Specifies the Company.';
            DataClassification = CustomerContent;
        }
        field(70133; "COL GS. Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            ToolTip = 'Specifies the Customer No.';
            DataClassification = CustomerContent;
        }
        field(70134; "COL GS. Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
            ToolTip = 'Specifies the salesperson code.';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser" where(Blocked = const(false));
            ValidateTableRelation = false;
        }
    }

    procedure COLGetHighestPriority(): Text
    var
        ServiceItemLine: Record "Service Shipment Item Line";
        LicenseRequired: Enum "COL Item Export Classification";
        LineFound: Boolean;
    begin
        ServiceItemLine.SetRange("No.", Rec."No.");
        if ServiceItemLine.FindSet() then
            repeat
                LineFound := true;
                COLGetIfHigherPriority(LicenseRequired, ServiceItemLine);
            until ServiceItemLine.Next() = 0;

        if LineFound then
            exit(Format(LicenseRequired))
        else
            exit('');
    end;

    local procedure COLGetIfHigherPriority(var LicenseRequired: Enum "COL Item Export Classification"; var ServiceItemLine: Record "Service Shipment Item Line")
    begin
        if LicenseRequired = Enum::"COL Item Export Classification"::Unknown then begin
            LicenseRequired := ServiceItemLine."COL Export Classification Code";
            exit;
        end;

        if ServiceItemLine."COL Export Classification Code" = Enum::"COL Item Export Classification"::Unknown then
            exit;

        if LicenseRequired.AsInteger() > ServiceItemLine."COL Export Classification Code".AsInteger() then
            LicenseRequired := ServiceItemLine."COL Export Classification Code";
    end;
}