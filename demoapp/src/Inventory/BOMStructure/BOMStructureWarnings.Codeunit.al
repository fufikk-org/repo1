namespace Weibel.Inventory.BOM;

using Microsoft.Inventory.BOM;
using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Inventory.Location;

codeunit 70185 "COL BOM Structure Warnings"
{
    EventSubscriberInstance = Manual;

    var
        MissingQtyPerLbl: Label 'Quantity per., in the BOM for Item %1 has not been set.', Comment = '%1 = Item No.';
        MissingQtyPerInBOMLbl: Label 'Quantity per., in the BOM %1 for Item %2 has not been set.', Comment = '%1 = Prod. BOM No.; %2 = Item No.';
        MissingSKULbl: Label 'Stockkeeping Unit for Item %1, Variant %2 and Location Code %3 does not exist.', Comment = '%1 = Item No.; %2 = variant code; %3 = location code';
        ItemNotABOMLbl: Label 'Item %1 at SKU is not a BOM. Therefore, the Replenishment System field must be set to Purchase.', Comment = '%1 = Item No.';
        ItemVariantNotABOMLbl: Label 'Item Variant (Item: %1, Variant: %2) at SKU is not a BOM. Therefore, the Replenishment System field must be set to Purchase.', Comment = '%1 = Item No., %2 = Variant Code';
        ItemIsABOMLbl: Label 'Item %1 at SKU is a BOM, but the Replenishment System field is not set to Assembly or Prod. Order. Verify that the value is correct.', Comment = '%1 = Item No.';
        ItemVariantIsABOMLbl: Label 'Item Variant (Item: %1, Variant: %2) at SKU is a BOM, but the Replenishment System field is not set to Assembly or Prod. Order. Verify that the value is correct.', Comment = '%1 = Item No.; %2 = Variant Code';
        MissingAssemblyBOMLbl: Label 'Replenishment System for Item %1 is Assembly, but the item does not have an assembly BOM. Verify that this is correct.', Comment = '%1 = Item No.';
        MissingItemProdBOMLbl: Label 'Replenishment System for Item %1 at SKU is Prod. Order, but the item does not have a production BOM. Verify that this is correct.', Comment = '%1 = Item No.';
        MissingItemVariantProdBOMLbl: Label 'Replenishment System for Item Variant (Item: %1, Variant: %2) at SKU is Prod. Order, but the item does not have a production BOM. Verify that this is correct.', Comment = '%1 = Item No.; %2 = Variant Code';

    [EventSubscriber(ObjectType::Table, Database::"BOM Buffer", OnBeforeIsQtyPerOk, '', false, false)]
    local procedure "BOM Buffer_OnBeforeIsQtyPerOk"(var BOMBuffer: Record "BOM Buffer"; var BOMWarningLog: Record "BOM Warning Log"; LogWarning: Boolean; var Result: Boolean; var IsHandled: Boolean)
    var
        CopyOfBOMBuffer: Record "BOM Buffer";
        Item: Record Item;
        ProdBOMHeader: Record "Production BOM Header";
    begin
        Clear(Result);
        IsHandled := true;

        Result := (BOMBuffer."Qty. per Parent" <> 0) or (BOMBuffer."No." = '') or (BOMBuffer.Indentation = 0) or (BOMBuffer.Type in [BOMBuffer.Type::"Machine Center", BOMBuffer.Type::"Work Center"]);
        if Result then
            exit;

        if LogWarning then begin
            CopyOfBOMBuffer.Copy(BOMBuffer);
            BOMBuffer.Reset();
            BOMBuffer.SetRange(Indentation, 0, BOMBuffer.Indentation);
            BOMBuffer.SetRange(Type, BOMBuffer.Type::Item);
            while (BOMBuffer.Next(-1) <> 0) and (BOMBuffer.Indentation >= CopyOfBOMBuffer.Indentation) do
                ;
            Item.SetLoadFields("No.");
            Item.SetAutoCalcFields("Assembly BOM");
            if BOMBuffer."Entry No." <> CopyOfBOMBuffer."Entry No." then begin
                Item.Get(BOMBuffer."No.");
                if Item."Assembly BOM" then
                    BOMWarningLog.SetWarning(StrSubstNo(MissingQtyPerLbl, Item."No."), Database::Item, CopyStr(Item.GetPosition(), 1, 250))
                else
                    if ProdBOMHeader.Get(BOMBuffer."Production BOM No.") then
                        BOMWarningLog.SetWarning(StrSubstNo(MissingQtyPerInBOMLbl, BOMBuffer."Production BOM No.", CopyOfBOMBuffer."No."), Database::"Production BOM Header", CopyStr(ProdBOMHeader.GetPosition(), 1, 250))
            end;
            BOMBuffer.Copy(CopyOfBOMBuffer);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"BOM Buffer", OnBeforeIsReplenishmentOk, '', false, false)]
    local procedure "BOM Buffer_OnBeforeIsReplenishmentOk"(var BOMBuffer: Record "BOM Buffer"; var BOMWarningLog: Record "BOM Warning Log"; LogWarning: Boolean; var Result: Boolean; var IsHandled: Boolean)
    var
        StockkeepingUnit: Record "Stockkeeping Unit";
        Item: Record Item;
    begin
        IsHandled := true;
        Result := (BOMBuffer.Type <> BOMBuffer.Type::Item) or (BOMBuffer."No." = '');
        if Result then
            exit;

        if not SKUExists(BOMBuffer) then begin
            Result := false;
            if LogWarning then begin
                Item.SetLoadFields("No.");
                Item.Get(BOMBuffer."No.");
                BOMWarningLog.SetWarning(StrSubstNo(MissingSKULbl, BOMBuffer."No.", BOMBuffer."Variant Code", BOMBuffer."Location Code"), Database::"Item", CopyStr(Item.GetPosition(), 1, 250))
            end;
            exit;
        end;

        StockkeepingUnit.SetAutoCalcFields("Assembly BOM");
        StockkeepingUnit.Get(BOMBuffer."Location Code", BOMBuffer."No.", BOMBuffer."Variant Code");
        if BOMBuffer."Is Leaf" then begin
            if StockkeepingUnit."Replenishment System" in [Enum::"Replenishment System"::Purchase, Enum::"Replenishment System"::Transfer] then begin
                Result := true;
                exit;
            end;
            if LogWarning then
                if BOMBuffer."Variant Code" = '' then
                    BOMWarningLog.SetWarning(StrSubstNo(ItemNotABOMLbl, StockkeepingUnit."Item No."), Database::"Stockkeeping Unit", CopyStr(StockkeepingUnit.GetPosition(), 1, 250))
                else
                    BOMWarningLog.SetWarning(StrSubstNo(ItemVariantNotABOMLbl, StockkeepingUnit."Item No.", StockkeepingUnit."Variant Code"), Database::"Stockkeeping Unit", CopyStr(StockkeepingUnit.GetPosition(), 1, 250));
        end else begin
            if StockkeepingUnit."Replenishment System" in [Enum::"Replenishment System"::"Prod. Order", Enum::"Replenishment System"::Assembly] then begin
                Result := IsBOMOk(BOMBuffer, StockkeepingUnit, LogWarning, BOMWarningLog);
                exit;
            end;
            if LogWarning then
                if BOMBuffer."Variant Code" = '' then
                    BOMWarningLog.SetWarning(StrSubstNo(ItemIsABOMLbl, StockkeepingUnit."Item No."), Database::"Stockkeeping Unit", CopyStr(StockkeepingUnit.GetPosition(), 1, 250))
                else
                    BOMWarningLog.SetWarning(StrSubstNo(ItemVariantIsABOMLbl, StockkeepingUnit."Item No.", StockkeepingUnit."Variant Code"), Database::"Stockkeeping Unit", CopyStr(StockkeepingUnit.GetPosition(), 1, 250));
        end;
    end;

    local procedure IsBOMOk(var BOMBuffer: Record "BOM Buffer"; var StockkeepingUnit: Record "Stockkeeping Unit"; LogWarning: Boolean; var BOMWarningLog: Record "BOM Warning Log"): Boolean
    var
        Item: Record Item;
    begin
        if BOMBuffer.Type <> BOMBuffer.Type::Item then
            exit(true);
        if BOMBuffer."No." = '' then
            exit(true);

        case StockkeepingUnit."Replenishment System" of
            Enum::"Replenishment System"::Assembly:
                begin
                    if StockkeepingUnit."Assembly BOM" then
                        exit(true);
                    if LogWarning then begin
                        Item.SetLoadFields("No.");
                        Item.Get(StockkeepingUnit."Item No.");
                        BOMWarningLog.SetWarning(StrSubstNo(MissingAssemblyBOMLbl, Item."No."), Database::Item, CopyStr(Item.GetPosition(), 1, 250));
                    end;
                end;
            Enum::"Replenishment System"::"Prod. Order":
                begin
                    if StockkeepingUnit."Production BOM No." <> '' then
                        exit(true);
                    if LogWarning then
                        if BOMBuffer."Variant Code" = '' then
                            BOMWarningLog.SetWarning(StrSubstNo(MissingItemProdBOMLbl, StockkeepingUnit."Item No."), Database::"Stockkeeping Unit", CopyStr(StockkeepingUnit.GetPosition(), 1, 250))
                        else
                            BOMWarningLog.SetWarning(StrSubstNo(MissingItemVariantProdBOMLbl, StockkeepingUnit."Item No.", StockkeepingUnit."Variant Code"), Database::"Stockkeeping Unit", CopyStr(StockkeepingUnit.GetPosition(), 1, 250))
                end;
            else
                exit(true);
        end;
    end;

    local procedure SKUExists(var BOMBuffer: Record "BOM Buffer"): Boolean
    var
        StockkeepingUnit: Record "Stockkeeping Unit";
    begin
        StockkeepingUnit.SetRange("Location Code", BOMBuffer."Location Code");
        StockkeepingUnit.SetRange("Item No.", BOMBuffer."No.");
        StockkeepingUnit.SetRange("Variant Code", BOMBuffer."Variant Code");
        exit(not StockkeepingUnit.IsEmpty());
    end;
}