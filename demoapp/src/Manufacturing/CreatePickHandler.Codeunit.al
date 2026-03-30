namespace Weibel.Manufacturing.Routing.Handler;

using Microsoft.Warehouse.Activity;
using Microsoft.Manufacturing.Routing;
using Microsoft.Warehouse.Request;
using Microsoft.Manufacturing.Document;
using Microsoft.Warehouse.Worksheet;

codeunit 70102 "COL Create Pick Handler"
{
    [EventSubscriber(ObjectType::Report, Report::"Create Invt Put-away/Pick/Mvmt", OnAfterInitWhseActivHeader, '', false, false)]
    local procedure "Create Invt Put-away/Pick/Mvmt_OnAfterInitWhseActivHeader"(var WarehouseActivityHeader: Record "Warehouse Activity Header"; var WarehouseRequest: Record "Warehouse Request")
    begin
        TransferCustomCode(WarehouseActivityHeader, WarehouseRequest);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Mfg. Create Invt.Pick/Movement", OnBeforeFindProdOrderComp, '', false, false)]
    local procedure "Mfg. Create Invt.Pick/Movement_OnBeforeFindProdOrderComp"(var ProdOrderComp: Record "Prod. Order Component"; ProductionOrder: Record "Production Order"; WarehouseActivityHeader: Record "Warehouse Activity Header")
    begin
        SetProdOrderCompRoutingLinkFilter(ProdOrderComp, ProductionOrder, WarehouseActivityHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Warehouse Mgt.", OnAfterFromProdOrderCompLineCreateWhseWkshLine, '', false, false)]
    local procedure "Prod. Order Warehouse Mgt._OnAfterFromProdOrderCompLineCreateWhseWkshLine"(var WhseWorksheetLine: Record "Whse. Worksheet Line"; ProdOrderComponent: Record "Prod. Order Component"; LocationCode: Code[10]; ToBinCode: Code[20])
    begin
        WhseWorksheetLine."COL Routing Link Code" := ProdOrderComponent."Routing Link Code";
    end;


    local procedure TransferCustomCode(var WarehouseActivityHeader: Record "Warehouse Activity Header"; var WarehouseRequest: Record "Warehouse Request")
    begin
        if WarehouseActivityHeader.Type <> WarehouseActivityHeader.Type::"Invt. Pick" then
            exit;

        // Transfer the Routing Link Code filter from the Warehouse Request to the Warehouse Activity Header when the Warehouse Activity Header is created.
        if WarehouseRequest."COL Routing Link Code" <> '' then
            WarehouseActivityHeader."COL Routing Link Code" := WarehouseRequest."COL Routing Link Code";

        // Transfer the work center Code filter from the Warehouse Request to the Warehouse Activity Header when the Warehouse Activity Header is created.
        if WarehouseRequest."COL Work Center Code" <> '' then
            WarehouseActivityHeader."COL Work Center Code" := WarehouseRequest."COL Work Center Code";
    end;

    local procedure SetProdOrderCompRoutingLinkFilter(var ProdOrderComp: Record "Prod. Order Component"; ProductionOrder: Record "Production Order"; var WarehouseActivityHeader: Record "Warehouse Activity Header")
    var
        RoutingLinkFilter: Text;
    begin
        if WarehouseActivityHeader.Type <> WarehouseActivityHeader.Type::"Invt. Pick" then
            exit;

        // Filter the production order components by the Custom Filters Code from the Warehouse Activity Header.
        if (WarehouseActivityHeader."COL Routing Link Code" = '') and (WarehouseActivityHeader."COL Work Center Code" = '') then
            exit;

        if WarehouseActivityHeader."COL Routing Link Code" <> '' then begin
            RoutingLinkFilter := WarehouseActivityHeader."COL Routing Link Code" + '|'''''; // Filter on the specific and empty Routing Link Code.
            ProdOrderComp.SetRange("Completely Picked", false);
            ProdOrderComp.SetFilter("Routing Link Code", RoutingLinkFilter);
        end
        else begin
            RoutingLinkFilter := GetRoutCodes(WarehouseActivityHeader."COL Work Center Code", ProductionOrder."Routing No.");
            ProdOrderComp.SetRange("Completely Picked", false);
            ProdOrderComp.SetFilter("Routing Link Code", RoutingLinkFilter);
        end;

    end;

    procedure GetRoutCodes(WorkCenterCode: Text; RoutingNo: Code[20]): Text
    var
        RoutingLine: Record "Routing Line";
        RetText: Text;
    begin
        RoutingLine.SetRange("Routing No.", RoutingNo);
        RoutingLine.SetRange(Type, RoutingLine.Type::"Work Center");
        RoutingLine.SetFilter("No.", WorkCenterCode);
        if RoutingLine.FindSet() then
            repeat
                if RetText <> '' then
                    RetText := RetText + '|';

                RetText := RetText + RoutingLine."Routing Link Code";
            until RoutingLine.Next() = 0;

        if RetText = '' then
            RetText := 'XYX'; // if there is no Work center or linked routing Lines code then no component selected 

        exit(RetText);
    end;

    procedure CheckRoutCodes(WorkCenterCode: Text; RoutingLinkCode: Code[20]; RoutingNo: Code[20]): Boolean
    var
        RoutingLine: Record "Routing Line";
    begin
        RoutingLine.SetRange("Routing No.", RoutingNo);
        RoutingLine.SetRange(Type, RoutingLine.Type::"Work Center");
        RoutingLine.SetFilter("No.", WorkCenterCode);
        RoutingLine.SetRange("Routing Link Code", RoutingLinkCode);
        if not RoutingLine.IsEmpty() then
            exit(true);

        exit(false);
    end;

}