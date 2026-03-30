namespace Weibel.Common;
page 70126 "COL Fields Selected"
{
    ApplicationArea = All;
    Caption = 'Template Field Mandatory';
    PageType = List;
    SourceTable = "COL Field Selected";
    UsageCategory = None;
    InsertAllowed = false;
    ModifyAllowed = true;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Selected; Rec.Selected)
                {
                    ToolTip = 'Specifies if field is allow to edit after sent to HQ.';
                }
                field("Field Name"; Rec."Field Caption")
                {
                    ToolTip = 'Specifies the value of the Field Name field.';
                }
                field("Field Value"; Rec."Field Value")
                {
                    ToolTip = 'Specifies the value of the Field Value field.';
                    Visible = false;
                }
            }
        }
    }
}
