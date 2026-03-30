namespace Weibel.Service.Document;

using Microsoft.Service.Document;
using Weibel.System.Automation;
using System.Automation;

pageextension 70116 "COL Service Credit Memos" extends "Service Credit Memos"
{
    actions
    {
        addlast("&Cr. Memo")
        {
            action("COL Approvals")
            {
                ApplicationArea = Suite;
                Caption = 'Approvals';
                Image = Approvals;
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                trigger OnAction()
                var
                    ServiceApprovalMgt: Codeunit "COL Service Approval Mgt.";
                begin
                    ServiceApprovalMgt.OpenApprovalsService(Rec);
                end;
            }
        }
        addlast(processing)
        {
            group("COL Request Approval")
            {
                Caption = 'Request Approval';
                Image = "Action";
                action("COL SendApprovalRequest")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send Approval Request';
                    Enabled = not OpenApprovalEntriesExist and CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ServiceApprovalMgt: Codeunit "COL Service Approval Mgt.";
                    begin
                        if ServiceApprovalMgt.CheckServiceApprovalPossible(Rec) then
                            ServiceApprovalMgt.OnSendServiceDocumentForApproval(Rec);
                    end;
                }
                action("COL CancelApprovalRequest")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord or CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ServiceApprovalMgt: Codeunit "COL Service Approval Mgt.";
                        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
                    begin
                        ServiceApprovalMgt.OnCancelServiceDocumentApprovalRequest(Rec);
                        WorkflowWebhookManagement.FindAndCancel(Rec.RecordId);
                    end;
                }
            }
        }
        addlast(Promoted)
        {
            group("COL Request Approval_Promoted")
            {
                Caption = 'Request Approval';
                actionref("COL SendApprovalRequest_Promoted"; "COL SendApprovalRequest") { }
                actionref("COL CancelApprovalRequest_Promoted"; "COL CancelApprovalRequest") { }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance();
    end;

    var
        CanCancelApprovalForRecord, CanCancelApprovalForFlow : Boolean;
        CanRequestApprovalForFlow: Boolean;
        OpenApprovalEntriesExist, OpenApprovalEntriesExistForCurrUser : Boolean;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookManagement: Codeunit "Workflow Webhook Management";
    begin
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        WorkflowWebhookManagement.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;
}