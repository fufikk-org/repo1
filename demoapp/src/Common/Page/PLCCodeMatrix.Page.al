namespace Weibel.Common;

using Weibel.Common;

page 70137 "COL PLC Code Matrix"
{
    ApplicationArea = All;
    Caption = 'PLC Code Matrix';
    PageType = List;
    SourceTable = "COL PLC Code Matrix";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Status; Rec.Status)
                {
                }
                field("Blocked for Planning"; Rec."Blocked for Planning")
                {
                }
                field("Blocked for Production"; Rec."Blocked for Production")
                {
                }
                field("Blocked for Projects"; Rec."Blocked for Projects")
                {
                }
                field("Blocked for Purchase"; Rec."Blocked for Purchase")
                {
                }
                field("Blocked for Sales"; Rec."Blocked for Sales")
                {
                }
                field("Blocked for Service"; Rec."Blocked for Service")
                {
                }
            }
        }
    }
}
