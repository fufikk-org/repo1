namespace Weibel.Inventory.Ledger;

using Microsoft.Inventory.Ledger;
using Microsoft.Manufacturing.Document;
using System.Text;
using System.Utilities;
using System.RestClient;
using Microsoft.Inventory.Item;
report 70115 "COL Cable Label2"
{
    ApplicationArea = All;
    Caption = 'Cable Label';
    UsageCategory = Administration;
    ProcessingOnly = true;

    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            DataItemTableView = sorting("Entry No.");
            UseTemporary = true;

            trigger OnAfterGetRecord()
            var
                CableLabelTemplate: Record "COL Cable Label Template";
                Math: Codeunit Math;
                SizeErr: Label 'Offset and Space Size must be greater than zero.';
                NewLine: Text[2];
                InstructionText: Text[100];
                Instructions: List of [Text[100]];
                HasVariant: Boolean;
                HasSerialNo: Boolean;
                MaxLength: Integer;
                LOffset, ROffset : Integer;
                SpaceSize: Decimal;
                FullLength: Integer;
                TLength: Integer;
            begin
#pragma warning disable AA0205, AA0139
                NewLine[1] := 13;
                NewLine[2] := 10;

                HasVariant := ItemLedgerEntry."Variant Code" <> '';
                HasSerialNo := ItemLedgerEntry."Serial No." <> '';

                CableLabelTemplate.SetRange("Cable Size", CableSize);
                if CableLabelTemplate.FindSet() then
                    repeat
                        if LOffset = 0 then
                            LOffset := CableLabelTemplate.LeftOffset;
                        if ROffset = 0 then
                            ROffset := CableLabelTemplate.RightOffset;
                        if SpaceSize = 0 then
                            SpaceSize := CableLabelTemplate."Space Size";
                        if ShouldIncludeLine(CableLabelTemplate.Condition, HasVariant, HasSerialNo) then begin
                            InstructionText := CableLabelTemplate.Instruction;
                            InstructionText := InstructionText.Replace('{ITEMNO}', ItemLedgerEntry."Item No.");
                            InstructionText := InstructionText.Replace('{VARIANT}', ItemLedgerEntry."Variant Code");
                            InstructionText := InstructionText.Replace('{SERIALNO}', ItemLedgerEntry."Serial No.");
                            if InstructionText.StartsWith('T') then
                                if InstructionText.LastIndexOf(';') > 0 then
                                    MaxLength := Math.Max(MaxLength, StrLen(InstructionText) - InstructionText.LastIndexOf(';'));
                            Instructions.Add(InstructionText);

                        end;
                    until CableLabelTemplate.Next() = 0;

                if (LOffset = 0) or (SpaceSize = 0) or (MaxLength = 0) then
                    Error(SizeErr);

                FullLength := Round(LOffset + ROffset + MaxLength * SpaceSize, 1, '>');
                TLength := FullLength - LOffset;

                foreach InstructionText in Instructions do begin
                    InstructionText := InstructionText.Replace('{FULLLENGTH}', Format(FullLength) + '.00');
                    InstructionText := InstructionText.Replace('{TEXTLENGTH}', Format(TLength));

                    LabelText.AddText(InstructionText);
                    LabelText.AddText(NewLine);
                end;
#pragma warning restore AA0205, AA0139
            end;

            trigger OnPostDataItem()
            var
                RestClient: Codeunit "Rest Client";
                Base64Convert: Codeunit "Base64 Convert";
                JObject: JsonObject;
                JToken: JsonToken;
                Base64Text, Plain, ApiKey : Text;
                AuthHeader: SecretText;
                UserFormatLbl: Label 'User:%1', Locked = true;
            begin
                LabelText.GetSubText(Plain, 1);
                Base64Text := Base64Convert.ToBase64Url(Plain, TextEncoding::UTF8);
                JObject.Add('printerId', Format(PrinterId));
                JObject.Add('title', 'Label BC');
                JObject.Add('contentType', 'raw_base64');
                JObject.Add('content', Base64Text);
                JObject.Add('source', 'Dynamics BC Weibel');

                RestClient.Create();
                IsolatedStorage.Get('COL_PrintNodeApiKey', DataScope::Company, ApiKey);
                AuthHeader := SecretText.SecretStrSubstNo('Basic ' + Base64Convert.ToBase64(StrSubstNo(UserFormatLbl, ApiKey)));
                RestClient.SetAuthorizationHeader(AuthHeader);

                JToken := RestClient.PostAsJson('https://api.printnode.com/printjobs', JObject);

            end;
        }
    }


    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(CableOptions)
                {
                    Caption = 'Options';
                    field(PrinterIdFld; PrinterId)
                    {
                        Caption = 'Printer Id';
                        ToolTip = 'Specifies Printer';
                        ApplicationArea = All;
                        Editable = false;
                        trigger OnAssistEdit()
                        begin
                            SelectPrinter();
                        end;
                    }
                    field(PrinterFld; PrinterName)
                    {
                        Caption = 'Printer Name';
                        ToolTip = 'Specifies Printer';
                        ApplicationArea = All;
                        Editable = false;

                        trigger OnAssistEdit()
                        begin
                            SelectPrinter();
                        end;
                    }
                    field(CableSizeFld; CableSize)
                    {
                        Caption = 'Cable Size';
                        ToolTip = 'Select the cable size for the label.';
                        ApplicationArea = All;
                    }


                }
                group(Info)
                {
                    Caption = 'Information';
                    label(NoSerial)
                    {
                        Visible = not SerialFilled;
                        ApplicationArea = Basic, Suite;
                        Caption = 'Serial Number has not been entered.';
                        Style = Attention;
                    }
                    field(VariantCode; VariantCodeReq)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Variant Code';
                        ToolTip = 'Select Variant for to print.';
                        Visible = VariantToSelected;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            ItemVariant: Record "Item Variant";
                            ItemVariants: Page "Item Variants";
                        begin
                            ItemVariant.SetRange("Item No.", CurrItemNo);
                            ItemVariants.SetTableView(ItemVariant);
                            ItemVariants.LookupMode := true;
                            if ItemVariants.RunModal() = Action::LookupOK then begin
                                ItemVariants.GetRecord(ItemVariant);
                                VariantCodeReq := ItemVariant."Code";
                                if ItemLedgerEntry.FindFirst() then begin
                                    ItemLedgerEntry."Variant Code" := VariantCodeReq;
                                    ItemLedgerEntry.Modify(false);
                                end;
                            end;
                        end;

                        trigger OnValidate()
                        var
                            ItemVariant: Record "Item Variant";
                        begin
                            if ItemLedgerEntry.FindFirst() then begin
                                ItemVariant.Get(ItemLedgerEntry."Item No.", VariantCodeReq);
                                ItemLedgerEntry."Variant Code" := VariantCodeReq;
                                ItemLedgerEntry.Modify(false);
                            end;
                        end;
                    }
                }
            }
        }
    }

    var
        LabelText: BigText;
        CableSize: Enum "COL Cable Size";
        SerialFilled: Boolean;
        VariantToSelected: Boolean;
        PrinterId: Integer;
        PrinterName: Text[100];
        VariantCodeReq: Code[10];
        CurrItemNo: Code[20];

    local procedure SelectPrinter()
    var
        PrintNodePrinter: Record "COL PrintNode Printers";
        PrintNodePrinters: Page "COL PrintNode Printers";
    begin
        PrintNodePrinter.SetRange("Default Label Size", Enum::"COL Cable Size"::"17", ENUM::"COL Cable Size"::"81");
        PrintNodePrinters.SetTableView(PrintNodePrinter);
        PrintNodePrinters.LookupMode := true;
        if PrintNodePrinters.RunModal() = Action::LookupOK then begin
            PrintNodePrinters.GetRecord(PrintNodePrinter);
            PrinterId := PrintNodePrinter."Printer Id";
            PrinterName := PrintNodePrinter.Description;
            CableSize := PrintNodePrinter."Default Label Size";
        end;
    end;

    local procedure ShouldIncludeLine(Condition: Enum "COL Cable Label Condition"; HasVariant: Boolean; HasSerialNo: Boolean): Boolean
    begin
        case Condition of
            Condition::Always:
                exit(true);
            Condition::"If Variant":
                exit(HasVariant);
            Condition::"If Not Variant":
                exit(not HasVariant);
            Condition::"If Serial No":
                exit(HasSerialNo);
            Condition::"If Not Serial No":
                exit(not HasSerialNo);
        end;
    end;

    procedure SetData(var pItemLedgerEntry: Record "Item Ledger Entry")
    begin
        if pItemLedgerEntry.FindSet() then
            repeat
                if pItemLedgerEntry."Serial No." = '' then
                    SerialFilled := false
                else
                    SerialFilled := true;

                ItemLedgerEntry.TransferFields(pItemLedgerEntry);
                ItemLedgerEntry.Insert();
            until pItemLedgerEntry.Next() = 0;
    end;

    procedure SetData(var pol: Record "Prod. Order Line")
    begin
        ItemLedgerEntry."Entry No." := 1;
        ItemLedgerEntry."Item No." := pol."Item No.";
        ItemLedgerEntry."Serial No." := '';
        ItemLedgerEntry."Variant Code" := pol."Variant Code";
        ItemLedgerEntry.Insert();
    end;

    procedure SetData(var item: Record "Item")
    begin
        VariantToSelected := true;
        CurrItemNo := item."No.";

        ItemLedgerEntry."Entry No." := 1;
        ItemLedgerEntry."Item No." := item."No.";
        ItemLedgerEntry."Serial No." := '';
        ItemLedgerEntry."Variant Code" := '';
        ItemLedgerEntry.Insert();
    end;
}
