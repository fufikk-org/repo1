namespace Weibel.Service.Document;

using Microsoft.Service.Document;
using Microsoft.Projects.Project.Job;

pageextension 70171 "COL Service Order Subform" extends "Service Order Subform"
{
    layout
    {
        addafter("Description")
        {
            field("COL Project Code"; Rec."COL Project Code")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;

                trigger OnDrillDown()
                var
                    Job: Record "Job";
                    ProjectCardWithTaskPGS: Page "Project Card With Task (PGS)";
                begin
                    if Rec."COL Project Code" = '' then
                        exit;
                    Job.SetRange("No.", Rec."COL Project Code");
                    ProjectCardWithTaskPGS.SetTableView(Job);
                    ProjectCardWithTaskPGS.Run();
                end;
            }
        }

        addafter("Repair Status Code")
        {
            field("COL Export Classification"; ClassificationTxt)
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Export Classification Code';
                ToolTip = 'Specifies export classification.';
            }
        }
    }

    var
        ClassificationTxt: Text;

    trigger OnAfterGetRecord()
    begin
        ClassificationTxt := '';
        if Rec."COL Export Classification Code" <> Rec."COL Export Classification Code"::Unknown then
            ClassificationTxt := Format(Rec."COL Export Classification Code");
    end;
}
