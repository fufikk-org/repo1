namespace Weibel.Warehouse.Request;

using Microsoft.Warehouse.Request;
using Microsoft.Manufacturing.Document;
using Microsoft.Warehouse.Structure;

codeunit 70171 "COL WhseSourceCreateDoc Events"
{
    EventSubscriberInstance = Manual;

    ObsoleteState = Pending;
    ObsoleteReason = 'Requirement 6763 has changed, it should allow to select zones FROM which picks are created instead of zones TO which pick is created.';

    var
        ZoneCode: Code[20];

    [EventSubscriber(ObjectType::Report, Report::"Whse.-Source - Create Document", OnAfterGetRecordProdOrderComponent, '', false, false)]
    local procedure "Whse.-Source - Create Document_OnAfterGetRecordProdOrderComponent"(var ProdOrderComponent: Record "Prod. Order Component"; var SkipProdOrderComp: Boolean)
    var
        Bin: Record Bin;
    begin
        if ZoneCode = '' then
            exit;

        Bin.ReadIsolation := IsolationLevel::ReadUncommitted;
        Bin.SetLoadFields("Zone Code");
        if Bin.Get(ProdOrderComponent."Location Code", ProdOrderComponent."Bin Code") then
            SkipProdOrderComp := Bin."Zone Code" <> ZoneCode;
    end;

    internal procedure SetZoneCode(NewZoneCode: Code[20])
    begin
        ZoneCode := NewZoneCode;
    end;

}