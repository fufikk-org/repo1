namespace Weibel.Projects.Project.Planning;

page 70105 "COL Job Planning Approvals"
{
    Caption = 'Project Planning';
    ApplicationArea = All;
    PageType = CardPart;
    RefreshOnActivate = true;
    ShowFilter = false;

    layout
    {
        area(Content)
        {
            cuegroup(PlanningApprovals)
            {
                Caption = 'Planning Approval';

                field("COL JobPlanningLinesToApprove"; JobPlanningLinesToApprove)
                {
                    ToolTip = 'Specifies how many project planning lines are pending planning approval.';
                    Caption = 'Pending Planning Approval';
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        JobPlanningApprMgt: Codeunit "COL Job Planning Appr. Mgt.";
                    begin
                        JobPlanningApprMgt.ShowJPLForApproval();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        Clear(BackgroundTaskParams);
        CurrPage.EnqueueBackgroundTask(BackgroundTaskId, Codeunit::"COL Job Planning Appr. Mgt.", BackgroundTaskParams, 5000, PageBackgroundTaskErrorLevel::Ignore);
    end;

    trigger OnPageBackgroundTaskCompleted(TaskId: Integer; Results: Dictionary of [Text, Text])
    begin
        if TaskId <> BackgroundTaskId then
            exit;
        Evaluate(JobPlanningLinesToApprove, Results.Get('JPLForApproval'));
    end;

    var
        JobPlanningLinesToApprove, BackgroundTaskId : Integer;
        BackgroundTaskParams: Dictionary of [Text, Text];
}