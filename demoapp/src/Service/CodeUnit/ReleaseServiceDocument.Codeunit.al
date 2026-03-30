namespace Weibel.Service.Document.Release;

using Microsoft.Service.Document;
using Weibel.System.Automation;
using Weibel.Service.Document;
using Weibel.Inventory.Item;

codeunit 70109 "COL Release Service Document"
{
    TableNo = "Service Header";

    var
        ServiceWorkflowLabels: Codeunit "COL Service Workflow Labels";

    /// <summary>
    /// Perform manual release of service credit memo
    /// </summary>
    /// <param name="ServiceHeader"></param>
    procedure CheckAndRelease(var ServiceHeader: Record "Service Header")
    begin
        if ServiceHeader."Document Type" <> ServiceHeader."Document Type"::"Credit Memo" then
            exit;

        if ServiceHeader."COL Document Status" = ServiceHeader."COL Document Status"::Released then
            exit;

        CheckServiceHeaderPendingApproval(ServiceHeader);
        ServiceHeader.COLCheckServiceReleaseRestrictions();
        Release(ServiceHeader);
    end;

    /// <summary>
    /// Perform manual reopen of service credit memo
    /// </summary>
    /// <param name="ServiceHeader"></param>
    procedure CheckAndReopen(var ServiceHeader: Record "Service Header")
    begin
        if ServiceHeader."Document Type" <> ServiceHeader."Document Type"::"Credit Memo" then
            exit;

        if ServiceHeader."COL Document Status" = ServiceHeader."COL Document Status"::Open then
            exit;

        if ServiceHeader."COL Document Status" = ServiceHeader."COL Document Status"::"Pending Approval" then
            Error(ServiceWorkflowLabels.GetApprovalProcessErr());

        Reopen(ServiceHeader);
    end;

    /// <summary>
    /// Check if service header is pending approval
    /// </summary>
    /// <param name="ServiceHeader"></param>
    /// <returns></returns>
    procedure CheckServiceHeaderPendingApproval(var ServiceHeader: Record "Service Header"): Boolean
    var
        ServiceApprovalMgt: Codeunit "COL Service Approval Mgt.";
    begin
        if ServiceHeader."COL Document Status" <> ServiceHeader."COL Document Status"::Open then
            exit;

        if ServiceApprovalMgt.IsServiceApprovalsWorkflowEnabled(ServiceHeader) then
            Error(ServiceWorkflowLabels.GetApprovalProcessNotCompletedErr()); // The pending approval check is performed in the approval process. In this place it's only important to check if the workflow is enabled.
    end;

    /// <summary>
    /// Release service document
    /// </summary>
    /// <param name="ServiceHeader"></param>
    procedure Release(var ServiceHeader: Record "Service Header")
    begin
        ServiceHeader.Validate("COL Document Status", Enum::"COL Service Document Status"::Released);
        ServiceHeader.Modify(true);
    end;

    /// <summary>
    /// Reopen service document
    /// </summary>
    /// <param name="ServiceHeader"></param>
    procedure Reopen(var ServiceHeader: Record "Service Header")
    begin
        ServiceHeader.Validate("COL Document Status", Enum::"COL Service Document Status"::Open);
        ServiceHeader.Modify(true);
    end;

    procedure CheckPriority(var ServiceHeader: Record "Service Header")
    var
        ExportPermitErr: Label 'Service document cannot be processed because field %1 is blank', Comment = '%1 = field caption';
    begin
        if ServiceHeader."Document Type" in [ServiceHeader."Document Type"::"Credit Memo", ServiceHeader."Document Type"::Quote] then
            exit;

        if ServiceHeader."COL Export Classification Code" in [enum::"COL Item Export Classification"::"Military Product", enum::"COL Item Export Classification"::"Dual Use", enum::"COL Item Export Classification"::Unknown] then
            if ServiceHeader."COL Export Permit No." = '' then
                Error(ExportPermitErr, ServiceHeader.FieldCaption("COL Export Permit No."));
    end;
}