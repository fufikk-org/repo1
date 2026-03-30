namespace Weibel.Intercompany;

page 70127 "COL Intercompany Transactions"
{
    ApplicationArea = All;
    Caption = 'Intercompany Transactions';
    PageType = List;
    SourceTable = "COL Intercompany Transactions";
    UsageCategory = History;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Transaction Document Type"; Rec."Transaction Document Type")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Posting Description"; Rec."Posting Description")
                {
                }
                field(Processed; Rec.Processed)
                {
                }
                field("Processed Date/Time"; Rec."Processed Date/Time")
                {
                }
                field("Sales GL Account No."; Rec."Sales GL Account No.")
                {
                }
                field("Purchase GL Account No."; Rec."Purchase GL Account No.")
                {
                }
                field("IC GL Account No."; Rec."IC GL Account No.")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field("Source Company"; Rec."Source Company")
                {
                }
                field("Destination Company"; Rec."Destination Company")
                {
                }
                field("Destination Customer No."; Rec."Destination Customer No.")
                {
                }
                field("Destination Customer Name"; Rec."Destination Customer Name")
                {
                }
                field("Last Error"; Rec."Last Error")
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("COL Post")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Post';
                Image = NewCustomer;
                PromotedCategory = Process;
                PromotedOnly = true;
                Promoted = true;
                ToolTip = 'Post Line';
                Visible = true;

                trigger OnAction()
                var
                    IntercompanyPost: Codeunit "COL Intercompany Post";
                begin
                    IntercompanyPost.SetPostEntryNo(Rec."Entry No.");
                    if not IntercompanyPost.Run() then begin
                        Rec."Last Error" := CopyStr(GetLastErrorText(), 1, MaxStrLen(Rec."Last Error"));
                        Rec.Modify(true);
                    end
                    else begin
                        Rec."Last Error" := '';
                        Rec.Processed := true;
                        Rec."Processed Date/Time" := CurrentDateTime;
                        Rec.Modify(true);
                    end;
                end;
            }
            action("COL Post2")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Post Batch';
                Image = NewCustomer;
                PromotedCategory = Process;
                PromotedOnly = true;
                Promoted = true;
                ToolTip = 'Post Line';
                Visible = false;

                trigger OnAction()
                var
                begin
                    TaskScheduler.CreateTask(Codeunit::"COL Intercompany Posting Job", 0, true, CompanyName());
                end;
            }
        }
    }
}
