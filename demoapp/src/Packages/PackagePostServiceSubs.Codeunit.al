namespace Weibel.Packaging;

using Microsoft.Service.Posting;
using Microsoft.Service.Document;
using Microsoft.Service.History;

codeunit 70130 "COL Package Post Service Subs"
{
    var
        PackagePostingMgt: Codeunit "COL Package Posting Mgt.";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Service-Post", OnBeforeInitialize, '', false, false)]
    local procedure "Service-Post_OnBeforeInitialize"(var PassedServiceHeader: Record "Service Header"; var PassedServiceLine: Record "Service Line"; var PassedShip: Boolean; var PassedConsume: Boolean; var PassedInvoice: Boolean; PreviewMode: Boolean)
    begin
        if not PassedShip then
            exit;

        PassedServiceHeader.CalcFields("Completely Shipped");
        if PassedServiceHeader."Completely Shipped" then
            exit;

        PackagePostingMgt.CheckIfPackagesForDocumentExist(PassedServiceHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Serv-Documents Mgt.", OnAfterFinalizeShipmentDocument, '', false, false)]
    local procedure "Serv-Documents Mgt._OnAfterFinalizeShipmentDocument"(var ServiceShipmentHeader: Record "Service Shipment Header"; ServiceHeader: Record "Service Header"; var PServShptHeader: Record "Service Shipment Header")
    begin
        if ServiceHeader."Document Type" = Enum::"Service Document Type"::Order then
            PackagePostingMgt.TransferPackagesToPostedDocument(ServiceHeader."No.", Database::"Service Shipment Header", PServShptHeader."No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Serv-Documents Mgt.", OnBeforeSetLastNos, '', false, false)]
    local procedure "Serv-Documents Mgt._OnBeforeSetLastNos"(var PServHeader: Record "Service Header"; var ServHeader: Record "Service Header" temporary; Ship: Boolean; Invoice: Boolean; ServLinesPassed: Boolean; CloseCondition: Boolean; var IsHandled: Boolean)
    begin
        if Ship and (PServHeader."Document Type" = Enum::"Service Document Type"::Order) then begin
            PServHeader."COL Total Gross Weight Manual" := 0;
            PServHeader."COL No. of Packages Manual" := 0;
        end;
    end;
}