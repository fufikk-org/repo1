namespace Weibel.Manufacturing.Planning.Batch;

using Microsoft.Manufacturing.Setup;
using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Requisition;
using Microsoft.Manufacturing.Planning;
using Weibel.Manufacturing.Planning;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.BOM.Tree;
using Weibel.weibel.Test;
using Microsoft.Inventory.Planning;

codeunit 70160 "COL Std Batch Planning Service"
{
    trigger OnRun()
    begin
        Initialize();
        DeletePlannedProdOrders(); // COMMIT
        //UpdateProdRoutingLines(); // COMMIT - Temporary On Hold
        DeleteRequisitionLines(); // COMMIT
        CalculateRegenerativePlan(); //COMMIT
        SelectPurchLines(); //COMMIT
        CarryOutPurchaseActionMsg(false); //COMMIT
        SelectProdLines(); //COMMIT
        CarryOutProdActionMsg(false); //COMMIT
        FillWorkInfo();
    end;

    var
        ManufacturingSetup: Record "Manufacturing Setup";
        DebugMode: Boolean;
        ItemSelected: Code[20];

    local procedure FillWorkInfo()
    var
        RequisitionLine: Record "Requisition Line";
    begin
        if RequisitionLine.FindSet() then
            repeat
                if (RequisitionLine."COL First Opr. Work Center" = '') or (RequisitionLine."COL First Opr. Wrk Center Grp" = '') then begin
                    RequisitionLine.COL_FillFromRouting();
                    RequisitionLine.Modify(false);
                end;
            until RequisitionLine.Next() = 0;
    end;

    procedure Batch_CalcLowLevelCode()
    begin
        DebugMode := true;
        Initialize();
        CalcLowLevelCode(); // COMMIT
    end;

    procedure Batch_CalculateRegenerativePlanMPS()
    begin
        DebugMode := true;
        Initialize();
        DeletePlannedProdOrders(); // COMMIT
        DeleteRequisitionLines(); // COMMIT
        CalculateRegenerativePlan(true); //COMMIT
    end;

    procedure Batch_CalculateRegenerativePlanMPR()
    begin
        DebugMode := true;
        Initialize();
        CalculateRegenerativePlan(false); //COMMIT
    end;

    procedure Batch_CalculateRegenerativePlanBoth()
    begin
        DebugMode := true;
        Initialize();
        DeletePlannedProdOrders(); // COMMIT
        DeleteRequisitionLines(); // COMMIT
        CalculateRegenerativePlan(); //COMMIT
    end;

    procedure Batch_CarryOut()
    begin
        Initialize();
        SelectPurchLines(); //COMMIT
        CarryOutPurchaseActionMsg(false); //COMMIT
        SelectProdLines(); //COMMIT
        CarryOutProdActionMsg(false); //COMMIT
    end;

    procedure Batch_Full()
    begin
        DebugMode := true;
        Initialize();
        DeletePlannedProdOrders(); // COMMIT
        DeleteRequisitionLines(); // COMMIT
        CalculateRegenerativePlan(); //COMMIT

        DebugMode := false;
        Initialize();
        SelectPurchLines(); //COMMIT
        CarryOutPurchaseActionMsg(false); //COMMIT
        SelectProdLines(); //COMMIT
        CarryOutProdActionMsg(false); //COMMIT
    end;

    procedure Manual_CalcLowLevelCode(pItemSelected: Code[20])
    begin
        ItemSelected := pItemSelected;
        DebugMode := true;
        Initialize();
        CalcLowLevelCode(); // COMMIT
        DeletePlannedProdOrders(); // COMMIT
        DeleteRequisitionLines(); // COMMIT
    end;

    procedure Manual_CalculateRegenerativePlan(pItemSelected: Code[20])
    begin
        ItemSelected := pItemSelected;
        DebugMode := true;
        Initialize();
        CalculateRegenerativePlan(); //COMMIT
    end;

    procedure Manual_CarryOutPurchaseActionMsg(pItemSelected: Code[20])
    begin
        ItemSelected := pItemSelected;
        DebugMode := true;
        Initialize();
        SelectPurchLines(); //COMMIT
        CarryOutPurchaseActionMsg(false); //COMMIT
    end;

    procedure Manual_CarryOutProdActionMsg(pItemSelected: Code[20])
    begin
        ItemSelected := pItemSelected;
        DebugMode := true;
        Initialize();
        SelectProdLines(); //COMMIT
        CarryOutProdActionMsg(false); //COMMIT
    end;

    local procedure CalcLowLevelCode()
    var
        LowLevelCodeCalculator: Codeunit "Low-Level Code Calculator";
    begin
        LowLevelCodeCalculator.Calculate(false);
        Commit();
    end;

    local procedure CarryOutProdActionMsg(ShowPage: Boolean)
    var
        RequisitionLine: Record "Requisition Line";
        CarryOutActionMsgPlan: Report "Carry Out Action Msg. - Plan.";
    begin
        RequisitionLine.SetRange("Worksheet Template Name", ManufacturingSetup."COL Plan. Worksheet Temp. Name");
        RequisitionLine.SetRange("Journal Batch Name", ManufacturingSetup."COL Std. Plan Jnl. Batch Name");
        RequisitionLine.SetRange("Ref. Order Type", RequisitionLine."Ref. Order Type"::"Prod. Order");
        RequisitionLine.SetRange("Action Message", RequisitionLine."Action Message"::New);
        RequisitionLine.SetFilter("Starting Date", '%1..', WorkDate());
        if DebugMode then
            RequisitionLine.SetRange("No.", ItemSelected);
        if RequisitionLine.FindFirst() then begin

            CarryOutActionMsgPlan.SetReqWkshLine(RequisitionLine);
            CarryOutActionMsgPlan.InitializeRequest2(1, 0, 0, 0, ManufacturingSetup."COL Requisition Template Name", ManufacturingSetup."COL Requisition Batch Name", '', '');
            CarryOutActionMsgPlan.SetHideDialog(true);
            CarryOutActionMsgPlan.COLSetErrorShow(false);
            CarryOutActionMsgPlan.UseRequestPage(ShowPage);
            CarryOutActionMsgPlan.RunModal();

            Commit();
        end;
    end;

    local procedure CarryOutPurchaseActionMsg(ShowPage: Boolean)
    var
        RequisitionLine: Record "Requisition Line";
        CarryOutActionMsgPlan: Report "Carry Out Action Msg. - Plan.";
    begin
        RequisitionLine.SetRange("Worksheet Template Name", ManufacturingSetup."COL Plan. Worksheet Temp. Name");
        RequisitionLine.SetRange("Journal Batch Name", ManufacturingSetup."COL Std. Plan Jnl. Batch Name");
        RequisitionLine.SetRange("Ref. Order Type", RequisitionLine."Ref. Order Type"::Purchase);
        if DebugMode then
            RequisitionLine.SetRange("No.", ItemSelected);
        if RequisitionLine.FindFirst() then begin

            CarryOutActionMsgPlan.SetReqWkshLine(RequisitionLine);
            CarryOutActionMsgPlan.InitializeRequest2(0, 3, 0, 0, ManufacturingSetup."COL Requisition Template Name", ManufacturingSetup."COL Requisition Batch Name", '', '');
            CarryOutActionMsgPlan.SetHideDialog(true);
            CarryOutActionMsgPlan.COLSetErrorShow(false);
            CarryOutActionMsgPlan.UseRequestPage(ShowPage);
            CarryOutActionMsgPlan.RunModal();

            Commit();
        end;
    end;

    local procedure SelectPurchLines()
    var
        RequisitionLine: Record "Requisition Line";
    begin
        RequisitionLine.SetRange("Worksheet Template Name", ManufacturingSetup."COL Plan. Worksheet Temp. Name");
        RequisitionLine.SetRange("Journal Batch Name", ManufacturingSetup."COL Std. Plan Jnl. Batch Name");
        RequisitionLine.ModifyAll("Accept Action Message", false);

        RequisitionLine.SetRange("Worksheet Template Name", ManufacturingSetup."COL Plan. Worksheet Temp. Name");
        RequisitionLine.SetRange("Journal Batch Name", ManufacturingSetup."COL Std. Plan Jnl. Batch Name");
        RequisitionLine.SetRange("Ref. Order Type", RequisitionLine."Ref. Order Type"::Purchase);
        RequisitionLine.ModifyAll("Accept Action Message", true);

        Commit();
    end;

    local procedure SelectProdLines()
    var
        RequisitionLine: Record "Requisition Line";
    begin
        RequisitionLine.SetRange("Worksheet Template Name", ManufacturingSetup."COL Plan. Worksheet Temp. Name");
        RequisitionLine.SetRange("Journal Batch Name", ManufacturingSetup."COL Std. Plan Jnl. Batch Name");
        RequisitionLine.ModifyAll("Accept Action Message", false);

        RequisitionLine.SetRange("Worksheet Template Name", ManufacturingSetup."COL Plan. Worksheet Temp. Name");
        RequisitionLine.SetRange("Journal Batch Name", ManufacturingSetup."COL Std. Plan Jnl. Batch Name");
        RequisitionLine.SetRange("Ref. Order Type", RequisitionLine."Ref. Order Type"::"Prod. Order");
        RequisitionLine.SetRange("Action Message", RequisitionLine."Action Message"::New);
        RequisitionLine.SetFilter("Starting Date", '%1..', WorkDate());
        RequisitionLine.ModifyAll("Accept Action Message", true);

        if RequisitionLine.FindSet() then
            repeat
                if not PlanningWarningLevelBlank(RequisitionLine) then
                    RequisitionLine.Validate("Accept Action Message", false);

            until RequisitionLine.Next() = 0;

        Commit();
    end;


    local procedure PlanningWarningLevelBlank(var RequisitionLine: Record "Requisition Line"): Boolean
    var
        Transparency: Codeunit "Planning Transparency";
        Warning: Integer;
    begin
        Warning := Transparency.ReqLineWarningLevel(RequisitionLine);
        if Warning = 0 then
            exit(true);
    end;

    local procedure CalculateRegenerativePlan(MPS: Boolean)
    var
        Item: Record Item;
        CalcPlan: Report "Calculate Plan - Plan. Wksh.";
        JobPlanningManualSub: Codeunit "COL Job Planning Manual Sub.";
        BatchPlanningSubs: Codeunit "COL Batch Planning Subs";
        pMPS: Boolean;
        pMPR: Boolean;
        BatchAdded: text;
    begin
        if not DebugMode then
            BindSubscription(JobPlanningManualSub);
        BindSubscription(BatchPlanningSubs);

        if MPS then begin
            pMPS := true;
            pMPR := false;
            BatchAdded := '';
        end
        else begin
            pMPS := false;
            pMPR := true;
            BatchAdded := '1';
        end;

        CalcPlan.SetTemplAndWorksheet(ManufacturingSetup."COL Plan. Worksheet Temp. Name", ManufacturingSetup."COL Std. Plan Jnl. Batch Name" + BatchAdded, true);
        CalcPlan.InitializeRequest(
            CalcDate(ManufacturingSetup."COL Order Date DF", WorkDate()),
            CalcDate(ManufacturingSetup."COL Plan Horizontal", WorkDate()),
            true,
            pMPS,
            pMPR,
            ManufacturingSetup."COL Use Forecast",
            CalcDate(ManufacturingSetup."COL Exclude Forecast Before DF", WorkDate()),
            ManufacturingSetup."COL Stop and Show First Error"
        );
        Item.SetRange(Item."Type", Item."Type"::Inventory);
        if DebugMode then begin
            //Item.SetRange("No.", ItemSelected);
            if ManufacturingSetup."COL Debug No. Filter" <> '' then
                Item.SetFilter("No.", '%1', ManufacturingSetup."COL Debug No. Filter");
            if GuiAllowed then
                Message('Start Date: %1, End Date: %2, Respect: true, MPS, %3, MRP: %4 , Use Forecast: %5, Exclude Forecast %6, Show First Error %7, Worksheet Temp: %8, Plan Jnl. Batch: %9',
                        CalcDate(ManufacturingSetup."COL Order Date DF", WorkDate()),
                        CalcDate(ManufacturingSetup."COL Plan Horizontal", WorkDate()),
                        pMPS,
                        pMPR,
                        ManufacturingSetup."COL Use Forecast",
                        CalcDate(ManufacturingSetup."COL Exclude Forecast Before DF", WorkDate()),
                        ManufacturingSetup."COL Stop and Show First Error",
                        ManufacturingSetup."COL Plan. Worksheet Temp. Name",
                        ManufacturingSetup."COL Std. Plan Jnl. Batch Name" + BatchAdded
                             );
        end;
        CalcPlan.SetTableView(Item);
        CalcPlan.UseRequestPage(false);
        CalcPlan.RunModal();

        if not DebugMode then
            UnbindSubscription(JobPlanningManualSub);
        UnbindSubscription(BatchPlanningSubs);
        Commit();
    end;

#if not HIDE_LOWLEVEL_SKU
    local procedure CalculateRegenerativePlanCustom()
    var
        CalcPlan: Report "COL Calc. Plan - Plan. Wksh.";
        BatchPlanningSubs: Codeunit "COL Batch Planning Subs";
    begin
        BindSubscription(BatchPlanningSubs);

        CalcPlan.SetTemplAndWorksheet(ManufacturingSetup."COL Plan. Worksheet Temp. Name", ManufacturingSetup."COL Std. Plan Jnl. Batch Name", true);
        CalcPlan.InitializeRequest(
            CalcDate(ManufacturingSetup."COL Order Date DF", WorkDate()),
            CalcDate(ManufacturingSetup."COL Plan Horizontal", WorkDate()),
            true,
            ManufacturingSetup."COL Calculate MPS",
            ManufacturingSetup."COL Calculate MRP",
            ManufacturingSetup."COL Use Forecast",
            CalcDate(ManufacturingSetup."COL Exclude Forecast Before DF", WorkDate()),
            ManufacturingSetup."COL Stop and Show First Error"
        );
        CalcPlan.UseRequestPage(false);
        CalcPlan.RunModal();

        UnbindSubscription(BatchPlanningSubs);
        Commit();
    end;
#endif

    local procedure CalculateRegenerativePlan()
    var
        Item: Record Item;
        CalcPlan: Report "Calculate Plan - Plan. Wksh.";
        JobPlanningManualSub: Codeunit "COL Job Planning Manual Sub.";
        BatchPlanningSubs: Codeunit "COL Batch Planning Subs";
    begin
        if not DebugMode then
            BindSubscription(JobPlanningManualSub);
        BindSubscription(BatchPlanningSubs);

        CalcPlan.SetTemplAndWorksheet(ManufacturingSetup."COL Plan. Worksheet Temp. Name", ManufacturingSetup."COL Std. Plan Jnl. Batch Name", true);
        CalcPlan.InitializeRequest(
            CalcDate(ManufacturingSetup."COL Order Date DF", WorkDate()),
            CalcDate(ManufacturingSetup."COL Plan Horizontal", WorkDate()),
            true,
            ManufacturingSetup."COL Calculate MPS",
            ManufacturingSetup."COL Calculate MRP",
            ManufacturingSetup."COL Use Forecast",
            CalcDate(ManufacturingSetup."COL Exclude Forecast Before DF", WorkDate()),
            ManufacturingSetup."COL Stop and Show First Error"
        );
        Item.SetRange(Item."Type", Item."Type"::Inventory);
        if DebugMode then begin
            //Item.SetRange("No.", ItemSelected);
            if ManufacturingSetup."COL Debug No. Filter" <> '' then
                Item.SetFilter("No.", '%1', ManufacturingSetup."COL Debug No. Filter");
            Message('Start Date: %1, End Date: %2, Respect: true, MPS, %3, MRP: %4 , Use Forecast: %5, Exclude Forecast %6, Show First Error %7, Worksheet Temp: %8, Plan Jnl. Batch: %9',
                    CalcDate(ManufacturingSetup."COL Order Date DF", WorkDate()),
                    CalcDate(ManufacturingSetup."COL Plan Horizontal", WorkDate()),
                    ManufacturingSetup."COL Calculate MPS",
                    ManufacturingSetup."COL Calculate MRP",
                    ManufacturingSetup."COL Use Forecast",
                    CalcDate(ManufacturingSetup."COL Exclude Forecast Before DF", WorkDate()),
                    ManufacturingSetup."COL Stop and Show First Error",
                    ManufacturingSetup."COL Plan. Worksheet Temp. Name",
                    ManufacturingSetup."COL Std. Plan Jnl. Batch Name"
                         );
        end;
        CalcPlan.SetTableView(Item);
        CalcPlan.UseRequestPage(false);
        CalcPlan.RunModal();

        if not DebugMode then
            UnbindSubscription(JobPlanningManualSub);
        UnbindSubscription(BatchPlanningSubs);
        Commit();
    end;

    local procedure Initialize()
    begin
        ManufacturingSetup.Get();
        ManufacturingSetup.TestField("COL Requisition Template Name");
        ManufacturingSetup.TestField("COL Requisition Batch Name");
        ManufacturingSetup.TestField("COL Plan. Worksheet Temp. Name");
        ManufacturingSetup.TestField("COL Std. Plan Jnl. Batch Name");
        ManufacturingSetup.TestField("COL Order Date DF");
        ManufacturingSetup.TestField("COL Plan Horizontal");
        ManufacturingSetup.TestField("COL Exclude Forecast Before");
        ManufacturingSetup.TestField("COL Exclude Forecast Before DF");
    end;

    local procedure DeletePlannedProdOrders()
    var
        ProductionOrder: Record "Production Order";
    begin
        ProductionOrder.ReadIsolation := IsolationLevel::ReadUncommitted;
        ProductionOrder.SetRange(Status, ProductionOrder.Status::Planned);
        if ProductionOrder.IsEmpty() then
            exit;

        ProductionOrder.SetHideValidationDialog(true);
        ProductionOrder.DeleteAll(true);
        Commit();
    end;

#pragma warning disable AA0228
    local procedure UpdateProdRoutingLines()
    var
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
    begin
        ProdOrderRoutingLine.SetRange(Status, ProdOrderRoutingLine.Status::Released);
        ProdOrderRoutingLine.SetRange(Recalculate, true);
        ProdOrderRoutingLine.ModifyAll(Recalculate, false);
        Commit();
    end;
#pragma warning restore AA0228

    local procedure DeleteRequisitionLines()
    var
        RequisitionLine: Record "Requisition Line";
    begin
        RequisitionLine.ReadIsolation := IsolationLevel::ReadUncommitted;
        RequisitionLine.SetRange("Worksheet Template Name", ManufacturingSetup."COL Plan. Worksheet Temp. Name");
        RequisitionLine.SetRange("Journal Batch Name", ManufacturingSetup."COL Std. Plan Jnl. Batch Name");
        if RequisitionLine.FindFirst() then
            RequisitionLine.ClearPlanningWorksheet(true);

        RequisitionLine.ReadIsolation := IsolationLevel::ReadUncommitted;
        RequisitionLine.SetRange("Worksheet Template Name", ManufacturingSetup."COL Requisition Template Name");
        RequisitionLine.SetRange("Journal Batch Name", ManufacturingSetup."COL Requisition Batch Name");
        if RequisitionLine.FindFirst() then
            RequisitionLine.ClearPlanningWorksheet(true);

        Commit();
    end;


}
