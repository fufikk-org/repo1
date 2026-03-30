namespace Weibel.Common;

using Weibel.Common;

page 70134 "COL Weibel Warranties"
{
    ApplicationArea = All;
    Caption = 'Weibel Warranties';
    PageType = List;
    SourceTable = "COL Weibel Warranties";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Warranty Code"; Rec."Warranty Code")
                {
                }
                field("Warranty Description"; Rec."Warranty Description")
                {
                }
            }
        }
    }
}
