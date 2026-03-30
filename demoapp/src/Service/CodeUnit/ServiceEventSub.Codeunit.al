namespace Weibel.Service.Document;

using Microsoft.Service.Document;
using Microsoft.Projects.Project.Job;
using Weibel.Common;
using Microsoft.Service.Item;
using Microsoft.Service.Ledger;
using Microsoft.Service.Posting;
using Microsoft.Service.History;

codeunit 70104 "COL Service Event Sub."
{
    [EventSubscriber(ObjectType::Table, DataBase::"Service Header", 'OnAfterValidateEvent', 'Document Date', false, false)]
    local procedure OnAfterValidateDocumentDate(var Rec: Record "Service Header"; var xRec: Record "Service Header")
    begin
        if xRec."Document Date" = Rec."Document Date" then
            exit;

        if not (Rec."Document Type" in [Rec."Document Type"::Quote, Rec."Document Type"::Order]) then
            exit;

        if Rec."Document Date" <> 0D then
            Rec.COLCalcQuoteValidUntilDate();
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Service Header", 'OnAfterInitRecord', '', false, false)]
    local procedure OnAfterInitRecord(var ServiceHeader: Record "Service Header")
    begin
        if not (ServiceHeader."Document Type" in [ServiceHeader."Document Type"::Quote, ServiceHeader."Document Type"::Order]) then
            exit;

        ServiceHeader.COLCalcQuoteValidUntilDate();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Service Header", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertEvent(var Rec: Record "Service Header"; RunTrigger: Boolean)
    begin
        SetEndUserData(Rec);
        CopyFromJob(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Service Header", 'OnAfterValidateEvent', 'Project No. PGS', false, false)]
    local procedure OnAfterValidateEvent(var Rec: Record "Service Header"; var xRec: Record "Service Header")
    begin
        if Rec."Project No. PGS" = xRec."Project No. PGS" then
            exit;

        SetEndUserData(Rec);
        CopyFromJob(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Service Item Line", 'OnAfterSetServItemInfo', '', false, false)]
    local procedure OnAfterSetServItemInfo(var ServiceItemLine: Record "Service Item Line"; xServiceItemLine: Record "Service Item Line"; ServiceItem: Record "Service Item")
    begin
        ServiceItemLine."COL Export Classification Code" := ServiceItem."COL Export Classification Code";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Service Ledger Entry", 'OnAfterCopyFromServLine', '', false, false)]
    local procedure OnAfterCopyFromServLine(var ServiceLedgerEntry: Record "Service Ledger Entry"; ServiceLine: Record "Service Line")
    var
        ServiceItemLine: Record "Service Item Line";
    begin
        ServiceItemLine.SetRange("Document Type", ServiceLine."Document Type");
        ServiceItemLine.SetRange("Document No.", ServiceLine."Document No.");
        ServiceItemLine.SetRange("Line No.", ServiceLine."Service Item Line No.");
        if ServiceItemLine.FindFirst() then
            ServiceLedgerEntry."COL Export Classification Code" := ServiceItemLine."COL Export Classification Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Serv-Documents Mgt.", 'OnBeforeServInvLineInsert', '', false, false)]
    local procedure OnBeforeServInvLineInsert(var ServiceInvoiceLine: Record "Service Invoice Line"; ServiceLine: Record "Service Line")
    var
        ServiceItemLine: Record "Service Item Line";
    begin
        ServiceItemLine.SetRange("Document Type", ServiceLine."Document Type");
        ServiceItemLine.SetRange("Document No.", ServiceLine."Document No.");
        ServiceItemLine.SetRange("Line No.", ServiceLine."Service Item Line No.");
        if ServiceItemLine.FindFirst() then
            ServiceInvoiceLine."COL Export Classification Code" := ServiceItemLine."COL Export Classification Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ServLedgEntries-Post", 'OnBeforeServLedgerEntryInsert', '', false, false)]
    local procedure OnBeforeServLedgerEntryInsert(var ServiceLedgerEntry: Record "Service Ledger Entry"; ServiceLine: Record "Service Line"; ServiceItemLine: Record "Service Item Line"; ServiceHeader: Record "Service Header")
    begin
        ServiceLedgerEntry."COL Export Classification Code" := ServiceItemLine."COL Export Classification Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"ServLedgEntries-Post", 'OnBeforeServLedgerEntrySaleInsert', '', false, false)]
    local procedure OnBeforeServLedgerEntrySaleInsert(var ServiceLedgerEntry: Record "Service Ledger Entry"; ServiceLine: Record "Service Line"; ServiceItemLine: Record "Service Item Line"; ServiceHeader: Record "Service Header")
    begin
        ServiceLedgerEntry."COL Export Classification Code" := ServiceItemLine."COL Export Classification Code";
    end;

    local procedure CopyFromJob(var Rec: Record "Service Header")
    var
        Job: Record "Job";
    begin
        if Rec."Project No. PGS" = '' then
            exit;

        if not Job.Get(Rec."Project No. PGS") then
            exit;

        Rec."COL Original Contractual Date" := Job."COL Original Contractual Date";
    end;

    local procedure SetEndUserData(var Rec: Record "Service Header")
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
}
