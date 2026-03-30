namespace Weibel.Foundation.SalesOrderCategory;

page 70144 "COL Sales Order Categories"
{
    ApplicationArea = All;
    Caption = 'Sales Order Categories';
    PageType = List;
    SourceTable = "COL Sales Order Category";
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
