namespace Weibel.Packaging;

using Microsoft.Sales.Document;
using Microsoft.Sales.Posting;
using Microsoft.Sales.History;
using Microsoft.Finance.GeneralLedger.Posting;

codeunit 70128 "COL Package Post Sales Subs"
{
    var
        PackagePostingMgt: Codeunit "COL Package Posting Mgt.";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnRunOnBeforeCheckAndUpdate, '', false, false)]
    local procedure "Sales-Post_OnRunOnBeforeCheckAndUpdate"(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader.CalcFields("Completely Shipped");
        if SalesHeader."Completely Shipped" then
            exit;
        PackagePostingMgt.CheckIfPackagesForDocumentExist(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnRunOnBeforeFinalizePosting, '', false, false)]
    local procedure OnRunOnBeforeFinalizePosting(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var ReturnReceiptHeader: Record "Return Receipt Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; CommitIsSuppressed: Boolean; GenJnlLineExtDocNo: Code[35]; var EverythingInvoiced: Boolean; GenJnlLineDocNo: Code[20]; SrcCode: Code[10]; PreviewMode: Boolean)
    begin
        if SalesHeader."Document Type" = Enum::"Sales Document Type"::Order then
            PackagePostingMgt.TransferPackagesToPostedDocument(SalesHeader."No.", Database::"Sales Shipment Header", SalesShipmentHeader."No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeFinalizePosting', '', false, false)]
    local procedure "Sales-Post_OnAfterFinalizePostingOnBeforeCommit"(var SalesHeader: Record "Sales Header")
    begin
        if SalesHeader.Ship and (SalesHeader."Document Type" = Enum::"Sales Document Type"::Order) then
            if (SalesHeader."COL Total Gross Weight Manual" <> 0) or (SalesHeader."COL No. of Packages Manual" <> 0) then begin
                SalesHeader."COL Total Gross Weight Manual" := 0;
                SalesHeader."COL No. of Packages Manual" := 0;
                SalesHeader.Modify();
            end;
    end;


}