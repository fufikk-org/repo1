namespace Weibel.Foundation.SalesResponsibilityGroup;

page 70253 "COL Sales Resp. Groups"
{
    ApplicationArea = All;
    Caption = 'Sales Responsibility Groups';
    PageType = List;
    SourceTable = "COL Sales Resp. Group";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the code for the sales responsibility group.';
                    ShowMandatory = true;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description of the sales responsibility group.';
                }
            }
        }
    }
}