namespace Weibel.Purchases.Document;

using Microsoft.Purchases.Document;
using Microsoft.Purchases.History;
using Microsoft.Purchases.Archive;

report 70101 "COL Update Purchaser Code"
{
    ApplicationArea = All;
    Caption = 'Update Purchaser Code on Purchase Documents';
    UsageCategory = Tasks;
    ToolTip = 'Update Purchaser Code field on purchase document lines.';
    ProcessingOnly = true;
    Permissions =
        tabledata "Purchase Header" = R,
        tabledata "Purchase Line" = RM,
        tabledata "Purchase Header Archive" = R,
        tabledata "Purchase Line Archive" = RM,
        tabledata "Purch. Inv. Line" = RM,
        tabledata "Purch. Inv. Header" = R,
        tabledata "Purch. Cr. Memo Hdr." = R,
        tabledata "Purch. Cr. Memo Line" = RM;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.");

            trigger OnPreDataItem()
            begin
                if not DoUpdatePurchLines then
                    CurrReport.Break();
                PurchDocCounter := 0;
            end;

            trigger OnAfterGetRecord()
            begin
                UpdateDocumentLines("Purchase Header");
            end;

            trigger OnPostDataItem()
            begin
                UpdateProgress(1, PurchDocCounter);
            end;
        }
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            DataItemTableView = sorting("No.");
            trigger OnPreDataItem()
            begin
                if not DoUpdatePurchInvLines then
                    CurrReport.Break();
                PurchInvCounter := 0;
            end;

            trigger OnAfterGetRecord()
            begin
                UpdateDocumentLines("Purch. Inv. Header");
            end;

            trigger OnPostDataItem()
            begin
                UpdateProgress(2, PurchInvCounter);
            end;
        }
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            DataItemTableView = sorting("No.");
            trigger OnPreDataItem()
            begin
                if not DoUpdatePurchCrMemoLines then
                    CurrReport.Break();
                PurchCrMemoCounter := 0;
            end;

            trigger OnAfterGetRecord()
            begin
                UpdateDocumentLines("Purch. Cr. Memo Hdr.");
            end;

            trigger OnPostDataItem()
            begin
                UpdateProgress(3, PurchCrMemoCounter);
            end;
        }
        dataitem("Purchase Header Archive"; "Purchase Header Archive")
        {
            DataItemTableView = sorting("Document Type", "No.", "Doc. No. Occurrence", "Version No.");

            trigger OnPreDataItem()
            begin
                if not DoUpdatePurchArchLines then
                    CurrReport.Break();
                PurchArchDocCounter := 0;
            end;

            trigger OnAfterGetRecord()
            begin
                UpdateDocumentLines("Purchase Header Archive");
            end;

            trigger OnPostDataItem()
            begin
                UpdateProgress(4, PurchArchDocCounter);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(DoUpdatePurchLinesCtrl; DoUpdatePurchLines)
                    {
                        Caption = 'Update Purchase Lines';
                        ToolTip = 'Specifies if lines for not posted purchase documents should be updated.';
                        ApplicationArea = All;
                    }
                    field(DoUpdatePurchInvLinesCtrl; DoUpdatePurchInvLines)
                    {
                        Caption = 'Update Purchase Inv. Lines';
                        ToolTip = 'Specifies if lines for posted purchase invoice documents should be updated.';
                        ApplicationArea = All;
                    }
                    field(DoUpdatePurchCrMemoLinesCtrl; DoUpdatePurchCrMemoLines)
                    {
                        Caption = 'Update Purchase Cr. Memo Lines';
                        ToolTip = 'Specifies if lines for posted purchase cr. memo documents should be updated.';
                        ApplicationArea = All;
                    }
                    field(DoUpdatePurchArchLinesCtrl; DoUpdatePurchArchLines)
                    {
                        Caption = 'Update Purchase Archive Lines';
                        ToolTip = 'Specifies if lines for archived purchase documents should be updated.';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        Window.Open(ProgressLbl);
    end;

    trigger OnPostReport()
    begin
        Window.Close();
    end;

    var
        DoUpdatePurchLines, DoUpdatePurchInvLines, DoUpdatePurchCrMemoLines, DoUpdatePurchArchLines : Boolean;
        PurchDocCounter, PurchInvCounter, PurchCrMemoCounter, PurchArchDocCounter : Integer;
        Window: Dialog;
        ProgressLbl: Label 'Purchase Documents: #1\Posted Purch. Invoices: #2\Posted Purchase Cr. Memo: #3\Arch. Purchase Documents: #4', Comment = '%1 = no. of documents; %2 = no. of documents; %3 = no. of documents; %4 = no. of documents';

    local procedure UpdateDocumentLines(var PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchaseLine.ModifyAll("COL Purchaser Code", PurchaseHeader."Purchaser Code");
        PurchDocCounter += 1;
        UpdateProgress(1, PurchDocCounter);
    end;

    local procedure UpdateDocumentLines(var PurchInvHeader: Record "Purch. Inv. Header")
    var
        PurchInvLine: Record "Purch. Inv. Line";
    begin
        PurchInvLine.SetRange("Document No.", PurchInvHeader."No.");
        PurchInvLine.ModifyAll("COL Purchaser Code", PurchInvHeader."Purchaser Code");
        PurchInvCounter += 1;
        UpdateProgress(2, PurchInvCounter);
    end;

    local procedure UpdateDocumentLines(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    var
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
    begin
        PurchCrMemoLine.SetRange("Document No.", PurchCrMemoHdr."No.");
        PurchCrMemoLine.ModifyAll("COL Purchaser Code", PurchCrMemoHdr."Purchaser Code");
        PurchCrMemoCounter += 1;
        UpdateProgress(3, PurchCrMemoCounter);
    end;

    local procedure UpdateDocumentLines(var PurchaseHeaderArchive: Record "Purchase Header Archive")
    var
        PurchaseLineArchive: Record "Purchase Line Archive";
    begin
        PurchaseLineArchive.SetRange("Document Type", PurchaseHeaderArchive."Document Type");
        PurchaseLineArchive.SetRange("Document No.", PurchaseHeaderArchive."No.");
        PurchaseLineArchive.SetRange("Doc. No. Occurrence", PurchaseHeaderArchive."Doc. No. Occurrence");
        PurchaseLineArchive.SetRange("Version No.", PurchaseHeaderArchive."Version No.");
        PurchaseLineArchive.ModifyAll("COL Purchaser Code", PurchaseHeaderArchive."Purchaser Code");
        PurchArchDocCounter += 1;
        UpdateProgress(4, PurchArchDocCounter);
    end;

    local procedure UpdateProgress(ControlId: Integer; ProgressValue: Integer)
    begin
        if ProgressValue mod 10 = 0 then
            Window.Update(ControlId, ProgressValue);
    end;
}
