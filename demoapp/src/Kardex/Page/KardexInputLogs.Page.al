namespace Weibel.Kardex;

page 70244 "COL Kardex Input Logs"
{
    ApplicationArea = All;
    Caption = 'Kardex Input Logs';
    PageType = List;
    SourceTable = "COL Kardex Input Log";
    UsageCategory = History;

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
                field("Log Date-Time"; Rec."Log Date-Time")
                {
                    ToolTip = 'Specifies the value of the Log Date-Time field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
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
        }
    }
}
