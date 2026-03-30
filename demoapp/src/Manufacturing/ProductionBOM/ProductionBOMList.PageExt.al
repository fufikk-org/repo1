namespace Weibel.Manufacturing.ProductionBOM;

using Microsoft.Manufacturing.ProductionBOM;

pageextension 70181 "COL Production BOM List" extends "Production BOM List"
{
    actions
    {
        addlast(Reporting)
        {
            action("COL Print BOM")
            {
                ApplicationArea = All;
                Caption = 'Print BOM';
                ToolTip = 'Print information about Production BOM.';
                Image = Report;

                trigger OnAction()
                begin
                    Rec.COLPrintBOM();
                end;

            }
        }
        addlast(processing)
        {
            action("COL Update Unit Prices & Costs")
            {
                Caption = 'Update Unit Prices & Costs';
                ToolTip = 'Updates unit price and unit cost on all item related BOM lines.';
                Image = UpdateDescription;
                ApplicationArea = All;
                Ellipsis = true;

                trigger OnAction()
                var
                    ProductionBOMUnitPrice: Codeunit "COL Production BOM Unit Price";
                    UpdatePricesCostsQst: Label 'Do you want to update unit price & unit cost on all BOM lines?';
                begin
                    if not Confirm(UpdatePricesCostsQst, false) then
                        exit;
                    ProductionBOMUnitPrice.Run();
                end;
            }
        }
        addlast(Category_Report)
        {
            actionref("COL Print BOM_Promoted"; "COL Print BOM") { }
        }
    }
}
