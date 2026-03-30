namespace Weibel.Service.Document;

using Microsoft.Service.Document;
using Weibel.Service.History;
using Microsoft.Service.Contract;

pageextension 70143 "COL Service Hist. Bill-to F.B." extends "Service Hist. Bill-to FactBox"
{
    layout
    {
        addlast(Control14)
        {
            field("COL NoOfOngoingServiceContracts"; NoOfOngoingServiceContracts)
            {
                ApplicationArea = Service;
                Caption = 'Ongoing Service Contracts';
                DrillDown = true;
                Editable = true;
                ToolTip = 'Specifies the number of outgoing contract that exist for the customer.';

                trigger OnDrillDown()
                var
                    ServiceContractHeader: Record "Service Contract Header";
                begin
                    ServiceContractHeader.SetRange("Contract Type", ServiceContractHeader."Contract Type"::Contract);
                    ServiceContractHeader.SetRange("Bill-to Customer No.", Rec."No.");
                    Page.Run(Page::"Customer Service Contracts", ServiceContractHeader);
                end;
            }
            field("COL NoOfContractQuotes"; NoOfContractQuotes)
            {
                ApplicationArea = Service;
                Caption = 'Service Contract Quotes';
                DrillDown = true;
                Editable = true;
                ToolTip = 'Specifies the number of contract quotes that exist for the customer.';

                trigger OnDrillDown()
                var
                    ServiceContractHeader: Record "Service Contract Header";
                begin
                    ServiceContractHeader.SetRange("Contract Type", ServiceContractHeader."Contract Type"::Quote);
                    ServiceContractHeader.SetRange("Bill-to Customer No.", Rec."No.");
                    Page.Run(Page::"Service Contract Quotes", ServiceContractHeader);
                end;
            }
        }
    }

    var
        NoOfContractQuotes: Integer;
        NoOfOngoingServiceContracts: Integer;
        TaskIdCalculateCueExt: Integer;

    trigger OnAfterGetRecord()
    var
        CalcServiceHistFBExt: Codeunit "COL Calc. Service Hist FB Ext";
        Args: Dictionary of [Text, Text];
    begin
        if (TaskIdCalculateCueExt <> 0) then
            CurrPage.CancelBackgroundTask(TaskIdCalculateCueExt);

        NoOfOngoingServiceContracts := 0;
        NoOfContractQuotes := 0;

        Args.Add(CalcServiceHistFBExt.GetBillToCustomerNoLbl(), Rec."No.");
        CurrPage.EnqueueBackgroundTask(TaskIdCalculateCueExt, Codeunit::"COL Calc. Service Hist FB Ext", Args);
    end;

    trigger OnPageBackgroundTaskCompleted(TaskId: Integer; Results: Dictionary of [Text, Text])
    var
        CalcServiceHistFBExt: Codeunit "COL Calc. Service Hist FB Ext";
    begin
        if (TaskId <> TaskIdCalculateCueExt) or (Results.Count() = 0) then
            exit;

        NoOfOngoingServiceContracts := COLGetResultAsInt(Results, CalcServiceHistFBExt.GetNoOfOngoingServiceContractsLbl());
        NoOfContractQuotes := COLGetResultAsInt(Results, CalcServiceHistFBExt.GetNoOfContractQuotesLbl());
    end;

    local procedure COLGetResultAsInt(var DictionaryToLookIn: Dictionary of [Text, Text]; KeyToSearchFor: Text): Integer
    var
        i: Integer;
    begin
        if not DictionaryToLookIn.ContainsKey(KeyToSearchFor) then
            exit(0);
        if Evaluate(i, DictionaryToLookIn.Get(KeyToSearchFor)) then;
        exit(i);
    end;
}
