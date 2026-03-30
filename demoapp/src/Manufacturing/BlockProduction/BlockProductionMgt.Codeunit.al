namespace Weibel.Manufacturing.BlockProduction;

using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Journal;

codeunit 70154 "COL Block Production Mgt."
{
    var
        ItemIsBlockedForProdErr: Label 'Item %1 is blocked for production.', Comment = '%1 = Item No.';
        ItemVariantIsBlockedForProdErr: Label 'Item %1, variant %2 is blocked for production.', Comment = '%1 = Item No., %2 = Variant Code';
        NotPossibleToReleaseOrderLbl: Label ' It will not be possible to change Production Order status to Released.';
        VerifyProductionOrderComponentNotificationIdTok: Label '7778aecc-0b8d-4ed7-aac0-9a2a219f7459', Locked = true;

    internal procedure CheckProductionBOMLine(var ProductionBOMLine: Record "Production BOM Line"; ShowError: Boolean; var ErrMsg: Text): Boolean
    var
        BlockedItemOnBOMErr: Label 'Production BOM %1 contains an item or variant that is blocked for production.', Comment = '%1 = Production BOM No.';
    begin
        Clear(ErrMsg);

        if ProductionBOMLine."Quantity per" <= 0 then
            exit(true);
        if ProductionBOMLine."No." = '' then
            exit(true);

        case ProductionBOMLine.Type of
            Enum::"Production BOM Line Type"::Item:
                if IsItemProductionBlocked(ProductionBOMLine) then
                    ErrMsg := StrSubstNo(ItemIsBlockedForProdErr, ProductionBOMLine."No.")
                else
                    if ProductionBOMLine."Variant Code" <> '' then
                        if IsItemVariantProductionBlocked(ProductionBOMLine) then
                            ErrMsg := StrSubstNo(ItemVariantIsBlockedForProdErr, ProductionBOMLine."No.", ProductionBOMLine."Variant Code");

            Enum::"Production BOM Line Type"::"Production BOM":
                if not CheckProductionBOM(ProductionBOMLine."No.", ShowError, ErrMsg) then
                    ErrMsg := StrSubstNo(BlockedItemOnBOMErr, ProductionBOMLine."No.");
        end;

        if ErrMsg <> '' then
            if ShowError then
                Error(ErrMsg)
            else
                exit(false);
        exit(true);
    end;

    local procedure CheckProductionBOM(ProductionBOMNo: Code[20]; ShowError: Boolean; ErrMsg: Text): Boolean
    var
        ProductionBOMLine: Record "Production BOM Line";
    begin
        ProductionBOMLine.ReadIsolation := IsolationLevel::ReadUncommitted;
        ProductionBOMLine.SetRange("Production BOM No.", ProductionBOMNo);
        ProductionBOMLine.SetFilter("No.", '<>%1', '');
        if ProductionBOMLine.FindSet() then
            repeat
                if not CheckProductionBOMLine(ProductionBOMLine, ShowError, ErrMsg) then
                    exit(false)
            until ProductionBOMLine.Next() = 0;
        exit(true);
    end;

    internal procedure IsProductionBOMLineBlocked(var ProductionBOMLine: Record "Production BOM Line"): Boolean
    var
        ErrMsg: Text;
    begin
        if not CheckProductionBOMLine(ProductionBOMLine, false, ErrMsg) then
            exit(true);
    end;

    internal procedure IsItemProductionBlocked(var ProductionBOMLine: Record "Production BOM Line"): Boolean
    var
        Item: Record Item;
    begin
        if ProductionBOMLine.Type <> Enum::"Production BOM Line Type"::Item then
            exit(false);

        Item.ReadIsolation := IsolationLevel::ReadUncommitted;
        Item.SetLoadFields("COL Production Blocked");

        Item.Get(ProductionBOMLine."No.");
        exit(Item."COL Production Blocked");
    end;

    internal procedure IsItemVariantProductionBlocked(var ProductionBOMLine: Record "Production BOM Line"): Boolean
    var
        ItemVariant: Record "Item Variant";
    begin
        if ProductionBOMLine.Type <> Enum::"Production BOM Line Type"::Item then
            exit(false);

        ItemVariant.ReadIsolation := IsolationLevel::ReadUncommitted;
        ItemVariant.SetLoadFields("COL Production Blocked");

        if ProductionBOMLine."Variant Code" <> '' then begin
            ItemVariant.Get(ProductionBOMLine."No.", ProductionBOMLine."Variant Code");
            if not ItemVariant."COL Production Blocked" then
                exit(IsItemProductionBlocked(ProductionBOMLine))
            else
                exit(true);
        end;
    end;

    internal procedure IsBOMProductionBlocked(ProductionBOMLine: Record "Production BOM Line"): Boolean
    var
        ErrMsg: Text;
    begin
        if ProductionBOMLine.Type <> Enum::"Production BOM Line Type"::"Production BOM" then
            exit(false);
        if not CheckProductionBOM(ProductionBOMLine."No.", true, ErrMsg) then
            exit(true);
    end;

    internal procedure CheckLinesOnBOMStatusChange(var ProductionBOMHeader: Record "Production BOM Header")
    var
        ProductionBOMLine: Record "Production BOM Line";
        ErrMsg: Text;
    begin
        ProductionBOMLine.SetRange("Production BOM No.", ProductionBOMHeader."No.");
        ProductionBOMLine.SetFilter(Type, '<>%1', ProductionBOMLine.Type::" ");
        if ProductionBOMLine.FindSet() then
            repeat
                CheckProductionBOMLine(ProductionBOMLine, true, ErrMsg);
            until ProductionBOMLine.Next() = 0;
    end;

    internal procedure CheckProductionOrderOnStatusChange(var ProdOrder: Record "Production Order"; NewStatus: Enum "Production Order Status")
    var
        ErrMsg: Text;
    begin
        if NewStatus <> Enum::"Production Order Status"::Released then
            exit;

        CheckProductionOrder(ProdOrder, true, ErrMsg);
    end;

    internal procedure CheckProductionOrder(var ProdOrder: Record "Production Order"; ShowError: Boolean; var ErrMsg: Text): Boolean
    var
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderComponent: Record "Prod. Order Component";
        TempProductionBOMLine: Record "Production BOM Line" temporary;
    begin
        if ProdOrder."Source Type" = Enum::"Prod. Order Source Type"::Item then begin
            TempProductionBOMLine.Type := Enum::"Production BOM Line Type"::Item;
            TempProductionBOMLine."No." := ProdOrder."Source No.";
            TempProductionBOMLine."Variant Code" := ProdOrder."Variant Code";
            TempProductionBOMLine."Quantity per" := 1;
            if not CheckProductionBOMLine(TempProductionBOMLine, ShowError, ErrMsg) then
                exit(false);
        end;

        ProdOrderLine.SetRange("Prod. Order No.", ProdOrder."No.");
        ProdOrderLine.SetRange(Status, ProdOrder.Status);
        if ProdOrderLine.FindSet() then
            repeat
                if not CheckProductionOrderLine(ProdOrderLine, ShowError, ErrMsg) then
                    exit(false)
            until ProdOrderLine.Next() = 0;

        ProdOrderComponent.SetRange("Prod. Order No.", ProdOrder."No.");
        ProdOrderComponent.SetRange(Status, ProdOrder.Status);
        if ProdOrderComponent.FindSet() then
            repeat
                if not CheckProductionOrderComponentLine(ProdOrderComponent, ShowError, ErrMsg) then
                    exit(false);
            until ProdOrderComponent.Next() = 0;
        exit(true);
    end;

    internal procedure CheckItemJournalLineBlocked(var ItemJournalLine: Record "Item Journal Line")
    var
        TempProductionBOMLine: Record "Production BOM Line" temporary;
        ErrMsg: Text;
    begin
        if not (ItemJournalLine."Entry Type" in [Enum::"Item Ledger Entry Type"::Consumption, Enum::"Item Ledger Entry Type"::Output]) then
            exit;

        TempProductionBOMLine.Type := Enum::"Production BOM Line Type"::Item;
        TempProductionBOMLine."No." := ItemJournalLine."Item No.";
        TempProductionBOMLine."Variant Code" := ItemJournalLine."Variant Code";
        TempProductionBOMLine."Quantity per" := ItemJournalLine.Quantity;
        CheckProductionBOMLine(TempProductionBOMLine, true, ErrMsg);
    end;

    internal procedure VerifyProductionOrder(var ProdOrder: Record "Production Order")
    var
        ErrMsg: Text;
    begin
        if not CheckProductionOrder(ProdOrder, true, ErrMsg) then
            Error(ErrMsg);
    end;

    internal procedure CheckProductionOrderLine(var ProdOrderLine: Record "Prod. Order Line"; ShowError: Boolean; var ErrMsg: Text): Boolean
    var
        TempProductionBOMLine: Record "Production BOM Line" temporary;
    begin
        if ProdOrderLine.Status = ProdOrderLine.Status::Finished then
            exit;
        TempProductionBOMLine.Type := Enum::"Production BOM Line Type"::Item;
        TempProductionBOMLine."No." := ProdOrderLine."Item No.";
        TempProductionBOMLine."Variant Code" := ProdOrderLine."Variant Code";
        TempProductionBOMLine."Quantity per" := ProdOrderLine."Remaining Quantity";
        exit(CheckProductionBOMLine(TempProductionBOMLine, ShowError, ErrMsg));
    end;

    internal procedure VerifyProductionOrderLine(var ProdOrderLine: Record "Prod. Order Line")
    var
        ProdBlockedNotification: Notification;
        ErrMsg: Text;
        NotificationIdTok: Label '50977d26-cb48-4f48-9946-8ad4571f2413', Locked = true;
    begin
        if not CheckProductionOrderLine(ProdOrderLine, true, ErrMsg) then begin
            ProdBlockedNotification.Id(NotificationIdTok);
            if ProdOrderLine.Status in [Enum::"Production Order Status"::Planned, Enum::"Production Order Status"::"Firm Planned"] then
                ProdBlockedNotification.Message(ErrMsg + NotPossibleToReleaseOrderLbl)
            else
                ProdBlockedNotification.Message(ErrMsg);
            ProdBlockedNotification.Send();
        end;
    end;

    internal procedure CheckProductionOrderComponentLine(var ProdOrderComponent: Record "Prod. Order Component"; ShowError: Boolean; var ErrMsg: Text): Boolean
    var
        TempProductionBOMLine: Record "Production BOM Line" temporary;
    begin
        if ProdOrderComponent.Status = ProdOrderComponent.Status::Finished then
            exit;
        TempProductionBOMLine.Type := Enum::"Production BOM Line Type"::Item;
        TempProductionBOMLine."No." := ProdOrderComponent."Item No.";
        TempProductionBOMLine."Variant Code" := ProdOrderComponent."Variant Code";
        TempProductionBOMLine."Quantity per" := ProdOrderComponent."Remaining Quantity";
        exit(CheckProductionBOMLine(TempProductionBOMLine, ShowError, ErrMsg));
    end;

    internal procedure VerifyProductionOrderComponentLine(var ProdOrderComponent: Record "Prod. Order Component")
    var
        ProdBlockedNotification: Notification;
        ErrMsg: Text;
    begin
        ProdBlockedNotification.Id(VerifyProductionOrderComponentNotificationIdTok);
        if not CheckProductionOrderComponentLine(ProdOrderComponent, true, ErrMsg) then begin
            if ProdOrderComponent.Status in [Enum::"Production Order Status"::Planned, Enum::"Production Order Status"::"Firm Planned"] then
                ProdBlockedNotification.Message(ErrMsg + NotPossibleToReleaseOrderLbl)
            else
                ProdBlockedNotification.Message(ErrMsg);
            ProdBlockedNotification.Send();
        end;
    end;

    internal procedure RecallVerifyProductionOrderComponentLineNotification()
    var
        ProdBlockedNotification: Notification;
    begin
        ProdBlockedNotification.Id(VerifyProductionOrderComponentNotificationIdTok);
        ProdBlockedNotification.Recall();
    end;
}