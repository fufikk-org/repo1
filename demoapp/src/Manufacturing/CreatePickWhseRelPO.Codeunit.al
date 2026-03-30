namespace Weibel.Warehouse.Activity;

using Microsoft.Warehouse.Activity;
using Microsoft.Warehouse.Structure;

using Microsoft.Inventory.Item;
using Microsoft.Warehouse.Setup;
using Microsoft.Inventory.Location;

codeunit 70188 "COL Create Pick Whse. Rel. PO"
{
    EventSubscriberInstance = Manual;

    var
        CreatePickZoneCode: Code[20];
        PerZone: Boolean;

    procedure SetPerZone(NewPerZone: Boolean)
    begin
        PerZone := NewPerZone;
    end;

    internal procedure SetZoneFilter(NewCreatePickZoneCode: Code[10])
    begin
        CreatePickZoneCode := NewCreatePickZoneCode;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Pick", OnAfterSetParameters, '', false, false)]
    local procedure "Create Pick_OnAfterSetParameters"(var CreatePickParameters: Record "Create Pick Parameters" temporary)
    begin
        if CreatePickParameters."Per Zone" <> PerZone then begin
            CreatePickParameters."Per Bin" := not PerZone;
            CreatePickParameters."Per Zone" := PerZone;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Bin Content", OnAfterBinContentExists, '', false, false)]
    local procedure "Bin Content_OnAfterBinContentExists"(var BinContent: Record "Bin Content")
    begin
        if CreatePickZoneCode = '' then
            exit;

        BinContent.SetRange("Zone Code", CreatePickZoneCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Pick", OnFindBWPickBinOnBeforeFromBinContentFindSet, '', false, false)]
    local procedure "Create Pick_OnFindBWPickBinOnBeforeFromBinContentFindSet"(var FromBinContent: Record "Bin Content"; SourceType: Integer; var TotalQtyPickedBase: Decimal; var TotalQtyToPickBase: Decimal; var IsHandled: Boolean; SourceSubType: Option; SourceNo: Code[20]; SourceLineNo: Integer; SourceSubLineNo: Integer; LocationCode: Code[10]; ItemNo: Code[20]; VariantCode: Code[10]; ToBinCode: Code[20])
    begin
        if CreatePickZoneCode <> '' then
            FromBinContent.SetRange("Zone Code", CreatePickZoneCode);

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Pick", OnCalcAvailQtyOnFindBWPickBin, '', false, false)]
    local procedure OnCalcAvailQtyOnFindBWPickBin(ItemNo: Code[20]; VariantCode: Code[10]; SNRequired: Boolean; LNRequired: Boolean; WhseItemTrkgExists: Boolean; SerialNo: Code[50]; LotNo: Code[50]; LocationCode: Code[10]; BinCode: Code[20]; SourceType: Integer; SourceSubType: Integer; SourceNo: Code[20]; SourceLineNo: Integer; SourceSubLineNo: Integer; TotalQtyToPickBase: Decimal; var QtyAvailableBase: Decimal)
    begin
        if IsZoneExcluded(LocationCode, BinCode, ItemNo, VariantCode, CreatePickZoneCode) then
            QtyAvailableBase := 0;
    end;

    procedure IsZoneExcluded(LocationCode: Code[10]; BinCode: Code[20]; ItemNo: Code[20]; VariantCode: Code[10]; PickZoneRequested: Code[20]): Boolean
    var
        Zone: Record Zone;
        FromBinContent: Record "Bin Content";
    begin
        FromBinContent.SetRange("Location Code", LocationCode);
        FromBinContent.SetRange("Bin Code", BinCode);
        FromBinContent.SetRange("Item No.", ItemNo);
        FromBinContent.SetRange("Variant Code", VariantCode);
        if FromBinContent.FindFirst() then begin
            if (PickZoneRequested <> '') and (FromBinContent."Zone Code" = PickZoneRequested) then // if the requested zone on request page is the same as the zone on bincontent, then it's not excluded
                exit(false);
            if Zone.Get(LocationCode, FromBinContent."Zone Code") then
                exit(Zone."COL Exclude Zone From Fil.");
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Pick", OnBeforeCreateWhseDocumentOnBeforeFindTempActivityLine, '', false, false)]
    local procedure OnBeforeCreateWhseDocumentOnBeforeFindTempActivityLine(var TempWarehouseActivLine: Record "Warehouse Activity Line" temporary; WhseSource: Option "Pick Worksheet",Shipment,"Movement Worksheet","Internal Pick",Production,Assembly; var IsHandled: Boolean; IsMovementWorksheet: Boolean; var FirstWhseDocNo: Code[20]; var LastWhseDocNo: Code[20]; CreatePickParameters: Record "Create Pick Parameters"; CalledFromWksh: Boolean)
    begin
        DeleteExcludedPics(CreatePickZoneCode, TempWarehouseActivLine, true);  // both must work as from pick worksheet
    end;

    procedure DeleteExcludedPics(CreatePickZoneCodeVar: Code[20]; var TempWarehouseActivLine: Record "Warehouse Activity Line" temporary; fromWorkSheet: Boolean)
    var
        TempWarehouseActivLine2: Record "Warehouse Activity Line" temporary;
        BinContent: Record "Bin Content";
        BinContent2: Record "Bin Content";
        Zone: Record Zone;
        CreatePicSM: Codeunit "COL Create Pic SM";
        NothingToPostLbl: Label 'Nothing to handle on filtered Bin.';
        PickZoneDefault: Boolean;
        ZoneAllowed: Boolean;
        ExcludeZone: Boolean;
        NoDefault: Boolean;
        DoCreate: Boolean;
        ShowError: Boolean;
    begin

        TempWarehouseActivLine.Reset();
        if TempWarehouseActivLine.FindSet() then
            repeat

                DoCreate := true;
                ZoneAllowed := false;
                PickZoneDefault := false;
                NoDefault := false;
                if TempWarehouseActivLine."Action Type" = TempWarehouseActivLine."Action Type"::Take then
                    if (CreatePickZoneCodeVar <> '') then begin

                        BinContent.SetRange("Zone Code", CreatePickZoneCodeVar);
                        BinContent.SetRange("Item No.", TempWarehouseActivLine."Item No.");
                        BinContent.SetRange("Variant Code", TempWarehouseActivLine."Variant Code");
                        if BinContent.FindFirst() then
                            if Zone.Get(BinContent."Location Code", CreatePickZoneCodeVar) then
                                ZoneAllowed := Zone."COL Exclude Zone From Fil.";

                        BinContent.Reset();
                        BinContent.SetRange("Zone Code", CreatePickZoneCodeVar);
                        BinContent.SetRange("Item No.", TempWarehouseActivLine."Item No.");
                        BinContent.SetRange("Variant Code", TempWarehouseActivLine."Variant Code");
                        BinContent.SetRange(Default, true);
                        if not BinContent.IsEmpty() then
                            PickZoneDefault := true;

                        BinContent.Reset();
                        BinContent.SetFilter("Zone Code", '<>%1', CreatePickZoneCodeVar);
                        BinContent.SetRange("Item No.", TempWarehouseActivLine."Item No.");
                        BinContent.SetRange("Variant Code", TempWarehouseActivLine."Variant Code");
                        BinContent.SetRange(Default, true);
                        if BinContent.IsEmpty() then
                            NoDefault := true;

                        if (not NoDefault) and (not ZoneAllowed) then
                            DoCreate := false;

                        if NoDefault or (PickZoneDefault and ZoneAllowed) then
                            DoCreate := true
                        else
                            DoCreate := false;
                    end
                    else begin

                        BinContent.SetRange("Item No.", TempWarehouseActivLine."Item No.");
                        BinContent.SetRange("Variant Code", TempWarehouseActivLine."Variant Code");
                        BinContent.SetRange(Default, true);
                        if BinContent.FindFirst() then begin

                            BinContent2.Reset();
                            BinContent2.SetRange("Zone Code", BinContent."Zone Code");
                            BinContent2.SetRange("Item No.", TempWarehouseActivLine."Item No.");
                            BinContent2.SetRange("Variant Code", TempWarehouseActivLine."Variant Code");
                            if BinContent2.FindFirst() then
                                if Zone.Get(BinContent2."Location Code", BinContent."Zone Code") then
                                    ZoneAllowed := Zone."COL Exclude Zone From Fil.";

                            if ZoneAllowed then
                                DoCreate := false
                            else
                                DoCreate := true;
                        end;
                    end;

                if not fromWorkSheet then
                    if TempWarehouseActivLine."Action Type" = TempWarehouseActivLine."Action Type"::Take then begin

                        ExcludeZone := false;
                        BinContent.Reset();
                        BinContent.SetRange("Location Code", TempWarehouseActivLine."Location Code");
                        BinContent.SetRange("Bin Code", TempWarehouseActivLine."Bin Code");
                        BinContent.SetRange("Item No.", TempWarehouseActivLine."Item No.");
                        BinContent.SetRange("Variant Code", TempWarehouseActivLine."Variant Code");
                        BinContent.SetRange("Unit of Measure Code", TempWarehouseActivLine."Unit of Measure Code");
                        if BinContent.FindFirst() then
                            if Zone.Get(BinContent."Location Code", BinContent."Zone Code") then
                                ExcludeZone := Zone."COL Exclude Zone From Fil.";

                        if ExcludeZone then
                            DoCreate := false;

                        if ExcludeZone then
                            if CreatePickZoneCodeVar <> '' then
                                if BinContent."Zone Code" = CreatePickZoneCodeVar then
                                    DoCreate := true;
                    end;

                if TempWarehouseActivLine."Action Type" = TempWarehouseActivLine."Action Type"::Place then begin
                    DoCreate := false;
                    TempWarehouseActivLine2.Reset();
                    TempWarehouseActivLine2.SetRange("Source Line No.", TempWarehouseActivLine."Source Line No.");
                    if not TempWarehouseActivLine2.IsEmpty() then
                        DoCreate := true;
                end;

                if DoCreate then begin
                    TempWarehouseActivLine2.Reset();
                    TempWarehouseActivLine2.TransferFields(TempWarehouseActivLine);
                    TempWarehouseActivLine2.Insert();
                end
                else
                    ShowError := true;

            until TempWarehouseActivLine.Next() = 0;

        TempWarehouseActivLine.Reset();
        TempWarehouseActivLine.DeleteAll();

        if TempWarehouseActivLine2.FindFirst() then
            repeat
                TempWarehouseActivLine.TransferFields(TempWarehouseActivLine2);
                TempWarehouseActivLine.Insert();
            until TempWarehouseActivLine2.Next() = 0;

        if ShowError then
            if GuiAllowed() then
                if not CreatePicSM.IsErrorDisplayed() then begin //single instance CU to avoid multiple messages
                    CreatePicSM.SetErrorDisplayed(true);
                    Message(NothingToPostLbl)
                end;

    end;
}