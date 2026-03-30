namespace Weibel.RoleCenters;

using Microsoft.Sales.Document;
using Weibel.Sales.Document;

codeunit 70166 "COL O365 Background Calc."
{
    var
        Results: Dictionary of [Text, Text];

    trigger OnRun()
    var
        Parameters: Dictionary of [Text, Text];
    begin
        Parameters := Page.GetBackgroundParameters();

        CalculateFieldValues(Parameters, Results);

        Page.SetBackgroundTaskResult(Results);
    end;

    procedure CalculateFieldValues(Parameters: Dictionary of [Text, Text]; var ReturnResults: Dictionary of [Text, Text])
    var
        SalesHeader: Record "Sales Header";
    begin
        Clear(ReturnResults);
        ReturnResults.Add(SalesHeader.FieldName("COL Sales Finance Category"), Format(CountOrders()));
    end;

    procedure CountOrders() Result: Integer
    var
        CountSalesOrders: Query "COL Count Sales Orders";
    begin
        CountSalesOrders.SetRange(SalesFinanceCategory, '');
        CountSalesOrders.Open();
        CountSalesOrders.Read();
        exit(CountSalesOrders.Count_Orders);
    end;
}