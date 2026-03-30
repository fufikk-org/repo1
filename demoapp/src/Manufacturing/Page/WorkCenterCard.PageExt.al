namespace Weibel.Manufacturing.WorkCenter;

using Microsoft.Manufacturing.WorkCenter;

pageextension 70268 "COL Work Center Card" extends "Work Center Card"
{
    layout
    {
        addafter(Warehouse)
        {
            group("COL Routing Setup")
            {
                Caption = 'Routing Setup';
                field("COL Setup Time"; Rec."COL Setup Time")
                {
                    ApplicationArea = All;
                    Caption = 'Setup Time';
                    ToolTip = 'Specifies the setup time for the work center.';
                }
                field("COL Wait Time"; Rec."COL Wait Time")
                {
                    ApplicationArea = All;
                    Caption = 'Wait Time';
                    ToolTip = 'Specifies the wait time for the work center.';
                }
                field("COL Move Time"; Rec."COL Move Time")
                {
                    ApplicationArea = All;
                    Caption = 'Move Time';
                    ToolTip = 'Specifies the move time for the work center.';
                }
                field("COL Run Time"; Rec."COL Run Time")
                {
                    ApplicationArea = All;
                    Caption = 'Run Time';
                    ToolTip = 'Specifies the run time for the work center.';
                }
            }
        }
    }
}
