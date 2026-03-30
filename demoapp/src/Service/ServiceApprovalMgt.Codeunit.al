namespace Weibel.System.Automation;

using Microsoft.Service.Document;
using System.Automation;

codeunit 70108 "COL Service Approval Mgt."
{
    var
        WorkflowManagement: Codeunit "Workflow Management";
        ServiceWorkflowLabels: Codeunit "COL Service Workflow Labels";

    /// <summary>
    /// Check if service approval is possible
    /// </summary>
    /// <param name="ServiceHeader"></param>
    /// <returns></returns>
    procedure CheckServiceApprovalPossible(var ServiceHeader: Record "Service Header"): Boolean
    var
        IsHandled: Boolean;
        Result: Boolean;
    begin
        IsHandled := false;
        OnBeforeCheckServiceApprovalPossible(ServiceHeader, Result, IsHandled);
        if IsHandled then
            exit(Result);

        if not IsServiceApprovalsWorkflowEnabled(ServiceHeader) then
            Error(ServiceWorkflowLabels.GetNoWorkflowEnabledErr());

        if not ServiceHeader.ServLineExists() then
            Error(ServiceWorkflowLabels.GetNothingToApproveErr());

        OnAfterCheckServiceApprovalPossible(ServiceHeader);

        exit(true);
    end;

    /// <summary>
    /// Check if service approval is possible
    /// </summary>
    /// <param name="ServiceHeader"></param>
    /// <returns></returns>
    procedure IsServiceApprovalsWorkflowEnabled(var ServiceHeader: Record "Service Header"): Boolean
    var
        ServiceWorkflowMgt: Codeunit "COL Service Workflow Mgt.";
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(ServiceHeader, ServiceWorkflowMgt.RunWorkflowOnSendServiceDocumentForApprovalCode()));
    end;

    /// <summary>
    /// Open approvals service
    /// </summary>
    /// <param name="ServiceHeader"></param>
    procedure OpenApprovalsService(ServiceHeader: Record "Service Header")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        ApprovalsMgmt.RunWorkflowEntriesPage(
            ServiceHeader.RecordId(), Database::"Service Header", ServiceHeader."Document Type", ServiceHeader."No.");
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendServiceDocumentForApproval(var ServiceHeader: Record "Service Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelServiceDocumentApprovalRequest(var ServiceHeader: Record "Service Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckServiceApprovalPossible(var ServiceHeader: Record "Service Header"; var Result: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCheckServiceApprovalPossible(var ServiceHeader: Record "Service Header")
    begin
    end;
}