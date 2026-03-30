namespace Weibel.Service.Document;

using Microsoft.Sales.Customer;
using Microsoft.Service.Document;

codeunit 70217 "COL Srv. Change Customer Mgt."
{
    procedure ChangeBillToCustomer(var ServiceHeader: Record "Service Header")
    var
        RecreateSrvLinesSub: Codeunit "COL Recreate Srv. Lines Sub";
        NewCustomerNo: Code[20];
    begin
        if not RecreateSrvLinesSub.IsValidDocumentType(ServiceHeader."Document Type") then
            exit;
        if not GetCustomerNo(NewCustomerNo, ServiceHeader."Bill-to Customer No.", ServiceHeader."Currency Code") then
            exit;
        BindSubscription(RecreateSrvLinesSub);
        ServiceHeader.SetHideValidationDialog(true);
        ServiceHeader.Validate("Bill-to Customer No.", NewCustomerNo);
        ServiceHeader.SetHideValidationDialog(false);
        ServiceHeader.Modify(true);
        UnbindSubscription(RecreateSrvLinesSub);
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