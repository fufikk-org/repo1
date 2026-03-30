namespace Weibel.Purchases.Document;

using Microsoft.Purchases.Document;
using System.Email;


tableextension 70144 "COL Purchase Header" extends "Purchase Header"
{

    fields
    {
        modify("Purchaser Code")
        {
            trigger OnAfterValidate()
            var
                PurchaseLine: Record "Purchase Line";
            begin
                PurchaseLine.SetRange("Document Type", Rec."Document Type");
                PurchaseLine.SetRange("Document No.", Rec."No.");
                if not PurchaseLine.IsEmpty() then
                    PurchaseLine.ModifyAll("COL Purchaser Code", Rec."Purchaser Code");
            end;
        }
        field(70100; "COL Missing Conf. Remi.Sent"; Integer)
        {
            Caption = 'Missing Confirmation Reminder Sent';
            Tooltip = 'Number of Missing Confirmation Reminder emails sent';
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = count("COL PO Reminder Log" where("Email Type" = filter("Purch. Missing Conf. Reminder" | "Missing Conf. and Overdue Delivery"), "Order No." = field("No.")));
        }
        field(70101; "COL Overdue Delivery Remi.Sent"; Integer)
        {
            Caption = 'Overdue Delivery Reminder Sent';
            Tooltip = 'Number of Overdue Delivery Reminder emails sent';
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = count("COL PO Reminder Log" where("Email Type" = filter("Purch. Overdue Delivery Reminder" | "Missing Conf. and Overdue Delivery"), "Order No." = field("No.")));
        }
#pragma warning disable AA0232
        field(70102; "COL Missing Conf. - Date"; DateTime)
        {
            Caption = 'Missing Confirmation Last Date';
            Tooltip = 'Last date the Missing Confirmation Reminder was sent';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Max("COL PO Reminder Log"."Send Date" where("Email Type" = filter("Purch. Missing Conf. Reminder" | "Missing Conf. and Overdue Delivery"), "Order No." = field("No.")));
        }
#pragma warning restore AA0232
        field(70103; "COL Overdue Delivery - Date"; DateTime)
        {
            Caption = 'Overdue Delivery - Last Date';
            Tooltip = 'Last date the Overdue Delivery Reminder was sent';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Max("COL PO Reminder Log"."Send Date" where("Email Type" = filter("Purch. Overdue Delivery Reminder" | "Missing Conf. and Overdue Delivery"), "Order No." = field("No.")));
        }
        field(70104; "COL Reminder Problem Exist"; Boolean)
        {
            Caption = 'Reminder Exist';
            ToolTip = 'Specifies if a reminder exists for the purchase line.';
            DataClassification = CustomerContent;
        }
        field(70105; "COL Previously Released"; Boolean)
        {
            Caption = 'Previously Released';
            ToolTip = 'Specifies if the purchase order was previously released.';
            Editable = false;
            ObsoleteReason = 'No longer used';
            ObsoleteState = Removed;
            DataClassification = CustomerContent;
        }
        field(70106; "COL Can Skip Re-Approval"; Boolean)
        {
            Caption = 'Can Skip Re-Approval';
            ToolTip = 'Specifies if the purchase order can skip re-approval.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70107; "COL Finance Approval Blocked"; Boolean)
        {
            Caption = 'Finance Approval Blocked';
            ToolTip = 'Specifies if the finance approval is blocked.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Rec."COL Finance Approval Blocked" <> xRec."COL Finance Approval Blocked" then
                    Rec.TestField(Status, Rec.Status::Open);

                if not Rec."COL Finance Approval Blocked" then begin
                    Rec."COL Finance Approval Resolved" := false;
                    Rec."COL Fin. Appr. Resolved By" := '';
                    Rec."COL Fin. Appr. Resolved Time" := 0DT;
                end;
            end;
        }
        field(70108; "COL Finance Approval Resolved"; Boolean)
        {
            Caption = 'Finance Approval Resolved';
            ToolTip = 'Specifies if the finance approval has been resolved.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Rec.TestField("COL Finance Approval Blocked", true);

                if Rec."COL Finance Approval Resolved" and not xRec."COL Finance Approval Resolved" then begin
                    Rec."COL Fin. Appr. Resolved By" := CopyStr(UserId(), 1, MaxStrLen(Rec."COL Fin. Appr. Resolved By"));
                    Rec."COL Fin. Appr. Resolved Time" := CurrentDateTime();
                end;
                if not Rec."COL Finance Approval Resolved" then begin
                    Rec."COL Fin. Appr. Resolved By" := '';
                    Rec."COL Fin. Appr. Resolved Time" := 0DT;
                end;
            end;
        }
        field(70109; "COL Fin. Appr. Resolved By"; Code[50])
        {
            Caption = 'Finance Approval Resolved By';
            ToolTip = 'Specifies who resolved the finance approval.';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(70110; "COL Fin. Appr. Resolved Time"; DateTime)
        {
            Caption = 'Finance Approval Resolved Time';
            ToolTip = 'Specifies when the finance approval was resolved.';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }
}
