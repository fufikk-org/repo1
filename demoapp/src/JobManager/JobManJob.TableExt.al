namespace Weibel.JobManager;

using Microsoft.Projects.Project.Job;

tableextension 70153 "COL JobManJob" extends JobManJob
{
    fields
    {
        field(70100; "COL FogBugz/Jira No."; Text[20])
        {
            Caption = 'FogBugz/Jira No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Job."COL FogBugz/Jira No." where("No." = field(RefNo)));
            ToolTip = 'Specifies the FogBugz or Jira number associated with the job.';
        }
    }
}
