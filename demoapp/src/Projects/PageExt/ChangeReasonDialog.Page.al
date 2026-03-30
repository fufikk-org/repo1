namespace Weibel.Projects.Project.Job;

page 70116 "COL Change Reason Dialog"
{
    ApplicationArea = All;
    Caption = 'Type Change Reason Comment';
    PageType = StandardDialog;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Change Reason"; ChangeReason)
                {
                    ApplicationArea = All;
                    Caption = 'Change Reason';
                    ToolTip = 'Specifies the change reason.';
                }
            }
        }
    }

    var
        ChangeReason: Text[80];

    procedure GetInputText(): Text[80];
    begin
        exit(ChangeReason);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        ChangeReasonErr: Label 'Change Reason is required.';
    begin
        if (CloseAction = Action::OK) and (ChangeReason = '') then
            Error(ChangeReasonErr);
    end;
}
