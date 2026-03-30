namespace Weibel.Service.Setup;

using Microsoft.Service.Setup;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Finance.GeneralLedger.Journal;

tableextension 70108 "COL Service Mgt. Setup" extends "Service Mgt. Setup"
{
    fields
    {
        field(70100; "COL Quote Validity Calculation"; DateFormula)
        {
            Caption = 'Quote Validity Calculation';
            ToolTip = 'Specifies a formula that determines how to calculate the quote expiration date based on the document date.';
            DataClassification = CustomerContent;
        }
        field(70101; "COL Default Service GL Account"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Default Service GL Account';
            ToolTip = 'Specifies of Default Service GL Account';
            TableRelation = "G/L Account"."No.";
        }
        field(70102; "COL InterCo. Journal Template"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Intercompany Journal Template';
            ToolTip = 'Specifies Intercompany Journal Template';
            TableRelation = "Gen. Journal Template";

            trigger OnValidate()
            begin
                "COL InterCo. Journal Batch" := '';
            end;
        }
        field(70103; "COL InterCo. Journal Batch"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Intercompany Journal Batch';
            ToolTip = 'Specifies Intercompany Journal Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("COL InterCo. Journal Template"));
        }
        field(70104; "COL Default Purch. GL Account"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Default Purchase GL Account';
            ToolTip = 'Specifies of Default Purchase GL Account';
            TableRelation = "G/L Account"."No.";
        }
        field(70105; "COL Default IC GL Account"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Default I/C GL Account';
            ToolTip = 'Specifies of Default I/C GL Account';
            TableRelation = "G/L Account"."No.";
        }
    }
}
