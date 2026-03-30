namespace Weibel.Sales.Document;
using Microsoft.Sales.Document;
using Microsoft.Sales.Customer;

codeunit 70216 "COL Sales Change Customer Mgt."
{
    var

    procedure ChangeSellToCustomer(var SalesHeader: Record "Sales Header")
    var
        RecreateSalesLinesSub: Codeunit "COL Recreate Sales Lines Sub";
        NewCustomerNo: Code[20];
    begin
        if not RecreateSalesLinesSub.IsValidDocumentType(SalesHeader."Document Type") then
            exit;
        if not GetCustomerNo(NewCustomerNo, SalesHeader."Sell-to Customer No.", SalesHeader."Currency Code") then
            exit;
        BindSubscription(RecreateSalesLinesSub);
        SalesHeader.SetHideValidationDialog(true);
        SalesHeader.Validate("Sell-to Customer No.", NewCustomerNo);
        SalesHeader.SetHideValidationDialog(false);
        SalesHeader.Modify(true);
        UnbindSubscription(RecreateSalesLinesSub);
    end;

    procedure ChangeBillToCustomer(var SalesHeader: Record "Sales Header")
    var
        RecreateSalesLinesSub: Codeunit "COL Recreate Sales Lines Sub";
        NewCustomerNo: Code[20];
    begin
        if not RecreateSalesLinesSub.IsValidDocumentType(SalesHeader."Document Type") then
            exit;
        if not GetCustomerNo(NewCustomerNo, SalesHeader."Bill-to Customer No.", SalesHeader."Currency Code") then
            exit;
        BindSubscription(RecreateSalesLinesSub);
        SalesHeader.SetHideValidationDialog(true);
        SalesHeader.Validate("Bill-to Customer No.", NewCustomerNo);
        SalesHeader.SetHideValidationDialog(false);
        SalesHeader.Modify(true);
        UnbindSubscription(RecreateSalesLinesSub);
    end;

    local procedure GetCustomerNo(var NewCustomerNo: Code[20]; CurrentCustomerNo: Code[20]; CurrentCurrencyCode: Code[10]): Boolean
    var
        Customer: Record Customer;
    begin
        Clear(NewCustomerNo);
        Customer.SetFilter("No.", '<>%1', CurrentCustomerNo);
        Customer.SetRange("Currency Code", CurrentCurrencyCode);
        Customer.SetRange(Blocked, Enum::"Customer Blocked"::" ");

        if Page.RunModal(Page::"Customer Lookup", Customer) = Action::LookupOK then begin
            NewCustomerNo := Customer."No.";
            exit(true);
        end;
        exit(false);
    end;
}