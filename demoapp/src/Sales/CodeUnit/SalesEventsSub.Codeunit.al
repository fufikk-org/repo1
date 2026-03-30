
namespace Weibel.Events.Sub;

using Microsoft.Sales.Document;
using Microsoft.Projects.Project.Job;
using Microsoft.Foundation.Reporting;
using Weibel.Sales.Setup;
using Weibel.Foundation.Reporting;
using Weibel.Common;
using Weibel.Inventory.Item;
using Microsoft.Sales.Posting;
using Microsoft.Sales.Setup;
using Microsoft.Sales.History;
using Weibel.Intercompany;
using Weibel.Sales.Document;
using Weibel.Foundation.TermsAndConditions;

codeunit 70119 "COL Sales Events Sub."
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertEvent(var Rec: Record "Sales Header"; RunTrigger: Boolean)
    begin
        SetEndUserData(Rec);
        CopyFromJob(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Project No. PGS', false, false)]
    local procedure OnAfterValidateEvent(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    begin
        if Rec."Project No. PGS" = xRec."Project No. PGS" then
            exit;

        SetEndUserData(Rec);
        CopyFromJob(Rec);

    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Get Source Doc. Outbound", OnBeforeCreateFromSalesOrder, '', false, false)]
    // local procedure OnBeforeCreateFromSalesOrder(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    // begin
    //     CheckPriority(SalesHeader);
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforePostSalesDoc, '', false, false)]
    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean)
    begin
        if PreviewMode then
            exit;

        CheckPriority(SalesHeader);
        CheckTermsAndConditions(SalesHeader);
    end;

    procedure CheckPriority(var SalesHeader: Record "Sales Header")
    var
        ExportPermitErr: Label 'Sales document cannot be processed because field %1 is blank', Comment = '%1 = field caption';
    begin
        if not (SalesHeader."Document Type" in [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Quote, SalesHeader."Document Type"::Invoice]) then
            exit;

        if SalesHeader."COL Export Classification Code" in [enum::"COL Item Export Classification"::"Military Product", enum::"COL Item Export Classification"::"Dual Use", enum::"COL Item Export Classification"::Unknown] then
            if SalesHeader."COL Export Permit No." = '' then
                Error(ExportPermitErr, SalesHeader.FieldCaption("COL Export Permit No."));
    end;

    local procedure CopyFromJob(var Rec: Record "Sales Header")
    var
        Job: Record "Job";
    begin
        if Rec."Project No. PGS" = '' then
            exit;

        if not Job.Get(Rec."Project No. PGS") then
            exit;

        Rec."COL Original Contractual Date" := Job."COL Original Contractual Date";
    end;

    local procedure SetEndUserData(var Rec: Record "Sales Header")
    var
        Job: Record "Job";
        CommonCustMgt: Codeunit "COL Common Cust. Mgt";
    begin
        if Rec."Project No. PGS" = '' then
            exit;

        if not Job.Get(Rec."Project No. PGS") then
            exit;

        CommonCustMgt.CopyFromJob(Rec, Job);
    end;

    local procedure CheckTermsAndConditions(var SalesHeader: Record "Sales Header")
    var
        TermsAndConditions: Record "COL Terms and Conditions";
    begin
        if SalesHeader."COL Terms and Cond. Code" = '' then
            exit;
        // just check if the record exists
        TermsAndConditions.Get(SalesHeader."COL Terms and Cond. Code");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterFinalizePostingOnBeforeCommit', '', false, false)]
    local procedure OnAfterFinalizePostingOnBeforeCommit(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var ReturnReceiptHeader: Record "Return Receipt Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean)
    var
        IntercompanyMgt: Codeunit "COL Intercompany Mgt.";
        IntercompanyCrMemoMgt: Codeunit "COL Intercompany Cr. Memo Mgt.";
    begin
        if PreviewMode then
            exit;

        if SalesHeader.Invoice then
            case SalesHeader."Document Type" of
                Enum::"Sales Document Type"::Invoice, Enum::"Sales Document Type"::Order:
                    IntercompanyMgt.AddIntercompanyEntry(SalesInvoiceHeader);
                Enum::"Sales Document Type"::"Credit Memo", Enum::"Sales Document Type"::"Return Order":
                    IntercompanyCrMemoMgt.AddIntercompanyEntry(SalesCrMemoHeader);
            end;
    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', false, false)]
    local procedure OnBeforeReleaseSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean; SkipCheckReleaseRestrictions: Boolean)
    var
        SalesBOMMgt: Codeunit "COL Sales BOM Mgt.";
        SalesArchiveMgt: Codeunit "COL Sales Archive Mgt.";
    begin
        SalesBOMMgt.CheckReleaseSalesDoc(SalesHeader);
        SalesArchiveMgt.DoArchiveSalesDoc(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Release Sales Document", 'OnBeforeReopenSalesDoc', '', false, false)]
    local procedure OnBeforeReleaseSalesDoc2(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean)
    var
        SalesArchiveMgt: Codeunit "COL Sales Archive Mgt.";
    begin
        SalesArchiveMgt.DoArchiveSalesDoc(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterIsBillToAddressEqualToSellToAddress, '', false, false)]
    local procedure "Sales Header_OnAfterIsBillToAddressEqualToSellToAddress"(SellToSalesHeader: Record "Sales Header"; BillToSalesHeader: Record "Sales Header"; var Result: Boolean)
    begin
        // no need to check, data in sell and bill to is different
        if not Result then
            exit;

        Result := Result and (SellToSalesHeader."Sell-to Customer Name" = BillToSalesHeader."Bill-to Name") and
            (SellToSalesHeader."Sell-to Customer Name 2" = BillToSalesHeader."Bill-to Name 2");
    end;

    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Inv. - Update", 'OnAfterRecordChanged', '', false, false)]
    local procedure RunOnAfterRecordChangedPostedSalesInvUpdate(var SalesInvoiceHeader: Record "Sales Invoice Header"; xSalesInvoiceHeader: Record "Sales Invoice Header"; var IsChanged: Boolean)
    begin
        if IsChanged then
            exit;

        IsChanged := IsChanged or
                 (SalesInvoiceHeader."Order No." <> xSalesInvoiceHeader."Order No.") or
                 (SalesInvoiceHeader."COL Sales Finance Category" <> xSalesInvoiceHeader."COL Sales Finance Category") or
                 (SalesInvoiceHeader."COL Sales Order Category" <> xSalesInvoiceHeader."COL Sales Order Category") or
                 (SalesInvoiceHeader."COL Project Name" <> xSalesInvoiceHeader."COL Project Name") or
                 (SalesInvoiceHeader."COL Sales Resp. Group" <> xSalesInvoiceHeader."COL Sales Resp. Group");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Inv. Header - Edit", 'OnOnRunOnBeforeTestFieldNo', '', false, false)]
    local procedure RunOnOnRunOnBeforeTestFieldNo(var SalesInvoiceHeader: Record "Sales Invoice Header"; SalesInvoiceHeaderRec: Record "Sales Invoice Header")
    begin
        SalesInvoiceHeader."Order No." := SalesInvoiceHeaderRec."Order No.";
        SalesInvoiceHeader."COL Sales Finance Category" := SalesInvoiceHeaderRec."COL Sales Finance Category";
        SalesInvoiceHeader."COL Sales Order Category" := SalesInvoiceHeaderRec."COL Sales Order Category";
        SalesInvoiceHeader."COL Project Name" := SalesInvoiceHeaderRec."COL Project Name";
        SalesInvoiceHeader."COL Sales Resp. Group" := SalesInvoiceHeaderRec."COL Sales Resp. Group";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Pstd. Sales Cr. Memo - Update", 'OnAfterRecordChanged', '', false, false)]
    local procedure RunOnAfterRecordChangedPostedSalesCrMemoUpdate(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; xSalesCrMemoHeader: Record "Sales Cr.Memo Header"; var IsChanged: Boolean)
    begin
        if IsChanged then
            exit;

        IsChanged := IsChanged or
                 (SalesCrMemoHeader."COL Order No." <> xSalesCrMemoHeader."COL Order No.") or
                 (SalesCrMemoHeader."COL Sales Finance Category" <> xSalesCrMemoHeader."COL Sales Finance Category") or
                 (SalesCrMemoHeader."COL Sales Order Category" <> xSalesCrMemoHeader."COL Sales Order Category") or
                 (SalesCrMemoHeader."COL Project Name" <> xSalesCrMemoHeader."COL Project Name") or
                 (SalesCrMemoHeader."COL Sales Resp. Group" <> xSalesCrMemoHeader."COL Sales Resp. Group");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Credit Memo Hdr. - Edit", 'OnBeforeSalesCrMemoHeaderModify', '', false, false)]
    local procedure RunOnBeforeSalesCrMemoHeaderModify(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; FromSalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
        SalesCrMemoHeader."COL Order No." := FromSalesCrMemoHeader."COL Order No.";
        SalesCrMemoHeader."COL Sales Finance Category" := FromSalesCrMemoHeader."COL Sales Finance Category";
        SalesCrMemoHeader."COL Sales Order Category" := FromSalesCrMemoHeader."COL Sales Order Category";
        SalesCrMemoHeader."COL Project Name" := FromSalesCrMemoHeader."COL Project Name";
        SalesCrMemoHeader."COL Sales Resp. Group" := FromSalesCrMemoHeader."COL Sales Resp. Group";
    end;

}
