namespace Weibel.JobManager;

using Microsoft.Projects.Project.Job;

tableextension 70154 "COL JobManTmpWeekJournal" extends JobManTmpWeekJournal
{
    fields
    {
        field(70100; "COL FogBugz/Jira No."; Text[20])
        {
            Caption = 'FogBugz/Jira No.';
            Editable = false;
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the FogBugz or Jira number associated with the job.';
        }

        modify(JobNo)
        {
            trigger OnAfterValidate()
            var
                JobManJob: Record JobManJob;
                Job: Record Job;
            begin
                JobManJob.SetLoadFields(JobType);
                Job.SetLoadFields("COL FogBugz/Jira No.");
                if Rec.JobNo <> '' then
                    if JobManJob.Get(Rec.JobNo) then
                        if JobManJob.JobType = JobManJob.JobType::JobTaskPlanLine then
                            if Job.Get(RefNo) then
                                Rec."COL FogBugz/Jira No." := Job."COL FogBugz/Jira No.";
            end;
        }
    }
}
