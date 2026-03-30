namespace Weibel.Purchases.Document;

using Microsoft.Purchases.Document;
using Weibel.Common;

pageextension 70186 "COL Purchase Order" extends "Purchase Order"
{
    layout
    {
        addlast(factboxes)
        {
            part(COLSKUReplenishmentFB; "COL SKU Replenishment FactBox")
            {
                ApplicationArea = Planning;
                Provider = PurchLines;
                SubPageLink = "Item No." = field("No."), "Variant Code" = field("Variant Code"), "Location Code" = field("Location Code");
                Visible = false;
            }
        }
        addlast(General)
        {
            field("COL No. Printed"; Rec."No. Printed")
            {
                ApplicationArea = All;
                ToolTip = 'Number of times the document has been printed.';
            }
            group(COLPOReminder)
            {
                Caption = 'PO Reminders';
                field("COL Missing Conf. Remi.Sent"; Rec."COL Missing Conf. Remi.Sent")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        ReminderMgt: Codeunit "COL Purch. Reminder Mgt.";
                    begin
                        ReminderMgt.OpenLookUpMails(Rec, Enum::"COL Email Type"::"Purch. Missing Conf. Reminder");
                    end;
                }
                field("COL Missing Conf. - Date"; Rec."COL Missing Conf. - Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("COL Overdue Delivery Remi.Sent"; Rec."COL Overdue Delivery Remi.Sent")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        ReminderMgt: Codeunit "COL Purch. Reminder Mgt.";
                    begin
                        ReminderMgt.OpenLookUpMails(Rec, Enum::"COL Email Type"::"Purch. Overdue Delivery Reminder");
                    end;
                }
                field("COL Overdue Delivery - Date"; Rec."COL Overdue Delivery - Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        addafter(SendCustom)
        {
            action("COL Send Reminder")
            {
                ApplicationArea = All;
                Caption = 'Send PO Reminder';
                Ellipsis = true;
                Image = SendEmailPDF;
                ToolTip = 'Send PO Reminder to Vendor.';

                trigger OnAction()
                var
                    PurchReminderMgt: Codeunit "COL Purch. Reminder Mgt.";
                begin
                    PurchReminderMgt.SentDocument(Rec);
                end;
            }
        }

        // addlast("F&unctions")
        // {
        //     action("COL Test Sent")
        //     {
        //         ApplicationArea = All;
        //         Caption = 'Test Print';
        //         Ellipsis = true;
        //         Image = SendEmailPDF;
        //         ToolTip = 'Test Print.';

        //         trigger OnAction()
        //         var
        //             PurchReminderMgt: Codeunit "COL Purch. Reminder Mgt.";
        //         begin
        //             PurchReminderMgt.GetPDfFromLasernet(Rec);
        //         end;
        //     }
        // }

        addafter(SendCustom_Promoted)
        {
            actionref("COL Send Reminder_Promoted"; "COL Send Reminder") { }
        }
    }
}
