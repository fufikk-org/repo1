namespace Weibel.JobManager;

tableextension 70155 "COL JobManStampEvent" extends JobManStampEvent
{
    keys
    {
        key(COL_Key1; EventStatus, EventType)
        {
        }
    }

    trigger OnInsert()
    var
        RoutingStatusJobManager: Codeunit "COL Routing Status JobManager";
    begin
        RoutingStatusJobManager.SetRouteStatus(Rec);
    end;
}