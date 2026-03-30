namespace Weibel.Projects.Project.Planning;

using Microsoft.Projects.Project.Planning;

codeunit 70122 "COL Job Planning Appr. Mgt."
{
    trigger OnRun()
    var
        BackgroundTaskResults: Dictionary of [Text, Text];
        NoOfJPLForApproval: Integer;
    begin
        CalculateDataForPage(NoOfJPLForApproval);
        BackgroundTaskResults.Add('JPLForApproval', Format(NoOfJPLForApproval));
        Page.SetBackgroundTaskResult(BackgroundTaskResults);
    end;

    local procedure CalculateDataForPage(var NoOfJPLForApproval: Integer)
    var
        JobPlanLinesAppCount: Query "COL Job Plan Lines App Count";
    begin
        JobPlanLinesAppCount.Open();
        JobPlanLinesAppCount.Read();
        NoOfJPLForApproval := JobPlanLinesAppCount.JobPlanningLine_Count;
    end;

    internal procedure ApproveJobPlanningLinesForPlanning(var JobPlanningLine: Record "Job Planning Line")
    var
        JobPlanningLine2: Record "Job Planning Line";
    begin
        if JobPlanningLine.FindSet() then
            repeat
                if not JobPlanningLine."COL Planning Approved" then
                    if JobPlanningLine2.Get(JobPlanningLine."Job No.", JobPlanningLine."Job Task No.", JobPlanningLine."Line No.") then begin
                        JobPlanningLine2.Validate("COL Planning Approved", true);
                        JobPlanningLine2.Modify(true);
                    end;
            until JobPlanningLine.Next() = 0;
    end;

    internal procedure ShowJPLForApproval()
    var
        JobPlanningLine: Record "Job Planning Line";
        JobPlanLinesForAppr: Query "COL Job Plan. Lines for Appr.";
    begin
        JobPlanLinesForAppr.Open();
        while JobPlanLinesForAppr.Read() do
            if JobPlanningLine.Get(JobPlanLinesForAppr.JobPlanningLine_JobNo, JobPlanLinesForAppr.JobPlanningLine_JobTaskNo, JobPlanLinesForAppr.JobPlanningLine_LineNo) then
                JobPlanningLine.Mark(true);
        JobPlanningLine.MarkedOnly(true);
        Page.Run(Page::"Job Planning Lines", JobPlanningLine);
    end;
}