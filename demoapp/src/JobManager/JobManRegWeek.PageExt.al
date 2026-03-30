pageextension 70251 "COL JobManRegWeek" extends JobManRegWeek
{
    layout
    {
        modify(InputValueEmployee)
        {
            Editable = InputValueEmployeeEditable;
        }
    }

    trigger OnOpenPage()
    begin
        InputValueEmployeeEditable := IsInputValueEmployeeEditable();
    end;

    var
        InputValueEmployeeEditable: Boolean;

    local procedure IsInputValueEmployeeEditable(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(UserId) then
            exit(UserSetup."COL Edit Empl. Week Timesheet");
        exit(false);
    end;
}