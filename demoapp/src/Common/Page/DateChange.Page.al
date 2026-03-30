namespace Weibel.Common;

page 70135 "COL Date Change"
{
    ApplicationArea = All;
    Caption = 'Date Change';
    PageType = StandardDialog;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Old Date"; OldDate)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Old Date';
                    ToolTip = 'Specifies the date that need to be changed.';
                }
                field("New Date"; NewDate)
                {
                    ApplicationArea = All;
                    Caption = 'New Date';
                    ToolTip = 'Specifies the new date.';
                }
            }

        }
    }

    var
        OldDate: Date;
        NewDate: Date;

    procedure SetOldDate(pDate: Date)
    begin
        OldDate := pDate;
    end;

    procedure GetNewDate(): Date;
    begin
        exit(NewDate);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        ChangeQtyErr: Label 'Change to Empty Date?';
    begin
        if (CloseAction = Action::OK) and (NewDate = 0D) then
            if not Confirm(ChangeQtyErr, true) then
                Error('');
    end;
}
