codeunit 70158 "COL Batch Email Sent Sub."
{
    EventSubscriberInstance = Manual;

    var
        PoFilter: Text;

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", 'OnEnqueueMailingJobOnBeforeRunJobQueueEnqueue', '', false, false)]
    local procedure RunOnEnqueueMailingJobOnBeforeRunJobQueueEnqueue(RecordIdToProcess: RecordID; ParameterString: Text; Description: Text; var JobQueueEntry: Record "Job Queue Entry"; var IsHandled: Boolean)
    var
        DocumentMailing: Codeunit "Document-Mailing";
    begin
        DocumentMailing.Run(JobQueueEntry);
        IsHandled := true;
    end;

    internal procedure SetPPFilter(FromPoFilter: Text)
    begin
        PoFilter := FromPoFilter;
    end;

    [EventSubscriber(ObjectType::Report, Report::"COL PO Reminder", 'OnSetPoFilter', '', false, false)]
    local procedure OnSetPoFilter(var ToPoFilter: Text)
    begin
        ToPoFilter := PoFilter;
    end;


}