namespace Weibel.Manufacturing.ProductionBOM;

using Microsoft.Manufacturing.ProductionBOM;
using Weibel.Manufacturing.Reports;

tableextension 70146 "COL Production BOM Header" extends "Production BOM Header"
{
    procedure COLPrintBOM()
    var
        ProductionBOMHeader: Record "Production BOM Header";
        ProductionBOMLine: Record "Production BOM Line";
        NoLinesNotification: Notification;
        NoLinesInBOMLbl: Label 'Production BOM %1 does not contain any lines.', Comment = '%1 = Production BOM No.';
    begin
        ProductionBOMLine.ReadIsolation := IsolationLevel::ReadUncommitted;
        ProductionBOMLine.SetRange("Production BOM No.", Rec."No.");
        ProductionBOMLine.SetRange("Version Code", '');
        if ProductionBOMLine.IsEmpty() then begin
            NoLinesNotification.Message := StrSubstNo(NoLinesInBOMLbl, Rec."No.");
            NoLinesNotification.Send();
            exit;
        end;

        ProductionBOMHeader := Rec;
        ProductionBOMHeader.SetRecFilter();
        Report.Run(Report::"COL Production BOM", true, false, ProductionBOMHeader);
    end;
}
