namespace Weibel.Service.Document;

using Weibel.System.Automation;
using Microsoft.Service.Document;
using Weibel.Service.Document.Release;
using System.Automation;
using Weibel.Common;

pageextension 70115 "COL Service Credit Memo" extends "Service Credit Memo"
{
    layout
    {
        addlast(General)
        {
            field("COL Document Status"; Rec."COL Document Status")
            {
                ApplicationArea = All;
                StyleExpr = StatusStyleTxt;
                Editable = false;
            }
        }
        addafter("Shipping")
        {
            group("COL End User Details")
            {
                Caption = 'End User Details';
                group("COL Details")
                {
                    ShowCaption = false;
                    group("COL User Type")
                    {
                        ShowCaption = false;
                        field("COL EndUserOptions"; Rec."COL End User Type")
                        {
                            ApplicationArea = Basic, Suite;
                        }
                        group("COL CustomerEndUser")
                        {
                            ShowCaption = false;
                            Visible = Rec."COL End User Type" = Rec."COL End User Type"::"Existing End User";

                            field("COL Existing End User No."; Rec."COL Existing End User No.")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                            field("COL CF_1"; Rec."COL End User Name")
                            {
                                ApplicationArea = Basic, Suite;
                                Editable = false;
                                Caption = 'Customer End User Name';
                            }
                            field("COL CF_2"; Rec."COL End User Address")
                            {
                                ApplicationArea = Basic, Suite;
                                Editable = false;
                                Caption = 'Customer End User Address';
                            }
                            field("COL CF_3"; Rec."COL End User Address 2")
                            {
                                ApplicationArea = Basic, Suite;
                                Editable = false;
                                Caption = 'Customer End User Address 2';
                            }
                            field("COL CF_4"; Rec."COL End User City")
                            {
                                ApplicationArea = Basic, Suite;
                                Editable = false;
                                Caption = 'Customer End User City';
                            }
                            field("COL CF_5"; Rec."COL End User County")
                            {
                                ApplicationArea = Basic, Suite;
                                Editable = false;
                                Caption = 'Customer End User County';
                            }
                            field("COL CF_6"; Rec."COL End User Post Code")
                            {
                                ApplicationArea = Basic, Suite;
                                Editable = false;
                                Caption = 'Customer End User Post Code';
                            }
                            field("COL CF_7"; Rec."COL End User Country/Region")
                            {
                                ApplicationArea = Basic, Suite;
                                Editable = false;
                                Caption = 'Customer End User Country';
                            }
                            field("COL CF_8"; Rec."COL End User E-Mail")
                            {
                                ApplicationArea = Basic, Suite;
                                Editable = false;
                                Caption = 'Customer End User Email';
                            }
                        }
                        group("COL NewEndUser")
                        {
                            ShowCaption = false;
                            Visible = Rec."COL End User Type" = Rec."COL End User Type"::"New End User";

                            field("COL NCF_1"; Rec."COL End User Name")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                            field("COL NCF_2"; Rec."COL End User Address")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                            field("COL NCF_3"; Rec."COL End User Address 2")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                            field("COL NCF_4"; Rec."COL End User City")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                            field("COL NCF_5"; Rec."COL End User County")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                            field("COL NCF_6"; Rec."COL End User Post Code")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                            field("COL NCF_7"; Rec."COL End User Country/Region")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                            field("COL NCF_8"; Rec."COL End User E-Mail")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                        }
                    }
                }

            }
        }
        addlast(factboxes)
        {
            part("COL PendingApprovalFactBox"; "Pending Approval FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = const(Database::"Service Header"),
                              "Document Type" = field("Document Type"),
                              "Document No." = field("No."),
                              Status = const(Open);
                Visible = OpenApprovalEntriesExistForCurrUser;
            }
            part("COL ApprovalFactBox"; "Approval FactBox")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part("COL WorkflowStatus"; "Workflow Status FactBox")
            {
                ApplicationArea = All;
                Editable = false;
                Enabled = false;
                ShowFilter = false;
                Visible = ShowWorkflowStatus;
            }
        }
    }
    actions
    {
        addlast("F&unctions")
        {
            action("COL CreateEndUser")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Create End User Customer';
                Image = NewCustomer;
                Enabled = Rec."COL End User Type" = Rec."COL End User Type"::"New End User";
                ToolTip = 'Create new end user from page details';

                trigger OnAction()
                var
                    CommonCustMgt: Codeunit "COL Common Cust. Mgt";
                begin
                    CommonCustMgt.CreateEndUserCust(Rec);
                end;
            }
        }
        addfirst(processing)
        {
            group("COL Release/Reopen")
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action("COL Release")
                {
                    ApplicationArea = Suite;
                    Caption = 'Release';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Release the document to the next stage of processing. You must reopen the document before you can make changes to it.';

                    trigger OnAction()
                    var
                        ReleaseServiceDocument: Codeunit "COL Release Service Document";
                    begin
                        ReleaseServiceDocument.CheckAndRelease(Rec);
                    end;
                }
                action("COL Reopen")
                {
                    ApplicationArea = Suite;
                    Caption = 'Reopen';
                    Enabled = Rec."COL Document Status" <> Rec."COL Document Status"::Open;
                    Image = ReOpen;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed.';

                    trigger OnAction()
                    var
                        ReleaseServiceDocument: Codeunit "COL Release Service Document";
                    begin
                        ReleaseServiceDocument.CheckAndReopen(Rec);
                    end;
                }
            }
        }
        addlast("&Cr. Memo")
        {
            group("COL Approval")
            {
                Caption = 'Approval';
                action("COL Approve")
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action("COL Reject")
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    ToolTip = 'Reject the approval request.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action("COL Delegate")
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action("COL Comment")
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            action("COL Approvals")
            {
                AccessByPermission = TableData "Approval Entry" = R;
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
        addlast("F&unctions")
        {
            group("COL Request Approval")
            {
                Caption = 'Request Approval';
                Image = Approval;
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
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        ServiceApprovalMgt.OnCancelServiceDocumentApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }
            }
        }
        addlast(Promoted)
        {
            group("COL Approval_Promoted")
            {
                Caption = 'Approval';
                actionref("COL Approve_Promoted"; "COL Approve") { }
                actionref("COL Reject_Promoted"; "COL Reject") { }
                actionref("COL Delegate_Promoted"; "COL Delegate") { }
                actionref("COL Comment_Promoted"; "COL Comment") { }
            }
            group("COL Request Approval_Promoted")
            {
                Caption = 'Request Approval';
                actionref("COL SendApprovalRequest_Promoted"; "COL SendApprovalRequest") { }
                actionref("COL CancelApprovalRequest_Promoted"; "COL CancelApprovalRequest") { }
            }
        }
        addlast(Category_Process)
        {
            group("COL Release/Reopen_Promoted")
            {
                Caption = 'Release', Comment = 'Generated from the PromotedActionCategories property index 4.';
                ShowAs = SplitButton;

                actionref("COL Release_Promoted"; "COL Release")
                {
                }
                actionref("COL Reopen_Promoted"; "COL Reopen")
                {
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage."COL ApprovalFactBox".Page.UpdateApprovalEntriesFromSourceRecord(Rec.RecordId);
        ShowWorkflowStatus := CurrPage."COL WorkflowStatus".Page.SetFilterOnWorkflowRecord(Rec.RecordId);
        StatusStyleTxt := Rec.COLGetStatusStyleText();
        SetControlAppearance();
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
        CurrPage.Editable := Rec."COL Document Status" in [Enum::"COL Service Document Status"::Open];
    end;

    var
        ShowWorkflowStatus: Boolean;
        CanCancelApprovalForRecord, CanCancelApprovalForFlow : Boolean;
        CanRequestApprovalForFlow: Boolean;
        OpenApprovalEntriesExist, OpenApprovalEntriesExistForCurrUser : Boolean;
        StatusStyleTxt: Text;
}