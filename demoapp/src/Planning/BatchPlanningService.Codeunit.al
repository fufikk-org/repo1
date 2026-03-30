// namespace Weibel.Manufacturing.Planning.Batch;

// using Microsoft.Manufacturing.Setup;
// using Microsoft.Manufacturing.Document;
// using Microsoft.Inventory.Requisition;
// using Microsoft.Inventory.Tracking;

// codeunit 70146 "COL Batch Planning Service"
// {
//     trigger OnRun()
//     begin
//         Initialize();
//         //ReservationCleanUp(); //has COMMIT // This will be enable in future
//         BatchCalcLowLevel(); //has COMMIT
//         DeletePlannedProdOrders(); //has COMMIT
//         UpdateProdRoutingLines(); //has COMMIT
//         DeleteRequisitionLines(); // has COMMIT
//         RunBatchPlanning();
//     end;

//     var
//         ManufacturingSetup: Record "Manufacturing Setup";

//     local procedure Initialize()
//     begin
//         ManufacturingSetup.Get();
//         ManufacturingSetup.TestField("COL Requisition Template Name");
//         ManufacturingSetup.TestField("COL Requisition Batch Name");
//         ManufacturingSetup.TestField("COL Plan. Worksheet Temp. Name");
//         ManufacturingSetup.TestField("COL Std. Plan Jnl. Batch Name");
//         ManufacturingSetup.TestField("COL Net. Plan Jnl. Batch Name");
//         ManufacturingSetup.TestField("COL Order Date DF");
//         ManufacturingSetup.TestField("COL End Date");
//         ManufacturingSetup.TestField("COL Exclude Forecast Before");
//         ManufacturingSetup.TestField("COL Exclude Forecast Before DF");
//     end;

//     local procedure BatchCalcLowLevel()
//     var
//         BatchCalcLowLevelCode: Codeunit "COL Batch Calc. Low-Level Code";
//     begin
//         BatchCalcLowLevelCode.Run();
//         Commit();
//     end;

//     /// <summary>
//     /// Based on report NAV Report 50097 CleanUp Resv. Entries
//     /// </summary>
//     local procedure ReservationCleanUp()
//     var
//         Reservation: Record "Reservation Entry";
//         ReservEntry1: Record "Reservation Entry";
//         ReservEntry2: Record "Reservation Entry";
//         i: Integer;
//         y: Integer;
//         FixedLbl: Label 'Fixed status of %1 and deleted %2', Comment = 'Fixed status = %1, deleted = %2';
//     begin
//         Reservation.Reset();
//         Reservation.SetRange("Reservation Status", Reservation."Reservation Status"::Reservation, Reservation."Reservation Status"::Tracking);
//         if Reservation.FindSet(true) then
//             repeat
//                 if not ReservEntry1.Get(Reservation."Entry No.", not Reservation.Positive) then begin // No partner
//                     ReservEntry2.Get(Reservation."Entry No.", Reservation.Positive);
//                     if Reservation."Serial No." <> '' then begin // Change Reservation Status to Surplus
//                         ReservEntry2."Reservation Status" := ReservEntry2."Reservation Status"::Surplus;
//                         ReservEntry2.Modify();
//                         i := i + 1;
//                     end else begin
//                         ReservEntry2.Delete(true);
//                         y := y + 1;
//                     end;
//                 end;
//             until Reservation.Next() = 0;

//         if GuiAllowed() then
//             Message(FixedLbl, i, y);

//         Commit();
//     end;

//     local procedure DeletePlannedProdOrders()
//     var
//         ProductionOrder: Record "Production Order";
//     begin
//         ProductionOrder.ReadIsolation := IsolationLevel::ReadUncommitted;
//         ProductionOrder.SetRange(Status, ProductionOrder.Status::Planned);
//         if ProductionOrder.IsEmpty() then
//             exit;

//         ProductionOrder.SetHideValidationDialog(true);
//         ProductionOrder.DeleteAll(true);
//         Commit();
//     end;

