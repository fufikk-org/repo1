namespace Weibel.Service.History;
using Microsoft.Service.Contract;

codeunit 70121 "COL Calc. Service Hist FB Ext"
{
    trigger OnRun()
    var
        ServiceContractHeader: Record "Service Contract Header";
        Params: Dictionary of [Text, Text];
        Results: Dictionary of [Text, Text];
        No: Code[20];
    begin
        Params := Page.GetBackgroundParameters();

        if (Params.ContainsKey(GetCustomerNoLabel()) and Params.ContainsKey(GetBillToCustomerNoLbl())) or
           (not Params.ContainsKey(GetCustomerNoLabel()) and not Params.ContainsKey(GetBillToCustomerNoLbl())) then
            exit;

        if Params.ContainsKey(GetCustomerNoLabel()) then begin
            No := CopyStr(Params.Get(GetCustomerNoLabel()), 1, MaxStrLen(No));
            ServiceContractHeader.SetRange("Customer No.", No);
        end else begin
            No := CopyStr(Params.Get(GetBillToCustomerNoLbl()), 1, MaxStrLen(No));
            ServiceContractHeader.SetRange("Bill-to Customer No.", No);
        end;

        ServiceContractHeader.SetRange("Contract Type", ServiceContractHeader."Contract Type"::Contract);
        Results.Add(GetNoOfOngoingServiceContractsLbl(), Format(ServiceContractHeader.Count()));

        ServiceContractHeader.SetRange("Contract Type", ServiceContractHeader."Contract Type"::Quote);
        Results.Add(GetNoOfContractQuotesLbl(), Format(ServiceContractHeader.Count()));

        Page.SetBackgroundTaskResult(Results);
    end;

    var
        CustomerNoLbl: label 'Customer No.', Locked = true;
        BillToCustomerNoLbl: label 'Bill-to Customer No.', Locked = true;
        NoOfContractQuotesLbl: Label 'NoOfContractQuotes', Locked = true;
        NoOfOngoingServiceContractsLbl: Label 'NoOfOngoingServiceContracts', Locked = true;

    procedure GetCustomerNoLabel(): Text
    begin
        exit(CustomerNoLbl);
    end;

    procedure GetBillToCustomerNoLbl(): Text
    begin
        exit(BillToCustomerNoLbl);
    end;

    internal procedure GetNoOfContractQuotesLbl(): Text
    begin
        exit(NoOfContractQuotesLbl);
    end;

    internal procedure GetNoOfOngoingServiceContractsLbl(): Text
    begin
        exit(NoOfOngoingServiceContractsLbl);
    end;
}
