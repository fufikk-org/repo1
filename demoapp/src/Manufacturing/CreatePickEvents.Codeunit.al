namespace Weibel.Manufacturing.Routing.Handler;

using Microsoft.Warehouse.Activity;
using Microsoft.Warehouse.Worksheet;
using Microsoft.Warehouse.Structure;
using Weibel.Warehouse.Activity;

// this functionality is used when pick is created from Pick-Worksheet with COL custom action that looks like the standard one
codeunit 70172 "COL Create Pick Events"
{
    EventSubscriberInstance = Manual;

    var
        CreatePickLocationCode: Code[10];
        CreatePickZoneCode: Code[20];

    [EventSubscriber(ObjectType::Report, Report::"Create Pick", OnAfterSetWkshPickLine, '', false, false)]
    local procedure "Create Pick_OnAfterSetWkshPickLine"(PickWhseWkshLine: Record "Whse. Worksheet Line"; var SortPick: Option)
    begin
        CreatePickLocationCode := PickWhseWkshLine."Location Code";
    end;

    [EventSubscriber(ObjectType::Report, Report::"Create Pick", COLOnAfterOpenRequestPage, '', false, false)]
    local procedure "Create Pick_OnAfterOpenRequestPage"(var Sender: Report "Create Pick")
    begin
        Sender.COLSetLocationCode(CreatePickLocationCode);
    end;

    [EventSubscriber(ObjectType::Report, Report::"Create Pick", COLOnBeforePreDataItem, '', false, false)]
    local procedure "Create Pick_COLOnBeforePreDataItem"(var Sender: Report "Create Pick")
    begin
        CreatePickZoneCode := Sender.COLGetZoneFilterCode();
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
        if CreatePickZoneCode = '' then
            exit;

        FromBinContent.SetRange("Zone Code", CreatePickZoneCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Pick", OnCalcAvailQtyOnFindBWPickBin, '', false, false)]
    local procedure OnCalcAvailQtyOnFindBWPickBin(ItemNo: Code[20]; VariantCode: Code[10]; SNRequired: Boolean; LNRequired: Boolean; WhseItemTrkgExists: Boolean; SerialNo: Code[50]; LotNo: Code[50]; LocationCode: Code[10]; BinCode: Code[20]; SourceType: Integer; SourceSubType: Integer; SourceNo: Code[20]; SourceLineNo: Integer; SourceSubLineNo: Integer; TotalQtyToPickBase: Decimal; var QtyAvailableBase: Decimal)
    var
        CreatePickWhseRelPO: Codeunit "COL Create Pick Whse. Rel. PO";
    begin
        if CreatePickWhseRelPO.IsZoneExcluded(LocationCode, BinCode, ItemNo, VariantCode, CreatePickZoneCode) then
            QtyAvailableBase := 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Pick", OnBeforeCreateWhseDocumentOnBeforeFindTempActivityLine, '', false, false)]
    local procedure OnBeforeCreateWhseDocumentOnBeforeFindTempActivityLine(var TempWarehouseActivLine: Record "Warehouse Activity Line" temporary; WhseSource: Option "Pick Worksheet",Shipment,"Movement Worksheet","Internal Pick",Production,Assembly; var IsHandled: Boolean; IsMovementWorksheet: Boolean; var FirstWhseDocNo: Code[20]; var LastWhseDocNo: Code[20]; CreatePickParameters: Record "Create Pick Parameters"; CalledFromWksh: Boolean)
    var
        CreatePickWhseRelPO: Codeunit "COL Create Pick Whse. Rel. PO";
    begin
        CreatePickWhseRelPO.DeleteExcludedPics(CreatePickZoneCode, TempWarehouseActivLine, true); // both must work as from pick worksheet
    end;

}