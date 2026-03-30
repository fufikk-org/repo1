namespace Weibel.Projects.Project.Planning;

using Microsoft.Projects.Project.Planning;
using Microsoft.Projects.Project.Job;

query 70102 "COL Job Plan. Lines for Appr."
{
    Caption = 'Job Planning Lines for Approval';
    DataAccessIntent = ReadOnly;
    QueryType = Normal;

    elements
    {
        dataitem(JobPlanningLine; "Job Planning Line")
        {
            DataItemTableFilter = Type = const(Item), "COL Planning Approved" = const(false);

            column(JobPlanningLine_JobNo; "Job No.") { }
            column(JobPlanningLine_JobTaskNo; "Job Task No.") { }
            column(JobPlanningLine_LineNo; "Line No.") { }

            dataitem(Job; Job)
            {
                DataItemTableFilter = Status = const(Open);
                DataItemLink = "No." = JobPlanningLine."Job No.";
                SqlJoinType = InnerJoin;
            }
        }
    }
}