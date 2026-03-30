namespace Weibel.Manufacturing.ProductionBOM;

using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Planning;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.Requisition;

codeunit 70164 "COL Prod. BOM Position Subs."
{
    [EventSubscriber(ObjectType::Report, Report::"Exchange Production BOM Item", OnAfterCopyPositionFields, '', false, false)]
    local procedure "Exchange Production BOM Item_OnAfterCopyPositionFields"(var ProdBOMLineCopyTo: Record "Production BOM Line"; ProdBOMLineCopyFrom: Record "Production BOM Line")
    begin
        ProdBOMLineCopyTo.Validate("COL Position", ProdBOMLineCopyFrom."COL Position");
        ProdBOMLineCopyTo.Validate("COL Position 3", ProdBOMLineCopyFrom."COL Position 3");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Component", OnAfterSetFilterFromProdBOMLine, '', false, false)]
    local procedure "Prod. Order Component_OnAfterSetFilterFromProdBOMLine"(var ProdOrderComponent: Record "Prod. Order Component"; ProdBOMLine: Record "Production BOM Line")
    begin
        ProdOrderComponent.SetRange("COL Position", ProdBOMLine."COL Position");
        ProdOrderComponent.SetRange("COL Position 3", ProdBOMLine."COL Position 3");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calculate Prod. Order", OnTransferBOMProcessItemOnBeforeGetPlanningParameters, '', false, false)]
    local procedure "Calculate Prod. Order_OnTransferBOMProcessItemOnBeforeGetPlanningParameters"(var ProdOrderComponent: Record "Prod. Order Component"; ProductionBOMLine: Record "Production BOM Line"; StockkeepingUnit: Record "Stockkeeping Unit")
    begin
        ProdOrderComponent."COL Position" := ProductionBOMLine."COL Position";
        ProdOrderComponent."COL Position 3" := ProductionBOMLine."COL Position 3";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Mfg. Planning Line Management", OnTransferBOMOnBeforeGetDefaultBin, '', false, false)]
    local procedure "Planning Line Management_OnTransferBOMOnBeforeGetDefaultBin"(var PlanningComponent: Record "Planning Component"; var ProductionBOMLine: Record "Production BOM Line"; RequisitionLine: Record "Requisition Line"; var StockkeepingUnit: Record "Stockkeeping Unit")
    begin
        PlanningComponent."COL Position" := ProductionBOMLine."COL Position";
        PlanningComponent."COL Position 3" := ProductionBOMLine."COL Position 3";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Component", OnAfterCopyFromPlanningComp, '', false, false)]
    local procedure "Prod. Order Component_OnAfterCopyFromPlanningComp"(var ProdOrderComponent: Record "Prod. Order Component"; PlanningComponent: Record "Planning Component")
    begin
        ProdOrderComponent."COL Position" := PlanningComponent."COL Position";
        ProdOrderComponent."COL Position 3" := PlanningComponent."COL Position 3";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Planning Component", OnAfterTransferFromComponent, '', false, false)]
    local procedure "Planning Component_OnAfterTransferFromComponent"(var PlanningComponent: Record "Planning Component"; var ProdOrderComp: Record "Prod. Order Component")
    begin
        PlanningComponent."COL Position" := ProdOrderComp."COL Position";
        PlanningComponent."COL Position 3" := ProdOrderComp."COL Position 3";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Mfg. Planning Line Management", OnAfterIsPlannedCompFound, '', false, false)]
    local procedure "Planning Line Management_OnAfterIsPlannedCompFound"(var PlanningComp: Record "Planning Component"; var ProdBOMLine: Record "Production BOM Line"; var IsFound: Boolean; var SKU: Record "Stockkeeping Unit")
    begin
        IsFound := IsFound and (PlanningComp."COL Position" = ProdBOMLine."COL Position") and (PlanningComp."COL Position 3" = ProdBOMLine."COL Position 3");
    end;


}