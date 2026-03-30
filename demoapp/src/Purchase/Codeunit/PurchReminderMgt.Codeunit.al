namespace Weibel.Purchases.Document;

using Microsoft.Purchases.Document;
using Microsoft.Foundation.Reporting;
using weibel.System.Email;
using System.Email;
using Weibel.Common;
using System.Utilities;
using System.Threading;

codeunit 70148 "COL Purch. Reminder Mgt."
{

    Permissions = tabledata "Sent Email" = RM;
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        PurchaseHeader: Record "Purchase Header";
        BatchEmailSentSub: Codeunit "COL Batch Email Sent Sub.";
        Parameters: List of [Text];
        VendorNo, PoNo : Text;
    begin
        HideSummary := true;
        HideDialog := true;
        Parameters := Rec."Parameter String".Split(':');
        Parameters.Get(1, VendorNo);
        Parameters.get(2, PoNo);
        PurchaseHeader.SetRange("Buy-from Vendor No.", VendorNo);
        PurchaseHeader.SetFilter("No.", PoNo);
        PurchaseHeader.SetFilter("Location Filter", PoNo);
        BatchEmailSentSub.SetPPFilter(PoNo);
        BindSubscription(BatchEmailSentSub);
        SentDocument(PurchaseHeader);
        UnbindSubscription(BatchEmailSentSub);
    end;


    var
        HideSummary, HideDialog : Boolean;
        MissingConf: Boolean;
        OverdueDelivery: Boolean;

    procedure SentDocument(var Rec: Record "Purchase Header"): Boolean
    var
        ReportSelections: Record "Report Selections";
        PurchaseHeader: Record "Purchase Header";
        DocumentSendingProfile: Record "Document Sending Profile";
        SentEmail: Record "Sent Email";
        ReportDistributionMgt: Codeunit "Report Distribution Management";
        EmailSentSub: Codeunit "COL Email Sent Sub.";
        DocTxt: Text[150];
        NoLineWithRemLbl: Label 'No lines with reminders to send.';
    begin
        MissingConf := false;
        OverdueDelivery := false;

        PurchaseHeader.SetFilter("No.", Rec.GetFilter("Location Filter"));
        PurchaseHeader.SetFilter("Buy-from Vendor No.", Rec.GetFilter("Buy-from Vendor No."));
#pragma warning disable AA0210
        PurchaseHeader.SetFilter("Location Filter", Rec.GetFilter("Location Filter"));
#pragma warning restore AA0210

        PrepareDocument(PurchaseHeader, MissingConf, OverdueDelivery);

        EmailSentSub.SetTypes(MissingConf, OverdueDelivery);
        BindSubscription(EmailSentSub);
        if (not MissingConf) and (not OverdueDelivery) then begin
            if not HideSummary then
                Message(NoLineWithRemLbl);
            exit(false);
        end;

        ReportSelections.SetRange("Usage", ReportSelections.Usage::"COL Order - Reminder");
        ReportSelections.FindFirst();
        DocTxt := ReportDistributionMgt.GetFullDocumentTypeText(Rec);

        PurchaseHeader.SetFilter("No.", Rec.GetFilter("Location Filter"));
        PurchaseHeader.SetFilter("Buy-from Vendor No.", Rec.GetFilter("Buy-from Vendor No."));
#pragma warning disable AA0210
        PurchaseHeader.SetFilter("Location Filter", Rec.GetFilter("Location Filter"));
#pragma warning restore AA0210
        PurchaseHeader.FindFirst();
        PurchaseHeader.SetRange("No.", PurchaseHeader."No.");

        DocumentSendingProfile."Combine Email Documents" := true;
        DocumentSendingProfile.TrySendToEMail(
          ReportSelections.Usage::"COL Order - Reminder".AsInteger(), PurchaseHeader, PurchaseHeader.FieldNo("No."),
          DocTxt, PurchaseHeader.FieldNo("Buy-from Vendor No."), not HideDialog);

        if SentEmail.Get(EmailSentSub.GetLastId()) then begin
            if MissingConf then
                SentEmail."COL Email Type" := SentEmail."COL Email Type"::"Purch. Missing Conf. Reminder";
            if OverdueDelivery then
                SentEmail."COL Email Type" := SentEmail."COL Email Type"::"Purch. Overdue Delivery Reminder";
            if MissingConf and OverdueDelivery then
                SentEmail."COL Email Type" := SentEmail."COL Email Type"::"Missing Conf. and Overdue Delivery";
            SentEmail."COL Related Document" := Rec."No.";
            SentEmail."COL Send Date" := CurrentDateTime();
            SentEmail.Modify();
        end;

        PurchaseHeader.SetFilter("No.", Rec.GetFilter("Location Filter"));
        PurchaseHeader.SetFilter("Buy-from Vendor No.", Rec.GetFilter("Buy-from Vendor No."));
        ClearDoc(PurchaseHeader);

        UnbindSubscription(EmailSentSub);
        exit(true);
    end;

    local procedure PrepareDocument(var PurchaseHeader: Record "Purchase Header"; var IsMissingConf: Boolean; var IsOverdueDelivery: Boolean): Boolean
    var
        PurchaseLine: Record "Purchase Line";
        MissDataLbl: Label 'Missing Date Confirmation';
        OverdueLbl: Label 'Late Delivery';
    begin
        if PurchaseHeader.GetFilter("No.") <> '' then
            PurchaseLine.SetFilter("Document No.", PurchaseHeader.GetFilter("No."));

        if PurchaseHeader.GetFilter("Buy-from Vendor No.") <> '' then
            PurchaseLine.SetRange("Buy-from Vendor No.", PurchaseHeader.GetFilter("Buy-from Vendor No."));

        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
        PurchaseLine.SetFilter(Type, '%1|%2', PurchaseLine.Type::Item, PurchaseLine.Type::"G/L Account");
        PurchaseLine.SetFilter("Outstanding Quantity", '>%1', 0);
        if PurchaseLine.FindSet() then
            repeat
                if PurchaseLine."Promised Receipt Date" = 0D then begin
                    IsMissingConf := true;
                    PurchaseLine."COL Reminder Problem Exist" := true;
                    PurchaseLine."COL Reminder Comment" := MissDataLbl;
                    PurchaseLine.Modify(false);
                end else
                    if (PurchaseLine."Promised Receipt Date" < Today()) and (PurchaseLine."Outstanding Quantity" > 0) then begin
                        IsOverdueDelivery := true;
                        PurchaseLine."COL Reminder Problem Exist" := true;
                        PurchaseLine."COL Reminder Comment" := OverdueLbl;
                        PurchaseLine.Modify(false);
                    end;

            until PurchaseLine.Next() = 0;

        if IsMissingConf or IsOverdueDelivery then
            PurchaseHeader.ModifyAll("COL Reminder Problem Exist", true);

    end;

    local procedure ClearDoc(var PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseHeader.ModifyAll("COL Reminder Problem Exist", false);

        if PurchaseHeader.GetFilter("No.") <> '' then
            PurchaseLine.SetFilter("Document No.", PurchaseHeader.GetFilter("No."));

        if PurchaseHeader.GetFilter("Buy-from Vendor No.") <> '' then
            PurchaseLine.SetRange("Buy-from Vendor No.", PurchaseHeader.GetFilter("Buy-from Vendor No."));

        PurchaseLine.ModifyAll("COL Reminder Problem Exist", false, false);
        PurchaseLine.ModifyAll("COL Reminder Comment", '', false);
    end;

    procedure OpenLookUpMails(Rec: Record "Purchase Header"; type: enum "COL Email Type")
    var
        SentEmail: Record "Sent Email";
        SentEmails: Page "Sent Emails";
    begin
        SentEmail.SetFilter("COL Email Type", '%1|%2', type, enum::"COL Email Type"::"Missing Conf. and Overdue Delivery");
        SentEmail.SetRange("COL Related Document", Rec."No.");

        SentEmails.COLSetFilters(SentEmail);
        SentEmails.Run();
    end;

    procedure GetPDfFromLasernet(var RecordVariant: Variant; var TempBlob: Codeunit "Temp Blob")
    var
        PurchaseHeader: Record "Purchase Header";
        TempPrintRequest: Record "FPL Print Request" temporary;
        RecRef: RecordRef;
        mFieldRef1: FieldRef;
        mFieldRef2: FieldRef;
    begin
        RecRef.GetTable(RecordVariant);
        RecRef.SetRecFilter();

        mFieldRef1 := RecRef.Field(PurchaseHeader.FieldNo("Buy-from Vendor No."));
        mFieldRef2 := RecRef.Field(PurchaseHeader.FieldNo("Pay-to Vendor No."));

        TempPrintRequest.Init();
        TempPrintRequest."Document Type" := Enum::"FPL Document Type"::PurchaseOrder;
        TempPrintRequest.GetReportSetupData();
        TempPrintRequest."Report Id" := GetCurrReportId();
        TempPrintRequest.SetUser(UserId());
        TempPrintRequest.Insert(false);

        TempPrintRequest.SourceType := Enum::"FPL Distribution Source Type"::Vendor;
        TempPrintRequest.SourceNo := TempPrintRequest.GetNo(mFieldRef1.Value, mFieldRef2.Value);
        TempPrintRequest.CheckDefaultPrintMethod();
        TempPrintRequest."Print Method" := TempPrintRequest."Print Method"::"Save to PDF";
        TempPrintRequest.Archive := TempPrintRequest.CheckDefaultArchive();
        TempPrintRequest.FillDefaultRequestPageParams();

        RunPrintForRecord(RecRef, TempPrintRequest, true, TempBlob);
    end;

    procedure SetHideSummary(NewHideSummary: Boolean)
    begin
        HideSummary := NewHideSummary;
    end;

    procedure SetHideDialog(NewHideDialog: Boolean)
    begin
        HideDialog := NewHideDialog;
    end;

    procedure GetSkipped(): Boolean
    begin
        exit(not MissingConf and not OverdueDelivery);
    end;

    local procedure RunPrintForRecord(var RecRef: RecordRef; var TempPrintRequest: Record "FPL Print Request"; PassBlob: Boolean; var TempBlob: Codeunit "Temp Blob")
    var
        InS: InStream;
        OutS: OutStream;
        NoPdfReturnErr: Label 'No PDF return from Lasernet!';
    begin
        TempPrintRequest.MainTableID := Database::"Purchase Header";
        TempPrintRequest.GetReportSetupData();
        TempPrintRequest.SetMainTableFilter(RecRef.GetView()); //setting top level table filter (one PK record preferably)
        TempPrintRequest.SaveParams(); //conserving parameters
        TempPrintRequest."Pass Blob" := PassBlob;
        TempPrintRequest.RunRequest();

        if PassBlob then begin
            if TempPrintRequest."Report Data Pdf".HasValue() then
                TempPrintRequest."Report Data Pdf".CreateInStream(InS)
            else
                Error(NoPdfReturnErr);
            TempBlob.CreateOutStream(OutS);
            CopyStream(OutS, InS);

            // filename := 'TestName.pdf';
            // DownloadFromStream(
            //     InS,  // InStream to save
            //     '',   // Not used in cloud
            //     '',   // Not used in cloud
            //     '',   // Not used in cloud
            //     filename); // Filename is browser download folder
        end;
    end;

    local procedure GetCurrReportId(): Integer
    begin
        exit(Report::"FPL Purchase-Order");
    end;

}
