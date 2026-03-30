namespace Weibel.System.Automation;

codeunit 70110 "COL Service Workflow Labels"
{
    SingleInstance = true;

    var
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';
        NothingToApproveErr: Label 'There is nothing to approve.';
        ApprovalProcessNotCompletedErr: Label 'This document can only be released when the approval process is complete.';
        ApprovalProcessErr: Label 'The approval process must be cancelled or completed to reopen this document.';

    procedure GetNoWorkflowEnabledErr(): Text
    begin
        exit(NoWorkflowEnabledErr);
    end;

    procedure GetNothingToApproveErr(): Text
    begin
        exit(NothingToApproveErr);
    end;

    procedure GetApprovalProcessNotCompletedErr(): Text
    begin
        exit(ApprovalProcessNotCompletedErr);
    end;

    procedure GetApprovalProcessErr(): Text
    begin
        exit(ApprovalProcessErr);
    end;
}