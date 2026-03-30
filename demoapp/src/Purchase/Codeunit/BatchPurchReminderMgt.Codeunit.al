codeunit 70170 "COL Batch Purch. Reminder Mgt."
{
    TableNo = "Purchase Header";
    trigger OnRun()
    begin
        PurchReminderMgt.SentDocument(Rec);
    end;


    var
        PurchReminderMgt: Codeunit "COL Purch. Reminder Mgt.";
        MailingJobCategoryTok: Label 'COL sending reminders via email';
        MailingJobCategoryCodeTok: Label 'COL_REMIND', Locked = true;

    procedure RunBatch(var ReportInstances: Dictionary of [Code[20], List of [Code[20]]]; Schedule: Boolean)
    var
        PurchaseHeader: Record "Purchase Header";
        ErrorCount, SkippedCount : Integer;
        VendorNo: Code[20];
        PoNos: List of [Code[20]];
        SummaryLbl: Label '%1 - Documents processed.\%2 - Documents skipped.\%3 - Errors.', Comment = '%1 - Number of Documents, %2 - Number of documents skipped, %3, Number of errors.';
        BackgroundSummaryLbl: Label '%1 - Documents scheduled.', Comment = '%1 - Number of Documents.';
    begin
        foreach VendorNo in ReportInstances.Keys do begin
            Clear(PurchReminderMgt);
            PurchReminderMgt.SetHideSummary(true);
            PurchReminderMgt.SetHideDialog(Schedule);

            ReportInstances.Get(VendorNo, PoNos);
            PurchaseHeader.SetRange("Buy-from Vendor No.", VendorNo);
            PurchaseHeader.SetFilter("No.", ListToFilter(PoNos));
            PurchaseHeader.SetFilter("Location Filter", ListToFilter(PoNos));
            PurchaseHeader.FindFirst();
            PurchaseHeader.SetRange("No.", PurchaseHeader."No.");

            if Schedule then
                EnqueueMailingJob(PurchaseHeader)
            else
                if this.Run(PurchaseHeader) then
                    SkippedCount += PurchReminderMgt.GetSkipped() ? 1 : 0
                else
                    ErrorCount += 1;
            Commit();
        end;

        if Schedule then
            Message(BackgroundSummaryLbl, ReportInstances.Count)
        else
            Message(SummaryLbl, ReportInstances.Count, SkippedCount, ErrorCount);
    end;

    procedure EnqueueMailingJob(var PurchaseHeader: Record "Purchase Header")
    var
        JobQueueEntry: Record "Job Queue Entry";
        Description: Text;
    begin
        JobQueueEntry.Init();
        JobQueueEntry."Object Type to Run" := JobQueueEntry."Object Type to Run"::Codeunit;
        JobQueueEntry."Object ID to Run" := CODEUNIT::"COL Purch. Reminder Mgt.";
        JobQueueEntry."Job Queue Category Code" := GetMailingJobCategory();
        JobQueueEntry."Maximum No. of Attempts to Run" := 0; // So that the job runs only once        
        JobQueueEntry."Parameter String" := CopyStr(StrsubstNo('%1:%2', PurchaseHeader.GetFilter("Buy-from Vendor No."), PurchaseHeader.GetFilter("Location Filter")), 1, MaxStrLen(JobQueueEntry."Parameter String"));
        JobQueueEntry.Description := CopyStr(Description, 1, MaxStrLen(JobQueueEntry.Description));
        Codeunit.Run(Codeunit::"Job Queue - Enqueue", JobQueueEntry);
    end;

    procedure GetMailingJobCategory(): Code[10]
    var
        JobQueueCategory: Record "Job Queue Category";
        MailingJobCategoryCode: Code[10];
    begin
        MailingJobCategoryCode := GetMailingJobCategoryCode();
        if not JobQueueCategory.Get(MailingJobCategoryCode) then begin
            JobQueueCategory.Init();
            JobQueueCategory.Code := MailingJobCategoryCode;
            JobQueueCategory.Description := CopyStr(MailingJobCategoryTok, 1, MaxStrLen(JobQueueCategory.Description));
            JobQueueCategory.Insert();
        end;

        exit(JobQueueCategory.Code);
    end;

    local procedure GetMailingJobCategoryCode(): Code[10]
    begin
        exit(CopyStr(MailingJobCategoryCodeTok, 1, 10));
    end;

    internal procedure ListToFilter(PoNos: List of [Code[20]]) Result: Text
    var
        PoNo: Code[20];
    begin
        foreach PoNo in PoNos do
            Result += ((Result <> '') ? Format('|') : '') + PoNo;
    end;

}