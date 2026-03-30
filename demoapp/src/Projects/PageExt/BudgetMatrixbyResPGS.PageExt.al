namespace Weibel.Projects.Project.Job;

using Microsoft.Projects.Project.Job;

pageextension 70197 "COL Budget Matrix by Res. PGS" extends "Budget Matrix by Resource PGS"
{
    layout
    {
        addafter("Basic Filters")
        {
            group("COL Change Reason Group")
            {
                Caption = 'Change Reason';
                ShowCaption = false;
                field("COL Change Reason"; ChangeReason)
                {
                    ApplicationArea = All;
                    Caption = 'Change Reason';
                    ToolTip = 'Specifies the change reason.';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        Job: Record "Job";
                    begin
                        if Job.Get(Rec."No.") then begin
                            Job.Validate("COL Change Reason", ChangeReason);
                            Job.Modify();
                            CurrPage.Update();
                            CurrPage.MatrixFormRes.Page.COLSetChangeReason(ChangeReason);
                        end;
                    end;
                }
            }
        }
    }


    var
        ChangeReason: Text[80];
}
