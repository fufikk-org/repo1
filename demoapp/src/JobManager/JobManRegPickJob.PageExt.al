namespace Weibel.JobManager;

pageextension 70228 "COL JobManRegPickJob" extends JobManRegPickJob
{
    layout
    {
        addlast(Group)
        {
            field("COL FogBugz/Jira No."; Rec."COL FogBugz/Jira No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("COL ColIsBlocked"; Rec.COLIsBlocked())
            {
                Editable = false;
                ApplicationArea = All;
                Caption = 'Is Blocked';
                ToolTip = 'Indicates whether the job is blocked.';
            }
        }
    }
}
