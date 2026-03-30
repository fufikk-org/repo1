namespace Weibel.Inventory.Planning;

using Microsoft.Inventory.Requisition;

pageextension 70105 "COL Requisition Lines" extends "Requisition Lines"
{
    actions
    {
        // These 2 standard actions for showing worksheet do not open desired planning worksheet and batch. Instead those open the last planning
        // worksheet used.
        modify("Show Worksheet")
        {
            Visible = false;
        }
        modify("Show Worksheet_Promoted")
        {
            Visible = false;
        }

        addlast("&Line")
        {
            action("COL OpenWorksheet")
            {
                Caption = 'Show Worksheet';
                ApplicationArea = All;
                ToolTip = 'Open the worksheet that the lines come from.';
                Image = ViewWorksheet;

                trigger OnAction()
                var
                    RequisitionWkshName: Record "Requisition Wksh. Name";
                    ReqJnlManagement: Codeunit ReqJnlManagement;
                begin
                    RequisitionWkshName.Get(Rec."Worksheet Template Name", Rec."Journal Batch Name");
                    ReqJnlManagement.TemplateSelectionFromBatch(RequisitionWkshName);
                end;
            }
        }

        addbefore("Show Worksheet_Promoted")
        {
            actionref("COL OpenWorksheet_Promoted"; "COL OpenWorksheet") { }
        }
    }
}