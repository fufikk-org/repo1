namespace Weibel.Projects.Project.Job;

using Microsoft.Projects.Project.Job;
using Weibel.Common;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.Address;
using System.Email;

tableextension 70110 "COL Job" extends Job
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
        field(70113; "COL Change Reason"; Text[80])
        {
            Caption = 'Change Reason';
            ToolTip = 'Specifies the change reason.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                JobCommonMethod: Codeunit "COL Job Common Method";
            begin
                JobCommonMethod.SetChangeReasonOnComment(Rec);
            end;
        }
        field(70114; "COL FogBugz/Jira No."; Text[20])
        {
            Caption = 'FogBugz/Jira No.';
            ToolTip = 'Specifies the FogBugz/Jira No.';
            DataClassification = CustomerContent;
        }


    }
    var
        PostCode: Record "Post Code";
}
