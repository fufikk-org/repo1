namespace Weibel.Intercompany;

using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Warehouse.Structure;
using Microsoft.Sales.Setup;
using Weibel.Common;
using Microsoft.Service.Setup;
using Microsoft.Finance.GeneralLedger.Posting;

codeunit 70141 "COL Intercompany Post"
{

    trigger OnRun()
    begin
        PostEntry();
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        ServiceMgtSetup: Record "Service Mgt. Setup";
        CurrEntryNo: Integer;
        SetupsInitialized: Boolean;

    procedure SetPostEntryNo(pCurrEntryNo: Integer);
    begin
        CurrEntryNo := pCurrEntryNo;
    end;

    local procedure CheckEntry(var IntercompanyTransactions: Record "COL Intercompany Transactions"): Boolean
    var
        WrongCompanyErr: Label 'Entry %1 cannot be processed because the destination company is not the current company', Comment = '%1 = Entry No.';
        EntryIsPostedErr: Label 'Entry %1 has already been processed', Comment = '%1 = Entry No.';
    begin
        if IntercompanyTransactions.Processed then
            Error(EntryIsPostedErr, IntercompanyTransactions."Entry No.");

        if IntercompanyTransactions."Destination Company" <> CompanyName() then
            Error(WrongCompanyErr, CurrEntryNo);

        IntercompanyTransactions.TestField("Destination Customer No.");
        IntercompanyTransactions.TestField("Document No.");
        IntercompanyTransactions.TestField("Sales GL Account No.");
        IntercompanyTransactions.TestField("Purchase GL Account No.");
        IntercompanyTransactions.TestField("IC GL Account No.");

        exit(true);
    end;

    local procedure GetSetups()
    begin
        if SetupsInitialized then
            exit;

        if not SalesSetup.Get() then
            SalesSetup.Init();

        if not ServiceMgtSetup.Get() then
            ServiceMgtSetup.Init();

        SetupsInitialized := true;
    end;

    procedure PostEntry()
    var
        IntercompanyTransactions: Record "COL Intercompany Transactions";
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalLine2: Record "Gen. Journal Line";
        IntercompanyManualSub: Codeunit "COL Intercompany Manual Sub.";
        SelectEntryLbl: Label 'Select entry to post';
        EntryNotExistLbl: Label 'Entry %1 not found', Comment = '%1 = Entry No.';
    begin
        if CurrEntryNo <= 0 then
            Error(SelectEntryLbl);

        if not IntercompanyTransactions.Get(CurrEntryNo) then
            Error(EntryNotExistLbl, CurrEntryNo);

        GetSetups();

        if not CheckEntry(IntercompanyTransactions) then
            exit;

        CreateJrn(IntercompanyTransactions, GenJournalLine);

        BindSubscription(IntercompanyManualSub);
        GenJournalLine.SendToPosting(Codeunit::"Gen. Jnl.-Post");
        UnbindSubscription(IntercompanyManualSub);

        CreatePurJrn(IntercompanyTransactions, GenJournalLine2);

        BindSubscription(IntercompanyManualSub);
        GenJournalLine2.SendToPosting(Codeunit::"Gen. Jnl.-Post");
        UnbindSubscription(IntercompanyManualSub);
    end;



    local procedure CreateJrn(var IntercompanyTransactions: Record "COL Intercompany Transactions"; var GenJournalLine: Record "Gen. Journal Line")
    var
        JournalTemplate: Code[10];
        JournalBatch: Code[10];
        LineNo: Integer;
    begin
        if IntercompanyTransactions."Transaction Document Type" = IntercompanyTransactions."Transaction Document Type"::"Service Invoice" then begin
            ServiceMgtSetup.TestField("COL InterCo. Journal Template");
            ServiceMgtSetup.TestField("COL InterCo. Journal Batch");
            JournalTemplate := ServiceMgtSetup."COL InterCo. Journal Template";
            JournalBatch := ServiceMgtSetup."COL InterCo. Journal Batch";
        end
        else begin
            SalesSetup.TestField("COL InterCo. Journal Template");
            SalesSetup.TestField("COL InterCo. Journal Batch");
            JournalTemplate := SalesSetup."COL InterCo. Journal Template";
            JournalBatch := SalesSetup."COL InterCo. Journal Batch";
        end;

        LineNo := 1000;
        GenJournalLine.Reset();
        GenJournalLine.SetRange("Journal Template Name", JournalTemplate);
        GenJournalLine.SetRange("Journal Batch Name", JournalBatch);
        if GenJournalLine.FindLast() then
            LineNo := GenJournalLine."Line No." + 1000;

        GenJournalLine.Reset();
        GenJournalLine."Journal Template Name" := JournalTemplate;
        GenJournalLine."Journal Batch Name" := JournalBatch;
        GenJournalLine."Line No." := LineNo;

        case IntercompanyTransactions."Transaction Document Type" of
            IntercompanyTransactions."Transaction Document Type"::"Service Invoice",
            IntercompanyTransactions."Transaction Document Type"::"Sales Invoice":
                GenJournalLine.Validate("Document Type", GenJournalLine."Document Type"::Invoice);
            IntercompanyTransactions."Transaction Document Type"::"Sales Cr. Memo":
                GenJournalLine.Validate("Document Type", GenJournalLine."Document Type"::"Credit Memo");
        end;
        GenJournalLine.Validate("Document No.", IntercompanyTransactions."Document No.");
        GenJournalLine.Validate("Posting Date", IntercompanyTransactions."Posting Date");
        GenJournalLine.Validate("Account Type", GenJournalLine."Account Type"::Customer);
        GenJournalLine.Validate("Account No.", IntercompanyTransactions."Destination Customer No.");
        if IntercompanyTransactions."Currency Code" <> '' then
            GenJournalLine.Validate("Currency Code", IntercompanyTransactions."Currency Code");
        GenJournalLine.Validate("Amount", IntercompanyTransactions.Amount);
        GenJournalLine.Validate("Bal. Account Type", GenJournalLine."Bal. Account Type"::"G/L Account");
        GenJournalLine.Validate("Bal. Account No.", IntercompanyTransactions."Sales GL Account No.");
        GenJournalLine.Validate(Description, IntercompanyTransactions."Posting Description");
        GenJournalLine.Validate("Allow Zero-Amount Posting", true);
        GenJournalLine.Insert(true);
    end;

    local procedure CreatePurJrn(var IntercompanyTransactions: Record "COL Intercompany Transactions"; var GenJournalLine2: Record "Gen. Journal Line")
    var
        JournalTemplate: Code[10];
        JournalBatch: Code[10];
        LineNo: Integer;
    begin
        if IntercompanyTransactions."Transaction Document Type" = IntercompanyTransactions."Transaction Document Type"::"Service Invoice" then begin
            ServiceMgtSetup.TestField("COL InterCo. Journal Template");
            ServiceMgtSetup.TestField("COL InterCo. Journal Batch");
            JournalTemplate := ServiceMgtSetup."COL InterCo. Journal Template";
            JournalBatch := ServiceMgtSetup."COL InterCo. Journal Batch";
        end
        else begin
            SalesSetup.TestField("COL InterCo. Journal Template");
            SalesSetup.TestField("COL InterCo. Journal Batch");
            JournalTemplate := SalesSetup."COL InterCo. Journal Template";
            JournalBatch := SalesSetup."COL InterCo. Journal Batch";
        end;

        LineNo := 1000;
        GenJournalLine2.Reset();
        GenJournalLine2.SetRange("Journal Template Name", JournalTemplate);
        GenJournalLine2.SetRange("Journal Batch Name", JournalBatch);
        if GenJournalLine2.FindLast() then
            LineNo := GenJournalLine2."Line No." + 1000;

        GenJournalLine2.Reset();
        GenJournalLine2."Journal Template Name" := JournalTemplate;
        GenJournalLine2."Journal Batch Name" := JournalBatch;
        GenJournalLine2."Line No." := LineNo + 1000;

        case IntercompanyTransactions."Transaction Document Type" of
            IntercompanyTransactions."Transaction Document Type"::"Service Invoice",
            IntercompanyTransactions."Transaction Document Type"::"Sales Invoice":
                GenJournalLine2.Validate("Document Type", GenJournalLine2."Document Type"::Invoice);
            IntercompanyTransactions."Transaction Document Type"::"Sales Cr. Memo":
                GenJournalLine2.Validate("Document Type", GenJournalLine2."Document Type"::"Credit Memo");
        end;
        GenJournalLine2.Validate("Document No.", IntercompanyTransactions."Document No.");
        GenJournalLine2.Validate("Posting Date", IntercompanyTransactions."Posting Date");
        GenJournalLine2.Validate("Account Type", GenJournalLine2."Account Type"::"G/L Account");
        GenJournalLine2.Validate("Account No.", IntercompanyTransactions."Purchase GL Account No.");
        if IntercompanyTransactions."Currency Code" <> '' then
            GenJournalLine2.Validate("Currency Code", IntercompanyTransactions."Currency Code");
        GenJournalLine2.Validate("Amount", IntercompanyTransactions.Amount);
        GenJournalLine2.Validate("Bal. Account Type", GenJournalLine2."Bal. Account Type"::"G/L Account");
        GenJournalLine2.Validate("Bal. Account No.", IntercompanyTransactions."IC GL Account No.");
        GenJournalLine2.Validate(Description, IntercompanyTransactions."Posting Description");
        GenJournalLine2.Validate("Allow Zero-Amount Posting", true);
        GenJournalLine2.Insert(true);
    end;
}
