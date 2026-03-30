namespace Weibel.Kardex;
using Weibel.Kardex.Ws;

page 70241 "COL Kardex Msg. Header"
{
    ApplicationArea = All;
    Caption = 'Kardex Msg. Header';
    PageType = Card;
    SourceTable = "COL Kardex Msg. Header";
    UsageCategory = Administration;
    //ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Related Log Line"; Rec."Related Log Line")
                {
                    Editable = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
                }
                field("Kardex Type"; Rec."Kardex Type")
                {
                    Editable = false;
                }
                field(Processed; Rec.Processed)
                {
                    Editable = false;
                }
                field(Response; Rec.Response)
                {
                    Editable = false;
                }
                field(DelMsg; Rec."Delete Req. Message")
                {
                }
                field("Skip Handling"; Rec."Skip Handling")
                {
                    Editable = false;
                }
                field("Response Type"; Rec."Response Type")
                {
                    Editable = false;
                }
                field("Has Error"; Rec."Has Error")
                {
                }
                field("Error Description"; Rec."Error Description")
                {
                }
                group(Valsues)
                {
                    Caption = 'Message Values';

                    field("Order Number 1"; Rec."Order Number 1")
                    {
                        Editable = false;
                    }
                    field("Order Number 2"; Rec."Order Number 2")
                    {
                        Editable = false;
                    }
                    field("Order Number 3"; Rec."Order Number 3")
                    {
                        Editable = false;
                    }
                }


            }

            part(KardexMsgLines; "COL Kardex Msg. Line")
            {
                Caption = 'Kardex Message Lines';
                SubPageLink = "Entry No." = field("Entry No."),
                              "Related Log Line" = field("Related Log Line");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(HandleMessage)
            {
                ApplicationArea = All;
                Caption = 'Handle Message';
                Image = Print;
                ToolTip = 'Handle out the Kardex message.';

                trigger OnAction()
                var
                    KardexMgt: Codeunit "COL Kardex Response";
                begin
                    KardexMgt.HandleIncomeMessage(Rec);
                end;
            }
            action(RawMessage)
            {
                ApplicationArea = All;
                Caption = 'Print Raw Message';
                Image = Print;
                ToolTip = 'Prints out the raw Kardex XML message.';

                trigger OnAction()
                var
                    rawXML: Text;
                begin
                    Rec.LoadRawMessage(rawXML);
                    Message(rawXML);
                end;
            }
            action(SentRawMessage)
            {
                ApplicationArea = All;
                Caption = 'Sent Raw Message';
                Image = Print;
                ToolTip = 'Send out the raw Kardex XML message to WS.';
                Visible = false;

                trigger OnAction()
                var
                    KardexMgt: Codeunit "COL Kardex Mgt.";
                begin
                    KardexMgt.SendLog(Rec);
                end;
            }
            action(GenerateRawMessage)
            {
                ApplicationArea = All;
                Caption = 'Generate Raw Pic Message';
                Image = Print;
                ToolTip = 'Send out the raw Kardex XML message to WS.';
                Visible = false;

                trigger OnAction()
                var
                    KardexMgt: Codeunit "COL Kardex Mgt.";
                begin
                    KardexMgt.GeneratePickMessage(Rec);
                end;
            }

        }
    }
}
