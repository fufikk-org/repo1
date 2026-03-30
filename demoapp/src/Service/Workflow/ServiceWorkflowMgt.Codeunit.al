namespace Weibel.System.Automation;

using Microsoft.Service.Document;
using Weibel.Service.Document.Release;
using System.Automation;
using Weibel.Service.Document;
using Microsoft.Utilities;

codeunit 70105 "COL Service Workflow Mgt."
{
    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        ReleaseServiceDocument: Codeunit "COL Release Service Document";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"COL Service Approval Mgt.", OnSendServiceDocumentForApproval, '', false, false)]
    local procedure "COL Service Approval Mgt._OnSendServiceDocumentForApproval"(var ServiceHeader: Record "Service Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendServiceDocumentForApprovalCode(), ServiceHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"COL Service Approval Mgt.", OnCancelServiceDocumentApprovalRequest, '', false, false)]
    local procedure "COL Service Approval Mgt._OnCancelServiceDocumentApprovalRequest"(var ServiceHeader: Record "Service Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelServiceDocumentForApprovalCode(), ServiceHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", OnAddWorkflowEventsToLibrary, '', false, false)]
    local procedure "Workflow Event Handling_OnAddWorkflowEventsToLibrary"()
    var
        ApprovalRequestedDescLbl: Label 'Approval of a Service Document is requested.';
        CancelRequestedDescLbl: Label 'An approval request for Service Document is cancelled.';
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendServiceDocumentForApprovalCode(), Database::"Service Header",
            ApprovalRequestedDescLbl, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelServiceDocumentForApprovalCode(), Database::"Service Header",
            CancelRequestedDescLbl, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", OnAddWorkflowEventPredecessorsToLibrary, '', false, false)]
    local procedure "Workflow Event Handling_OnAddWorkflowEventPredecessorsToLibrary"(EventFunctionName: Code[128])
    begin
        case EventFunctionName of
            RunWorkflowOnCancelServiceDocumentForApprovalCode():
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelServiceDocumentForApprovalCode(),
                    RunWorkflowOnSendServiceDocumentForApprovalCode());
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode():
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode(),
                    RunWorkflowOnSendServiceDocumentForApprovalCode());
            WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode():
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode(),
                    RunWorkflowOnSendServiceDocumentForApprovalCode());
            WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode():
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode(),
                    RunWorkflowOnSendServiceDocumentForApprovalCode());
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnAddWorkflowResponsePredecessorsToLibrary, '', false, false)]
    local procedure "Workflow Response Handling_OnAddWorkflowResponsePredecessorsToLibrary"(ResponseFunctionName: Code[128])
    begin
        case ResponseFunctionName of
            WorkflowResponseHandling.SendApprovalRequestForApprovalCode():
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode(),
                    RunWorkflowOnSendServiceDocumentForApprovalCode());
            WorkflowResponseHandling.SetStatusToPendingApprovalCode():
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode(),
                    RunWorkflowOnSendServiceDocumentForApprovalCode());
            WorkflowResponseHandling.CancelAllApprovalRequestsCode():
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode(),
                    RunWorkflowOnCancelServiceDocumentForApprovalCode());
            WorkflowResponseHandling.OpenDocumentCode():
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode(),
                    RunWorkflowOnCancelServiceDocumentForApprovalCode());
            WorkflowResponseHandling.CreateApprovalRequestsCode():
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode(),
                    RunWorkflowOnSendServiceDocumentForApprovalCode());
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnPopulateApprovalEntryArgument, '', false, false)]
    local procedure "Approvals Mgmt._OnPopulateApprovalEntryArgument"(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        ServiceHeader: Record "Service Header";
    begin
        if RecRef.Number = Database::"Service Header" then begin
            RecRef.SetTable(ServiceHeader);
            ApprovalEntryArgument."Document No." := ServiceHeader."No.";
            ApprovalEntryArgument."Document Type" := ServiceHeader."Document Type";
            ApprovalEntryArgument."Table ID" := Database::"Service Header";
            ApprovalEntryArgument."Currency Code" := ServiceHeader."Currency Code";
            ApprovalEntryArgument."Salespers./Purch. Code" := ServiceHeader."Salesperson Code";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnSetStatusToPendingApproval, '', false, false)]
    local procedure "Approvals Mgmt._OnSetStatusToPendingApproval"(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        ServiceHeader: Record "Service Header";
    begin
        if GetServiceHeader(RecRef, ServiceHeader) then begin
            ServiceHeader.Validate("COL Document Status", Enum::"COL Service Document Status"::"Pending Approval");
            ServiceHeader.Modify(true);
            Variant := ServiceHeader;
            IsHandled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnApproveApprovalRequest, '', false, false)]
    local procedure "Approvals Mgmt._OnApproveApprovalRequest"(var ApprovalEntry: Record "Approval Entry")
    var
        ServiceHeader: Record "Service Header";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if GetServiceHeader(ApprovalEntry, ServiceHeader) then
            if not ApprovalsMgmt.HasOpenOrPendingApprovalEntries(ApprovalEntry."Record ID to Approve") then
                ReleaseServiceDocument.Release(ServiceHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnRejectApprovalRequest, '', false, false)]
    local procedure "Approvals Mgmt._OnRejectApprovalRequest"(var ApprovalEntry: Record "Approval Entry")
    var
        ServiceHeader: Record "Service Header";
    begin
        if GetServiceHeader(ApprovalEntry, ServiceHeader) then
            ReleaseServiceDocument.CheckAndReopen(ServiceHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnOpenDocument, '', false, false)]
    local procedure "Workflow Response Handling_OnOpenDocument"(RecRef: RecordRef; var Handled: Boolean)
    var
        ServiceHeader: Record "Service Header";
    begin
        if GetServiceHeader(RecRef, ServiceHeader) then begin
            ReleaseServiceDocument.Reopen(ServiceHeader);
            Handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", OnReleaseDocument, '', false, false)]
    local procedure "Workflow Response Handling_OnReleaseDocument"(RecRef: RecordRef; var Handled: Boolean)
    var
        ServiceHeader: Record "Service Header";
    begin
        if GetServiceHeader(RecRef, ServiceHeader) then begin
            ReleaseServiceDocument.CheckAndRelease(ServiceHeader);
            Handled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", OnConditionalCardPageIDNotFound, '', false, false)]
    local procedure "Page Management_OnConditionalCardPageIDNotFound"(RecordRef: RecordRef; var CardPageID: Integer)
    var
        ServiceHeader: Record "Service Header";
    begin
        if GetServiceHeader(RecordRef, ServiceHeader) then
            case ServiceHeader."Document Type" of
                Enum::"Service Document Type"::Invoice:
                    CardPageID := Page::"Service Invoice";
                Enum::"Service Document Type"::Quote:
                    CardPageID := Page::"Service Quote";
                Enum::"Service Document Type"::Order:
                    CardPageID := Page::"Service Order";
                Enum::"Service Document Type"::"Credit Memo":
                    CardPageID := Page::"Service Credit Memo";
            end;
    end;

    local procedure GetServiceHeader(var RecordRef: RecordRef; var ServiceHeader: Record "Service Header"): Boolean
    begin
        if RecordRef.Number = Database::"Service Header" then begin
            RecordRef.SetTable(ServiceHeader);
            exit(true);
        end;
        exit(false);
    end;

    local procedure GetServiceHeader(var ApprovalEntry: Record "Approval Entry"; var ServiceHeader: Record "Service Header"): Boolean
    var
        RecRef: RecordRef;
    begin
        RecRef.Get(ApprovalEntry."Record ID to Approve");
        exit(GetServiceHeader(RecRef, ServiceHeader));
    end;

    procedure RunWorkflowOnSendServiceDocumentForApprovalCode(): Code[128]
    var
        ApprovalCodeLbl: Label 'RUNWORKFLOWONSENDSERVICEDOCUMENTFORAPPROVAL', Locked = true;
    begin
        exit(ApprovalCodeLbl);
    end;

    procedure RunWorkflowOnCancelServiceDocumentForApprovalCode(): Code[128]
    var
        ApprovalCodeLbl: Label 'RUNWORKFLOWONCANCELSERVICEDOCUMENTFORAPPROVAL', Locked = true;
    begin
        exit(ApprovalCodeLbl);
    end;
}