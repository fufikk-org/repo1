namespace Weibel.Intercompany;

using Microsoft.Foundation.Attachment;
using Microsoft.Sales.History;
using Microsoft.Sales.Receivables;
using Microsoft.Finance.GeneralLedger.Journal;
using System.Environment;
using System.Utilities;

page 70266 "COL IC Source Doc Attachments"
{
    Caption = 'Source Company Attachments';
    PageType = ListPart;
    SourceTable = "Document Attachment";
    SourceTableTemporary = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Attachments)
            {
                field(FileName; Rec."File Name")
                {
                    ApplicationArea = All;
                    Caption = 'File Name';
                    ToolTip = 'Specifies the file name of the attachment from the source company.';

                    trigger OnDrillDown()
                    begin
                        OpenAttachmentFromSource();
                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Open)
            {
                ApplicationArea = All;
                Caption = 'Open';
                Image = View;
                ToolTip = 'Open the attachment.';

                trigger OnAction()
                begin
                    OpenAttachmentFromSource();
                end;
            }
        }
    }


    trigger OnFindRecord(Which: Text): Boolean
    var
        Found: Boolean;
    begin
        if not LoadSourceCompanyAttachments(Rec.GetRangeMin("Line No.")) then
            exit(false);
        Found := TempDocumentAttachmentBuffer.Find(Which);
        if Found then
            Rec := TempDocumentAttachmentBuffer;
        exit(Found);
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    var
        ResultSteps: Integer;
    begin
        TempDocumentAttachmentBuffer.Copy(Rec);
        ResultSteps := TempDocumentAttachmentBuffer.Next(Steps);
        if ResultSteps <> 0 then
            Rec := TempDocumentAttachmentBuffer;
        exit(ResultSteps);
    end;

    var
        TempDocumentAttachmentBuffer: Record "Document Attachment" temporary;
        MediaGuidDict: Dictionary of [Guid, Guid];
        SourceCompanyName: Text[30];

    local procedure OpenAttachmentFromSource()
    var
        TenantMedia: Record "Tenant Media";
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
    begin
        TenantMedia.SetAutoCalcFields(Content);
        TenantMedia.Get(MediaGuidDict.Get(Rec.SystemId));
        TempBlob.FromRecord(TenantMedia, TenantMedia.FieldNo(Content));
        TempBlob.CreateInStream(InStr);
        File.ViewFromStream(InStr, Rec."File Name" + '.' + Rec."File Extension", true);
    end;

    local procedure LoadSourceCompanyAttachments(CustLedgerEntryNo: Integer): Boolean
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        ICTransaction: Record "COL Intercompany Transactions";
        DocAttachment: Record "Document Attachment";
        DataExists: Boolean;
    begin
        Clear(MediaGuidDict);
        CustLedgerEntry.ReadIsolation := IsolationLevel::ReadUncommitted;
        CustLedgerEntry.SetLoadFields("Document Type", "Document No.");
        CustLedgerEntry.SetRange("Document Type", CustLedgerEntry."Document Type"::Invoice);
        CustLedgerEntry.SetRange("Entry No.", CustLedgerEntryNo);
        if not CustLedgerEntry.FindFirst() then
            exit;

        TempDocumentAttachmentBuffer.Reset();
        TempDocumentAttachmentBuffer.DeleteAll();
        SourceCompanyName := '';

        // Find matching IC transaction
        ICTransaction.ReadIsolation := IsolationLevel::ReadUncommitted;
        ICTransaction.SetRange("Document No.", CustLedgerEntry."Document No.");
        ICTransaction.SetRange("Transaction Document Type", ICTransaction."Transaction Document Type"::"Sales Invoice");
        ICTransaction.SetRange("Destination Company", CompanyName());
        ICTransaction.SetRange(Processed, true);
        ICTransaction.SetLoadFields("Document No.", "Source Company");
        if ICTransaction.IsEmpty() then
            exit;

        ICTransaction.FindFirst();

        SourceCompanyName := ICTransaction."Source Company";

        // Load attachments from source company
        DocAttachment.ReadIsolation := IsolationLevel::ReadCommitted;
        DocAttachment.ChangeCompany(SourceCompanyName);
        DocAttachment.SetRange("Table ID", Database::"Sales Invoice Header");
        DocAttachment.SetRange("No.", ICTransaction."Document No.");
        DocAttachment.SetRange("File Type", DocAttachment."File Type"::PDF);

        if DocAttachment.FindSet() then
            repeat
                TempDocumentAttachmentBuffer.TransferFields(DocAttachment);
                TempDocumentAttachmentBuffer."Line No." := CustLedgerEntryNo;
                TempDocumentAttachmentBuffer."Document Reference ID" := DocAttachment."Document Reference ID";
                TempDocumentAttachmentBuffer.SystemId := DocAttachment.SystemId;
                TempDocumentAttachmentBuffer.Insert();
                // guid for later use with tenant media is additionally stored here, there are some issues later on when trying to access it from temporary table
                MediaGuidDict.Add(DocAttachment.SystemId, TempDocumentAttachmentBuffer."Document Reference ID".MediaId());
                DataExists := true;
            until DocAttachment.Next() = 0;

        exit(DataExists);
    end;
}
