codeunit 70199 "COL Production BOM Line Events"
{
    [EventSubscriber(ObjectType::Table, Database::"Production BOM Line", OnValidateNoOnAfterAssignItemFields, '', false, false)]
    local procedure "Production BOM Line_OnValidateNoOnAfterAssignItemFields"(var ProductionBOMLine: Record "Production BOM Line"; Item: Record Item; var xProductionBOMLine: Record "Production BOM Line"; CallingFieldNo: Integer)
    begin
        ProductionBOMLine."COL Description 2" := Item."Description 2";
        ProductionBOMLine."COL Unit Price" := Item."Unit Price";
        ProductionBOMLine."COL Unit Cost" := Item."Unit Cost";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Production BOM Line", OnValidateNoOnAfterAssignProdBOMFields, '', false, false)]
    local procedure "Production BOM Line_OnValidateNoOnAfterAssignProdBOMFields"(var ProductionBOMLine: Record "Production BOM Line"; ProductionBOMHeader: Record "Production BOM Header"; var xProductionBOMLine: Record "Production BOM Line"; CallingFieldNo: Integer)
    begin
        ProductionBOMLine."COL Description 2" := ProductionBOMHeader."Description 2";
    end;
}