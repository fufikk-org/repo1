namespace Weibel.Service.History;

using Microsoft.Service.History;
using System.Automation;

pageextension 70114 "COL Posted Service Cr. Memo" extends "Posted Service Credit Memo"
{
    actions
    {
        addlast("&Cr. Memo")
        {
            action("COL Approvals")
            {
                AccessByPermission = TableData "Posted Approval Entry" = R;
                ApplicationArea = Suite;
                Caption = 'Approvals';
                Image = Approvals;
                ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.ShowPostedApprovalEntries(Rec.RecordId);
                end;
            }
        }

        addlast("Category_Credit Memo")
        {
            actionref("COL Approvals_Promoted"; "COL Approvals") { }
        }
    }
}