namespace Weibel.Inventory.BOM;

using Microsoft.Inventory.Item;
using Microsoft.Inventory.BOM;
using Microsoft.Manufacturing.Document;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Inventory.Location;
using Microsoft.Assembly.Document;
using Weibel.Inventory.Item;
using Weibel.Inventory.BOM.Tree;

codeunit 70173 "COL BOM Structure Events"
{
    [EventSubscriber(ObjectType::Page, Page::"BOM Structure", OnBeforeRefreshPage, '', false, false)]
    local procedure "BOM Structure_OnBeforeRefreshPage"(var BOMBuffer: Record "BOM Buffer"; var Item: Record Item; var SourceRecordVar: Variant; ShowBy: Enum "BOM Structure Show By"; ItemFilter: Code[250]; var IsHandled: Boolean)
    var
        StockkeepingUnit: Record "Stockkeeping Unit";
        CalculateSKUTree: Codeunit "COL Calculate SKU Tree";
    begin
        if ShowBy <> Enum::"BOM Structure Show By"::"COL SKU" then
            exit;

        IsHandled := true;

        StockkeepingUnit.GetBySystemId(ItemFilter);
        StockkeepingUnit.TestField("Replenishment System", Enum::"Replenishment System"::"Prod. Order");
        StockkeepingUnit.TestField("Production BOM No.");
        CalculateSKUTree.GenerateTree(StockkeepingUnit, BOMBuffer);
    end;


    [EventSubscriber(ObjectType::Table, Database::"BOM Buffer", OnTransferFromProdOrderLineCopyFields, '', false, false)]
    local procedure "BOM Buffer_OnTransferFromProdOrderLineCopyFields"(var BOMBuffer: Record "BOM Buffer"; ProdOrderLine: Record "Prod. Order Line")
    begin
        FillAdditionalData(BOMBuffer);
    end;

    [EventSubscriber(ObjectType::Table, Database::"BOM Buffer", OnTransferFromProdOrderCompCopyFields, '', false, false)]
    local procedure "BOM Buffer_OnTransferFromProdOrderCompCopyFields"(var BOMBuffer: Record "BOM Buffer"; ProdOrderComponent: Record "Prod. Order Component")
    begin
        FillAdditionalData(BOMBuffer);
    end;

    [EventSubscriber(ObjectType::Table, Database::"BOM Buffer", OnTransferFromProdCompCopyFields, '', false, false)]
    local procedure "BOM Buffer_OnTransferFromProdCompCopyFields"(var BOMBuffer: Record "BOM Buffer"; ProductionBOMLine: Record "Production BOM Line"; ParentItem: Record Item; ParentQtyPer: Decimal; ParentScrapQtyPer: Decimal)
    begin
        FillAdditionalData(BOMBuffer);
    end;

    [EventSubscriber(ObjectType::Table, Database::"BOM Buffer", OnTransferFromBOMCompCopyFields, '', false, false)]
    local procedure "BOM Buffer_OnTransferFromBOMCompCopyFields"(var BOMBuffer: Record "BOM Buffer"; BOMComponent: Record "BOM Component")
    begin
        FillAdditionalData(BOMBuffer);
    end;

    [EventSubscriber(ObjectType::Table, Database::"BOM Buffer", OnTransferFromAsmHeaderCopyFields, '', false, false)]
    local procedure "BOM Buffer_OnTransferFromAsmHeaderCopyFields"(var BOMBuffer: Record "BOM Buffer"; AssemblyHeader: Record "Assembly Header")
    begin
        FillAdditionalData(BOMBuffer);
    end;

    [EventSubscriber(ObjectType::Table, Database::"BOM Buffer", OnTransferFromAsmLineCopyFields, '', false, false)]
    local procedure "BOM Buffer_OnTransferFromAsmLineCopyFields"(var BOMBuffer: Record "BOM Buffer"; AssemblyLine: Record "Assembly Line")
    begin
        FillAdditionalData(BOMBuffer);
    end;

    [EventSubscriber(ObjectType::Table, Database::"BOM Buffer", OnTransferFromItemCopyFields, '', false, false)]
    local procedure "BOM Buffer_OnTransferFromItemCopyFields"(var BOMBuffer: Record "BOM Buffer"; Item: Record Item)
    begin
        FillAdditionalData(BOMBuffer);
    end;

    [EventSubscriber(ObjectType::Table, Database::"BOM Buffer", COLOnTransferFromSKUCopyFields, '', false, false)]
    local procedure "BOM Buffer_COLOnTransferFromSKUCopyFields"(var BOMBuffer: Record "BOM Buffer"; SKU: Record "Stockkeeping Unit")
    begin
        FillAdditionalData(BOMBuffer);
    end;

    [EventSubscriber(ObjectType::Table, Database::"BOM Buffer", COLOnAfterInitFromItem, '', false, false)]
    local procedure "BOM Buffer_COLOnAfterInitFromItem"(var BOMBuffer: Record "BOM Buffer"; Item: Record Item; StockkeepingUnit: Record "Stockkeeping Unit")
    begin
        FillAdditionalData(BOMBuffer);
    end;

    local procedure FillAdditionalData(var BOMBuffer: Record "BOM Buffer")
    var
        ItemVariant: Record "Item Variant";
        Item: Record Item;
    begin
        ItemVariant.ReadIsolation := IsolationLevel::ReadUncommitted;
        ItemVariant.SetLoadFields("COL Product Life Cycle", "COL EU RoHS Dir. Compliant", "COL EU REACH Reg. Compliant", "COL EU RoHS Status");

        Item.ReadIsolation := IsolationLevel::ReadUncommitted;
        Item.SetLoadFields("COL EU RoHS Dir. Compliant", "COL EU REACH Reg. Compliant", "COL EU RoHS Status");

        if BOMBuffer.Type <> BOMBuffer.Type::Item then
            exit;

        if BOMBuffer."Variant Code" <> '' then begin
            if ItemVariant.Get(BOMBuffer."No.", BOMBuffer."Variant Code") then begin
                BOMBuffer."COL Product Life Cycle" := ItemVariant."COL Product Life Cycle";
                BOMBuffer."COL EU RoHS Dir. Compliant" := ItemVariant."COL EU RoHS Dir. Compliant";
                BOMBuffer."COL EU REACH Reg. Compliant" := ItemVariant."COL EU REACH Reg. Compliant";
                BOMBuffer."COL EU RoHS Status" := ItemVariant."COL EU RoHS Status";
            end;
        end else
            if Item.Get(BOMBuffer."No.") then begin
                BOMBuffer."COL EU RoHS Dir. Compliant" := Item."COL EU RoHS Dir. Compliant";
                BOMBuffer."COL EU REACH Reg. Compliant" := Item."COL EU REACH Reg. Compliant";
                BOMBuffer."COL EU RoHS Status" := Item."COL EU RoHS Status";
            end;
    end;
}