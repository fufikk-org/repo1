namespace Weibel.Projects.Project.Planning;

using Microsoft.Projects.Project.Planning;
using Microsoft.Projects.Project.Job;
using Microsoft.Inventory.Item;

codeunit 70123 "COL Job Planning Line Subs"
{
    [EventSubscriber(ObjectType::Table, Database::"Job Planning Line", OnAfterCopyFromItem, '', false, false)]
    local procedure "Job Planning Line_OnAfterCopyFromItem"(var JobPlanningLine: Record "Job Planning Line"; Job: Record Job; Item: Record Item)
    begin
        JobPlanningLine."COL Item Lead Time Calculation" := Item."Lead Time Calculation";
    end;
}