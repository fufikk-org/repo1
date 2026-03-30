pageextension 70250 "COL Intrastat Report List" extends "Intrastat Report List"
{
    actions
    {
        addlast(Processing)
        {
            action(COLExportPurchasePerTariffDetail)
            {
                Caption = 'Export Purchase per Tariff Detail';
                ToolTip = 'Exports Purchase per Tariff Detail.';
                Image = ExportDatabase;
                ApplicationArea = All;
                //RunObject = report "COL ExportPurch.TariffNo.Det.";

                trigger OnAction()
                var
                    ExportPurchTariffNoDet: Report "COL ExportPurch.TariffNo.Det.";
                begin
                    if Rec."Statistics Period" <> '' then
                        ExportPurchTariffNoDet.SetDates(Rec.GetStatisticsStartDate(), CalcDate('<+1M-1D>', Rec.GetStatisticsStartDate()));
                    ExportPurchTariffNoDet.RunModal();

                end;
            }
        }
    }
}