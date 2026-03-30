namespace Weibel.Inventory.Planning;

using Microsoft.Inventory.Planning;
using Weibel.AppManagement;

pageextension 70211 "COL Planning Error Log" extends "Planning Error Log"
{
    actions
    {
        addafter("&Show")
        {
            action("COL Get Error Log")
            {
                ApplicationArea = All;
                Caption = 'Get Error Log Archive';
                Image = Archive;
                ToolTip = 'Open Error Log Archive.';

                trigger OnAction()
                var
                    PlanningErrorLogArch: Record "COL Planning Error Log Arch.";
                    PlanningErrorLogArchive: Page "COL Planning Error Log Archive";
                begin
                    AddTablesForRetentionPolicy();
                    Commit();
                    PlanningErrorLogArch.SetRange("Journal Batch Name", Rec.GetFilter("Journal Batch Name"));
                    PlanningErrorLogArch.SetRange("Worksheet Template Name", Rec.GetFilter("Worksheet Template Name"));
                    PlanningErrorLogArchive.SetTableView(PlanningErrorLogArch);
                    PlanningErrorLogArchive.RunModal();
                end;
            }
        }

        addafter(Category_Process)
        {
            actionref("COL COL Get Error Log_Promoted"; "COL Get Error Log") { }
        }
    }

    local procedure AddTablesForRetentionPolicy()
    var
        InstallApp: Codeunit "COL Install App";
    begin
        InstallApp.AddTablesForRetentionPolicy();
    end;
}
