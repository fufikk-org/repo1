namespace Weibel.Service.Posting;

using Microsoft.Service.Posting;
using Microsoft.Service.Document;
using System.Automation;
using Microsoft.Service.History;
using Weibel.Service.Document.Release;
using Microsoft.Warehouse.Request;
using Weibel.Intercompany;

codeunit 70106 "COL Service Post Subs."
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Serv-Documents Mgt.", OnBeforeFinalizeDeleteHeader, '', false, false)]
    local procedure "Serv-Documents Mgt._OnBeforeFinalizeDeleteHeader"(var PassedServHeader: Record "Service Header"; var ServHeader: Record "Service Header" temporary; var IsHandled: Boolean)
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        ApprovalsMgmt.DeleteApprovalEntries(PassedServHeader.RecordId);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Serv-Documents Mgt.", OnAfterFinalizeCrMemoDocument, '', false, false)]
    local procedure "Serv-Documents Mgt._OnAfterFinalizeCrMemoDocument"(var ServiceCrMemoHeader: Record "Service Cr.Memo Header"; ServiceHeader: Record "Service Header"; var PServCrMemoHeader: Record "Service Cr.Memo Header")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        ApprovalsMgmt.PostApprovalEntries(ServiceHeader.RecordId, PServCrMemoHeader.RecordId, PServCrMemoHeader."No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Service-Post", OnBeforeInitialize, '', false, false)]
    local procedure "Service-Post_OnBeforeInitialize"(var PassedServiceHeader: Record "Service Header"; PreviewMode: Boolean)
    var
        ReleaseServiceDocument: Codeunit "COL Release Service Document";
    begin
        if PreviewMode then
            exit;

        ReleaseServiceDocument.CheckPriority(PassedServiceHeader);
        ReleaseServiceDocument.CheckServiceHeaderPendingApproval(PassedServiceHeader);
        PassedServiceHeader.COLCheckServicePostRestrictions();
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Get Source Doc. Outbound", OnBeforeCreateFromServiceOrder, '', false, false)]
    // local procedure OnBeforeCreateFromServiceOrder(var ServiceHeader: Record "Service Header")
    // var
    //     ReleaseServiceDocument: Codeunit "COL Release Service Document";
    // begin
    //     ReleaseServiceDocument.CheckPriority(ServiceHeader);
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Serv-Documents Mgt.", 'OnAfterFinalizeInvoiceDocument', '', false, false)]
    local procedure OnAfterFinalizeInvoiceDocument(var ServiceInvoiceHeader: Record "Service Invoice Header"; ServiceHeader: record "Service Header"; var PServInvHeader: Record "Service Invoice Header")
    var
        IntercompanyMgt: Codeunit "COL Intercompany Mgt.";
    begin
        IntercompanyMgt.AddIntercompanyEntry(PServInvHeader);
    end;

}