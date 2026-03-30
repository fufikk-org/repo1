namespace Weibel.Utilities;

using System.Threading;

codeunit 70197 "COL Job Queue Mgt."
{
    procedure CreateJobQueue(ObjectType: Option; ObjectNo: Integer)
    var
        JobQueueEntry: Record "Job Queue Entry";
    begin
        JobQueueEntry.SetRange("Object Type to Run", ObjectType);
        JobQueueEntry.SetRange("Object ID to Run", ObjectNo);
        if not JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Init();
            JobQueueEntry.Validate("Object Type to Run", ObjectType);
            JobQueueEntry.Validate("Object ID to Run", ObjectNo);
            JobQueueEntry.Insert(true);
            JobQueueEntry.SetStatus(JobQueueEntry.Status::"On Hold");
        end;
        ShowJobQueueEntryCard(JobQueueEntry);
    end;

    procedure CreateJobQueue(ObjectType: Option; ObjectNo: Integer; Description: Text)
    var
        JobQueueEntry: Record "Job Queue Entry";
    begin
        JobQueueEntry.SetRange("Object Type to Run", ObjectType);
        JobQueueEntry.SetRange("Object ID to Run", ObjectNo);
        if not JobQueueEntry.FindFirst() then begin
            JobQueueEntry.Init();
            JobQueueEntry.Validate("Object Type to Run", ObjectType);
            JobQueueEntry.Validate("Object ID to Run", ObjectNo);
            JobQueueEntry.Description := CopyStr(Description, 1, MaxStrLen(JobQueueEntry.Description));
            JobQueueEntry.Insert(true);
            JobQueueEntry.SetStatus(JobQueueEntry.Status::"On Hold");
        end;
        ShowJobQueueEntryCard(JobQueueEntry);
    end;

    procedure ShowJobQueueEntryCard(JobQueueEntry: Record "Job Queue Entry")
    var
        JobQueueEntryCard: Page "Job Queue Entry Card";
    begin
        JobQueueEntryCard.SetRecord(JobQueueEntry);
        JobQueueEntryCard.Run();
    end;
}
