namespace Weibel.Manufacturing.ProductionBOM;

using Microsoft.Manufacturing.ProductionBOM;

codeunit 70182 "COL Where-Used Sub."
{
    SingleInstance = true;
    EventSubscriberInstance = Manual;

    var
        currVariant: code[20];

    procedure SetVariant(pCurrVariant: code[20])
    begin
        currVariant := pCurrVariant;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Where-Used Management", 'OnBeforeIsActiveProductionBOM', '', false, false)]
    local procedure OnBeforeIsActiveProductionBOM(ProductionBOMLine: Record "Production BOM Line"; var Result: Boolean; var IsHandled: Boolean)
    begin
        if (ProductionBOMLine.Type = ProductionBOMLine.Type::Item) and (ProductionBOMLine."Variant Code" <> currVariant) then begin
            IsHandled := true;
            Result := false;
        end;
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Where-Used Management", 'OnBuildWhereUsedListOnLoopProdBomComponent', '', false, false)]
    // local procedure OnBuildWhereUsedListOnLoopProdBomComponent(var ProductionBOMLine: Record "Production BOM Line"; var TempWhereUsedLine: Record "Where-Used Line" temporary; var NextWhereUsedEntryNo: Integer; No: Code[20]; CalcDate: Date; var Level: Integer)
    // begin
    //     if (ProductionBOMLine.Type <> ProductionBOMLine.Type::"Production BOM") then
    //         exit;

    //     TempWhereUsedLine.Init();
    //     TempWhereUsedLine."Entry No." := NextWhereUsedEntryNo;
    //     TempWhereUsedLine."Item No." := ProductionBOMLine."No.";
    //     TempWhereUsedLine.Description := ProductionBOMLine.Description;
    //     TempWhereUsedLine."Level Code" := Level;
    //     TempWhereUsedLine.Insert();
    //     NextWhereUsedEntryNo := NextWhereUsedEntryNo + 1;
    // end; // also delete BOM withaut components in temp table

}
