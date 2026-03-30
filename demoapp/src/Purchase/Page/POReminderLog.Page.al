namespace Weibel.Purchases.Document;

using Weibel.Common;
using System.Email;

page 70256 "COL PO Reminder Log"
{
    Caption = 'PO Reminder Log';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "COL PO Reminder Log";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field("Email Type"; Rec."Email Type")
                {
                    ApplicationArea = All;
                }
                field("Send Date"; Rec."Send Date")
                {
                    ApplicationArea = All;
                }
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(OpenSentEmail)
            {
                ApplicationArea = All;
                Caption = 'Open Sent Email';
                Image = Email;
                ToolTip = 'Open the related sent email record.';

                trigger OnAction()
                var
                    SentEmail: Record "Sent Email";
                begin
                    if Rec."Sent Email ID" <> 0 then begin
                        SentEmail.SetRange(Id, Rec."Sent Email ID");
                        if SentEmail.FindFirst() then
                            Page.Run(Page::"Sent Emails", SentEmail);
                    end;
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                actionref(OpenSentEmail_Promoted; OpenSentEmail)
                {
                }
            }
        }
    }
}