namespace Weibel.JobManager;

query 70202 "COL JM Stamp Error Log"
{
    Caption = 'JM Stamp Event Errors with Log';

    elements
    {
        dataitem(JobManStampEvent; JobManStampEvent)
        {
            DataItemTableFilter = EventStatus = const(Error);

            column(LineSequence; LineSequence)
            {
            }
            column(LineSeqJournalLine; LineSequenceJournalLine)
            {
            }
            column(EventTimestamp; EventTimestamp)
            {
            }
            column(EventType; EventType)
            {
            }
            column(EventStatus; EventStatus)
            {
            }
            column(EmployeeNo; EmployeeNo)
            {
            }
            column(JobNo; JobNo)
            {
            }
            column(ProfileDate; ProfileDate)
            {
            }
            column(PostingAttempts; PostingAttempts)
            {
            }

            dataitem(LogLatest; "COL JM Stamp Event Post. Log")
            {
                SqlJoinType = InnerJoin;
                DataItemLink = "Line Sequence" = JobManStampEvent.LineSequence, "Line Seq. Journal Line" = JobManStampEvent.LineSequenceJournalLine;

                column(LogEntryNo; "Entry No.")
                {
                }
                column(LogPostingDateTime; "Posting Date-Time")
                {
                }
                column(LogUserId; "User ID")
                {
                }
                column(LogErrorText; "Error Text")
                {
                }
            }
        }
    }
}
