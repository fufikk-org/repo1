namespace Weibel.Foundation.TermsAndConditions;

page 70119 "COL Terms and Conditions"
{
    ApplicationArea = All;
    Caption = 'Terms and Conditions';
    PageType = List;
    SourceTable = "COL Terms and Conditions";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ShowMandatory = true;
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }
}
