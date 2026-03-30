namespace Weibel.Security.User;

using System.Security.User;

tableextension 70167 "COL User Setup" extends "User Setup"
{
    fields
    {
        field(70100; "COL Allow Skip Kardex File"; Boolean)
        {
            Caption = 'Allow Skip Kardex File';
            ToolTip = 'Specifies whether to allow skipping the Kardex file.';
            DataClassification = CustomerContent;
        }
        field(70101; "COL Edit Empl. Week Timesheet"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Empl. Ch. Time Sh.(Week)';
            ToolTip = 'Specifies whether the user is allowed to edit employee on timesheets for the week.';
        }
    }
}
