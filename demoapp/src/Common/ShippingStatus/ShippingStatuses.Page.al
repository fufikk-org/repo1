namespace Weibel.Shipping;

page 70123 "COL Shipping Statuses"
{
    ApplicationArea = All;
    Caption = 'Shipping Statuses';
    PageType = List;
    SourceTable = "COL Shipping Status";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }
}
