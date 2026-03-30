page 70224 "COL PrintNode Printers"
{
    ApplicationArea = All;
    Caption = 'PrintNode Printers';
    PageType = List;
    SourceTable = "COL PrintNode Printers";
    UsageCategory = Lists;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Printer Id"; Rec."Printer Id")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Default Label Size"; Rec."Default Label Size")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(UpdateApiKey)
            {
                ApplicationArea = All;
                Caption = 'Update ApiKey';
                Image = Setup;
                ToolTip = 'Update the PrintNode API Key stored in isolated storage.';

                trigger OnAction()
                var
                    ApiKeyDialog: Page "COL API Key Dialog";
                    ApiKey: Text;
                begin
                    if ApiKeyDialog.RunModal() = Action::OK then begin
                        ApiKey := ApiKeyDialog.GetInputText();
                        if ApiKey <> '' then begin
                            if not IsolatedStorage.Set('COL_PrintNodeApiKey', ApiKey, DataScope::Company) then
                                Error(FailedToSaveErr);
                            Message(ApiKeyUpdatedMsg);
                        end else
                            Error(ApiKeyEmptyErr);
                    end;
                end;
            }
            action(UpdatePrinters)
            {
                ApplicationArea = All;
                Caption = 'Update Printers';
                Image = PostPrint;
                ToolTip = 'Retrieve printers from PrintNode API and update the table.';

                trigger OnAction()
                var
                    PrintNodePrinter: Record "COL PrintNode Printers";
                    RestClient: Codeunit "Rest Client";
                    Base64Convert: Codeunit "Base64 Convert";
                    JArray: JsonArray;
                    JToken: JsonToken;
                    JObject: JsonObject;
                    ApiKey: Text;
                    AuthHeader: SecretText;
                    PrinterId: Integer;
                    PrinterName: Text[100];
                    Counter: Integer;
                begin
                    if not IsolatedStorage.Get('COL_PrintNodeApiKey', DataScope::Company, ApiKey) then
                        Error(NoApiKeyErr);

                    RestClient.Create();
                    AuthHeader := SecretText.SecretStrSubstNo(AuthHeaderLbl, Base64Convert.ToBase64(StrSubstNo(UserKeyLbl, ApiKey)));
                    RestClient.SetAuthorizationHeader(AuthHeader);

                    JArray := RestClient.GetAsJson('https://api.printnode.com/printers').AsArray();

                    Counter := 0;

                    foreach JToken in JArray do begin
                        JObject := JToken.AsObject();

                        if JObject.Get('id', JToken) then
                            PrinterId := JToken.AsValue().AsInteger();

                        if JObject.Get('name', JToken) then
                            PrinterName := CopyStr(JToken.AsValue().AsText(), 1, 100);

                        if not PrintNodePrinter.Get(PrinterId) then begin
                            PrintNodePrinter.Init();
                            PrintNodePrinter."Printer Id" := PrinterId;
                            PrintNodePrinter.Description := PrinterName;
                            PrintNodePrinter.Insert();
                            Counter += 1;
                        end else begin
                            PrintNodePrinter.Description := PrinterName;
                            PrintNodePrinter.Modify();
                            Counter += 1;
                        end;
                    end;

                    Message(PrintersUpdatedMsg, Counter);
                    CurrPage.Update(false);
                end;
            }
        }
        area(Navigation)
        {
            action(CableLabelTemplates)
            {
                ApplicationArea = All;
                Caption = 'Cable Label Templates';
                Image = Template;
                ToolTip = 'Open the Cable Label Templates page.';
                RunObject = page "COL Cable Label Templates";
            }
        }
        area(Promoted)
        {
            actionref(UpdateApiKey_Promoted; UpdateApiKey) { }
            actionref(UpdatePrinters_Promoted; UpdatePrinters) { }
            actionref(CableLabelTemplates_Promoted; CableLabelTemplates) { }
        }
    }

    var
        FailedToSaveErr: Label 'Failed to save API Key to isolated storage.';
        ApiKeyUpdatedMsg: Label 'API Key has been updated successfully.';
        ApiKeyEmptyErr: Label 'API Key cannot be empty.';
        NoApiKeyErr: Label 'PrintNode API Key is not configured. Please update the API Key first.';
        PrintersUpdatedMsg: Label '%1 printer(s) updated successfully.', Comment = '%1 = Number of printers updated';
        AuthHeaderLbl: Label 'Basic %1', Locked = true;
        UserKeyLbl: Label 'User:%1', Locked = true;
}
