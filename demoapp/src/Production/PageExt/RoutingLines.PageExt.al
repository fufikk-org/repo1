namespace Weibel.Manufacturing.Routing;

using Microsoft.Manufacturing.Routing;

pageextension 70229 "COL Routing Lines" extends "Routing Lines"
{
    layout
    {
        addafter("Operation No.")
        {
            field("COL First Operation"; Rec."COL First Operation")
            {
                ApplicationArea = All;
                Caption = 'First Operation';
                ToolTip = 'Specifies if this is the first operation.';
            }
        }
    }
}