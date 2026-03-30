namespace Weibel.JobManager;

tableextension 70165 "COL JobManSetup" extends JobManSetup
{
    fields
    {
        field(70100; "COL Duplicate Resource Allowed"; Boolean)
        {
            Caption = 'Duplicate Resource Allowed';
            ToolTip = 'Specifies, if multiple employee cards can be assigned with the same resource no.';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                Rec."COL Updt. Resource from Empl." := not Rec."COL Duplicate Resource Allowed";
            end;
        }
        field(70101; "COL Updt. Resource from Empl."; Boolean)
        {
            Caption = 'Update Resource from Employee';
            ToolTip = 'Specifies, if resource selected on employee card should be updated with employee information.';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                Rec.TestField("COL Duplicate Resource Allowed");
            end;
        }
    }
}
