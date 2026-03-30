namespace Weibel.Inventory.BOM;

page 70246 "COL BOM Structure Warnings"
{
    ApplicationArea = All;
    Caption = 'BOM Structure Warnings';
    PageType = List;
    SourceTable = "COL BOM Structure Warning";
    UsageCategory = None;
    Editable = false;
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Warning Description"; Rec."Warning Description")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Show")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Show';
                Image = View;
                ToolTip = 'View the log details.';
                Enabled = Rec."Table Id" <> 0;

                trigger OnAction()
                begin
                    Rec.ShowWarning();
                end;
            }
        }
    }
}