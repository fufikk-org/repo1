namespace Weibel.Service.Document;

using Microsoft.Inventory.Item.Catalog;
using Microsoft.Service.Document;

codeunit 70218 "COL Recreate Srv. Lines Sub"
{
    EventSubscriberInstance = Manual;

    [EventSubscriber(ObjectType::Table, Database::"Service Header", OnBeforeRecreateServLines, '', false, false)]
    local procedure "Service Header_OnBeforeRecreateServLines"(var ServiceHeader: Record "Service Header"; xServiceHeader: Record "Service Header"; ChangedFieldName: Text[100]; var IsHandled: Boolean; CurrentFieldNo: Integer)
    var
        CannotChangeErr: Label 'You cannot change field''s value because this would lead to change in ''%1''.', Comment = '%1 = changed field name';
    begin
        if not IsValidDocumentType(ServiceHeader."Document Type") then
            exit;

        if ServiceHeader."Currency Code" <> xServiceHeader."Currency Code" then
            Error(CannotChangeErr, ServiceHeader.FieldCaption("Currency Code"));
    end;

    [EventSubscriber(ObjectType::Table, Database::"Service Header", OnBeforeInsertServLineOnServLineRecreation, '', false, false)]
    local procedure "Service Header_OnBeforeInsertServLineOnServLineRecreation"(var ServiceLine: Record "Service Line"; var TempServiceLine: Record "Service Line" temporary)
    begin
        if not IsValidDocumentType(ServiceLine."Document Type") then
            exit;

        if ServiceLine."No." = '' then
            exit;

        ServiceLine.Description := TempServiceLine.Description;
        ServiceLine."Description 2" := TempServiceLine."Description 2";

        if (TempServiceLine."Item Reference Type" <> Enum::"Item Reference Type"::Customer) then begin
            ServiceLine."Item Reference Unit of Measure" := TempServiceLine."Item Reference Unit of Measure";
            ServiceLine."Item Reference Type" := TempServiceLine."Item Reference Type";
            ServiceLine."Item Reference Type No." := TempServiceLine."Item Reference Type No.";
            ServiceLine."Item Reference No." := TempServiceLine."Item Reference No.";
        end;

        if TempServiceLine."Unit Price" <> ServiceLine."Unit Price" then
            ServiceLine.Validate("Unit Price", TempServiceLine."Unit Price");
        if TempServiceLine."Line Discount %" <> ServiceLine."Line Discount %" then
            ServiceLine.Validate("Line Discount %", TempServiceLine."Line Discount %");
    end;

    internal procedure IsValidDocumentType(DocType: Enum "Service Document Type"): Boolean
    begin
        exit(DocType in [Enum::"Service Document Type"::Order]);
    end;
}