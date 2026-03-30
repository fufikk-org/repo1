namespace Weibel.RoleCenters;

using Microsoft.Sales.Document;

pageextension 70206 "COL O365 Activities" extends "O365 Activities"
{
    layout
    {
        addafter("Incoming Documents")
        {
            cuegroup("COL Finance Review")
            {
                Caption = 'Finance Review';
                field("COL EmptyFinanceCategoryCount"; EmptyFinanceCategoryCount)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Finance Category';
                    ToolTip = 'Specifies sales orders that need to have their finance category reviewed or set.';

                    trigger OnDrillDown()
                    var
                        SalesHeader: Record "Sales Header";
                    begin
                        SalesHeader.SetRange("Document Type", Enum::"Sales Document Type"::Order);
                        SalesHeader.SetRange("COL Sales Finance Category", '');
                        Page.Run(Page::"Sales Order List", SalesHeader);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CalculateCueValues();
    end;

    trigger OnPageBackgroundTaskCompleted(TaskId: Integer; Results: Dictionary of [Text, Text])
    var
        SalesHeader: Record "Sales Header";
        ResultValue: Text;
    begin
        if TaskId <> EmptyCategoryTaskId then
            exit;
        EmptyCategoryTaskId := 0;

        if TryGetDictionaryValue(Results, SalesHeader.FieldName("COL Sales Finance Category"), ResultValue) then
            Evaluate(EmptyFinanceCategoryCount, ResultValue);

    end;

    local procedure CalculateCueValues()
    var
        Parameters: Dictionary of [Text, Text];
        TimeoutInMs: Integer;
    begin
        TimeoutInMs := 5000;
        if EmptyCategoryTaskId <> 0 then
            if CurrPage.CancelBackgroundTask(EmptyCategoryTaskId) then;
        CurrPage.EnqueueBackgroundTask(EmptyCategoryTaskId, Codeunit::"COL O365 Background Calc.", Parameters, TimeoutInMs, PageBackgroundTaskErrorLevel::Ignore);
    end;

    [TryFunction]
    local procedure TryGetDictionaryValue(var Results: Dictionary of [Text, Text]; DictionaryKey: Text; var ReturnValue: Text)
    begin
        ReturnValue := Results.Get(DictionaryKey);
    end;

    var
        EmptyCategoryTaskId, EmptyFinanceCategoryCount : Integer;
}