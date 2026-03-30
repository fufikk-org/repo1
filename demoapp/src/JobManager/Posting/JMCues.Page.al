page 70269 "COL JM Cues"
{
    Caption = 'Job Manager';
    PageType = CardPart;
    RefreshOnActivate = true;
    ShowFilter = false;

    layout
    {
        area(content)
        {
            cuegroup(COLJobManager)
            {

                Caption = 'Job Manager';
                field(StampErrors; ErrorCount)
                {
                    ApplicationArea = All;
                    Caption = 'Stamp Posting Errors';
                    ToolTip = 'Specifies the number of stamp errors that have occurred.';

                    trigger OnDrillDown()
                    begin
                        ShowStampErrorLog();
                    end;
                }

            }
        }

    }
    actions
    {
        area(Processing)
        {
            action(RefreshStampErrors)
            {
                ApplicationArea = All;
                Caption = 'Refresh';
                Image = Refresh;
                ToolTip = 'Refreshes stamp error count and list drilldown data.';

                trigger OnAction()
                begin
                    CalcCount();
                    CurrPage.Update(false);
                end;
            }
        }
    }

    var
        ErrorCount: Integer;
        LastCalc: DateTime;

    trigger OnAfterGetCurrRecord()
    begin
        if LastCalc = 0DT then begin
            CalcCount();
            exit;
        end;

        if (CurrentDateTime() - LastCalc) > 5 * 60 * 1000 then
            CalcCount();
    end;

    local procedure CalcCount()
    var
        JMStampErrorLog: Query "COL JM Stamp Error Log";
    begin
        ErrorCount := 0;
        JMStampErrorLog.Open();
        while JMStampErrorLog.Read() do
            ErrorCount += 1;
        LastCalc := CurrentDateTime;
    end;

    local procedure ShowStampErrorLog()
    var
        TempErrorBuf: Record "COL JM Stamp Error Buf" temporary;
    begin
        FillStampErrorBuffer(TempErrorBuf);
        Page.RunModal(Page::"COL JM Stamp Error Log List", TempErrorBuf);
    end;

    local procedure FillStampErrorBuffer(var TempErrorBuf: Record "COL JM Stamp Error Buf")
    var
        JMStampErrorLog: Query "COL JM Stamp Error Log";
        EntryNo: Integer;
    begin
        TempErrorBuf.Reset();
        TempErrorBuf.DeleteAll();

        JMStampErrorLog.Open();
        while JMStampErrorLog.Read() do begin
            EntryNo += 1;
            TempErrorBuf.Init();
            TempErrorBuf."Entry No." := EntryNo;
            TempErrorBuf."Line Sequence" := JMStampErrorLog.LineSequence;
            TempErrorBuf."Line Seq. Journal Line" := JMStampErrorLog.LineSeqJournalLine;
            TempErrorBuf."Event Timestamp" := JMStampErrorLog.EventTimestamp;
            TempErrorBuf."Event Type" := Format(JMStampErrorLog.EventType, 0, '<Text>');
            TempErrorBuf."Event Status" := Format(JMStampErrorLog.EventStatus, 0, '<Text>');
            TempErrorBuf."Employee No." := JMStampErrorLog.EmployeeNo;
            TempErrorBuf."Job No." := JMStampErrorLog.JobNo;
            TempErrorBuf."Profile Date" := JMStampErrorLog.ProfileDate;
            TempErrorBuf."Posting Attempts" := JMStampErrorLog.PostingAttempts;
            TempErrorBuf."Log Entry No." := JMStampErrorLog.LogEntryNo;
            TempErrorBuf."Log Posting Date-Time" := JMStampErrorLog.LogPostingDateTime;
            TempErrorBuf."Log User ID" := JMStampErrorLog.LogUserId;
            TempErrorBuf."Log Error Text" := JMStampErrorLog.LogErrorText;
            TempErrorBuf.Insert();
        end;
        JMStampErrorLog.Close();
    end;

}