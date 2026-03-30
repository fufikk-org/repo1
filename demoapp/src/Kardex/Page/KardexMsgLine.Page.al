namespace Weibel.Kardex;

page 70243 "COL Kardex Msg. Line"
{
    ApplicationArea = All;
    Caption = 'Kardex Msg. Line';
    PageType = ListPart;
    SourceTable = "COL Kardex Msg. Line";
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item ID"; Rec."Item ID")
                {
                }
                field("Item Variant"; Rec."Item Variant")
                {
                }
                field("Item Text"; Rec."Item Text")
                {
                }
                field("Jrn. Line No."; Rec."Jrn. Line No.")
                {
                }
                field("Position Number"; Rec."Position Number")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("New Quantity"; Rec."New Quantity")
                {
                }
                field("Serial Number Mode"; Rec."Serial Number Mode")
                {
                }
                field("Serial Number"; Rec."Serial Number")
                {
                }
                field("User Id"; Rec."User Id")
                {
                }
            }
        }
    }
}
