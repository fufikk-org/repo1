namespace Weibel.Service.Document;

page 70102 "COL Service Order States"
{
    ApplicationArea = All;
    Caption = 'Service Order States';
    AdditionalSearchTerms = 'Order States';
    PageType = List;
    SourceTable = "COL Service Header State";
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
