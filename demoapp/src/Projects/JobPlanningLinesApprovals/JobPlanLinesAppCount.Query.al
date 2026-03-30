namespace Weibel.Projects.Project.Planning;

using Microsoft.Projects.Project.Planning;
using Microsoft.Projects.Project.Job;

query 70101 "COL Job Plan Lines App Count"
{
    Caption = 'Count Job Planning Lines for Approval';
    DataAccessIntent = ReadOnly;
    QueryType = Normal;

    elements
    {
        dataitem(JobPlanningLine; "Job Planning Line")
        {
            DataItemTableFilter = Type = const(Item), "COL Planning Approved" = const(false);

            filter(JobPlanningLine_JobNo; "Job No.") { }
            filter(JobPlanningLine_JobTaskNo; "Job Task No.") { }
            filter(JobPlanningLine_LineNo; "Line No.") { }

            column(JobPlanningLine_Count)
            {
                Method = Count;
            }

            dataitem(Job; Job)
            {
                DataItemTableFilter = Status = const(Open);
                DataItemLink = "No." = JobPlanningLine."Job No.";
                SqlJoinType = InnerJoin;
            }
        }
    }
}