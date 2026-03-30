namespace Weibel.Intercompany;

using Microsoft.Sales.History;
using Microsoft.Sales.Setup;

codeunit 70214 "COL Intercompany Cr. Memo Mgt."
{
    procedure AddIntercompanyEntry(var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        IntercompanyTransactions: Record "COL Intercompany Transactions";
        SalesSetup: Record "Sales & Receivables Setup";
        ErrorSetupErr: Label 'In Company: %1, there is not setup Default G/L Accounts for Intercompany transactions (Table Sales & Receivables Setup)', Comment = '%1 is the company name';
    begin
        if (SalesCrMemoHeader."No." = '') or (SalesCrMemoHeader."COL GS. Company" = '') or (SalesCrMemoHeader."COL GS. Customer No." = '') then
            exit;

        SalesSetup.ChangeCompany(SalesCrMemoHeader."COL GS. Company");
        if not SalesSetup.Get() then
            Error(ErrorSetupErr, SalesCrMemoHeader."COL GS. Company");

        if (SalesSetup."COL Default Sales GL Account" = '') or (SalesSetup."COL Default Purch. GL Account" = '') or (SalesSetup."COL Default IC GL Account" = '') then
            Error(ErrorSetupErr, SalesCrMemoHeader."COL GS. Company");

        InitEntry(IntercompanyTransactions);
        IntercompanyTransactions."Transaction Document Type" := IntercompanyTransactions."Transaction Document Type"::"Sales Cr. Memo";
        IntercompanyTransactions.CopyFromSalesCrMemoHeader(SalesCrMemoHeader);
        IntercompanyTransactions."Sales GL Account No." := SalesSetup."COL Default Sales GL Account";
        IntercompanyTransactions."Purchase GL Account No." := SalesSetup."COL Default Purch. GL Account";
        IntercompanyTransactions."IC GL Account No." := SalesSetup."COL Default IC GL Account";
        IntercompanyTransactions.Insert(true);
    end;

    local procedure InitEntry(var IntercompanyTransactions: Record "COL Intercompany Transactions")
    var
        IntercompanyTransactionsLocal: Record "COL Intercompany Transactions";
        EntryNo: Integer;
    begin
        EntryNo := 1;
        IntercompanyTransactions.SetLoadFields("Entry No.");
        if IntercompanyTransactionsLocal.FindLast() then
            EntryNo := IntercompanyTransactionsLocal."Entry No." + 1;

        IntercompanyTransactions."Entry No." := EntryNo;
        IntercompanyTransactions."Source Company" := CopyStr(CompanyName(), 1, MaxStrLen(IntercompanyTransactions."Source Company"));
    end;
}
