namespace Weibel.HumanResources.Employee;

using Microsoft.HumanResources.Employee;
using Microsoft.Projects.Resources.Resource;

pageextension 70230 "COL Employee Card" extends "Employee Card"
{
    layout
    {
        modify("Resource No.")
        {
            Visible = not DuplicateResourceAllowed;
            Enabled = not DuplicateResourceAllowed;
        }

        addafter("Resource No.")
        {
            /// <summary>
            /// Replaces standard field on Employee Card to allow for resource to be assigned to multiple employees.
            /// </summary>
            field("COL Resource No."; ResourceNo)
            {
                Caption = 'Resource No. (Weibel)';
                ToolTip = 'Specifies a resource number for the employee.';
                ApplicationArea = All;
                TableRelation = Resource where(Type = const(Person));
                Visible = DuplicateResourceAllowed;

                trigger OnValidate()
                var
                    EmployeeResUpdate: Codeunit "Employee/Resource Update";
                begin
                    if ResourceNo = '' then
                        Rec.Validate("Resource No.", ResourceNo)
                    else begin
                        Rec."Resource No." := ResourceNo;
                        Rec.Modify(true);
                        if DoEmployeeResUpdate then
                            EmployeeResUpdate.ResUpdate(Rec);
                    end;
                end;
            }
        }
    }

    var
        JobManSetup: Record JobManSetup;
        DuplicateResourceAllowed: Boolean;
        DoEmployeeResUpdate: Boolean;
        ResourceNo: Code[20];

    trigger OnOpenPage()
    begin
        if not JobManSetup.Get() then begin
            JobManSetup.Init();
            DoEmployeeResUpdate := true;
            DuplicateResourceAllowed := false;
        end else begin
            DuplicateResourceAllowed := JobManSetup."COL Duplicate Resource Allowed";
            DoEmployeeResUpdate := JobManSetup."COL Updt. Resource from Empl.";
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        ResourceNo := Rec."Resource No.";
    end;
}
