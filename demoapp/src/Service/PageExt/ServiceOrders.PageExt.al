namespace Weibel.Service.Document;

using Microsoft.Service.Document;

using Microsoft.Integration.Dataverse;
using Microsoft.Integration.SyncEngine;
using Microsoft.Sales.Document;
using System.Environment.Configuration;
using System.Threading;
using System.Utilities;

pageextension 70119 "COL Service Orders" extends "Service Orders"
{
    layout
    {
        addlast(Control1)
        {
            field("COL Shipping Status"; Rec."COL Shipping Status")
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
        addafter("External Document No.")
        {
            field("COL Quote Valid Until Date"; Rec."COL Quote Valid Until Date")
            {
                ApplicationArea = Service;
                StyleExpr = StyleTxt;
            }
            field("COL Order State"; Rec."COL Order State")
            {
                ApplicationArea = All;
            }
        }
        addafter("Customer No.")
        {
            field("COL LastNoteText"; LastNoteText)
            {
                Caption = 'Note';
                ToolTip = 'Displays the last note added to the service order.';
                ApplicationArea = All;
                Editable = false;
            }
        }
        modify("No.")
        {
            StyleExpr = StyleTxt;
        }
    }
    var
        StyleTxt: Text;
        LastNoteText: Text;

    trigger OnAfterGetRecord()
    begin
        StyleTxt := COLSetStyle();
        LastNoteText := COL_FillLastNote();
    end;

    procedure COLSetStyle(): Text
    var
        StyleLbl: Label 'Unfavorable', Locked = true;
    begin
        if (Rec."COL Quote Valid Until Date" <> 0D) and (WorkDate() > Rec."COL Quote Valid Until Date") then
            exit(StyleLbl);

        exit('');
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