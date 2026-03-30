namespace Weibel.Finance.GeneralLedger.Ledger;

using Microsoft.Finance.GeneralLedger.Ledger;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.Bank.BankAccount;
using Microsoft.Sales.Customer;
using Microsoft.Purchases.Vendor;
using Microsoft.HumanResources.Employee;
using Microsoft.Intercompany.Partner;

codeunit 70210 "COL GLEntry Subs"
{
    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", OnAfterCopyGLEntryFromGenJnlLine, '', false, false)]
    local procedure "G/L Entry_OnAfterCopyGLEntryFromGenJnlLine"(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GLEntry."COL Acubiz Travel ID" := GenJournalLine."COL Acubiz Travel ID";
        SetSourceName(GLEntry);
    end;

    internal procedure SetSourceName(var GLEntry: Record "G/L Entry")
    begin
        if not ShouldSourceNameBeUpdated(GLEntry) then
            exit;

        case GLEntry."Source Type" of
            Enum::"Gen. Journal Source Type"::"Bank Account":
                SetSourceNameFromBankAccount(GLEntry);
            Enum::"Gen. Journal Source Type"::Customer:
                SetSourceNameFromCustomer(GLEntry);
            Enum::"Gen. Journal Source Type"::Vendor:
                SetSourceNameFromVendor(GLEntry);
            Enum::"Gen. Journal Source Type"::Employee:
                SetSourceNameFromEmployee(GLEntry);
            Enum::"Gen. Journal Source Type"::"Fixed Asset":
                SetSourceNameFromFA(GLEntry);
            Enum::"Gen. Journal Source Type"::"IC Partner":
                SetSourceNameFromICPartner(GLEntry);
        end;
    end;

    internal procedure ShouldSourceNameBeUpdated(var GLEntry: Record "G/L Entry"): Boolean
    begin
        if (GLEntry."Source No." = '') or (GLEntry."Source Type" = Enum::"Gen. Journal Source Type"::" ") then
            exit(false);

        exit(true);
    end;


    local procedure SetSourceNameFromBankAccount(var GLEntry: Record "G/L Entry")
    var
        BankAccount: Record "Bank Account";
    begin
        BankAccount.ReadIsolation := IsolationLevel::ReadCommitted;
        BankAccount.SetLoadFields(Name);
        if BankAccount.Get(GLEntry."Source No.") then
            GLEntry."COL Source Name" := BankAccount.Name;
    end;

    local procedure SetSourceNameFromCustomer(var GLEntry: Record "G/L Entry")
    var
        Customer: Record Customer;
    begin
        Customer.ReadIsolation := IsolationLevel::ReadCommitted;
        Customer.SetLoadFields(Name);
        if Customer.Get(GLEntry."Source No.") then
            GLEntry."COL Source Name" := Customer.Name;
    end;

    local procedure SetSourceNameFromVendor(var GLEntry: Record "G/L Entry")
    var
        Vendor: Record Vendor;
    begin
        Vendor.ReadIsolation := IsolationLevel::ReadCommitted;
        Vendor.SetLoadFields(Name);
        if Vendor.Get(GLEntry."Source No.") then
            GLEntry."COL Source Name" := Vendor.Name;
    end;

    local procedure SetSourceNameFromEmployee(var GLEntry: Record "G/L Entry")
    var
        Employee: Record Employee;
    begin
        Employee.ReadIsolation := IsolationLevel::ReadCommitted;
        if Employee.Get(GLEntry."Source No.") then
            if StrLen(Employee.FullName()) <= MaxStrLen(GLEntry."COL Source Name") then
                GLEntry."COL Source Name" := CopyStr(Employee.FullName(), 1, MaxStrLen(GLEntry."COL Source Name"))
            else
                GLEntry."COL Source Name" := Employee.Initials;
    end;

    local procedure SetSourceNameFromFA(var GLEntry: Record "G/L Entry")
    var
        FA: Record "Fixed Asset";
    begin
        FA.ReadIsolation := IsolationLevel::ReadCommitted;
        FA.SetLoadFields(Description);
        if FA.Get(GLEntry."Source No.") then
            GLEntry."COL Source Name" := FA.Description;
    end;

    local procedure SetSourceNameFromICPartner(var GLEntry: Record "G/L Entry")
    var
        ICPartner: Record "IC Partner";
    begin
        ICPartner.ReadIsolation := IsolationLevel::ReadCommitted;
        ICPartner.SetLoadFields(Name);
        if ICPartner.Get(GLEntry."Source No.") then
            GLEntry."COL Source Name" := ICPartner.Name;
    end;
}