namespace Weibel.Inventory.Item;
page 70264 "COL Blocking Reason Dialog"
{
    ApplicationArea = All;
    Caption = 'Enter Blocking Change Reason';
    PageType = StandardDialog;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(Reason; ReasonText)
                {
                    ApplicationArea = All;
                    Caption = 'Reason';
                    ToolTip = 'Specifies the reason for the blocking change.';
                    MultiLine = true;
                }
            }
        }
    }
    var
        ReasonText: Text[80];

    procedure GetReason(): Text[80]
    var
        ReasonMandatoryErr: Label 'Reason is mandatory.';
    begin
        if ReasonText.Trim() = '' then
            Error(ReasonMandatoryErr);
        exit(CopyStr(ReasonText.Trim(), 1, 80));
    end;

    procedure SetReason(NewReason: Text[80])
    begin
        ReasonText := NewReason;
    end;
}