namespace Weibel.System.Automation;

using System.Automation;
using Microsoft.Service.Document;
using Weibel.Service.Document;

codeunit 70107 "COL Service Workflow Setup"
{
    var
        WorkflowSetup: Codeunit "Workflow Setup";
        BlankDateFormula: DateFormula;
        WorkflowPrefixLbl: Label 'WBL', locked = true;
        ServiceCreditMemoApprWorkflowCodeTxt: Label 'SRVCRMEMO', Locked = true;
        ServiceCreditMemoApprWorkflowDescTxt: Label 'Service Credit Memo Approval Workflow';
        ServiceCatLbl: Label 'SERVICE', Locked = true;
        ServiceCatDescLbl: Label 'Service Documents';

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", OnAddWorkflowCategoriesToLibrary, '', false, false)]
    local procedure "Workflow Setup_OnAddWorkflowCategoriesToLibrary"()
    begin
        WorkflowSetup.InsertWorkflowCategory(ServiceCatLbl, ServiceCatDescLbl);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", OnAfterInsertApprovalsTableRelations, '', false, false)]
    local procedure "Workflow Setup_OnAfterInsertApprovalsTableRelations"()
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        WorkflowSetup.InsertTableRelation(Database::"Service Header", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Setup", OnInsertWorkflowTemplates, '', false, false)]
    local procedure "Workflow Setup_OnInsertWorkflowTemplates"(var Sender: Codeunit "Workflow Setup")
    begin
        InsertServiceCrMemoWorkflowTemplate();
    end;

    procedure InsertServiceCrMemoWorkflowTemplate()
    var
        Workflow: Record Workflow;
        ApprovalEntry: Record "Approval Entry";
    begin
        InsertWorkflowTemplate(Workflow, ServiceCreditMemoApprWorkflowCodeTxt, ServiceCreditMemoApprWorkflowDescTxt, ServiceCatLbl);
        InsertServiceCreditMemoApprovalWorkflowDetails(Workflow);
        WorkflowSetup.MarkWorkflowAsTemplate(Workflow);
        WorkflowSetup.InsertTableRelation(Database::"Service Header", 0, Database::"Approval Entry", ApprovalEntry.FieldNo("Record ID to Approve"));
    end;

    procedure InsertWorkflowTemplate(var Workflow: Record Workflow; WorkflowCode: Code[17]; WorkflowDescription: Text[100]; CategoryCode: Code[20])
    begin
        Workflow.Init();
        Workflow.Code := GetWorkflowPrefixLbl() + WorkflowCode;
        Workflow.Description := WorkflowDescription;
        Workflow.Category := CategoryCode;
        Workflow.Enabled := false;
        if Workflow.Insert() then;
    end;

    local procedure InsertServiceCreditMemoApprovalWorkflowDetails(var Workflow: Record Workflow)
    var
        WorkflowStepArgument: Record "Workflow Step Argument";
        ServiceWorkflowMgt: Codeunit "COL Service Workflow Mgt.";
    begin
        WorkflowSetup.InitWorkflowStepArgument(
            WorkflowStepArgument, WorkflowStepArgument."Approver Type"::Approver,
            WorkflowStepArgument."Approver Limit Type"::"Direct Approver", 0, '', BlankDateFormula, true);

        WorkflowSetup.InsertDocApprovalWorkflowSteps(
            Workflow,
            BuildServiceHeaderTypeConditionsText(Enum::"Service Document Type"::"Credit Memo", Enum::"COL Service Document Status"::Open),
            ServiceWorkflowMgt.RunWorkflowOnSendServiceDocumentForApprovalCode(),
            BuildServiceHeaderTypeConditionsText(Enum::"Service Document Type"::"Credit Memo", Enum::"COL Service Document Status"::"Pending Approval"),
            ServiceWorkflowMgt.RunWorkflowOnCancelServiceDocumentForApprovalCode(),
            WorkflowStepArgument, true);
    end;

    procedure GetWorkflowPrefixLbl(): Text;
    begin
        exit(WorkflowPrefixLbl);
    end;

    procedure BuildServiceHeaderTypeConditionsText(DocumentType: Enum "Service Document Type"; Status: Enum "COL Service Document Status"): Text
    var
        ServiceHeader: Record "Service Header";
        ServiceLine: Record "Service Line";
        ServiceHeaderTypeConditionTxt: Label '<?xml version="1.0" encoding="utf-8" standalone="yes"?><ReportParameters><DataItems><DataItem name="Service Header">%1</DataItem><DataItem name="Service Line">%2</DataItem></DataItems></ReportParameters>', Locked = true;
    begin
        ServiceHeader.SetRange("Document Type", DocumentType);
        ServiceHeader.SetRange("COL Document Status", Status);
        exit(StrSubstNo(ServiceHeaderTypeConditionTxt,
            WorkflowSetup.Encode(ServiceHeader.GetView(false)), WorkflowSetup.Encode(ServiceLine.GetView(false))));
    end;
}