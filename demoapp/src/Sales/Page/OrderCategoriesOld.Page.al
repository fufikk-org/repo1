namespace Weibel.Foundation.OrderCategoryOld;

page 70235 "COL Order Categories (Old)"
{
    ApplicationArea = All;
    Caption = 'Order Categories (Old)';
    PageType = List;
    SourceTable = "COL Order Category (Old)";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ShowMandatory = true;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
}
