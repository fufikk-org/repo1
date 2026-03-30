namespace Weibel.JobManager;

using Microsoft.Manufacturing.Document;

codeunit 70180 "COL Routing Status JobManager"
{
    procedure SetRouteStatus(var JobManStampEvent: Record JobManStampEvent)
    var
        JobManJob: Record JobManJob;
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
    begin
        if not (JobManStampEvent.RefType = JobManStampEvent.RefType::Production) then
            exit;

        if not (JobManStampEvent.JobType in [JobManStampEvent.JobType::ProdSetup, JobManStampEvent.JobType::ProdRun]) then
            exit;

        if not (JobManStampEvent.StampType = JobManStampEvent.StampType::Work) then
            exit;

        if not JobManJob.Get(JobManStampEvent.JobNo) then
            exit;

        if not ProdOrderRoutingLine.Get(ProdOrderRoutingLine.Status::Released, JobManStampEvent.RefNo, JobManJob.ProdRoutingReferenceNo, JobManJob.ProdRoutingNo, JobManJob.ProdOperationNo) then
            exit;

        case JobManStampEvent.ReportFinish of

            JobManStampEvent.ReportFinish::Pick:
                if (JobManStampEvent.EventType = JobManStampEvent.EventType::Stamp) and
                   (JobManStampEvent.EventStatus = JobManStampEvent.EventStatus::OK) and
                   (ProdOrderRoutingLine."Routing Status" <> ProdOrderRoutingLine."Routing Status"::"In Progress")
                then begin
                    ProdOrderRoutingLine."Routing Status" := ProdOrderRoutingLine."Routing Status"::"In Progress";
                    ProdOrderRoutingLine.COLUpdateRoutingStatusLogFields();
                    ProdOrderRoutingLine.Modify();
                end;

            JobManStampEvent.ReportFinish::Finish:
                if (JobManStampEvent.EventType = JobManStampEvent.EventType::OutputJournal) and
                   (JobManStampEvent.ReportFinish = JobManStampEvent.ReportFinish::Finish) and
                   (ProdOrderRoutingLine."Routing Status" <> ProdOrderRoutingLine."Routing Status"::Finished)
                then
                    if JobManStampEvent.JobType = JobManStampEvent.JobType::ProdRun then begin
                        ProdOrderRoutingLine."Routing Status" := ProdOrderRoutingLine."Routing Status"::Finished;
                        ProdOrderRoutingLine.COLUpdateRoutingStatusLogFields();
                        ProdOrderRoutingLine.Modify();

                        // ResetProdOrderRoutingLineAllocatedTime(ProdOrderRoutingLine);
                    end;
        end;
    end;
}