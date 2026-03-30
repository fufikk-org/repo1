namespace Weibel.Sales.Document;

using Microsoft.Sales.Document;
using Microsoft.Sales.Setup;
using Microsoft.Integration.Dataverse;
using Microsoft.Integration.SyncEngine;
using System.Environment.Configuration;
using System.Threading;
using System.Utilities;

pageextension 70153 "COL Sales Order List" extends "Sales Order List"
{
    layout
    {
        addlast(Control1)
        {
            field("COL Shipping Status"; Rec."COL Shipping Status")
            {
                ApplicationArea = All;
            }
            field("COL Sales Finance Category"; Rec."COL Sales Finance Category")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("COL Sales Order Category"; Rec."COL Sales Order Category")
            {
                ApplicationArea = All;
                Editable = false;
            }
#pragma warning disable AA0218
            // no tooltip - this is a std. field
            field("COL Responsibility Center"; Rec."Responsibility Center")
#pragma warning restore AA0218
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("COL Description"; Rec."COL Description")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("COL Order Information"; Rec."COL Order Information")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("COL Project Name"; Rec."COL Project Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
#pragma warning disable AA0218
            // it's a standard field, no custom tooltip added
            field("COL Promised Delivery Date"; Rec."Promised Delivery Date")
#pragma warning restore AA0218
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("COL Order Value"; Rec."COL Order Value")
            {
                ApplicationArea = All;
            }
            field("COL Prepayment Value"; Rec."COL Prepayment Value")
            {
                ApplicationArea = All;
            }
            field("COL Responsibility Group"; Rec."COL Responsibility Group")
            {
                ApplicationArea = All;
            }
            field("COL Order Category (Old)"; Rec."COL Order Category (Old)")
            {
                ApplicationArea = All;
            }
            field("COL Export Classification Code"; Rec."COL Export Classification Code")
            {
                ApplicationArea = All;
            }
            field("COL Export Permit No."; Rec."COL Export Permit No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Location Code")
        {
            field("COL LastNoteText"; LastNoteText)
            {
                Caption = 'Note';
                ToolTip = 'Displays the last note added to the service order.';
                ApplicationArea = All;
                Editable = false;
            }
        }
    }

    views
    {
        addlast
        {
            view("COL Finance Category")
            {
                Caption = 'Finance Category';
                Filters = where("COL Sales Finance Category" = filter(''));
            }
        }
    }

    trigger OnOpenPage()
    begin
        FilterOrderAndContractValueFields();
    end;

    var
        SalesSetup: Record "Sales & Receivables Setup";
        LastNoteText: Text;

    trigger OnAfterGetRecord()
    begin
        LastNoteText := COL_FillLastNote();
    end;

    local procedure FilterOrderAndContractValueFields()
    begin
        SalesSetup.GetRecordOnce();
        NotifyIfMissingSetup();
        Rec.SetFilter("COL Prep.Value G/L Acc.Filter", SalesSetup."COL Prep.Value G/L Acc.Filter");
        Rec.SetFilter("COL Order Value G/L Acc.Filter", SalesSetup."COL Order Value G/L Acc.Filter");
    end;

    local procedure NotifyIfMissingSetup()
    var
        SalesHeader: Record "Sales Header";
        SalesReceivablesSetup: Page "Sales & Receivables Setup";
        MissingSetupNotification: Notification;
        MissingSetupNotificationIdLbl: Label 'e6abe8d6-2c92-4a85-adf7-e7f482946f4c', Locked = true;
        MissingSetupLbl: Label '%1 is missing setup in %2 or %3. Values for %4 or %5 might not be correct.', Comment = '%1 = sales setup caption; %2 = field caption; %3 = field caption; %4 = field caption; %5 = field caption';
    begin
        SalesSetup.GetRecordOnce();
        if (SalesSetup."COL Prep.Value G/L Acc.Filter" = '') or (SalesSetup."COL Order Value G/L Acc.Filter" = '') then begin
            MissingSetupNotification.Id := MissingSetupNotificationIdLbl;
            MissingSetupNotification.Scope := NotificationScope::LocalScope;
            MissingSetupNotification.Message := StrSubstNo(MissingSetupLbl, SalesReceivablesSetup.Caption(), SalesSetup.FieldCaption("COL Prep.Value G/L Acc.Filter"),
                SalesSetup.FieldCaption("COL Order Value G/L Acc.Filter"), SalesHeader.FieldCaption("COL Prepayment Value"), SalesHeader.FieldCaption("COL Order Value"));
            MissingSetupNotification.Send();
        end;
    end;

    local procedure COL_FillLastNote(): Text
    var
        RecordLink: Record "Record Link";
        RecordLinkManagement: Codeunit "Record Link Management";
        NoteText: Text;
    begin
        NoteText := '';
        RecordLink.SetRange("Record ID", Rec.RecordId);
        if RecordLink.FindLast() then begin
            RecordLink.CalcFields(Note);
            NoteText := CopyStr(RecordLinkManagement.ReadNote(RecordLink), 1, 250);
        end;
        exit(NoteText);
    end;
}