namespace Weibel.Finance.GeneralLedger.Reports;

using Microsoft.Finance.GeneralLedger.Reports;

reportextension 70112 "COL Detail Trial Balance" extends "Detail Trial Balance"
{
    rendering
    {
        layout(COLReportLayout)
        {
            Caption = 'Detail Trial Balance';
            Type = RDLC;
            LayoutFile = './src/Sales/ReportExt/Layout/COLDetailTrialBalance.rdl';
        }
    }
}
