namespace Weibel.Common;

page 70254 "COL Common Log Entries"
{
    ApplicationArea = All;
    Caption = 'Common Log Entries';
    PageType = List;
    SourceTable = "COL Common Log Entry";
    SourceTableView = sorting("Entry No.") order(Descending);
    UsageCategory = History;
    ModifyAllowed = false;
    DeleteAllowed = true;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Prod Order No."; Rec."Prod Order No.")
                {
                    ToolTip = 'Specifies the value of the Prod Order No. field.', Comment = '%';
                }
                field("Prod Order Line"; Rec."Prod Order Line")
                {
                    ToolTip = 'Specifies the value of the Prod Order Line field.', Comment = '%';
                }
                field("Operation Source"; Rec."Operation Source")
                {
                    ToolTip = 'Specifies the value of the Operation Source field.', Comment = '%';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ToolTip = 'Specifies the value of the Serial No. field.', Comment = '%';
                }
                field("Old Serial No."; Rec."Old Serial No.")
                {
                    ToolTip = 'Specifies the value of the Old Serial No. field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
                field("User Id"; Rec."User Id")
                {
                    ToolTip = 'Specifies the value of the User Id field.', Comment = '%';
                }
                field("Created At"; Rec."Created At")
                {
                    ToolTip = 'Specifies the value of the Created At field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RawMessage)
            {
                ApplicationArea = All;
                Caption = 'Print Callstack';
                Image = Print;
                ToolTip = 'Print the callstack stored in the log entry.';

                trigger OnAction()
                var
                    rawTxt: Text;
                begin
                    Rec.LoadRawMessage(rawTxt);
                    Message(rawTxt);
                end;
            }
        }
    }
}