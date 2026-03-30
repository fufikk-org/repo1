namespace Weibel.Manufacturing.Order;

using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.Routing;
using Microsoft.Manufacturing.WorkCenter;
using Weibel.Manufacturing.Archive;
using Microsoft.Inventory.Requisition;

codeunit 70228 "COL Prod. Order Sub."
{
    [EventSubscriber(ObjectType::Page, Page::"Released Production Order", 'OnDeleteRecordEvent', '', false, false)]
    local procedure OnDeleteRecordEvent_RelPO(var Rec: Record "Production Order")
    var
        ProdWarnings: Codeunit "COL Prod. Warnings";
    begin
        ProdWarnings.WarningCheck(Rec);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Firm Planned Prod. Order", 'OnDeleteRecordEvent', '', false, false)]
    local procedure OnDeleteRecordEvent_FirmPO(var Rec: Record "Production Order")
    var
        ProdWarnings: Codeunit "COL Prod. Warnings";
    begin
        ProdWarnings.WarningCheck(Rec);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", 'OnRunOnAfterChangeStatusFormRun', '', false, false)]
    local procedure OnRunOnAfterChangeStatusFormRun(var ProductionOrder: Record "Production Order")
    var
        ProdArchiveManagement: Codeunit "COL Prod. Archive Management";
    begin
        if ProductionOrder.Status in [ProductionOrder.Status::Planned, ProductionOrder.Status::"Firm Planned", ProductionOrder.Status::Released] then
            ProdArchiveManagement.StorePurchDocument(ProductionOrder, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Mfg. Carry Out Action", 'OnAfterInsertProdOrder', '', false, false)]
    local procedure OnAfterInsertProdOrder(var ProductionOrder: Record "Production Order"; ProdOrderChoice: Integer; var RequisitionLine: Record "Requisition Line")
    var
        ProdArchiveManagement: Codeunit "COL Prod. Archive Management";
    begin
        ProdArchiveManagement.StorePurchDocument(ProductionOrder, false);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Production Order", 'OnAfterValidateEvent', 'Source No.', false, false)]
    local procedure OnAfterValidateEvent_SourceNo(var Rec: Record "Production Order"; var xRec: Record "Production Order")
    begin
        if Rec."Source Type" <> Rec."Source Type"::Item then
            exit;

        SetTrackingInfo(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Production Order", 'OnAfterValidateEvent', 'Source Type', false, false)]
    local procedure OnAfterValidateEvent_SourceType(var Rec: Record "Production Order"; var xRec: Record "Production Order")
    begin
        if Rec."Source Type" <> Rec."Source Type"::Item then
            Rec."COL Item Tracked" := false;
    end;

    local procedure SetTrackingInfo(var Rec: Record "Production Order"): Boolean
    var
        Item: Record Item;
        TrackingExist: Boolean;
    begin
        if Rec."Source Type" <> Rec."Source Type"::Item then
            exit(false);

        TrackingExist := false;
        if Item.Get(Rec."Source No.") then
            if Item."Item Tracking Code" <> '' then
                TrackingExist := true
            else
                TrackingExist := false;

        Rec."COL Item Tracked" := TrackingExist;
        exit(true);
    end;

    procedure UpdateAllProductionOrderTrackingInfo()
    var
        Rec: Record "Production Order";
    begin
        if Rec.FindSet() then
            repeat

                if SetTrackingInfo(Rec) then
                    Rec.Modify();

            until Rec.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Routing Line", 'OnAfterWorkCenterTransferFields', '', false, false)]
    local procedure OnAfterWorkCenterTransferFields(var RoutingLine: Record "Routing Line"; WorkCenter: Record "Work Center")
    begin
        RoutingLine."Setup Time" := WorkCenter."COL Setup Time";
        RoutingLine."Wait Time" := WorkCenter."COL Wait Time";
        RoutingLine."Move Time" := WorkCenter."COL Move Time";
        RoutingLine."Run Time" := WorkCenter."COL Run Time";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Routing Line", 'OnAfterValidateNo', '', false, false)]
    local procedure OnAfterValidateNo(var ProdOrderRoutingLine: Record "Prod. Order Routing Line"; var xProdOrderRoutingLine: Record "Prod. Order Routing Line"; var ProdOrderLine: Record "Prod. Order Line")
    var
        WorkCenter: Record "Work Center";
    begin
        if ProdOrderRoutingLine.Type <> ProdOrderRoutingLine.Type::"Work Center" then
            exit;

        if xProdOrderRoutingLine."No." <> '' then
            exit;

        WorkCenter.Get(ProdOrderRoutingLine."No.");
        ProdOrderRoutingLine."Setup Time" := WorkCenter."COL Setup Time";
        ProdOrderRoutingLine."Wait Time" := WorkCenter."COL Wait Time";
        ProdOrderRoutingLine."Move Time" := WorkCenter."COL Move Time";
        ProdOrderRoutingLine."Run Time" := WorkCenter."COL Run Time";
    end;
}
