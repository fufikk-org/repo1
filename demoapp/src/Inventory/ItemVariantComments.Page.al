namespace Weibel.Inventory.Item;
using Microsoft.Inventory.Item;
page 70265 "COL Item Variant Comments"
{
    ApplicationArea = All;
    Caption = 'Item Variant Comments';
    PageType = List;
    SourceTable = "COL Item Variant Comment";
    UsageCategory = None;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item number.';
                    Visible = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the variant code.';
                    Visible = false;
                }
                field("Date"; Rec.Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of the comment.';
                }
                field("Changed By"; Rec."Changed By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the user who added the comment.';
                }
                field("Field Name"; Rec."Field Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the field that was changed.';
                }
                field("New Value"; Rec."New Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the new value of the blocking field.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the comment text.';
                }
            }
        }
    }
}

