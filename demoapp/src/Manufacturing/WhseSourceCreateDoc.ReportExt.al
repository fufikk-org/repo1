namespace Weibel.Manufacturing.Processing;

using Microsoft.Warehouse.Request;
using Microsoft.Warehouse.Structure;
using Microsoft.Inventory.Location;
using Microsoft.Manufacturing.Routing;
using Microsoft.Manufacturing.Document;
using System.Text;
using Microsoft.Manufacturing.WorkCenter;
using Weibel.Manufacturing.Routing.Handler;
using Weibel.Warehouse.Request;
using Weibel.Warehouse.Activity;

reportextension 70101 "COL Whse.-Source - Create Doc." extends "Whse.-Source - Create Document"
{
    dataset
    {
        modify("Prod. Order Component")
        {
            trigger OnBeforePreDataItem()
            begin
                COLCreatePicSM.SetErrorDisplayed(false);
                BindSubscription(COLCreatePickWhseRelPO);
                COLCreatePickWhseRelPO.SetPerZone(COLPerZone);
                // requirement has changed, it should allow to select zones FROM which picks are created instead of zones TO which pick is created
                COLCreatePickWhseRelPO.SetZoneFilter(COLPickZoneCodeFilter);
            end;

            trigger OnAfterPreDataItem()
            begin
                SetProdOrderComponentCustomFilter();
                SetProdOrderComponentLocationFilter();
                // requirement has changed, it should allow to select zones FROM which picks are created instead of zones TO which pick is created
                // if COLPickZoneCodeFilter <> '' then begin
                //     BindSubscription(COLWhseSourceCreateDocEvents);
                //     COLWhseSourceCreateDocEvents.SetZoneCode(COLPickZoneCodeFilter);
                // end;
            end;

            trigger OnAfterPostDataItem()
            begin
                //UnbindSubscription(COLCreatePickWhseRelPO);
                // requirement has changed, it should allow to select zones FROM which picks are created instead of zones TO which pick is created
                // if COLPickZoneCodeFilter <> '' then
                //     UnbindSubscription(COLWhseSourceCreateDocEvents);
            end;

        }
    }

    requestpage
    {
        layout
        {
            addafter("Reserved From Stock")
            {
                field("COL Work Center Code"; COLWorkCenterCode)
                {
                    Caption = 'Work Center Code';
                    ToolTip = 'Specifies the Work Center Code to be used for the document creation.';
                    TableRelation = "Work Center";
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        LookupWorkCenters();
                    end;

                    trigger OnValidate()
                    begin
                        ValidateWorkCenterCode(COLWorkCenterCode);
                    end;
                }
                field("COL Routing Link Code"; COLRoutingLinkCode)
                {
                    Caption = 'Routing Link Code';
                    ToolTip = 'Specifies the Routing Link Code to be used for the document creation.';
                    TableRelation = "Routing Link";
                    ApplicationArea = All;
                }
                field("COL Pick Location Code Filter"; COLPickLocationCodeFilter)
                {
                    Caption = 'Pick Location Code Filter';
                    ToolTip = 'Specifies the Location Code to be used for the document creation.';
                    LookupPageId = "Location List";
                    ApplicationArea = All;
                    TableRelation = Location where("Use As In-Transit" = filter(false));

                    trigger OnValidate()
                    begin
                        COLPickZoneCodeFilter := '';
                    end;
                }
                field("COL Pick Zone Code Filter"; COLPickZoneCodeFilter)
                {
                    Caption = 'Pick Zone Code Filter';
                    ToolTip = 'Specifies the Zone within selected Location to be used for the document creation.';
                    ApplicationArea = All;
                    Enabled = COLPickLocationCodeFilter <> '';

                    // requirement has changed, it should allow to select zones FROM which picks are created instead of zones TO which pick is created
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Zone: Record Zone;
                    begin
                        Zone.SetRange("Location Code", COLPickLocationCodeFilter);
                        if Page.RunModal(0, Zone) = Action::LookupOK then
                            COLPickZoneCodeFilter := Zone.Code;
                    end;

                    trigger OnValidate()
                    var
                        Zone: Record Zone;
                    begin
                        if COLPickZoneCodeFilter <> '' then
                            if COLPickLocationCodeFilter <> '' then
                                Zone.Get(COLPickLocationCodeFilter, COLPickZoneCodeFilter);
                    end;
                }
                field("COL Pick Per Zone"; COLPerZone)
                {
                    Caption = 'Per Zone';
                    ToolTip = 'Specifies if the picks should be created per zone.';
                    ApplicationArea = All;
                    Enabled = COLPerZoneEnabled;
                }
            }
        }
    }

    trigger OnPostReport()
    begin
        UnbindSubscription(COLCreatePickWhseRelPO);
    end;

    protected var
        COLProdOrderHeader: Record "Production Order";
        COLCreatePickHandler: Codeunit "COL Create Pick Handler";
        //COLWhseSourceCreateDocEvents: Codeunit "COL WhseSourceCreateDoc Events";
        COLCreatePickWhseRelPO: Codeunit "COL Create Pick Whse. Rel. PO";
        COLCreatePicSM: Codeunit "COL Create Pic SM";
        COLPickLocationCodeFilter: Code[10];
        COLPickZoneCodeFilter: Code[10];
        COLRoutingLinkCode: Text;
        COLWorkCenterCode: Text;
        COLPerZone, COLPerZoneEnabled : Boolean;

    procedure COLSetWorkCenterFilter(var ProductionHeader: Record "Production Order")
    begin
        COLProdOrderHeader.Copy(ProductionHeader);
        COLPickLocationCodeFilter := ProductionHeader."Location Code";
    end;

    local procedure SetProdOrderComponentCustomFilter()
    var
        ProductionOrder: Record "Production Order";
        RoutingLinkFilter: text;
        ProdOrderNo: Code[20];
    begin
        if (COLRoutingLinkCode = '') and (COLWorkCenterCode = '') then
            exit;

        "Prod. Order Component".SetRange("Completely Picked", false);

        if COLRoutingLinkCode <> '' then
            "Prod. Order Component".SetRange("Routing Link Code", COLRoutingLinkCode)
        else begin
            ProdOrderNo := CopyStr("Prod. Order Component".GetFilter("Prod. Order No."), 1, MaxStrLen("Prod. Order Component"."Prod. Order No."));
            ProductionOrder.Get(ProductionOrder.Status::Released, ProdOrderNo);
            RoutingLinkFilter := COLCreatePickHandler.GetRoutCodes(COLWorkCenterCode, ProductionOrder."Routing No.");
            "Prod. Order Component".SetFilter("Routing Link Code", RoutingLinkFilter);
        end;
    end;

    local procedure LookupWorkCenters()
    var
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        TempWorkCenter: Record "Work Center" temporary;
        WorkCenter, WorkCenter2 : Record "Work Center";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
        WorkCenterLookup: Page "COL Work Center Lookup";
        RecRef: RecordRef;
    begin
        ProdOrderRoutingLine.SetLoadFields(Type, "No.");
        ProdOrderRoutingLine.SetRange(Status, COLProdOrderHeader.Status);
        ProdOrderRoutingLine.SetRange("Prod. Order No.", COLProdOrderHeader."No.");
        ProdOrderRoutingLine.SetRange(Type, ProdOrderRoutingLine.Type::"Work Center");
        if ProdOrderRoutingLine.FindSet() then
            repeat
                if WorkCenter.Get(ProdOrderRoutingLine."No.") then
                    if not TempWorkCenter.Get(WorkCenter."No.") then begin
                        TempWorkCenter.TransferFields(WorkCenter);
                        TempWorkCenter.Insert();
                    end;
            until ProdOrderRoutingLine.Next() = 0;

        WorkCenterLookup.COLSetTable(TempWorkCenter);
        WorkCenterLookup.LookupMode(true);
        if WorkCenterLookup.RunModal() = Action::LookupOK then begin
            WorkCenterLookup.SetSelectionFilter(WorkCenter2);
            RecRef.GetTable(WorkCenter2);
            COLWorkCenterCode := SelectionFilterManagement.GetSelectionFilter(RecRef, WorkCenter2.FieldNo("No."))
        end;
    end;

    local procedure ValidateWorkCenterCode(WorkCenterCode: Text)
    var
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        WorkCenterNotInRoutingErr: Label 'Work Center %1 is not used in the Production Order Routing', Comment = '%1 Work Center Code';
    begin
        if WorkCenterCode = '' then
            exit;

        ProdOrderRoutingLine.SetLoadFields(Type, "No.");
        ProdOrderRoutingLine.SetRange(Status, COLProdOrderHeader.Status);
        ProdOrderRoutingLine.SetRange("Prod. Order No.", COLProdOrderHeader."No.");
        ProdOrderRoutingLine.SetRange(Type, ProdOrderRoutingLine.Type::"Work Center");
        ProdOrderRoutingLine.SetFilter("No.", WorkCenterCode);
        if ProdOrderRoutingLine.IsEmpty() then
            Error(WorkCenterNotInRoutingErr, WorkCenterCode)
    end;

    local procedure SetProdOrderComponentLocationFilter()
    begin
        if COLPickLocationCodeFilter <> '' then
            "Prod. Order Component".SetRange("Location Code", COLPickLocationCodeFilter);
    end;

    // requirement has changed, it should allow to select zones FROM which picks are created instead of zones TO which pick is created
    // local procedure GetZoneListFromComponentLines(): List of [Code[10]]
    // var
    //     ProdOrderComponent: Record "Prod. Order Component";
    //     Bin: Record Bin;
    //     ZoneList: List of [Code[10]];
    // begin
    //     Clear(ZoneList);
    //     if COLProdOrderHeader."No." = '' then
    //         exit(ZoneList);

    //     ProdOrderComponent.SetRange(Status, COLProdOrderHeader.Status);
    //     ProdOrderComponent.SetRange("Prod. Order No.", COLProdOrderHeader."No.");
    //     ProdOrderComponent.SetRange("Location Code", COLPickLocationCodeFilter);
    //     ProdOrderComponent.SetFilter("Bin Code", '<>%1', '');
    //     ProdOrderComponent.SetLoadFields("Bin Code", "Location Code");
    //     ProdOrderComponent.ReadIsolation := IsolationLevel::ReadUncommitted;
    //     if ProdOrderComponent.FindSet() then
    //         repeat
    //             if Bin.Get(ProdOrderComponent."Location Code", ProdOrderComponent."Bin Code") then
    //                 if Bin."Zone Code" <> '' then
    //                     if not ZoneList.Contains(Bin."Zone Code") then
    //                         ZoneList.Add(Bin."Zone Code");
    //         until ProdOrderComponent.Next() = 0;
    //     exit(ZoneList);
    // end;

    // requirement has changed, it should allow to select zones FROM which picks are created instead of zones TO which pick is created
    // local procedure GetZonesFilterFromComponentLines(): Text
    // var
    //     ZoneCode: Code[10];
    //     ZoneFilterBuilder: TextBuilder;
    //     IsFirst: Boolean;
    //     ZoneList: List of [Code[10]];
    // begin
    //     ZoneList := GetZoneListFromComponentLines();
    //     if ZoneList.Count() = 0 then
    //         exit('');

    //     Clear(ZoneFilterBuilder);
    //     IsFirst := true;
    //     foreach ZoneCode in ZoneList do begin
    //         if not IsFirst then
    //             ZoneFilterBuilder.Append('|');
    //         ZoneFilterBuilder.Append(ZoneCode);
    //         IsFirst := false;
    //     end;
    //     exit(ZoneFilterBuilder.ToText())
    // end;

    procedure COLSetPerZoneEnabled()
    begin
        COLPerZoneEnabled := true;
    end;
}