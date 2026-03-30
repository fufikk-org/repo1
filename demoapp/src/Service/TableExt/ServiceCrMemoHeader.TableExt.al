namespace Weibel.Service.History;

using Microsoft.Service.History;
using Weibel.Common;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.Address;

tableextension 70111 "COL Service Cr.Memo Header" extends "Service Cr.Memo Header"
{
    fields
    {
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
    }
}
