namespace Weibel.Projects.RoleCenters;

using Microsoft.Projects.RoleCenters;
using Weibel.Projects.Project.Planning;

pageextension 70145 "COL Job Project Manager RC" extends "Job Project Manager RC"
{
    layout
    {
        addafter(Control33)
        {
            part("COL Job Planning Approvals"; "COL Job Planning Approvals")
            {
                ApplicationArea = All;
            }
        }
    }
}