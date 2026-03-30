namespace Weibel.Foundation.FinanceCategory;

page 70143 "COL Sales Finance Categories"
{
    ApplicationArea = All;
    Caption = 'Sales Finance Categories';
    PageType = List;
    SourceTable = "COL Sales Finance Category";
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
