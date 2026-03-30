namespace Weibel.Sales.Document;

using Microsoft.Sales.Document;
using Microsoft.Inventory.Item.Catalog;

codeunit 70215 "COL Recreate Sales Lines Sub"
{
    EventSubscriberInstance = Manual;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnBeforeRecreateSalesLinesHandler, '', false, false)]
    local procedure "Sales Header_OnBeforeRecreateSalesLinesHandler"(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; ChangedFieldName: Text[100]; var IsHandled: Boolean)
    var
        CannotChangeErr: Label 'You cannot change field''s value because this would lead to change in ''%1''.', Comment = '%1 = changed field name';
    begin
        if not IsValidDocumentType(SalesHeader."Document Type") then
            exit;

        if SalesHeader."Currency Code" <> xSalesHeader."Currency Code" then
            Error(CannotChangeErr, SalesHeader.FieldCaption("Currency Code"));
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnBeforeSalesLineInsert, '', false, false)]
    local procedure "Sales Header_OnBeforeSalesLineInsert"(var SalesLine: Record "Sales Line"; var TempSalesLine: Record "Sales Line" temporary; SalesHeader: Record "Sales Header")
    begin
        if not IsValidDocumentType(SalesLine."Document Type") then
            exit;

        if SalesLine."No." = '' then
            exit;

        SalesLine.Description := TempSalesLine.Description;
        SalesLine."Description 2" := TempSalesLine."Description 2";

        if (TempSalesLine."Item Reference Type" <> Enum::"Item Reference Type"::Customer) then begin
            SalesLine."Item Reference Unit of Measure" := TempSalesLine."Item Reference Unit of Measure";
            SalesLine."Item Reference Type" := TempSalesLine."Item Reference Type";
            SalesLine."Item Reference Type No." := TempSalesLine."Item Reference Type No.";
            SalesLine."Item Reference No." := TempSalesLine."Item Reference No.";
        end;

        if TempSalesLine."Unit Price" <> SalesLine."Unit Price" then
            SalesLine.Validate("Unit Price", TempSalesLine."Unit Price");
        if TempSalesLine."Line Discount %" <> SalesLine."Line Discount %" then
            SalesLine.Validate("Line Discount %", TempSalesLine."Line Discount %");
    end;

    internal procedure IsValidDocumentType(DocType: Enum "Sales Document Type"): Boolean
    begin
        exit(DocType in [Enum::"Sales Document Type"::Quote, Enum::"Sales Document Type"::Order]);
    end;

}