report 70107 "COL JM Batch Posting Report"
{
    UsageCategory = None;
    ApplicationArea = All;
    Caption = 'JM Batch Posting Report';
    ProcessingOnly = true;

    dataset
    {
        dataitem(JobManStampEvent; JobManStampEvent)
        {
            RequestFilterFields = JobNo, EmployeeNo, ProfileDate, EventStatus;
            trigger OnAfterGetRecord()
            var
                ModifyJobManStampEvent: Record JobManStampEvent;
                JMStampEventPostingLog: Record "COL JM Stamp Event Post. Log";
                BatchPosting: Codeunit "COL JM BatchPosting";
            begin
                if JobManStampEvent.EventStatus <> ModifyJobManStampEvent.EventStatus::OK then begin // 01.37.1002
                    ModifyJobManStampEvent.Get(JobManStampEvent.LineSequence);

                    JMStampEventPostingLog.DeleteByLineSequence(ModifyJobManStampEvent.LineSequence, ModifyJobManStampEvent.LineSequenceJournalLine);
                    Commit();
                    ClearLastError();
                    if not BatchPosting.Run(ModifyJobManStampEvent) then
                        JMStampEventPostingLog.LogError(ModifyJobManStampEvent, GetLastErrorText(), GetLastErrorCallStack());

                end;

            end;

            trigger OnPreDataItem()
            begin
                if not GuiAllowed then
                    BindSubscription(Events);
            end;

            trigger OnPostDataItem()
            begin
                if not GuiAllowed then
                    UnbindSubscription(Events);
            end;
        }

    }

    var
        Events: Codeunit "COL JM Events";
}