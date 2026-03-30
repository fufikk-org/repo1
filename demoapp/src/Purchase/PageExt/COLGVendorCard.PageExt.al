pageextension 70249 "COL COLG Vendor Card" extends "Vendor Card"
{
    layout
    {
        addlast(General)
        {
            field("COL Statistics Group"; Rec."Statistics Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the statistics group for the vendor.';
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


}