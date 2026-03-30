namespace Weibel.weibel.Test;

page 70140 "COL Pick Number"
{
    ApplicationArea = All;
    Caption = 'Pick Number';
    PageType = StandardDialog;

    layout
    {
        area(Content)
        {
            field("Pick Number"; PickNumber)
            {
                Editable = true;
                Caption = 'Pick Number';
                ToolTip = 'Specifies the pick number.';
            }
        }
    }

    var
        PickNumber: Integer;

    procedure GetNumber(): Integer
    begin
        exit(PickNumber);
    end;
}
