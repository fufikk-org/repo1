page 70226 "COL API Key Dialog"
{
    ApplicationArea = All;
    Caption = 'Enter PrintNode API Key';
    PageType = StandardDialog;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("API Key"; ApiKey)
                {
                    ApplicationArea = All;
                    Caption = 'API Key';
                    ToolTip = 'Specifies the PrintNode API Key.';
                }
            }
        }
    }

    var
        ApiKey: Text[250];
        ApiKeyRequiredErr: Label 'API Key is required.';

    procedure GetInputText(): Text[250];
    begin
        exit(ApiKey);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if (CloseAction = Action::OK) and (ApiKey = '') then
            Error(ApiKeyRequiredErr);
    end;
}
