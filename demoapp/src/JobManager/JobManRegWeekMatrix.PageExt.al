namespace Weibel.JobManager;

pageextension 70227 "COL JobManRegWeekMatrix" extends JobManRegWeekMatrix
{
    layout
    {
        addafter(Description)
        {
            field("COL FogBugz/Jira No."; Rec."COL FogBugz/Jira No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("COL ColIsBlocked"; Rec.COLIsBlocked())
            {
                Editable = false;
                ApplicationArea = All;
                Caption = 'Is Blocked';
                ToolTip = 'Indicates whether the job is blocked.';
            }
        }
        modify(JobNo)
        {
            trigger OnBeforeValidate()
            var
                JobManJob: Record "JobManJob";
                JobManSetup: Record "JobManSetup";
                JobBlockedLbl: Label 'Warning: The job is blocked and should not be used for registrations.';
            begin
                if Rec.JobNo = '' then
                    exit;
                JobManJob.Get(Rec.JobNo);
                JobManSetup.SetLoadFields("COL Error on Blocked Job");
                JobManSetup.Get();
                if JobManJob.COLIsBlocked() then
                    if JobManSetup."COL Error on Blocked Job" then
                        Error(JobBlockedLbl)
                    else
                        Message(JobBlockedLbl);
            end;

        }
    }
}
