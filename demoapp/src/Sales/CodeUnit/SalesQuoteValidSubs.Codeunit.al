namespace Weibel.Events.Sub;

using Microsoft.Sales.Document;

using Microsoft.Foundation.Reporting;

codeunit 70222 "COL Sales Quote Valid. Subs."
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Print", OnBeforeDoPrintSalesHeader, '', false, false)]
    local procedure "Document-Print_OnBeforeDoPrintSalesHeader"(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader.COLCheckIfQuoteValidToDateIsEmpty();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Print", OnDoPrintSalesHeaderToDocumentAttachmentOnBeforeRunSaveAsDocumentAttachment, '', false, false)]
    local procedure "Document-Print_OnDoPrintSalesHeaderToDocumentAttachmentOnBeforeRunSaveAsDocumentAttachment"(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader.COLCheckIfQuoteValidToDateIsEmpty();
    end;
}