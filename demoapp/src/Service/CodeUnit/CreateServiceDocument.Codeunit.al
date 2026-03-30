namespace Weibel.Service.Document;

using Microsoft.Projects.Project.Job;
using Microsoft.Service.Document;
using Weibel.Common;

codeunit 70136 "COL Create Service Document"
{
    procedure CreateServiceOrderFrom(var Rec: Record "Job Task"; WithQuestions: Boolean)
    var
        OrderWasCreatedLbl: Label 'Service Order %1 created.', Comment = '%1 - Service Order.';
    begin
        CheckFromLine(Rec);

        if WithQuestions then
            if not AskQuestion() then
                exit;

        CreateOrder(Rec);
        CreateOrderLines(Rec);

        if WithQuestions then
            Message(OrderWasCreatedLbl, Rec."COL Service Order");
    end;

    local procedure CheckFromLine(var Rec: Record "Job Task")
    var
        OrderExistErr: Label 'Service Order already exists for this project task.';
        ServiceOrderItemNotExistErr: Label 'Service Item No. must be specified on project task.';
    begin
        if Rec."COL Service Order" <> '' then
            Error(OrderExistErr);

        if Rec."COL Service Item No." = '' then
            Error(ServiceOrderItemNotExistErr);
    end;

    local procedure AskQuestion(): Boolean
    var
        CreateSOForProjectTaskLbl: Label 'Create Service Order from this project task?';
    begin
        if Confirm(CreateSOForProjectTaskLbl) then
            exit(true);

        exit(false);
    end;

    local procedure CreateOrder(var Rec: Record "Job Task")
    var
        ServiceHeader: Record "Service Header";
        Job: Record Job;
        CommonCustMgt: Codeunit "COL Common Cust. Mgt";
    begin
        Job.Get(Rec."Job No.");

        ServiceHeader.Init();
        ServiceHeader."Document Type" := ServiceHeader."Document Type"::Order;
        ServiceHeader."Document Date" := WorkDate();
        ServiceHeader.Insert(true);

        ServiceHeader.Validate("Customer No.", Job."COL Existing End User No.");
        ServiceHeader.Validate("Project No. PGS", Rec."Job No.");
        ServiceHeader.Validate("Project Task Code PGS", Rec."Job Task No.");
        CommonCustMgt.CopyFromJob(ServiceHeader, Job);
        ServiceHeader.Validate("Shortcut Dimension 1 Code", Rec."Global Dimension 1 Code");
        ServiceHeader.Validate("Shortcut Dimension 2 Code", Rec."Global Dimension 2 Code");
        ServiceHeader.Modify(true);

        Rec.Validate("COL Service Order", ServiceHeader."No.");
        Rec.Modify(true);
    end;

    local procedure CreateOrderLines(var Rec: Record "Job Task")
    var
        ServiceItemLine: Record "Service Item Line";
    begin
        ServiceItemLine.Init();
        ServiceItemLine."Document Type" := ServiceItemLine."Document Type"::Order;
        ServiceItemLine."Document No." := Rec."COL Service Order";
        ServiceItemLine."Line No." := 10000;
        ServiceItemLine.Insert(true);

        ServiceItemLine.Validate("Service Item No.", Rec."COL Service Item No.");
        ServiceItemLine.Validate("Shortcut Dimension 1 Code", Rec."Global Dimension 1 Code");
        ServiceItemLine.Validate("Shortcut Dimension 2 Code", Rec."Global Dimension 2 Code");
        ServiceItemLine.Validate("COL Project Code", Rec."Job No.");
        ServiceItemLine.Validate("COL Project Task Code", Rec."Job Task No.");
        ServiceItemLine.Modify(true);
    end;
}
