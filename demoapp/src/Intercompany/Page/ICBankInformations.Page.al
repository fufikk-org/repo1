namespace Weibel.Intercompany;

using Weibel.Intercompany;

page 70249 "COL I/C Bank Informations"
{
    ApplicationArea = All;
    Caption = 'I/C Bank information';
    PageType = List;
    SourceTable = "COL I/C Bank Information";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("IC Company"; Rec."IC Company")
                {
                }
                field("I/C Bank Name"; Rec."I/C Bank Name")
                {
                }
                field("I/C SWIFT"; Rec."I/C SWIFT")
                {
                }
                field("I/C IBAN"; Rec."I/C IBAN")
                {
                }
                field("I/C ACH"; Rec."I/C ACH")
                {
                }
            }
        }
    }
}
