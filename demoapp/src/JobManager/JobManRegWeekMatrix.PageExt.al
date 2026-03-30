namespace Weibel.JobManager;

pageextension 70227 "COL JobManRegWeekMatrix" extends JobManRegWeekMatrix
{
    layout
    {
        addafter(Description)
        {
            field("COL FogBugz/Jira No."; Rec."COL FogBugz/Jira No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
}
