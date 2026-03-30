pageextension 70117 "COL Workflow Templates" extends "Workflow Templates"
{
    actions
    {
        addlast(processing)
        {
            action("COL Reset Custom Templates")
            {
                ApplicationArea = Suite;
                Caption = 'Reset Custom Templates';
                Visible = not IsLookupMode;
                Image = ResetStatus;
                ToolTip = 'Recreate all Custom templates';

                trigger OnAction()
                begin
                    WorkflowSetup.SetCustomTemplateToken(CopyStr(ServiceWorkflowSetup.GetWorkflowPrefixLbl(), 1, 3));
                    ResetWorkflowTemplates();
                    Initialize();
                end;
            }
        }
    }

    var
        WorkflowSetup: Codeunit "Workflow Setup";
        ServiceWorkflowSetup: Codeunit "COL Service Workflow Setup";

    internal procedure ResetWorkflowTemplates()
    var
        Workflow: Record Workflow;
        WorkflowStep: Record "Workflow Step";
        WorkflowStepArgument: Record "Workflow Step Argument";
    begin
        Workflow.SetRange(Template, true);
        Workflow.SetFilter(Code, '%1', WorkflowSetup.GetWorkflowTemplateToken() + '*');
        Workflow.DeleteAll();

        WorkflowStep.SetFilter("Workflow Code", '%1', WorkflowSetup.GetWorkflowTemplateToken() + '*');
        if WorkflowStep.FindSet() then begin
            repeat
                WorkflowStepArgument.SetRange(ID, WorkflowStep.Argument);
                WorkflowStepArgument.DeleteAll();
            until WorkflowStep.Next() = 0;
            WorkflowStep.DeleteAll();
        end;

        //WorkflowSetup.InitWorkflow(); 
        ServiceWorkflowSetup.InsertServiceCrMemoWorkflowTemplate();
    end;
}