#if not HIDE_LOWLEVEL_SKU
namespace Weibel.Manufacturing.ProductionBOM;

page 70224 "COL SKU Low Level Detail"
{
    ApplicationArea = All;
    Caption = 'SKU Low Level Detail';
    PageType = List;
    SourceTable = "COL SKU Low Level Detail";
    UsageCategory = None;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                IndentationColumn = Rec."Low Level Code";
                IndentationControls = "Path Information";

                field("Item No."; Rec."Item No.")
                {
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Visible = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    Visible = false;
                }
                field("Low Level Code"; Rec."Low Level Code")
                {
                }
                field("Path Information"; Rec."Path Information")
                {
                }
            }
        }
    }
}
#endif