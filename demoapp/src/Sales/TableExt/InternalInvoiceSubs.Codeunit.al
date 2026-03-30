codeunit 70204 "COL Internal Invoice Subs."
{
    EventSubscriberInstance = Manual;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"COL Internal Invoice Subs.", 'OnCheckIfInternalInvoice', '', false, false)]
    local procedure RunOnCheckIfInternalInvoice(var IsInternalInvoice: Boolean)
    begin
        IsInternalInvoice := true;
    end;

    [IntegrationEvent(false, false)]
    procedure OnCheckIfInternalInvoice(var IsInternalInvoice: Boolean)
    begin
    end;
}