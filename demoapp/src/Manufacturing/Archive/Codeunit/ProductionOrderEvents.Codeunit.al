namespace Weibel.Manufacturing.Order;

using Microsoft.Manufacturing.Document;
using Microsoft.Manufacturing.Setup;
using Microsoft.Warehouse.Worksheet;
using Microsoft.Warehouse.Activity;
using Weibel.Manufacturing.Archive;
using Microsoft.Warehouse.Setup;
using Microsoft.Warehouse.Request;

codeunit 70103 "COL Production Order Events"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", OnBeforeCheckBeforeFinishProdOrder, '', false, false)]
    local procedure "OnBeforeCheckBeforeFinishProdOrder"(var ProductionOrder: Record "Production Order"; var IsHandled: Boolean)
    begin
        CheckFinishProdOrderRemainingQty(ProductionOrder);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", OnBeforeChangeStatusOnProdOrder, '', false, false)]
    local procedure OnBeforeChangeStatusOnProdOrder(var ProductionOrder: Record "Production Order")
    begin
        CheckInternalStatus(ProductionOrder);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Pick Worksheet", OnAfterActionGetWarehouseDocuments, '', false, false)]
    local procedure OnAfterActionGetWarehouseDocuments(WhseWkshTemplate: Code[10]; WhseWkshName: Code[10]; LocationCode: Code[10]; SortingMethod: Enum "Whse. Activity Sorting Method")
    begin
        InitRoutingLinkCode(WhseWkshTemplate, WhseWkshName, LocationCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", OnBeforeShowStatusMessage, '', false, false)]
    local procedure OnBeforeShowStatusMessage(ProdOrder: Record "Production Order"; ToProdOrder: Record "Production Order")
    var
        ProdArchiveManagement: Codeunit "COL Prod. Archive Management";
    begin
        ProdArchiveManagement.MoveArchiveState(ProdOrder, ToProdOrder);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Production Order", OnBeforeRunCreatePickFromWhseSource, '', false, false)]
    local procedure "Production Order_OnBeforeRunCreatePickFromWhseSource"(var ProductionOrder: Record "Production Order"; AssignedUserID: Code[50]; SortingMethod: Option; PrintDocument: Boolean; DoNotFillQtyToHandle: Boolean; SetBreakBulkFilter: Boolean; HideValidationDialog: Boolean; var IsHandled: Boolean)
    var
        WarehouseEmployee: Record "Warehouse Employee";
        CreatePickFromWhseSource: Report "Whse.-Source - Create Document";
        ClearAssignedUserId: Boolean;
    begin
        IsHandled := true; // Prevent default behavior

        ClearAssignedUserId := true;
        if (ProductionOrder."Location Code" <> '') and (AssignedUserID <> '') then
            ClearAssignedUserId := not WarehouseEmployee.Get(AssignedUserID, ProductionOrder."Location Code");

        CreatePickFromWhseSource.SetProdOrder(ProductionOrder);
        CreatePickFromWhseSource.COLSetWorkCenterFilter(ProductionOrder);
        CreatePickFromWhseSource.COLSetPerZoneEnabled();
        CreatePickFromWhseSource.SetHideValidationDialog(HideValidationDialog);
        if HideValidationDialog or not ClearAssignedUserId then
            CreatePickFromWhseSource.Initialize(
                AssignedUserID, Enum::"Whse. Activity Sorting Method".FromInteger(SortingMethod), PrintDocument, DoNotFillQtyToHandle, SetBreakBulkFilter);
        CreatePickFromWhseSource.UseRequestPage(not HideValidationDialog);
        CreatePickFromWhseSource.RunModal();
        CreatePickFromWhseSource.GetResultMessage(2);
    end;

    local procedure CheckInternalStatus(var ProductionOrder: Record "Production Order")
    var
        InternalStatusErr: Label 'Production Order %1 Internal Status is open, Status can''t be changed.', Comment = '%1 PO number';
    begin
        if ProductionOrder."COL Internal Status" = ProductionOrder."COL Internal Status"::Open then
            Error(InternalStatusErr, ProductionOrder."No.");
    end;

    local procedure CheckFinishProdOrderRemainingQty(var ProductionOrder: Record "Production Order")
    var
        ManufacturingSetup: Record "Manufacturing Setup";
        ProdOrderComponent: Record "Prod. Order Component";
        UnFinishedComponentsTxt: Label 'Production Order %1 has unfinished components, Status can''t be changed to finished.', Comment = '%1 PO number';
    begin
        ManufacturingSetup.Get();
        if not ManufacturingSetup."COL NoFinishRemainQty" then
            exit;

        ProdOrderComponent.SetAutoCalcFields("Pick Qty. (Base)");
        ProdOrderComponent.SetRange(Status, ProductionOrder.Status);
        ProdOrderComponent.SetRange("Prod. Order No.", ProductionOrder."No.");
        ProdOrderComponent.SetFilter("Remaining Quantity", '<> 0');
        if not ProdOrderComponent.IsEmpty() then
            if ProdOrderComponent.FindSet() then
                repeat
                    ProdOrderComponent.TestField("Pick Qty. (Base)", 0);
                    // BC27+ behavior change: Manual flushing no longer requires picking.
                    // Use "Pick + Manual" if picking is required before manual consumption.
                    // This check may need review when feature key 'Manual Flushing Method without requiring pick' is enabled.
#pragma warning disable AL0432
                    if ProdOrderComponent."Flushing Method" in [Enum::"Flushing Method"::Manual, Enum::"Flushing Method"::"Pick + Manual"] then
#pragma warning restore AL0432
                        Error(UnFinishedComponentsTxt, ProductionOrder."No.");
                until (ProdOrderComponent.Next() = 0);
    end;

    local procedure InitRoutingLinkCode(WhseWkshTemplate: Code[10]; WhseWkshName: Code[10]; LocationCode: Code[10])
    var
        WhseWorksheetLine: Record "Whse. Worksheet Line";
        ProdOrderComponent: Record "Prod. Order Component";
    begin
        WhseWorksheetLine.SetRange("Worksheet Template Name", WhseWkshTemplate);
        WhseWorksheetLine.SetRange("Name", WhseWkshName);
        WhseWorksheetLine.SetRange("Location Code", LocationCode);
        WhseWorksheetLine.SetRange("Source Document", WhseWorksheetLine."Source Document"::"Prod. Consumption");
        if WhseWorksheetLine.FindSet() then
            repeat
                if WhseWorksheetLine."COL Routing Link Code" = '' then begin
                    ProdOrderComponent.SetRange(Status, ProdOrderComponent.Status::Released);
                    ProdOrderComponent.SetRange("Prod. Order No.", WhseWorksheetLine."Source No.");
                    ProdOrderComponent.SetRange("Prod. Order Line No.", WhseWorksheetLine."Source Line No.");
                    ProdOrderComponent.SetRange("Line No.", WhseWorksheetLine."Source Subline No.");
                    if ProdOrderComponent.FindFirst() then begin
                        WhseWorksheetLine."COL Routing Link Code" := ProdOrderComponent."Routing Link Code";
                        WhseWorksheetLine.Modify();
                    end;
                end;
            until WhseWorksheetLine.Next() = 0;
    end;
}