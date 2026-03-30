namespace Weibel.Packaging;

page 70114 "COL Package Types"
{
    ApplicationArea = All;
    Caption = 'Package Types';
    PageType = List;
    SourceTable = "COL Package Type";
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
                field(Length; Rec.Length)
                {
                }
                field(Width; Rec.Width)
                {
                }
                field(Height; Rec.Height)
                {
                }
            }
        }
    }
}
