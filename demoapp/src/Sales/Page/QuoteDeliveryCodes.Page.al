namespace Weibel.Foundation.QuoteDeliveryCodes;

page 70138 "COL Quote Delivery Codes"
{
    ApplicationArea = All;
    Caption = 'Quote Delivery Codes';
    PageType = List;
    SourceTable = "COL Quote Delivery Code";
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
