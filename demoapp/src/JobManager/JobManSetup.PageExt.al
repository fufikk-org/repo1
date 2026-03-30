namespace Weibel.JobManager;

pageextension 70236 "COL JobManSetup" extends JobManSetup
{
    layout
    {
        addlast(content)
        {
            group("COL Weibel")
            {
                Caption = 'Weibel', Locked = true;

                group("COL Employee")
                {
                    Caption = 'Employees';

                    field("COL Duplicate Resource Allowed"; Rec."COL Duplicate Resource Allowed")
                    {
                        ApplicationArea = All;
                    }
                    field("COL Updt. Resource from Empl."; Rec."COL Updt. Resource from Empl.")
                    {
                        ApplicationArea = All;
                        Enabled = Rec."COL Duplicate Resource Allowed";
                    }
                }
            }
        }
    }
}
