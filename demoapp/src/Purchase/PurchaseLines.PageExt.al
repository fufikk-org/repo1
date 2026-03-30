namespace Weibel.Purchase.Document;

using Microsoft.Purchases.Document;
using Weibel.Purchases.Document;

pageextension 70100 "COL Purchase Lines" extends "Purchase Lines"
{
    layout
    {
        modify("Variant Code")
        {
            Visible = true;
        }
        addlast(Control1)
        {
            field("COL Planned Receipt Date"; Rec."Planned Receipt Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date when the item is planned to arrive in inventory. Forward calculation: planned receipt date = order date + vendor lead time (per the vendor calendar and rounded to the next working day in first the vendor calendar and then the location calendar). If no vendor calendar exists, then: planned receipt date = order date + vendor lead time (per the location calendar). Backward calculation: order date = planned receipt date - vendor lead time (per the vendor calendar and rounded to the previous working day in first the vendor calendar and then the location calendar). If no vendor calendar exists, then: order date = planned receipt date - vendor lead time (per the location calendar).';
            }
            field("COL Purchaser Code"; Rec."COL Purchaser Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Expected Receipt Date")
        {
            field("COL Promised Receipt Date"; Rec."Promised Receipt Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the date that the vendor has promised to deliver the order.';
            }
        }
    }

    actions
    {
        addafter("Item &Tracking Lines")
        {
            action("COL Send Reminder")
            {
                ApplicationArea = All;
                Caption = 'Send PO Reminders';
                Ellipsis = true;
                Image = SendToMultiple;
                ToolTip = 'Send PO Reminders to Vendor.';

                trigger OnAction()
                begin
                    SendReminders(false);
                end;
            }
            action("COL Batch Send Reminder")
            {
                ApplicationArea = All;
                Caption = 'Schedule PO Reminders';
                Ellipsis = true;
                Image = ExecuteBatch;
                ToolTip = 'Schedule sending PO Reminders to Vendor.';

                trigger OnAction()
                begin
                    SendReminders(true);
                end;
            }
        }
        addafter("Item &Tracking Lines_Promoted")
        {
            actionref("COL Send Reminder_Promoted"; "COL Send Reminder") { }
            actionref("COL Batch Send Reminder_Promoted"; "COL Batch Send Reminder") { }
        }
    }

    local procedure SendReminders(Schedule: Boolean)
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        PurchReminderMgt: Codeunit "COL Purch. Reminder Mgt.";
        BatchPurchReminderMgt: Codeunit "COL Batch Purch. Reminder Mgt.";
        ReportInstances: Dictionary of [Code[20], List of [Code[20]]];
        PoNos: List of [Code[20]];
        VendorNo: Code[20];
    begin
        PurchaseLine.SetLoadFields("Document Type", "Document No.", "Buy-from Vendor No.");
        CurrPage.SetSelectionFilter(PurchaseLine);
        PurchaseLine.SetFilter("Buy-from Vendor No.", '>%1', '');
        if PurchaseLine.FindSet() then
            repeat
                Clear(PoNos);
                if not ReportInstances.Get(PurchaseLine."Buy-from Vendor No.", PoNos) then begin
                    ReportInstances.Add(PurchaseLine."Buy-from Vendor No.", PoNos);
                    PoNos.Add(PurchaseLine."Document No.");
                end else
                    if not PoNos.Contains(PurchaseLine."Document No.") then
                        PoNos.Add(PurchaseLine."Document No.");
            until PurchaseLine.Next() = 0;

        case true of
            Schedule, ReportInstances.Count > 1:
                BatchPurchReminderMgt.RunBatch(ReportInstances, Schedule);
            else begin
                ReportInstances.Keys.Get(1, VendorNo);
                ReportInstances.Get(VendorNo, PoNos);
                PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
                PurchaseHeader.SetFilter("Location Filter", BatchPurchReminderMgt.ListToFilter(PoNos));
                PurchaseHeader.SetRange("Buy-from Vendor No.", VendorNo);
                PurchaseHeader.SetFilter("No.", BatchPurchReminderMgt.ListToFilter(PoNos));
                PurchaseHeader.FindFirst();
                PurchaseHeader.SetRecFilter();
                PurchReminderMgt.SentDocument(PurchaseHeader);
            end;
        end;
    end;
}