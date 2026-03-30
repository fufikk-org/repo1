namespace Weibel.Projects.Project.Job;

using Microsoft.Projects.Project.Job;

pageextension 70226 "COL Job List" extends "Job List"
{
    layout
    {
        addlast(Control1)
        {
            field("COL FogBugz/Jira No."; Rec."COL FogBugz/Jira No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
