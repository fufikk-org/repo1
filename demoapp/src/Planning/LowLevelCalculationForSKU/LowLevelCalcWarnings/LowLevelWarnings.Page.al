#if not HIDE_LOWLEVEL_SKU
namespace Weibel.Manufacturing.ProductionBOM;

page 70226 "COL Low Level Warnings"
{
    ApplicationArea = All;
    Caption = 'Low Level Warnings';
    PageType = List;
    SourceTable = "COL Low Level Warning";
    UsageCategory = None;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Visible = false;
                }
                field("Warning Code"; Rec."Warning Code")
                {
                }
                field("Warning Information"; Rec."Warning Information")
                {
                }
            }
        }
    }
}
#endif