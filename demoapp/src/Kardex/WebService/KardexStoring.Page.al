namespace Weibel.Kardex.Ws;

page 70233 "COL Kardex Storing"
{
    ApplicationArea = All;
    Caption = 'Kardex Storing';
    PageType = Card;
    SourceTable = "COL Kardex In Data";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Some Data"; Rec."Some Data")
                {
                    ToolTip = 'Specifies the value of the Some Data field.', Comment = '%';
                }
            }
        }
    }
}
