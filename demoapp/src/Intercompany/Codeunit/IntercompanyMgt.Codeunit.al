namespace Weibel.Intercompany;

using Microsoft.Sales.History;
using Microsoft.Sales.Setup;
using Weibel.Common;
using Microsoft.Service.Setup;
using Microsoft.Service.Document;
using Microsoft.Finance.Currency;
using Microsoft.Service.History;

codeunit 70140 "COL Intercompany Mgt."
{
    procedure AddIntercompanyEntry(var Rec: Record "Sales Invoice Header")
    var
        IntercompanyTransactions: Record "COL Intercompany Transactions";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesSetup: Record "Sales & Receivables Setup";
        ErrorSetupErr: Label 'In Company: %1, there is not setup Default G/L Accounts for Intercompany transactions (Table Sales & Receivables Setup)', Comment = '%1 is the company name';
    begin
        if not SalesInvoiceHeader.Get(Rec."No.") then
            exit;

        if (Rec."COL GS. Company" = '') or (Rec."COL GS. Customer No." = '') then
            exit;

        SalesSetup.ChangeCompany(Rec."COL GS. Company");
        if not SalesSetup.Get() then
            Error(ErrorSetupErr, Rec."COL GS. Company");

        if (SalesSetup."COL Default Sales GL Account" = '') or (SalesSetup."COL Default Purch. GL Account" = '') or (SalesSetup."COL Default IC GL Account" = '') then
            Error(ErrorSetupErr, Rec."COL GS. Company");

        InitEntry(IntercompanyTransactions);
        IntercompanyTransactions."Transaction Document Type" := IntercompanyTransactions."Transaction Document Type"::"Sales Invoice";
        IntercompanyTransactions."Posting Date" := Rec."Posting Date";
        IntercompanyTransactions."Document No." := Rec."No.";
        IntercompanyTransactions."Posting Description" := Rec."Posting Description";
        IntercompanyTransactions."Currency Code" := Rec."Currency Code";
        IntercompanyTransactions."Destination Company" := Rec."COL GS. Company";
        IntercompanyTransactions."Destination Customer No." := Rec."COL GS. Customer No.";
        IntercompanyTransactions."Destination Customer Name" := Rec."COL GS. Name";
        IntercompanyTransactions."Sales GL Account No." := SalesSetup."COL Default Sales GL Account";
        IntercompanyTransactions."Purchase GL Account No." := SalesSetup."COL Default Purch. GL Account";
        IntercompanyTransactions."IC GL Account No." := SalesSetup."COL Default IC GL Account";
        CalcAndSetAmt(Rec, IntercompanyTransactions);
        IntercompanyTransactions.Insert(true);
    end;

    local procedure CalcAndSetAmt(var Rec: Record "Sales Invoice Header"; var IntercompanyTransactions: Record "COL Intercompany Transactions")
    var
        CurrExchRate: Record "Currency Exchange Rate";
        Amt: Decimal;
        AmtLcy: Decimal;
    begin
        Rec.CalcFields(Amount);
        Amt := Rec.Amount;

        if Rec."Currency Factor" <> 0 then
            AmtLcy := CurrExchRate.ExchangeAmtFCYToLCY(Rec."Posting Date", Rec."Currency Code", Amt, Rec."Currency Factor")
        else
            AmtLcy := Amt;

        IntercompanyTransactions.Amount := Amt;
        IntercompanyTransactions."Amount (LCY)" := AmtLcy;
    end;

    local procedure CalcAndSetAmt(var Rec: Record "Service Invoice Header"; var IntercompanyTransactions: Record "COL Intercompany Transactions")
    var
        CurrExchRate: Record "Currency Exchange Rate";
        Amt: Decimal;
        AmtLcy: Decimal;
    begin
        Rec.CalcFields(Amount);
        Amt := Rec.Amount;

        if Rec."Currency Factor" <> 0 then
            AmtLcy := CurrExchRate.ExchangeAmtFCYToLCY(Rec."Posting Date", Rec."Currency Code", Amt, Rec."Currency Factor")
        else
            AmtLcy := Amt;

        IntercompanyTransactions.Amount := Amt;
        IntercompanyTransactions."Amount (LCY)" := AmtLcy;
    end;

    procedure AddIntercompanyEntry(var Rec: Record "Service Invoice Header")
    var
        IntercompanyTransactions: Record "COL Intercompany Transactions";
        ServiceInvoiceHeader: Record "Service Invoice Header";
        ServiceMgtSetup: Record "Service Mgt. Setup";
    begin
        if not ServiceInvoiceHeader.Get(Rec."No.") then
            exit;

        if (Rec."COL GS. Company" = '') or (Rec."COL GS. Customer No." = '') then
            exit;

        if not ServiceMgtSetup.Get() then
            ServiceMgtSetup.Init();

        ServiceMgtSetup.TestField("COL Default Service GL Account");
        ServiceMgtSetup.TestField("COL Default Purch. GL Account");
        ServiceMgtSetup.TestField("COL Default IC GL Account");

        InitEntry(IntercompanyTransactions);
        IntercompanyTransactions."Transaction Document Type" := IntercompanyTransactions."Transaction Document Type"::"Service Invoice";
        IntercompanyTransactions."Posting Date" := Rec."Posting Date";
        IntercompanyTransactions."Document No." := Rec."No.";
        IntercompanyTransactions."Posting Description" := Rec."Posting Description";
        IntercompanyTransactions."Currency Code" := Rec."Currency Code";
        IntercompanyTransactions."Destination Company" := Rec."COL GS. Company";
        IntercompanyTransactions."Destination Customer No." := Rec."COL GS. Customer No.";
        IntercompanyTransactions."Destination Customer Name" := Rec."COL GS. Name";
        IntercompanyTransactions."Sales GL Account No." := ServiceMgtSetup."COL Default Service GL Account";
        IntercompanyTransactions."Purchase GL Account No." := ServiceMgtSetup."COL Default Purch. GL Account";
        IntercompanyTransactions."IC GL Account No." := ServiceMgtSetup."COL Default IC GL Account";
        CalcAndSetAmt(Rec, IntercompanyTransactions);
        IntercompanyTransactions.Insert(true);
    end;

    local procedure InitEntry(var IntercompanyTransactions: Record "COL Intercompany Transactions")
    var
        IntercompanyTransactionsLocal: Record "COL Intercompany Transactions";
        EntryNo: Integer;
    begin
        EntryNo := 1;
        if IntercompanyTransactionsLocal.FindLast() then
            EntryNo := IntercompanyTransactionsLocal."Entry No." + 1;

        IntercompanyTransactions."Entry No." := EntryNo;
        IntercompanyTransactions."Source Company" := CopyStr(CompanyName(), 1, MaxStrLen(IntercompanyTransactions."Source Company"));
    end;
}
