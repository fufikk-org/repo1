namespace Weibel.Inventory.Planning.Handler;

using Microsoft.Inventory.Requisition;
using Microsoft.Inventory.Tracking;
using Microsoft.Sales.Document;
using Microsoft.Inventory.Item;
using Microsoft.Service.Document;
using Microsoft.Projects.Project.Planning;
using Microsoft.Inventory.Planning;
using Microsoft.Manufacturing.Document;

codeunit 70100 "COL Calc. Planning Handlers"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Inventory Profile Offsetting", OnSetAcceptActionOnBeforeAcceptActionMsg, '', false, false)]
    local procedure OnSetAcceptActionOnBeforeAcceptActionMsg(var RequisitionLine: Record "Requisition Line"; var AcceptActionMsg: Boolean)
    begin
        SetAcceptActionMessage(RequisitionLine, AcceptActionMsg);
    end;

    [EventSubscriber(ObjectType::Report, Report::"Carry Out Action Msg. - Plan.", OnBeforeRequisitionLineOnAfterGetRecord, '', false, false)]
    local procedure OnBeforeRequisitionLineOnAfterGetRecord(var RequisitionLine: Record "Requisition Line")
    begin
        CheckActionMessage(RequisitionLine);
    end;

    local procedure SetAcceptActionMessage(var RequisitionLine: Record "Requisition Line"; var AcceptActionMsg: Boolean)
    begin
        if RequisitionLine."Action Message" in [RequisitionLine."Action Message"::" ", RequisitionLine."Action Message"::New] then
            exit;

        // The accept action message can only be set if the action message is not empty or new.
        AcceptActionMsg := false;
    end;

    local procedure CheckActionMessage(var RequisitionLine: Record "Requisition Line")
    begin
        //TODO Wait for consultant
        exit; //It is temporary disable on behalf of Mikael Klaus Aaberg (to be removed/enable in future)

#pragma warning disable AA0136
        if RequisitionLine."Action Message" in [RequisitionLine."Action Message"::" ", RequisitionLine."Action Message"::New] then
            exit;

        // If the system somehow gets to this point with action message being empty or new, then the additional check is needed on the accept action message.
        RequisitionLine.TestField("Accept Action Message", false, ErrorInfo.Create());
#pragma warning restore AA0136
    end;

#if BC24
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Inventory Profile Offsetting", OnAfterFindLinesWithItemToPlan, '', false, false)]
    local procedure "Inventory Profile Offsetting_OnAfterFindLinesWithItemToPlan"(var SalesLine: Record "Sales Line"; var IsHandled: Boolean; var InventoryProfile: Record "Inventory Profile"; var Item: Record Item; var LineNo: Integer)
    var
        SalesHeader: Record "Sales Header";
    begin
        if SalesLine."Document Type" <> Enum::"Sales Document Type"::Order then
            exit;
        SalesHeader.SetLoadFields(Status);
        SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.");
        IsHandled := not (SalesHeader.Status = Enum::"Sales Document Status"::Released);
    end;
#else    
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Line Invt. Profile", OnAfterFindLinesWithItemToPlan, '', false, false)]
    local procedure "Sales Line Invt. Profile_OnAfterFindLinesWithItemToPlan"(var SalesLine: Record "Sales Line"; var IsHandled: Boolean; var InventoryProfile: Record "Inventory Profile"; var Item: Record Item; var LineNo: Integer)
    var
        SalesHeader: Record "Sales Header";
    begin
        if SalesLine."Document Type" <> Enum::"Sales Document Type"::Order then
            exit;
        SalesHeader.SetLoadFields(Status);
        SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.");
        IsHandled := not (SalesHeader.Status = Enum::"Sales Document Status"::Released);
    end;
#endif

