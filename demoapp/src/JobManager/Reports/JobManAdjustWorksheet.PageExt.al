namespace Weibel.JobManager;

pageextension 70274 "COL JobManAdjustWorksheet" extends JobManAdjustWorksheet
{
    actions
    {
        addlast(processing)
        {
            action("COL ExportAdjustedEntries")
            {
                ApplicationArea = All;
                Caption = 'Export Adjusted Entries';
                ToolTip = 'Export adjusted JobMan entries to Excel.';
                Image = ExportToExcel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Report.Run(Report::"COL Weibel Adj. JobMan Entries");
                end;
            }
        }
    }
}
