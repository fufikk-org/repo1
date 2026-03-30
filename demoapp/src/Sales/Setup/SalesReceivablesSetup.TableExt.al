namespace Weibel.Sales.Setup;

using Microsoft.Sales.Setup;
using Microsoft.Sales.Customer;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Inventory.Item;
using Microsoft.HumanResources.Employee;

tableextension 70125 "COL Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    fields
    {
        field(70100; "COL Internal Customer No."; Code[20])
        {
            Caption = 'Internal Customer No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies internal customer no. For internal customers it is not required to provide packaging information on sales orders.';
            TableRelation = Customer;
        }
        field(70101; "COL Default Sales GL Account"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Default Sales GL Account';
            ToolTip = 'Specifies of Default Sales GL Account';
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
        field(70104; "COL Assembly Explode Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Assembly Explode Item No.';
            ToolTip = 'Specifies of Assembly Explode Item No.';
            TableRelation = "Item"."No." where(Type = filter("Non-Inventory"));
        }
        field(70105; "COL Default Purch. GL Account"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Default Purchase GL Account';
            ToolTip = 'Specifies of Default Purchase GL Account';
            TableRelation = "G/L Account"."No.";
        }
        field(70106; "COL Default IC GL Account"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Default I/C GL Account';
            ToolTip = 'Specifies of Default I/C GL Account';
            TableRelation = "G/L Account"."No.";
        }
        field(70107; "COL Prep.Value G/L Acc.Filter"; Code[150])
        {
            Caption = 'Prepayment Value G/L Acc. Filter';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
            ValidateTableRelation = false;
            ToolTip = 'Specifies which G/L Accounts from sales lines should be used to calculate prepayment value.';

            trigger OnLookup()
            var
                GLAccList: Page "G/L Account List";
            begin
                GLAccList.LookupMode(true);
                if GLAccList.RunModal() = Action::LookupOK then
                    Rec."COL Prep.Value G/L Acc.Filter" := CopyStr(GLAccList.GetSelectionFilter(), 1, MaxStrLen("COL Prep.Value G/L Acc.Filter"));
            end;
        }
        field(70108; "COL Order Value G/L Acc.Filter"; Code[150])
        {
            Caption = 'Order Value G/L Acc. Filter';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
            ValidateTableRelation = false;
            ToolTip = 'Specifies which G/L Accounts from sales lines should be used to calculate order value.';

            trigger OnLookup()
            var
                GLAccList: Page "G/L Account List";
            begin
                GLAccList.LookupMode(true);
                if GLAccList.RunModal() = Action::LookupOK then
                    Rec."COL Order Value G/L Acc.Filter" := CopyStr(GLAccList.GetSelectionFilter(), 1, MaxStrLen("COL Order Value G/L Acc.Filter"));
            end;
        }
        field(70109; "COL Disable Release Archive"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Disable Release Archive';
            ToolTip = 'Disable Archive of documents during release and opening.';
        }
        field(70110; "COL QHSE Manager for CoC Sig."; Code[20])
        {
            Caption = 'QHSE Manager for CoC signature';
            DataClassification = CustomerContent;
            TableRelation = "Employee";
            ToolTip = 'Specifies the QHSE Manager who will sign the Certificate of Conformity.';
        }
        field(70111; "COL Show IC Attachments"; Boolean)
        {
            Caption = 'Show IC Source Attachments';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether to show the Source Company Attachments factbox on Customer Ledger Entries page for intercompany invoices.';
        }
    }

    [TryFunction]
    internal procedure HasValidIntercompanySetup()
    begin
        Rec.TestField("COL Default Sales GL Account");
        Rec.TestField("COL Default Purch. GL Account");
        Rec.TestField("COL Default IC GL Account");
    end;
}