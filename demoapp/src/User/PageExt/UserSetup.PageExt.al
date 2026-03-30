namespace Weibel.Security.User;

using System.Security.User;

pageextension 70258 "COL User Setup" extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field("COL Allow Skip Kardex File"; Rec."COL Allow Skip Kardex File")
            {
                ApplicationArea = All;
            }
            field("COL Edit Empl. Week Timesheet"; Rec."COL Edit Empl. Week Timesheet")
            {
                ApplicationArea = All;
            }
        }
    }
}
