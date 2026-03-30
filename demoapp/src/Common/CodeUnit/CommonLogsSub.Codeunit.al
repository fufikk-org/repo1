namespace Weibel.Common;
using Microsoft.Inventory.Tracking;
using Microsoft.Manufacturing.Document;
using Microsoft.Manufacturing.Setup;

codeunit 70229 "COL Common Logs Sub."
{
    var
        ManufacturingSetup: Record "Manufacturing Setup";

    [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyEventRE(var Rec: Record "Reservation Entry"; var xRec: Record "Reservation Entry")
    begin
        if Rec."Source Type" <> Database::"Prod. Order Line" then
            exit;

        if Rec.IsTemporary() then
            exit;

        if ManufacturingSetup.Get() then
            if ManufacturingSetup."COL Log Prod. Tracking" then
                CreateNewLog(Rec, xRec."Serial No.", enum::"COL Operation Source"::Modify);

    end;

    [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertEventRE(var Rec: Record "Reservation Entry")
    begin
        if Rec."Source Type" <> Database::"Prod. Order Line" then
            exit;

        if Rec.IsTemporary() then
            exit;

        if ManufacturingSetup.Get() then
            if ManufacturingSetup."COL Log Prod. Tracking" then
                CreateNewLog(Rec, '', enum::"COL Operation Source"::Insert);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeleteEventRE(var Rec: Record "Reservation Entry")
    begin
        if Rec."Source Type" <> Database::"Prod. Order Line" then
            exit;

        if Rec.IsTemporary() then
            exit;

        if ManufacturingSetup.Get() then
            if ManufacturingSetup."COL Log Prod. Tracking" then
                CreateNewLog(Rec, '', enum::"COL Operation Source"::Delete);
    end;

    local procedure CreateNewLog(var Rec: Record "Reservation Entry"; oldSerialNo: Code[50]; operation: enum "COL Operation Source")
    var
        CommonLogEntry: Record "COL Common Log Entry";
        EntryNo: Integer;
        callstackTxt: Text;
    begin

        if CommonLogEntry.FindLast() then
            EntryNo := CommonLogEntry."Entry No." + 1
        else
            EntryNo := 1;

        CommonLogEntry.Reset();
        CommonLogEntry."Entry No." := EntryNo;
        CommonLogEntry."Created At" := CurrentDateTime();
        CommonLogEntry."User Id" := CopyStr(UserId(), 1, MaxStrLen(CommonLogEntry."User Id"));
        CommonLogEntry."Operation Source" := operation;
        CommonLogEntry.Insert();

        callstackTxt := SessionInformation.Callstack();

        CommonLogEntry."Prod Order No." := Rec."Source ID";
        CommonLogEntry."Prod Order Line" := Rec."Source Prod. Order Line";
        CommonLogEntry."Serial No." := Rec."Serial No.";
        CommonLogEntry."Old Serial No." := oldSerialNo;
        CommonLogEntry.Quantity := Rec.Quantity;
        CommonLogEntry.SetRawMessage(callstackTxt);
        CommonLogEntry.Modify();
    end;
}
