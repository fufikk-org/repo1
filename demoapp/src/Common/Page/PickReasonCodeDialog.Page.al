namespace Weibel.Common;

using Microsoft.Foundation.AuditCodes;

page 70125 "COL Pick Reason Code Dialog"
{
    ApplicationArea = All;
    Caption = 'Pick Reason Code Dialog';
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
                    Caption = 'Reason Code';
                    ToolTip = 'Specifies the change reason.';
                    TableRelation = "Reason Code";
                }
            }
        }
    }

    var
        ChangeReason: Code[10];

    procedure GetInputText(): Code[10];
    begin
        exit(ChangeReason);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        ChangeReasonErr: Label 'Reason Code is required.';
    begin
        if (CloseAction = Action::OK) and (ChangeReason = '') then
            Error(ChangeReasonErr);
    end;
}
