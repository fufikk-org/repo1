namespace Weibel.Kardex;

page 70242 "COL Kardex Msg. Headers"
{
    ApplicationArea = All;
    Caption = 'Kardex Msg. Headers';
    PageType = List;
    SourceTable = "COL Kardex Msg. Header";
    SourceTableView = sorting("Related Log Line");
    UsageCategory = Administration;
    Editable = false;
    CardPageId = "COL Kardex Msg. Header";
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Related Log Line"; Rec."Related Log Line")
                {
                }
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Kardex Type"; Rec."Kardex Type")
                {
                }
                field(Processed; Rec.Processed)
                {
                }
                field(Response; Rec.Response)
                {
                }
                field(DelMsg; Rec."Delete Req. Message")
                {
                }
                field("Skip Handling"; Rec."Skip Handling")
                {
                }
                field("Response Type"; Rec."Response Type")
                {
                }
                field("Order Number 1"; Rec."Order Number 1")
                {
                }
                field("Order Number 2"; Rec."Order Number 2")
                {
                }
                field("Order Number 3"; Rec."Order Number 3")
                {
                }
                field("Has Error"; Rec."Has Error")
                {
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetRange(Processed, false);
    end;
}
