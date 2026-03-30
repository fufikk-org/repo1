namespace Weibel.Manufacturing.Planning.Batch;

using Microsoft.Manufacturing.Planning;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Planning;
using Microsoft.Inventory.Requisition;

codeunit 70165 "COL Batch Planning Subs"
{
    EventSubscriberInstance = Manual;

    [EventSubscriber(ObjectType::Report, Report::"Calculate Plan - Plan. Wksh.", OnOnPreDataItemOnAfterCalcShouldSetAtStartPosition, '', false, false)]
    local procedure OnOnPreDataItemOnAfterCalcShouldSetAtStartPosition(Item: Record Item; PlanningErrorLog: Record "Planning Error Log"; RequisitionLine: Record "Requisition Line"; var SetAtStartPosition: Boolean; var ShouldSetAtStartPosition: Boolean)
    begin
        ShouldSetAtStartPosition := false;
        SetAtStartPosition := true;
    end;
}
