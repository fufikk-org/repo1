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
            CalcFormula = count("Sent Email" where("COL Email Type" = filter("Purch. Missing Conf. Reminder" | "Missing Conf. and Overdue Delivery"), "COL Related Document" = field("No.")));
        }
        field(70101; "COL Overdue Delivery Remi.Sent"; Integer)
        {
            Caption = 'Overdue Delivery Reminder Sent';
            Tooltip = 'Number of Overdue Delivery Reminder emails sent';
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = count("Sent Email" where("COL Email Type" = filter("Purch. Overdue Delivery Reminder" | "Missing Conf. and Overdue Delivery"), "COL Related Document" = field("No.")));
        }
#pragma warning disable AA0232
        field(70102; "COL Missing Conf. - Date"; DateTime)
        {
            Caption = 'Missing Confirmation Last Date';
            Tooltip = 'Last date the Missing Confirmation Reminder was sent';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Max("Sent Email"."COL Send Date" where("COL Email Type" = filter("Purch. Missing Conf. Reminder" | "Missing Conf. and Overdue Delivery"), "COL Related Document" = field("No.")));
        }
#pragma warning restore AA0232
        field(70103; "COL Overdue Delivery - Date"; DateTime)
        {
            Caption = 'Overdue Delivery - Last Date';
            Tooltip = 'Last date the Overdue Delivery Reminder was sent';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Max("Sent Email"."COL Send Date" where("COL Email Type" = filter("Purch. Overdue Delivery Reminder" | "Missing Conf. and Overdue Delivery"), "COL Related Document" = field("No.")));
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
    }
}
