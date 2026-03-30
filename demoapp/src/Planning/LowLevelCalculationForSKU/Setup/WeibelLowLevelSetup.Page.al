#if not HIDE_LOWLEVEL_SKU
namespace Weibel.Manufacturing.ProductionBOM;

using System.Threading;
using Weibel.Utilities;

page 70223 "COL Weibel Low Level Setup"
{
    ApplicationArea = All;
    Caption = 'Weibel Low Level Setup';
    PageType = Card;
    SourceTable = "COL Weibel Low Level Setup";
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Log Warnings"; Rec."Log Warnings")
                {
                }
                field("Log Low Level Details"; Rec."Log Low Level Details")
                {
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(JobQueue)
            {
                Caption = 'Job Queue';
                ToolTip = 'Create or open job queue entry for running low level code calculations.';
                Image = Job;

                trigger OnAction()
                var
                    JobQueueEntry: Record "Job Queue Entry";
                    JobQueueMgt: Codeunit "COL Job Queue Mgt.";
                    JQDescriptionLbl: Label 'Weibel Low Level Calculation', Locked = true;
                begin
                    JobQueueMgt.CreateJobQueue(JobQueueEntry."Object Type to Run"::Codeunit, Codeunit::"COL Weibel Low Level Calc.", JQDescriptionLbl);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}

#endif