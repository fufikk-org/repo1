namespace Weibel.JobManager;

report 70118 "COL Weibel Adj. JobMan Entries"
{
    Caption = 'Weibel Adjusted JobMan Entries';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Excel;
    ExcelLayout = '.\src\JobManager\Reports\WeibelAdjJobManEntries.xlsx';

    dataset
    {
        dataitem(JobManStampEvent; JobManStampCalcLine)
        {
            DataItemTableView = where(AdjustmentRecord = const(true));
            RequestFilterFields = ProfileDate, EmployeeNo;



            column(ProfileDate; ProfileDate)
            {
            }

            column(EmployeeNo; EmployeeNo)
            {
            }
            column(JobNo; JobNo)
            {
            }
            column(FromDateTime; FromDateTime)
            {

            }
            column(ToDateTime; ToDateTime)
            {

            }
            column(CalcTime; CalcTime)
            {

            }


        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                }
            }
        }
    }

}

