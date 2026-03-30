namespace Weibel.Manufacturing.Document;

using Microsoft.Manufacturing.Document;
using Weibel.Manufacturing.Archive;
using Weibel.Common;

codeunit 70133 "COL Prod. Order Subs."
{
    [EventSubscriber(ObjectType::Table, Database::"Production Order", 'OnBeforeValidateEvent', 'Due Date', false, false)]
    local procedure OnBeforeValidate(var Rec: Record "Production Order"; var xRec: Record "Production Order")
    begin
        CheckFields(Rec, xRec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Production Order", 'OnBeforeValidateEvent', 'Assigned User ID', false, false)]
    local procedure OnBeforeValidateAsUserID(var Rec: Record "Production Order"; var xRec: Record "Production Order")
    begin
        CheckFields(Rec, xRec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Production Order", 'OnBeforeValidateEvent', 'Inventory Posting Group', false, false)]
    local procedure OnBeforeValidateInvPost(var Rec: Record "Production Order"; var xRec: Record "Production Order")
    begin
        CheckFields(Rec, xRec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Production Order", 'OnBeforeValidateEvent', 'Gen. Bus. Posting Group', false, false)]
    local procedure OnBeforeValidateGenBus(var Rec: Record "Production Order"; var xRec: Record "Production Order")
    begin
        CheckFields(Rec, xRec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Production Order", 'OnBeforeValidateEvent', 'Gen. Prod. Posting Group', false, false)]
    local procedure OnBeforeValidateGenProd(var Rec: Record "Production Order"; var xRec: Record "Production Order")
    begin
        CheckFields(Rec, xRec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Production Order", 'OnBeforeValidateEvent', 'Shortcut Dimension 1 Code', false, false)]
    local procedure OnBeforeValidateSc1(var Rec: Record "Production Order"; var xRec: Record "Production Order")
    begin
        CheckFields(Rec, xRec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Production Order", 'OnBeforeValidateEvent', 'Shortcut Dimension 2 Code', false, false)]
    local procedure OnBeforeValidateSc2(var Rec: Record "Production Order"; var xRec: Record "Production Order")
    begin
        CheckFields(Rec, xRec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Production Order", 'OnBeforeValidateEvent', 'Bin Code', false, false)]
    local procedure OnBeforeValidateBinCode(var Rec: Record "Production Order"; var xRec: Record "Production Order")
    begin
        CheckFields(Rec, xRec);
    end;


    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Line", 'OnBeforeValidateEvent', 'Unit Cost', false, false)]
    local procedure OnBeforeValidateUnitCost(var Rec: Record "Prod. Order Line"; var xRec: Record "Prod. Order Line")
    begin
        CheckFields(Rec, xRec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Routing Line", 'OnBeforeValidateEvent', 'No.', false, false)]
    local procedure OnBeforeValidateNo(var Rec: Record "Prod. Order Routing Line"; var xRec: Record "Prod. Order Routing Line")
    begin
        CheckFields(Rec, xRec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Routing Line", 'OnBeforeValidateEvent', 'Description', false, false)]
    local procedure OnBeforeValidateDescription(var Rec: Record "Prod. Order Routing Line"; var xRec: Record "Prod. Order Routing Line")
    begin
        CheckFields(Rec, xRec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Routing Line", 'OnBeforeValidateEvent', 'Starting Date-Time', false, false)]
    local procedure OnBeforeValidateStartDate(var Rec: Record "Prod. Order Routing Line"; var xRec: Record "Prod. Order Routing Line")
    begin
        CheckFields(Rec, xRec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Routing Line", 'OnBeforeValidateEvent', 'Ending Date-Time', false, false)]
    local procedure OnBeforeValidateEndDate(var Rec: Record "Prod. Order Routing Line"; var xRec: Record "Prod. Order Routing Line")
    begin
        CheckFields(Rec, xRec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Routing Line", 'OnBeforeValidateEvent', 'Setup Time', false, false)]
    local procedure OnBeforeValidateSetupTime(var Rec: Record "Prod. Order Routing Line"; var xRec: Record "Prod. Order Routing Line")
    begin
        CheckFields(Rec, xRec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Routing Line", 'OnBeforeValidateEvent', 'Wait Time', false, false)]
    local procedure OnBeforeValidateWaitTime(var Rec: Record "Prod. Order Routing Line"; var xRec: Record "Prod. Order Routing Line")
    begin
        CheckFields(Rec, xRec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Routing Line", 'OnBeforeValidateEvent', 'Run Time', false, false)]
    local procedure OnBeforeValidateRunTime(var Rec: Record "Prod. Order Routing Line"; var xRec: Record "Prod. Order Routing Line")
    begin
        CheckFields(Rec, xRec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Prod. Order Routing Line", 'OnBeforeValidateEvent', 'Move Time', false, false)]
    local procedure OnBeforeValidateMoveTime(var Rec: Record "Prod. Order Routing Line"; var xRec: Record "Prod. Order Routing Line")
    begin
        CheckFields(Rec, xRec);
    end;

    local procedure CheckFields(var Rec: Record "Production Order"; var xRec: Record "Production Order")
    var
        FieldSelect: Codeunit "COL Field Select Mgt";
    begin
        if (Rec."COL Internal Status" = Rec."COL Internal Status"::Released) and (xRec."COL Internal Status" = xRec."COL Internal Status"::Released) then
            FieldSelect.CheckIfModifyAllowed(Rec, xRec);
    end;

    local procedure CheckFields(var Rec: Record "Prod. Order Line"; var xRec: Record "Prod. Order Line")
    var
        ProductionOrder: Record "Production Order";
        FieldSelect: Codeunit "COL Field Select Mgt";
    begin
        ProductionOrder.Get(Rec.Status, Rec."Prod. Order No.");
        if (ProductionOrder."COL Internal Status" = ProductionOrder."COL Internal Status"::Released) then
            FieldSelect.CheckIfModifyAllowed(Rec, xRec);
    end;

    local procedure CheckFields(var Rec: Record "Prod. Order Routing Line"; var xRec: Record "Prod. Order Routing Line")
    var
        ProductionOrder: Record "Production Order";
        FieldSelect: Codeunit "COL Field Select Mgt";
    begin
        ProductionOrder.Get(Rec.Status, Rec."Prod. Order No.");
        if (ProductionOrder."COL Internal Status" = ProductionOrder."COL Internal Status"::Released) then
            FieldSelect.CheckIfModifyAllowed(Rec, xRec);
    end;
}
