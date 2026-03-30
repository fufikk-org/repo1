namespace Weibel.Finance;

using Microsoft.Purchases.Document;

pageextension 70277 "COL Purchase Invoice" extends "Purchase Invoice"
{
    layout
    {
        addlast(General)
        {
            group(COLFinanceApproval)
            {
                Caption = 'Finance Approval';
                field("COL Finance Approval Blocked"; Rec."COL Finance Approval Blocked")
                {
                    Caption = 'Blocked';
                    ApplicationArea = All;
                }
                field("COL Finance Approval Resolved"; Rec."COL Finance Approval Resolved")
                {
                    Caption = 'Resolved';
                    ApplicationArea = All;
                }
                field("COL Fin. Appr. Resolved By"; Rec."COL Fin. Appr. Resolved By")
                {
                    Caption = 'Resolved By';
                    ApplicationArea = All;
                }
                field("COL Fin. Appr. Resolved Time"; Rec."COL Fin. Appr. Resolved Time")
                {
                    Caption = 'Resolved Time';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        FinanceApprovalNotification: Notification;
    begin
        if Rec."COL Finance Approval Blocked" and not Rec."COL Finance Approval Resolved"
            and (Rec.Status = Rec.Status::"Pending Approval") then begin
            FinanceApprovalNotification.Message := FinanceApprovalBlockedMsg;
            FinanceApprovalNotification.Scope := NotificationScope::LocalScope;
            FinanceApprovalNotification.Send();
        end;
    end;

    var
        FinanceApprovalBlockedMsg: Label 'This invoice is blocked for approval until corresponding documents are updated including line details within Invoice, Once updated please set the "Finance Approval Resolved" field to TRUE.';
}
