namespace Weibel.Finance.GeneralLedger.Journal;

using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Finance.VAT.Setup;
using System.Reflection;
using System.IO;
using System.Utilities;

codeunit 70251 "COL Import Acubiz File"
{
    var
        SelectCSVFileToImportLbl: Label 'Select Acubiz File';
        CSVFilesFilterLbl: Label 'CSV Files (*.csv)|*.csv';
        ImportCompletedSuccessfullyLbl: Label 'Import completed successfully.';
        InvalidCSVFormatErr: Label 'Invalid CSV format. Expected at least 7 columns, found %1 in line: %2', Comment = '%1 = Number of columns found, %2 = CSV line content';
        InvalidLineNoErr: Label 'Invalid Line No. in CSV: %1', Comment = '%1 = Invalid line number value';
        InvalidPostingDateErr: Label 'Invalid Posting Date in CSV: %1', Comment = '%1 = Invalid posting date value';
        InvalidAmountErr: Label 'Invalid Amount in CSV: %1', Comment = '%1 = Invalid amount value';

    procedure ImportCSVFile(var GenJournalLine: Record "Gen. Journal Line")
    var
        InStream: InStream;
        FileName: Text;
        FileContent: Text;
    begin
        if not UploadIntoStream(SelectCSVFileToImportLbl, '', CSVFilesFilterLbl, FileName, InStream) then
            exit;
        GenJournalLine.Init();
        while not InStream.EOS do begin
            InStream.ReadText(FileContent);
            if FileContent.Trim() = '' then
                continue;
            CreateJournalLineFromCSV(FileContent, GenJournalLine);
        end;

        Message(ImportCompletedSuccessfullyLbl);
    end;

    local procedure CreateJournalLineFromCSV(CSVLine: Text; var GenJournalLine: Record "Gen. Journal Line")
    var
        GLAccount: Record "G/L Account";
        NewGenJournalLine: Record "Gen. Journal Line";
        TypeHelper: Codeunit "Type Helper";
        Fields: List of [Text];
        CSVLineNo: Integer;
        PostingDate: Date;
        GLAccountNo: Code[20];
        Amount: Decimal;
        VATProdPostingGroup: Code[20];
        Description: Text[100];
        AcuBizTravelId: Text[50];
        NewLineNo: Integer;
        FieldText: Text;
        Variant: Variant;
    begin
        Clear(PostingDate);
        Fields := CSVLine.Split(';');

        if Fields.Count < 7 then
            Error(InvalidCSVFormatErr, Fields.Count, CSVLine);

        // Parse fields according to specification
        // Column 1: Line No.
        FieldText := Fields.Get(1);
        if not Evaluate(CSVLineNo, FieldText) then
            Error(InvalidLineNoErr, FieldText);

        // Column 2: Posting Date
        FieldText := Fields.Get(2);

        Variant := PostingDate;
        if not TypeHelper.Evaluate(Variant, FieldText, 'dd-MM-yyyy', '') then
            Error(InvalidPostingDateErr, FieldText);
        PostingDate := Variant2Date(Variant);
        // Column 3: Ignore

        // Column 4: G/L Account No.
        GLAccountNo := CopyStr(Fields.Get(4), 1, MaxStrLen(GLAccountNo));

        // Column 5: Amount
        FieldText := Fields.Get(5);
        if not Evaluate(Amount, FieldText) then
            Error(InvalidAmountErr, FieldText);

        // Column 6: VAT Prod. Posting Group
        VATProdPostingGroup := CopyStr(Fields.Get(6), 1, MaxStrLen(VATProdPostingGroup));

        // Column 7: Description
        Description := CopyStr(Fields.Get(7), 1, MaxStrLen(Description));

        if Fields.Count >= 16 then
            AcuBizTravelId := CopyStr(Fields.Get(16), 1, MaxStrLen(AcuBizTravelId));

        NewGenJournalLine.Init();
        NewGenJournalLine."Journal Template Name" := GenJournalLine."Journal Template Name";
        NewGenJournalLine."Journal Batch Name" := GenJournalLine."Journal Batch Name";
        NewLineNo := GetNextLineNo(GenJournalLine);
        NewGenJournalLine."Line No." := NewLineNo;

        if GenJournalLine."Document No." = '' then
            NewGenJournalLine.SetUpNewLine(GenJournalLine, 0, true)
        else
            NewGenJournalLine."Document No." := GenJournalLine."Document No.";

        NewGenJournalLine.Validate("Account Type", NewGenJournalLine."Account Type"::"G/L Account");
        NewGenJournalLine.Validate("Account No.", GLAccountNo);
        NewGenJournalLine.Validate("Posting Date", PostingDate);
        NewGenJournalLine.Validate("Document Date", PostingDate);
        NewGenJournalLine.Validate(Amount, Amount);
        if VATProdPostingGroup <> '' then begin
            GLAccount.SetLoadFields("Gen. Posting Type", "VAT Bus. Posting Group");
            GLAccount.Get(NewGenJournalLine."Account No.");
            NewGenJournalLine."Gen. Posting Type" := GLAccount."Gen. Posting Type";
            NewGenJournalLine.Validate("VAT Bus. Posting Group", GLAccount."VAT Bus. Posting Group");
            NewGenJournalLine.Validate("VAT Prod. Posting Group", VATProdPostingGroup);
        end;
        NewGenJournalLine.Validate(Description, Description);
        NewGenJournalLine.Validate("COL Acubiz Travel ID", AcuBizTravelId);
        NewGenJournalLine.Insert(true);

        GenJournalLine := NewGenJournalLine;
    end;

    local procedure GetNextLineNo(GenJournalLine: Record "Gen. Journal Line"): Integer
    var
        GenJournalLine2: Record "Gen. Journal Line";
    begin
        GenJournalLine2.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        GenJournalLine2.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        if GenJournalLine2.FindLast() then
            exit(GenJournalLine2."Line No." + 10000)
        else
            exit(10000);
    end;
}