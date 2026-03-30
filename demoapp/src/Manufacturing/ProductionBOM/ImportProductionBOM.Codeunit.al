namespace Weibel.Manufacturing.ProductionBOM;

using Microsoft.Manufacturing.ProductionBOM;

codeunit 70194 "COL Import Production BOM"
{
    ObsoleteState = Pending;
    ObsoleteReason = 'Replaced by functionality in src/Manufacturing/ImportBOMLines';

    procedure ImportProdBOMLines(BOMHeader: Code[20])
    var
        ProductionBOMHeader: Record "Production BOM Header";
        VersionManagement: Codeunit "VersionManagement";
        ImportProductionBOMLine: XmlPort "COL Import Production BOM Line";
        GetProdBOMErr: Label 'Could not find Production BOM Header %1', Comment = '%1=Production BOM Header No.';
    begin

        if not ProductionBOMHeader.Get(BOMHeader) then
            Error(GetProdBOMErr, BOMHeader);
        ImportProductionBOMLine.SetBOMHeader(ProductionBOMHeader."No.", VersionManagement.GetBOMVersion(ProductionBOMHeader."No.", Today(), true));
        ImportProductionBOMLine.Run();
    end;
}
