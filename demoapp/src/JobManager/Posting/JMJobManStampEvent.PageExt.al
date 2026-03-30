pageextension 70263 "COL JM JobManStampEvent" extends JobManStampEvent
{
    actions
    {
        addafter(PostEventOnlyJournal)
        {
            action("COL JM CreateJournalLines")
            {
                ApplicationArea = All;
                Caption = 'Weibel Manual Post (journal only)';
                ToolTip = 'Create journal lines for the selected records in error status.';
                Image = OpenJournal;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    LocalJobManStampEvent, LocalJobManStampEvent2, LocalJobManStampEvent3 : Record JobManStampEvent;
                    TempJobManStampEvent: Record JobManStampEvent temporary;
                    JobManNavPost: Codeunit JobManNavPost;
                    Events: Codeunit "COL JM Events";
                    OverrideJournalName: Code[10];
                    EnsureConsistencyTxt: Label 'The Journal will now open. It must be posted to ensure consistency!', Comment = 'HINT: {T130-Q1022-P26171} - {C5631-Q1008-P26171}';
                    ConfirmJnlQst: Label 'Do you want to create journal lines for following entries (%1): %2?', Comment = '%1 = Count, %2 = Filters';
                    Window: Dialog;
                    Counter: Integer;
                    ProgressTxt: Label 'Lines: #1#', Comment = '#1# = Counter';
                begin
                    CurrPage.SetSelectionFilter(LocalJobManStampEvent);
                    LocalJobManStampEvent.FindFirst();
                    LocalJobManStampEvent.SetFilter(EventStatus, '<>%1', LocalJobManStampEvent.EventStatus::OK);
                    LocalJobManStampEvent.SetRange(EventType, LocalJobManStampEvent.EventType);
                    if not Confirm(ConfirmJnlQst, false, LocalJobManStampEvent.Count(), LocalJobManStampEvent.GetFilters()) then
                        exit;

                    LocalJobManStampEvent.FindFirst();

                    LocalJobManStampEvent2 := LocalJobManStampEvent;

                    OverrideJournalName := JobManNavPost.PickJournalName(LocalJobManStampEvent2);
                    if OverrideJournalName = '' then
                        exit;

                    TempJobManStampEvent.Reset();
                    TempJobManStampEvent.DeleteAll();
                    if LocalJobManStampEvent.FindSet() then
                        repeat
                            TempJobManStampEvent := LocalJobManStampEvent;
                            TempJobManStampEvent.Insert();
                        until LocalJobManStampEvent.Next() = 0;

                    UnbindSubscription(Events);
                    BindSubscription(Events);
                    Window.Open(ProgressTxt);
                    if TempJobManStampEvent.FindSet() then
                        repeat
                            Counter += 1;
                            Window.Update(1, Counter);
                            LocalJobManStampEvent3.Get(TempJobManStampEvent.LineSequence);
                            JobManNavPost.RunEvent(LocalJobManStampEvent3, true, OverrideJournalName);
                        until TempJobManStampEvent.Next() = 0;
                    UnbindSubscription(Events);
                    Window.Close();

                    Message(EnsureConsistencyTxt);
                    JobManNavPost.OpenJournalPage(LocalJobManStampEvent2, OverrideJournalName);
                end;
            }
            action("COL JM COLPostEvent")
            {
                ApplicationArea = All;
                Caption = 'Weibel Manual Post';
                Enabled = AllowPosting2;
                Image = Action;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'The line are posted in NAV using Journals.', Comment = '{AUTO}Page JobManStampEvent - ActionControl ToolTip (FOUND IN PAGE-HELP) for PostEvent';

                trigger OnAction()
                var
                    LocalJobManStampEvent: Record JobManStampEvent;
                    ModifyJobManStampEvent: Record JobManStampEvent;
                    BatchPosting: Codeunit "COL JM BatchPosting";
                begin
                    CurrPage.SetSelectionFilter(LocalJobManStampEvent);
                    if LocalJobManStampEvent.FindSet(true) then
                        repeat
                            if LocalJobManStampEvent.EventStatus <> ModifyJobManStampEvent.EventStatus::OK then begin // 01.37.1002
                                ModifyJobManStampEvent.Get(LocalJobManStampEvent.LineSequence);
                                Commit();
                                if BatchPosting.Run(ModifyJobManStampEvent) then;

                            end;
                        until LocalJobManStampEvent.Next() = 0;
                end;
            }
        }

    }

    trigger OnAfterGetRecord()
    begin
        AllowPosting2 := (Rec.EventStatus <> Rec.EventStatus::OK);
    end;

    var
        AllowPosting2: Boolean;
}