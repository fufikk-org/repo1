namespace Weibel.Inventory.Planning;


page 70145 "COL Planning Error Log Archive"
{
    ApplicationArea = All;
    Caption = 'Planning Error Log Archive';
    PageType = List;
    SourceTable = "COL Planning Error Log Arch.";
    UsageCategory = History;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Worksheet Template Name"; Rec."Worksheet Template Name")
                {
                    ToolTip = 'Specifies the value of the Worksheet Template Name field.', Comment = '%';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ToolTip = 'Specifies the value of the Journal Batch Name field.', Comment = '%';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.', Comment = '%';
                }
                field("Error Description"; Rec."Error Description")
                {
                    ToolTip = 'Specifies the value of the Error Description field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
            }
        }
    }
}
