namespace Weibel.Automation;

using System.Automation;
using Microsoft.Purchases.Document;
using Microsoft.Purchases.Setup;
using Microsoft.Sales.Document;

codeunit 70167 "COL Approval Management Events"
{
    Permissions = tabledata "Approval Entry" = rm;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeApproveApprovalRequests', '', true, true)]
    local procedure ApprovalMgmtOnApproveApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        ApprovalEntryToUpdate: Record "Approval Entry";
        PurchaseHeader: Record "Purchase Header";
        FinanceApprovalBlockedErr: Label 'This invoice cannot be approved because Finance Approval is blocked and not yet resolved.';
    begin
        ApprovalEntryToUpdate.Copy(ApprovalEntry);
        if not ApprovalEntryToUpdate.FindFirst() then
            exit;

        if ApprovalEntryToUpdate."Table ID" = Database::"Purchase Header" then
            if ApprovalEntryToUpdate."Document Type" = Enum::"Approval Document Type"::Invoice then
                if PurchaseHeader.Get(Enum::"Purchase Document Type"::Invoice, ApprovalEntryToUpdate."Document No.") then
                    if PurchaseHeader."COL Finance Approval Blocked" and not PurchaseHeader."COL Finance Approval Resolved" then
                        Error(FinanceApprovalBlockedErr);

        if ApprovalEntryToUpdate."Approval Type" <> ApprovalEntryToUpdate."Approval Type"::"Workflow User Group" then
            exit;

        if ApprovalEntryToUpdate."Sender ID" = ApprovalEntryToUpdate."Approver ID" then
            exit;

        this.CancelApprovalRequestForRecord(ApprovalEntryToUpdate);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeCheckPurchaseApprovalPossible', '', true, true)]
    local procedure RunOnBeforeCheckPurchaseApprovalPossible(var PurchaseHeader: Record "Purchase Header"; var Result: Boolean; var IsHandled: Boolean)
    begin
        PurchaseHeader."COL Can Skip Re-Approval" := false;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeIsPurchaseApprovalsWorkflowEnabled', '', true, true)]
    local procedure RunOnBeforeIsPurchaseApprovalsWorkflowEnabled(var PurchaseHeader: Record "Purchase Header"; var Result: Boolean; var IsHandled: Boolean);
    var
        ApprovalEntry: Record "Approval Entry";
        PurchaseSetup: Record "Purchases & Payables Setup";
    begin
        if PurchaseHeader."Document Type" <> Enum::"Sales Document Type"::Order then
            exit;

        if PurchaseHeader.Status <> Enum::"Purchase Document Status"::Open then
            exit;

        if not PurchaseHeader."COL Can Skip Re-Approval" then
            exit
        else
            PurchaseHeader."COL Can Skip Re-Approval" := false;

        PurchaseSetup.SetLoadFields("COL Skip PO Re-Approval");
        PurchaseSetup.Get();
        if not PurchaseSetup."COL Skip PO Re-Approval" then
            exit;

        ApprovalEntry.SetLoadFields("Table ID", "Document Type", "Document No.", Status);
        ApprovalEntry.SetCurrentKey("Entry No.");
        ApprovalEntry.SetRange("Table ID", Database::"Purchase Header");
        ApprovalEntry.SetRange("Document Type", Enum::"Approval Document Type"::Order);
        ApprovalEntry.SetRange("Document No.", PurchaseHeader."No.");
        if ApprovalEntry.FindLast() then
            if ApprovalEntry.Status = Enum::"Approval Status"::Approved then begin
                Result := false;
                IsHandled := true;
            end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnBeforeCheckPurchaseHeaderPendingApproval', '', true, true)]
    local procedure RunOnBeforeCheckPurchaseHeaderPendingApproval(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
        if PurchaseHeader."Document Type" = Enum::"Purchase Document Type"::Order then
            PurchaseHeader."COL Can Skip Re-Approval" := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnBeforeReleasePurchaseDoc', '', true, true)]
    local procedure OnBeforeReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var SkipCheckReleaseRestrictions: Boolean; var IsHandled: Boolean; SkipWhseRequestOperations: Boolean)
    begin
        if PreviewMode then
            exit;
        if PurchaseHeader."Document Type" = Enum::"Purchase Document Type"::Order then
            PurchaseHeader."COL Can Skip Re-Approval" := true;
    end;

    local procedure CancelApprovalRequestForRecord(var FromApprovalEntry: record "Approval Entry")
    var
        ApprovalEntry: Record "Approval Entry";
        ApprovalEntryToUpdate: Record "Approval Entry";
    begin
        ApprovalEntry.SetCurrentKey("Table ID", "Document Type", "Document No.", "Sequence No.");
        ApprovalEntry.SetRange("Table ID", FromApprovalEntry."Table ID");
        ApprovalEntry.SetRange("Record ID to Approve", FromApprovalEntry."Record ID to Approve");
        ApprovalEntry.SetRange("Sequence No.", FromApprovalEntry."Sequence No.");
        ApprovalEntry.SetFilter("Approver ID", '<>%1', FromApprovalEntry."Approver ID");
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        ApprovalEntry.SetRange("Workflow Step Instance ID", FromApprovalEntry."Workflow Step Instance ID");
        if ApprovalEntry.FindSet() then
            repeat
                ApprovalEntryToUpdate := ApprovalEntry;
                ApprovalEntryToUpdate.Validate(Status, ApprovalEntryToUpdate.Status::Canceled);
                ApprovalEntryToUpdate.Modify(true);
            until ApprovalEntry.Next() = 0;
    end;
}
