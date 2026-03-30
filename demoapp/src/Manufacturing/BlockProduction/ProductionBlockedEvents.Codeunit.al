namespace Weibel.Manufacturing.BlockProduction;

using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Manufacturing.Document;
using Microsoft.Manufacturing.Journal;
using Microsoft.Inventory.Posting;
using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Tracking;
using System.Security.User;
using Microsoft.Manufacturing.Routing;
using Microsoft.Manufacturing.WorkCenter;

codeunit 70153 "COL Production Blocked Events"
{
    var
        BlockProductionMgt: Codeunit "COL Block Production Mgt.";
        LineLockedErr: Label 'Routing Line (Operation: %1) is Locked.', Comment = '%1 routing line.';
        LineLockedDateErr: Label 'Routing Line (Operation: %1) is Locked and have starting or ending data conflict.', Comment = '%1 routing line.';

    [EventSubscriber(ObjectType::Table, Database::"Production BOM Header", OnBeforeOnValidateStatus, '', false, false)]
    local procedure "Production BOM Header_OnBeforeOnValidateStatus"(var Sender: Record "Production BOM Header"; var ProductionBOMHeader: Record "Production BOM Header"; var xProductionBOMHeader: Record "Production BOM Header"; var IsHandled: Boolean)
    begin
        if (ProductionBOMHeader.Status <> xProductionBOMHeader.Status) and (ProductionBOMHeader.Status = ProductionBOMHeader.Status::Certified) then
            BlockProductionMgt.CheckLinesOnBOMStatusChange(ProductionBOMHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Status Management", OnChangeProdOrderStatusOnBeforeTransProdOrder, '', false, false)]
    local procedure "Prod. Order Status Management_OnChangeProdOrderStatusOnBeforeTransProdOrder"(var ProdOrder: Record "Production Order"; NewStatus: Enum "Production Order Status")
    begin
        BlockProductionMgt.CheckProductionOrderOnStatusChange(ProdOrder, NewStatus);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Batch", OnAfterCheckJnlLine, '', false, false)]
    local procedure "Item Jnl.-Post Batch_OnAfterCheckJnlLine"(var ItemJournalLine: Record "Item Journal Line"; CommitIsSuppressed: Boolean)
    begin
        BlockProductionMgt.CheckItemJournalLineBlocked(ItemJournalLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Prod. Order Comp.-Reserve", OnBeforeVerifyQuantity, '', false, false)]
    local procedure "Prod. Order Comp.-Reserve_OnBeforeVerifyQuantity"(var NewProdOrderComponent: Record "Prod. Order Component"; OldProdOrderComponent: Record "Prod. Order Component"; var ReservationManagement: Codeunit "Reservation Management"; var IsHandled: Boolean)
    begin
        if NewProdOrderComponent.Status = NewProdOrderComponent.Status::Finished then
            exit;
        if NewProdOrderComponent."Line No." = OldProdOrderComponent."Line No." then
            if NewProdOrderComponent."Remaining Qty. (Base)" <> OldProdOrderComponent."Remaining Qty. (Base)" then
                BlockProductionMgt.VerifyProductionOrderComponentLine(NewProdOrderComponent);
    end;

    [EventSubscriber(ObjectType::Report, Report::"Refresh Production Order", OnBeforeCalcProdOrder, '', false, false)]
    local procedure "Refresh Production Order_OnBeforeCalcProdOrder"(var ProductionOrder: Record "Production Order"; Direction: Option)
    begin
        BlockProductionMgt.RecallVerifyProductionOrderComponentLineNotification();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Routing Line", 'OnBeforeModifyEvent', '', false, false)]
    local procedure ProdOrderRoutingLineOnBeforeModifyEvent(var Rec: Record "Prod. Order Routing Line"; var xRec: Record "Prod. Order Routing Line"; RunTrigger: Boolean)
    var
        IsHandled: Boolean;
    begin
        if not GuiAllowed() then
            exit;

        if Format(Rec) = Format(xRec) then
            exit;

        if (Rec.Status <> xRec.Status) and (Rec.Status = Rec.Status::Finished) then
            exit;

        if (Rec."Routing Status" <> xRec."Routing Status") then
            exit;

        OnBeforeCheckRoutingLineLockStatus(Rec, RunTrigger, IsHandled);
        if IsHandled then
            exit;

        if (Rec."COL Lock" = xRec."COL Lock") and (Rec."COL Lock") then
            if Rec.Status in [Rec.Status::Released, Rec.Status::"Firm Planned"] then
                Error(LineLockedErr, Rec."Operation No.");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Routing Line", 'OnBeforeDeleteEvent', '', false, false)]
    local procedure ProdOrderRoutingLineOnBeforeDeleteEvent(var Rec: Record "Prod. Order Routing Line"; RunTrigger: Boolean)
    var
        IsHandled: Boolean;
    begin
        if not GuiAllowed() then
            exit;

        if not RunTrigger then
            exit;

        OnBeforeCheckRoutingLineLockStatus(Rec, RunTrigger, IsHandled);
        if IsHandled then
            exit;

        if (Rec."COL Lock") then
            if Rec.Status in [Rec.Status::Released, Rec.Status::"Firm Planned"] then
                Error(LineLockedErr, Rec."Operation No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Calculate Prod. Order", 'OnRecalculateOnBeforeCalculateRouting', '', false, false)]
    local procedure OnRecalculateOnBeforeCalculateRouting(var ProdOrderLine: Record "Prod. Order Line"; var IsHandled: Boolean)
    var
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
    begin
        if not GuiAllowed() then
            exit;

        ProdOrderRoutingLine.SetRange("Prod. Order No.", ProdOrderLine."Prod. Order No.");
        ProdOrderRoutingLine.SetRange("Routing No.", ProdOrderLine."Routing No.");
        ProdOrderRoutingLine.SetRange("Routing Reference No.", ProdOrderLine."Routing Reference No.");
        ProdOrderRoutingLine.SetRange("COL Lock", true);
        if ProdOrderRoutingLine.FindFirst() then
            if ProdOrderRoutingLine.Status in [ProdOrderRoutingLine.Status::Released, ProdOrderRoutingLine.Status::"Firm Planned"] then
                Error(LineLockedErr, ProdOrderRoutingLine."Operation No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Calculate Prod. Order", 'OnCalculateRoutingFromActualOnAfterSetProdOrderRoutingLineFilters', '', false, false)]
    local procedure OnCalculateRoutingFromActualOnAfterSetProdOrderRoutingLineFilters(var ProdOrderRoutingLine: Record "Prod. Order Routing Line");
    begin
        ProdOrderRoutingLine.SetRange("COL Lock", false);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Routing Line", 'OnCalcStartingEndingDatesOnBeforeCalculateRouting', '', false, false)]
    local procedure OnCalcStartingEndingDatesOnBeforeCalculateRouting(var ProdOrderRoutingLine: Record "Prod. Order Routing Line"; var IsHandled: Boolean)
    begin
        CheckLockedDates(ProdOrderRoutingLine);
        CalculateRoutingBack(ProdOrderRoutingLine);
        CalculateRoutingForward(ProdOrderRoutingLine);
        IsHandled := true;
    end;

    local procedure CheckLockedDates(var Rec: Record "Prod. Order Routing Line")
    var
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        dataConflictOperation: Code[20];
        DateTimeUpper: DateTime;
        DateTimeLower: DateTime;
    begin
        DateTimeUpper := Rec."Starting Date-Time";
        if Rec."Starting Date-Time" < Rec."Ending Date-Time" then
            DateTimeUpper := Rec."Ending Date-Time";

        DateTimeLower := Rec."Starting Date-Time";
        if Rec."Starting Date-Time" > Rec."Ending Date-Time" then
            DateTimeLower := Rec."Ending Date-Time";

        ProdOrderRoutingLine.SetRange(Status, Rec.Status);
        ProdOrderRoutingLine.SetRange("Prod. Order No.", Rec."Prod. Order No.");
        ProdOrderRoutingLine.SetRange("Routing Reference No.", Rec."Routing Reference No.");
        ProdOrderRoutingLine.SetRange("Routing No.", Rec."Routing No.");
        ProdOrderRoutingLine.SetFilter("Routing Status", '<>%1', ProdOrderRoutingLine."Routing Status"::Finished);
        ProdOrderRoutingLine.SetRange("COL Lock", true);
        if ProdOrderRoutingLine.FindSet() then
            repeat

                if ProdOrderRoutingLine."Sequence No. (Forward)" > Rec."Sequence No. (Forward)" then begin

                    if ProdOrderRoutingLine."Starting Date-Time" < DateTimeUpper then
                        dataConflictOperation := ProdOrderRoutingLine."Operation No.";

                end
                else
                    if ProdOrderRoutingLine."Ending Date-Time" > DateTimeLower then
                        dataConflictOperation := ProdOrderRoutingLine."Operation No.";

                if dataConflictOperation <> '' then
                    Error(LineLockedDateErr, dataConflictOperation);

            until ProdOrderRoutingLine.Next() = 0;
    end;

    local procedure CalculateRoutingBack(var Rec: Record "Prod. Order Routing Line")
    var
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        WorkCenter: Record "Work Center";
        ProdOrderRouteMgt: Codeunit "Prod. Order Route Management";
        CalcProdOrder: Codeunit "Calculate Prod. Order";
        Direction: Option Forward,Backward;
        BackErr: Label 'This routing line cannot be moved because of critical work centers in previous operations';
    begin
        if Rec."Previous Operation No." <> '' then begin
            ProdOrderRoutingLine.SetRange(Status, Rec.Status);
            ProdOrderRoutingLine.SetRange("Prod. Order No.", Rec."Prod. Order No.");
            ProdOrderRoutingLine.SetRange("Routing Reference No.", Rec."Routing Reference No.");
            ProdOrderRoutingLine.SetRange("Routing No.", Rec."Routing No.");
            ProdOrderRoutingLine.SetFilter("Operation No.", Rec."Previous Operation No.");
            ProdOrderRoutingLine.SetFilter("Routing Status", '<>%1', ProdOrderRoutingLine."Routing Status"::Finished);
            ProdOrderRoutingLine.SetRange("COL Lock", false);

            if ProdOrderRoutingLine.Find('-') then
                repeat
                    ProdOrderRoutingLine.SetCurrentKey(Status, "Prod. Order No.", "Routing Reference No.",
                      "Routing No.", "Sequence No. (Actual)");
                    WorkCenter.Get(ProdOrderRoutingLine."Work Center No.");
                    case WorkCenter."Simulation Type" of
                        WorkCenter."Simulation Type"::Moves:
                            begin
                                ProdOrderRouteMgt.CalcSequenceFromActual(ProdOrderRoutingLine, Direction::Backward);
                                CalcProdOrder.CalculateRoutingFromActual(ProdOrderRoutingLine, Direction::Backward, true);
                            end;
                        WorkCenter."Simulation Type"::"Moves When Necessary":
                            if (ProdOrderRoutingLine."Ending Date" > Rec."Starting Date") or
                               ((ProdOrderRoutingLine."Ending Date" = Rec."Starting Date") and
                                (ProdOrderRoutingLine."Ending Time" > Rec."Starting Time"))
                            then begin
                                ProdOrderRouteMgt.CalcSequenceFromActual(ProdOrderRoutingLine, Direction::Backward);
                                CalcProdOrder.CalculateRoutingFromActual(ProdOrderRoutingLine, Direction::Backward, true);
                            end;
                        WorkCenter."Simulation Type"::Critical:
                            if (ProdOrderRoutingLine."Ending Date" > Rec."Starting Date") or
                                ((ProdOrderRoutingLine."Ending Date" = Rec."Starting Date") and
                                (ProdOrderRoutingLine."Ending Time" > Rec."Starting Time"))
                            then
                                Error(BackErr);
                    end;
                    ProdOrderRoutingLine.SetCurrentKey(Status, "Prod. Order No.", "Routing Reference No.",
                      "Routing No.", "Operation No.");

                until ProdOrderRoutingLine.Next() = 0;
        end;

        ProdOrderLine.SetRange(Status, Rec.Status);
        ProdOrderLine.SetRange("Prod. Order No.", Rec."Prod. Order No.");
        ProdOrderLine.SetRange("Routing Reference No.", Rec."Routing Reference No.");
        ProdOrderLine.SetRange("Routing No.", Rec."Routing No.");
        if ProdOrderLine.Find('-') then
            repeat
                CalcProdOrder.CalculateProdOrderDates(ProdOrderLine, true);
                AdjustComponents(Rec, ProdOrderLine);
            until ProdOrderLine.Next() = 0;
    end;

    local procedure CalculateRoutingForward(var Rec: Record "Prod. Order Routing Line")
    var
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        WorkCenter: Record "Work Center";
        ProdOrderRouteMgt: Codeunit "Prod. Order Route Management";
        CalcProdOrder: Codeunit "Calculate Prod. Order";
        routeCalcErr: Label 'This routing line cannot be moved because of critical work centers in next operations';
        Direction: Option Forward,Backward;
    begin
        if Rec."Next Operation No." <> '' then begin
            ProdOrderRoutingLine.SetRange(Status, Rec.Status);
            ProdOrderRoutingLine.SetRange("Prod. Order No.", Rec."Prod. Order No.");
            ProdOrderRoutingLine.SetRange("Routing Reference No.", Rec."Routing Reference No.");
            ProdOrderRoutingLine.SetRange("Routing No.", Rec."Routing No.");
            ProdOrderRoutingLine.SetFilter("Operation No.", Rec."Next Operation No.");
            ProdOrderRoutingLine.SetFilter("Routing Status", '<>%1', ProdOrderRoutingLine."Routing Status"::Finished);
            ProdOrderRoutingLine.SetRange("COL Lock", false);

            if ProdOrderRoutingLine.Find('-') then
                repeat
                    ProdOrderRoutingLine.SetCurrentKey(Status, "Prod. Order No.", "Routing Reference No.",
                      "Routing No.", "Sequence No. (Actual)");
                    WorkCenter.Get(ProdOrderRoutingLine."Work Center No.");
                    case WorkCenter."Simulation Type" of
                        WorkCenter."Simulation Type"::Moves:
                            begin
                                ProdOrderRouteMgt.CalcSequenceFromActual(ProdOrderRoutingLine, Direction::Forward);
                                CalcProdOrder.CalculateRoutingFromActual(ProdOrderRoutingLine, Direction::Forward, true);
                            end;
                        WorkCenter."Simulation Type"::"Moves When Necessary":
                            if (ProdOrderRoutingLine."Starting Date" < Rec."Ending Date") or
                               ((ProdOrderRoutingLine."Starting Date" = Rec."Ending Date") and
                                (ProdOrderRoutingLine."Starting Time" < Rec."Ending Time"))
                            then begin
                                ProdOrderRouteMgt.CalcSequenceFromActual(ProdOrderRoutingLine, Direction::Forward);
                                CalcProdOrder.CalculateRoutingFromActual(ProdOrderRoutingLine, Direction::Forward, true);
                            end;
                        WorkCenter."Simulation Type"::Critical:
                            if (ProdOrderRoutingLine."Starting Date" < Rec."Ending Date") or
                                ((ProdOrderRoutingLine."Starting Date" = Rec."Ending Date") and
                                (ProdOrderRoutingLine."Starting Time" < Rec."Ending Time"))
                            then
                                Error(routeCalcErr);
                    end;
                    ProdOrderRoutingLine.SetCurrentKey(Status, "Prod. Order No.", "Routing Reference No.",
                      "Routing No.", "Operation No.");
                until ProdOrderRoutingLine.Next() = 0;
        end;

        ProdOrderLine.SetRange(Status, Rec.Status);
        ProdOrderLine.SetRange("Prod. Order No.", Rec."Prod. Order No.");
        ProdOrderLine.SetRange("Routing Reference No.", Rec."Routing Reference No.");
        ProdOrderLine.SetRange("Routing No.", Rec."Routing No.");
        if ProdOrderLine.Find('-') then
            repeat
                CalcProdOrder.CalculateProdOrderDates(ProdOrderLine, true);
                AdjustComponents(Rec, ProdOrderLine);
            until ProdOrderLine.Next() = 0;
        CalcProdOrder.CalculateComponents();
    end;

    local procedure AdjustComponents(var RouteLine: Record "Prod. Order Routing Line"; var ProdOrderLine: Record "Prod. Order Line")
    var
        ProdOrderComp: Record "Prod. Order Component";
    begin
        ProdOrderComp.SetRange(Status, RouteLine.Status);
        ProdOrderComp.SetRange("Prod. Order No.", RouteLine."Prod. Order No.");
        ProdOrderComp.SetRange("Prod. Order Line No.", ProdOrderLine."Line No.");

        if ProdOrderComp.Find('-') then
            repeat
                ProdOrderComp.Validate("Routing Link Code");
                ProdOrderComp.Modify();
            until ProdOrderComp.Next() = 0;
    end;

    // [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Calculate Routing Line", 'OnBeforeCalcRoutingLineForward', '', false, false)]
    // local procedure OnBeforeCalcRoutingLineForward(var ProdOrderRoutingLine: Record "Prod. Order Routing Line"; var CalculateStartDate: Boolean; var IsHandled: Boolean; var TempProdOrderRoutingLine: Record "Prod. Order Routing Line" temporary; var SendAheadLotSize: Decimal; MaxLotSize: Decimal; var TotalLotSize: Decimal; var RemainNeedQty: Decimal; var UpdateDates: Boolean)
    // var
    //     ProdOrderRoutingLine2: Record "Prod. Order Routing Line";
    // begin
    //     ProdOrderRoutingLine2.SetRange(Status, ProdOrderRoutingLine.Status);
    //     ProdOrderRoutingLine2.SetRange("Prod. Order No.", ProdOrderRoutingLine."Prod. Order No.");
    //     ProdOrderRoutingLine2.SetRange("Routing Reference No.", ProdOrderRoutingLine."Routing Reference No.");
    //     ProdOrderRoutingLine2.SetRange("Routing No.", ProdOrderRoutingLine."Routing No.");
    //     ProdOrderRoutingLine2.SetFilter("Routing Status", '<>%1', ProdOrderRoutingLine2."Routing Status"::Finished);
    //     ProdOrderRoutingLine2.SetFilter("Operation No.", ProdOrderRoutingLine."Previous Operation No.");
    //     ProdOrderRoutingLine2.SetRange("COL Lock", true);
    //     if not (ProdOrderRoutingLine2.IsEmpty()) then
    //         IsHandled := true;
    // end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckRoutingLineLockStatus(var Rec: Record "Prod. Order Routing Line"; RunTrigger: Boolean; var IsHandled: Boolean)
    begin
    end;
}