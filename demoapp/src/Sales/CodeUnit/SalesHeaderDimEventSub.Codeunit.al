namespace Weibel.Sales.Document;

using Microsoft.Sales.Document;

codeunit 70236 "COL Sales Header Dim Event Sub"
{
    EventSubscriberInstance = Manual;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeConfirmKeepExistingDimensions', '', false, false)]
    local procedure RunOnBeforeConfirmKeepExistingDimensions(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; FieldNo: Integer; OldDimSetID: Integer; var Confirmed: Boolean; var IsHandled: Boolean)
    begin
        Confirmed := true;
        IsHandled := true;
    end;
}
