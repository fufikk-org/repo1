namespace Weibel.JobManager;

using Microsoft.Projects.Project.Job;
using Microsoft.Manufacturing.Document;

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

    procedure COLIsBlocked(): Boolean
    var
        Job: Record Job;
        ProductionOrder: Record "Production Order";
    begin
        case Rec.RefType of
            Rec.RefType::Job:
                begin
                    Job.SetLoadFields(Blocked);
                    if Job.Get(Rec.RefNo) then
                        exit(Job.Blocked <> Job.Blocked::" ")
                    else
                        exit(true);
                end;
            Rec.RefType::Production:
                begin
                    ProductionOrder.SetLoadFields(Status);
                    if ProductionOrder.Get(Rec.RefNo) then
                        exit(ProductionOrder.Status = ProductionOrder.Status::Finished)
                    else
                        exit(true);
                end;
        end;
        exit(false);
    end;
}