//     local procedure UpdateProdRoutingLines()
//     var
//         ProdOrderRoutingLine: Record "Prod. Order Routing Line";
//     begin
//         ProdOrderRoutingLine.SetRange(Status, ProdOrderRoutingLine.Status::Released);
//         ProdOrderRoutingLine.SetRange(Recalculate, true);
//         ProdOrderRoutingLine.ModifyAll(Recalculate, false);
//         Commit();
//     end;

//     local procedure DeleteRequisitionLines()
//     var
//         RequisitionLine: Record "Requisition Line";
//     begin
//         RequisitionLine.ReadIsolation := IsolationLevel::ReadUncommitted;
//         RequisitionLine.SetFilter("Worksheet Template Name", '%1|%2', ManufacturingSetup."COL Plan. Worksheet Temp. Name", ManufacturingSetup."COL Requisition Template Name");
//         RequisitionLine.SetFilter("Journal Batch Name", '%1|%2', ManufacturingSetup."COL Std. Plan Jnl. Batch Name", ManufacturingSetup."COL Requisition Batch Name");
//         if RequisitionLine.IsEmpty() then
//             exit;

//         RequisitionLine.DeleteAll(true);
//         Commit();
//     end;

//     local procedure RunBatchPlanning()
//     begin
//         DoBatchPlanning();
//         DoCarryOutAction();
//         DoCopyPlanToRequisition();
//     end;

//     local procedure DoBatchPlanning()
//     var
//         BatchPlanning: Report "COL Batch Planning";
//     begin
//         BatchPlanning.SetTemplate(ManufacturingSetup."COL Plan. Worksheet Temp. Name", ManufacturingSetup."COL Std. Plan Jnl. Batch Name", true);
//         BatchPlanning.SetResiliency(ManufacturingSetup."COL Stop and Show First Error");
//         BatchPlanning.SetMPS(ManufacturingSetup."COL Calculate MPS");
//         BatchPlanning.SetMRP(ManufacturingSetup."COL Calculate MRP");
//         BatchPlanning.SetUseForecast(ManufacturingSetup."COL Use Forecast");
//         BatchPlanning.SetPreventForecastBefore(ManufacturingSetup."COL Exclude Forecast Before");
//         BatchPlanning.SetOrderDate(CalcDate(ManufacturingSetup."COL Order Date DF", WorkDate()));
//         BatchPlanning.SetToDate(ManufacturingSetup."COL End Date");
//         BatchPlanning.SetRespectPlanningParm(true);

//         BatchPlanning.UseRequestPage(false);
//         BatchPlanning.RunModal();
//     end;

//     local procedure DoCarryOutAction()
//     var
//         CarryOutActionMsgPlan: Report "Carry Out Action Msg. - Plan.";
//         FilterReqLinesHandler: Codeunit "COL Filter Req. Lines Handler";
//     begin
//         BindSubscription(FilterReqLinesHandler);
//         CarryOutActionMsgPlan.COLMarkAAMReqLines(); // This will set all action messages for the selected items
//         CarryOutActionMsgPlan.COLRunFromBatchPlanning(true);
//         CarryOutActionMsgPlan.UseRequestPage(false);
//         CarryOutActionMsgPlan.RunModal();
//         UnbindSubscription(FilterReqLinesHandler);

//         Commit();
//     end;

//     local procedure DoCopyPlanToRequisition()
//     var
//         RequisitionLine: Record "Requisition Line";
//         CopyPlanToRequisition: Report "COL Copy Plan. To Requisition";
//     begin
//         RequisitionLine.SetRange("Worksheet Template Name", ManufacturingSetup."COL Plan. Worksheet Temp. Name");
//         RequisitionLine.SetRange("Journal Batch Name", ManufacturingSetup."COL Std. Plan Jnl. Batch Name");

//         CopyPlanToRequisition.SetTemplateAndBatch(ManufacturingSetup."COL Requisition Template Name", ManufacturingSetup."COL Requisition Batch Name");
//         CopyPlanToRequisition.UseRequestPage(false);
//         CopyPlanToRequisition.SetTableView(RequisitionLine);
//         CopyPlanToRequisition.RunModal();
//     end;
// }