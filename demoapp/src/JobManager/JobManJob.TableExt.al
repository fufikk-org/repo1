namespace Weibel.JobManager;

using Microsoft.Projects.Project.Job;
using Microsoft.Manufacturing.Document;

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
