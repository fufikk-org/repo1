namespace Weibel.Inventory.Tracking;

using Microsoft.Inventory.Tracking;
using Weibel.Inventory.Item;
using Weibel.Inventory.Ledger;

pageextension 70273 "COL Serial No. Inf. List" extends "Serial No. Information List"
{
    actions
    {
        modify(PrintLabel)
        {
            Visible = false;
        }
        // modify(FPL_PrintLabel)
        // {
        //     Visible = false;
        // }

        addlast(reporting)
        {
            action("COL FPL_PrintLabel")
            {
                Caption = 'Print Serial No. Label';
                ToolTip = 'Print Serial No. Label.';
                Image = Print;
                //Promoted = true;
                //PromotedCategory = Report;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SerialNoInformation: Record "Serial No. Information";
                    ReportLabel: Report "COL SN Label";
                begin
                    CurrPage.SetSelectionFilter(SerialNoInformation);
                    ReportLabel.InitFrom(SerialNoInformation);
                    ReportLabel.RunModal();
                end;
            }
        }

        addafter(Navigate_Promoted)
        {
            actionref(COLFPL_PrintLabel_Promoted; "COL FPL_PrintLabel")
            {
            }

        }
    }
}
