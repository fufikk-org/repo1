namespace weibel.System.Email;

using System.Email;
using Microsoft.Foundation.Reporting;
using Microsoft.Purchases.Vendor;
using System.Utilities;
using Microsoft.Purchases.Document;
using Microsoft.Purchases.Setup;
using Weibel.Purchases.Document;


codeunit 70149 "COL Email Sent Sub."
{
    EventSubscriberInstance = Manual;

    var
        LastEmailID: BigInteger;
        MissingConf: Boolean;
        OverdueDelivery: Boolean;

    [EventSubscriber(ObjectType::Table, DataBase::"Sent Email", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInitRecord(var Rec: Record "Sent Email"; RunTrigger: Boolean)
    begin
        LastEmailID := Rec.Id;
    end;

    procedure GetLastId(): BigInteger
    begin
        exit(LastEmailID);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Sent Email", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInitRecord2(var Rec: Record "Sent Email"; RunTrigger: Boolean)
    begin
        LastEmailID := Rec.Id;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Document Sending Profile", 'OnBeforeTrySendToEMail', '', false, false)]
    local procedure OnBeforeTrySendToEMail(ReportUsage: Integer; RecordVariant: Variant; DocumentNoFieldNo: Integer; DocName: Text[150]; CustomerFieldNo: Integer; var ShowDialog: Boolean; var Handled: Boolean; var IsCustomer: Boolean)
    begin
        IsCustomer := false;
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Report Selections", 'OnBeforeSaveReportAsPDF', '', false, false)]
    local procedure OnBeforeSaveReportAsPDF(var ReportID: Integer; RecordVariant: Variant; var LayoutCode: Code[20]; var IsHandled: Boolean; FilePath: Text[250]; ReportUsage: Enum "Report Selection Usage"; SaveToBlob: Boolean; var TempBlob: Codeunit "Temp Blob"; var ReportSelections: Record "Report Selections")
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        PurchReminderMgt: Codeunit "COL Purch. Reminder Mgt.";
    begin
        if not PurchasesPayablesSetup.Get() then
            PurchasesPayablesSetup.init();

        if PurchasesPayablesSetup."COL Force Default Report" then
            exit;

        //code that is replaced
        // TempBlob.CreateOutStream(OutStream);
        // LastUsedParameters := CustomLayoutReporting.GetReportRequestPageParameters(ReportID);
        // Report.SaveAs(ReportID, LastUsedParameters, ReportFormat::Pdf, OutStream, GetRecRef(RecordVariant));

        PurchReminderMgt.GetPDfFromLasernet(RecordVariant, TempBlob);
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", OnBeforeGetVendorEmailAddress, '', false, false)]
    local procedure OnBeforeGetVendorEmailAddress(BuyFromVendorNo: Code[20]; var ToAddress: Text; ReportUsage: Option; var IsHandled: Boolean; RecVar: Variant)
    var
        Vendor: Record Vendor;
    begin
        if ReportUsage <> Enum::"Report Selection Usage"::"COL Order - Reminder".AsInteger() then
            exit;
        Vendor.SetLoadFields("FPL Lasernet E-Mail");
        if Vendor.Get(BuyFromVendorNo) then
            if Vendor."FPL Lasernet E-Mail" <> '' then begin
                IsHandled := true;
                ToAddress := Vendor."FPL Lasernet E-Mail";
            end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Mailing", OnAfterGetEmailSubject, '', false, false)]
    local procedure RunOnAfterGetEmailSubject(PostedDocNo: Code[20]; EmailDocumentName: Text[250]; ReportUsage: Integer; var EmailSubject: Text[250])
    var
        SubjectLateDeliveryLbl: Label 'Reminder: Late delivery';
        SubjectMissingConfLbl: Label 'Reminder: Missing confirmation';
        SubjectBothLbl: Label 'Reminder: Late delivery/Missing confirmation';
    begin
        if ReportUsage = Enum::"Report Selection Usage"::"COL Order - Reminder".AsInteger() then
            case true of
                MissingConf and OverdueDelivery:
                    begin
                        EmailSubject := SubjectBothLbl;
                        exit;
                    end;
                MissingConf:
                    begin
                        EmailSubject := SubjectMissingConfLbl;
                        exit;
                    end;
                OverdueDelivery:
                    begin
                        EmailSubject := SubjectLateDeliveryLbl;
                        exit;
                    end;
            end;
    end;

#pragma warning disable AA0228
    local procedure GetRecRef(RecVariant: Variant) RecRef: RecordRef
    begin
        if RecVariant.IsRecordRef() then
            exit(RecVariant);
        if RecVariant.IsRecord() then
            RecRef.GetTable(RecVariant);
    end;
#pragma warning restore AA0228

    internal procedure SetTypes(IsMissingConf: Boolean; IsOverdueDelivery: Boolean)
    begin
        MissingConf := IsMissingConf;
        OverdueDelivery := IsOverdueDelivery;
    end;
}