#if BC24
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Inventory Profile Offsetting", OnTransServLineToProfileOnBeforeProcessLine, '', false, false)]
    local procedure "Inventory Profile Offsetting_OnTransServLineToProfileOnBeforeProcessLine"(ServiceLine: Record "Service Line"; var ShouldProcess: Boolean; var Item: Record Item)
    var
        ServiceHeader: Record "Service Header";
    begin
        if ServiceLine."Document Type" <> Enum::"Service Document Type"::Order then
            exit;
        ServiceHeader.SetLoadFields("Release Status");
        ServiceHeader.Get(ServiceLine."Document Type", ServiceLine."Document No.");
        ShouldProcess := ServiceHeader."Release Status" <> Enum::"Service Doc. Release Status"::Open;
    end;
#else
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Service Line Invt. Profile", OnTransServLineToProfileOnBeforeProcessLine, '', false, false)]
    local procedure "Service Line Invt. Profile_OnTransServLineToProfileOnBeforeProcessLine"(ServiceLine: Record "Service Line"; var ShouldProcess: Boolean; var Item: Record Item)
    var
        ServiceHeader: Record "Service Header";
    begin
        if ServiceLine."Document Type" <> Enum::"Service Document Type"::Order then
            exit;
        ServiceHeader.SetLoadFields("Release Status");
        ServiceHeader.Get(ServiceLine."Document Type", ServiceLine."Document No.");
        ShouldProcess := ServiceHeader."Release Status" <> Enum::"Service Doc. Release Status"::Open;
    end;
#endif

    [EventSubscriber(ObjectType::Table, Database::"Job Planning Line", OnAfterFilterLinesWithItemToPlan, '', false, false)]
    local procedure "Job Planning Line_OnAfterFilterLinesWithItemToPlan"(var JobPlanningLine: Record "Job Planning Line"; var Item: Record Item)
    begin
        JobPlanningLine.SetRange("COL Planning Approved", true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Get Unplanned Demand", OnBeforeGetUnplannedJobPlanningLine, '', false, false)]
    local procedure "Get Unplanned Demand_OnBeforeGetUnplannedJobPlanningLine"(var UnplannedDemand: Record "Unplanned Demand"; var JobPlanningLine: Record "Job Planning Line")
    begin
        JobPlanningLine.SetRange("COL Planning Approved", true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Mfg. Carry Out Action", OnAfterInsertProdOrder, '', false, false)]
    local procedure "Carry Out Action_OnAfterInsertProdOrder"(var ProductionOrder: Record "Production Order"; ProdOrderChoice: Integer; var RequisitionLine: Record "Requisition Line")
    begin
        if ProductionOrder.Status in [ProductionOrder.Status::"Firm Planned", ProductionOrder.Status::Planned] then begin
            ProductionOrder."COL Internal Status" := ProductionOrder."COL Internal Status"::Released;
            ProductionOrder.Modify(true);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Carry Out Action", OnAfterCarryOutToReqWksh, '', false, false)]
    local procedure OnAfterCarryOutToReqWksh(var RequisitionLine: Record "Requisition Line"; RequisitionLine2: Record "Requisition Line")
    var
        UntrackedPlanningElement: Record "Untracked Planning Element";
        UntrackedPlanningElement2: Record "Untracked Planning Element";
    begin
        UntrackedPlanningElement.SetRange("Worksheet Template Name", RequisitionLine2."Worksheet Template Name");
        UntrackedPlanningElement.SetRange("Worksheet Batch Name", RequisitionLine2."Journal Batch Name");
        UntrackedPlanningElement.SetRange("Worksheet Line No.", RequisitionLine2."Line No.");
        if UntrackedPlanningElement.FindSet() then
            repeat
                UntrackedPlanningElement2.Init();
                UntrackedPlanningElement2 := UntrackedPlanningElement;
                UntrackedPlanningElement2."Worksheet Template Name" := RequisitionLine."Worksheet Template Name";
                UntrackedPlanningElement2."Worksheet Batch Name" := RequisitionLine."Journal Batch Name";
                UntrackedPlanningElement2."Worksheet Line No." := RequisitionLine."Line No.";
                UntrackedPlanningElement2.Insert(true);
            until UntrackedPlanningElement.Next() = 0;
    end;
}