namespace Weibel.Manufacturing.Archive;

using Microsoft.Manufacturing.Document;
using System.Utilities;
using Weibel.Common;
codeunit 70147 "COL Prod. Archive Management"
{
    procedure StorePurchDocument(var ProductionOrder: Record "Production Order"; InteractionExist: Boolean)
    var
        ProdLine: Record "Prod. Order Line";
        ProductionHeaderArchive: Record "COL Production Order Archive";
        ProdLineArchive: Record "COL Prod. Order Line Archive";
    begin
        ProductionHeaderArchive.Init();
        ProductionHeaderArchive.TransferFields(ProductionOrder);
        ProductionHeaderArchive."Original Status" := ProductionOrder.Status;
        ProductionHeaderArchive."Archived By" := CopyStr(UserId(), 1, MaxStrLen(ProductionHeaderArchive."Archived By"));
        ProductionHeaderArchive."Date Archived" := Today();
        ProductionHeaderArchive."Time Archived" := Time();
        ProductionHeaderArchive."Version No." :=
            GetNextVersionNo(
                ProductionOrder.Status, ProductionOrder."No.", ProductionOrder."COL Doc. No. Occurrence");
        ProductionHeaderArchive."Interaction Exist" := InteractionExist;
        RecordLinkManagement.CopyLinks(ProductionOrder, ProductionHeaderArchive);
        ProductionHeaderArchive.Insert();

        StoreProdDocumentComments(ProductionOrder.Status, ProductionOrder."No.", ProductionOrder."COL Doc. No. Occurrence", ProductionHeaderArchive."Version No.");

        ProdLine.SetRange(Status, ProductionOrder.Status);
        ProdLine.SetRange("Prod. Order No.", ProductionOrder."No.");
        if ProdLine.FindSet() then
            repeat
                ProdLineArchive.Init();
                ProdLineArchive.TransferFields(ProdLine);
                ProdLineArchive."Doc. No. Occurrence" := ProductionOrder."COL Doc. No. Occurrence";
                ProdLineArchive."Version No." := ProductionHeaderArchive."Version No.";
                RecordLinkManagement.CopyLinks(ProdLine, ProdLineArchive);
                ProdLineArchive.Insert();

                StoreProdComponent(ProdLine, ProdLineArchive);
                StoreProdRouting(ProdLine, ProdLineArchive);
            until ProdLine.Next() = 0;
    end;

    local procedure StoreProdRouting(var ProdLine: Record "Prod. Order Line"; var ProdLineArchive: Record "COL Prod. Order Line Archive")
    var
        ProdRoute: Record "Prod. Order Routing Line";
        ProdRouteArchive: Record "COL Prod.Or. Routing Line Arch";
    begin
        ProdRoute.SetRange(Status, ProdLine.Status);
        ProdRoute.SetRange("Prod. Order No.", ProdLine."Prod. Order No.");
        ProdRoute.SetRange("Routing Reference No.", ProdLine."Routing Reference No.");
        ProdRoute.SetRange("Routing No.", ProdLine."Routing No.");
        if ProdRoute.FindSet() then
            repeat
                ProdRouteArchive.Init();
                ProdRouteArchive.TransferFields(ProdRoute);
                ProdRouteArchive."Doc. No. Occurrence" := ProdLineArchive."Doc. No. Occurrence";
                ProdRouteArchive."Version No." := ProdLineArchive."Version No.";
                RecordLinkManagement.CopyLinks(ProdRoute, ProdRouteArchive);
                ProdRouteArchive.Insert();
            until ProdRoute.Next() = 0;
    end;

    local procedure StoreProdComponent(var ProdLine: Record "Prod. Order Line"; var ProdLineArchive: Record "COL Prod. Order Line Archive")
    var
        ProdComponent: Record "Prod. Order Component";
        ProdComponentArchive: Record "COL Prod. Order Component Arch";
    begin
        ProdComponent.SetRange(Status, ProdLine.Status);
        ProdComponent.SetRange("Prod. Order No.", ProdLine."Prod. Order No.");
        ProdComponent.SetRange("Prod. Order Line No.", ProdLine."Line No.");
        if ProdComponent.FindSet() then
            repeat
                ProdComponentArchive.Init();
                ProdComponentArchive.TransferFields(ProdComponent);
                ProdComponentArchive."Doc. No. Occurrence" := ProdLineArchive."Doc. No. Occurrence";
                ProdComponentArchive."Version No." := ProdLineArchive."Version No.";
                RecordLinkManagement.CopyLinks(ProdComponent, ProdComponentArchive);
                ProdComponentArchive.Insert();
            until ProdComponent.Next() = 0;
    end;

    local procedure StoreProdDocumentComments(DocType: Enum "Production Order Status"; DocNo: Code[20]; DocNoOccurrence: Integer; VersionNo: Integer)
    var
        ProdCommentLine: Record "Prod. Order Comment Line";
        ProdCommentLineArch: Record "COL Prod. Order Comment Arch";
    begin
        ProdCommentLine.SetRange(Status, DocType);
        ProdCommentLine.SetRange("Prod. Order No.", DocNo);
        if ProdCommentLine.FindSet() then
            repeat
                ProdCommentLineArch.Init();
                ProdCommentLineArch.TransferFields(ProdCommentLine);
                ProdCommentLineArch."Doc. No. Occurrence" := DocNoOccurrence;
                ProdCommentLineArch."Version No." := VersionNo;
                ProdCommentLineArch.Insert();
            until ProdCommentLine.Next() = 0;
    end;

    procedure GetNextVersionNo(DocType: Enum "Production Order Status"; DocNo: Code[20]; DocNoOccurrence: Integer) VersionNo: Integer
    var
        ProductionHeaderArchive: Record "COL Production Order Archive";
    begin
        ProductionHeaderArchive.LockTable();
        ProductionHeaderArchive.SetRange(Status, DocType);
        ProductionHeaderArchive.SetRange("No.", DocNo);
        ProductionHeaderArchive.SetRange("Doc. No. Occurrence", DocNoOccurrence);
        if ProductionHeaderArchive.FindLast() then
            exit(ProductionHeaderArchive."Version No." + 1);

        exit(1);
    end;

    procedure GetNextOccurrenceNo(DocType: Enum "Production Order Status"; DocNo: Code[20]) OccurenceNo: Integer
    var
        ProductionHeaderArchive: Record "COL Production Order Archive";
    begin
        ProductionHeaderArchive.LockTable();
        ProductionHeaderArchive.SetRange(Status, DocType);
        ProductionHeaderArchive.SetRange("No.", DocNo);
        if ProductionHeaderArchive.FindLast() then
            exit(ProductionHeaderArchive."Doc. No. Occurrence" + 1);

        exit(1);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Production Order", 'OnAfterInitRecord', '', false, false)]
    local procedure OnAfterInitRecord(var ProductionOrder: Record "Production Order")
    begin
        if ProductionOrder.COLGetVariantCodeChanging() then begin
            ProductionOrder.COLSetVariantCodeChanging(false);
            exit;
        end;
        ProductionOrder."COL Doc. No. Occurrence" :=
            GetNextOccurrenceNo(ProductionOrder.Status, ProductionOrder."No.");
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Production Order", 'OnBeforeValidateVariantCode', '', false, false)]
    local procedure OnBeforeValidateVariantCode(var ProductionOrder: Record "Production Order"; xProductionOrder: Record "Production Order")
    begin
        if ProductionOrder."Variant Code" <> xProductionOrder."Variant Code" then
            ProductionOrder.COLSetVariantCodeChanging(true);
    end;

    procedure ChangeInternalStatus(var Rec: Record "Production Order"; var xRec: Record "Production Order")
    var
        ArchiveOrder: Boolean;
        ReasonCode: Code[20];
    begin
        if Rec."COL Internal Status" = xRec."COL Internal Status" then
            exit;

        ArchiveOrder := true;

        if Rec."COL Internal Status" = Rec."COL Internal Status"::Open then
            if GetInternalStatusReasonCode(Rec, ReasonCode) then begin
                Rec.Validate("COL Reason Code", ReasonCode);
                ArchiveOrder := false;
            end else begin
                Rec."COL Internal Status" := Rec."COL Internal Status"::Released;
                Rec.Validate("COL Reason Code", '');
                exit;
            end;

        if ArchiveOrder then
            StorePurchDocument(Rec, false);
    end;

    local procedure GetInternalStatusReasonCode(var ProductionOrder: Record "Production Order"; var ReasonCode: Code[20]): Boolean
    var
        PickReasonCodeDialog: Page "COL Pick Reason Code Dialog";
    begin
        Clear(ReasonCode);
        if ProductionOrder."COL Reason Code" <> '' then begin
            ReasonCode := ProductionOrder."COL Reason Code";
            exit(true);
        end;
        if PickReasonCodeDialog.RunModal() = Action::OK then
            ReasonCode := PickReasonCodeDialog.GetInputText();
        exit(ReasonCode <> '');
    end;

    procedure MoveArchiveState(var ProductionOrder: Record "Production Order"; var ToProductionOrder: Record "Production Order")
    var
        ProductionHeaderArchive: Record "COL Production Order Archive";
        ProductionHeaderArchive2: Record "COL Production Order Archive";
        ProdLineArchive: Record "COL Prod. Order Line Archive";
        ProdLineArchive2: Record "COL Prod. Order Line Archive";
        ProdComponentArchive: Record "COL Prod. Order Component Arch";
        ProdComponentArchive2: Record "COL Prod. Order Component Arch";
        ProdCommentLineArch: Record "COL Prod. Order Comment Arch";
        ProdCommentLineArch2: Record "COL Prod. Order Comment Arch";
        ProdRouteArchive: Record "COL Prod.Or. Routing Line Arch";
        ProdRouteArchive2: Record "COL Prod.Or. Routing Line Arch";
        ToStatus: Enum "Production Order Status";
    begin
        //ToStatus := Enum::"Production Order Status".FromInteger(NewStatus);
        ToStatus := ToProductionOrder.Status;

        ProductionHeaderArchive.SetRange(Status, ProductionOrder.Status);
        ProductionHeaderArchive.SetRange("No.", ProductionOrder."No.");
        if ProductionHeaderArchive.FindSet() then
            repeat
                ProductionHeaderArchive2.TransferFields(ProductionHeaderArchive);
                ProductionHeaderArchive2.Status := ToStatus;
                ProductionHeaderArchive2."No." := ToProductionOrder."No.";
                ProductionHeaderArchive2.Insert();
            until ProductionHeaderArchive.Next() = 0;

        ProdLineArchive.SetRange(Status, ProductionOrder.Status);
        ProdLineArchive.SetRange("Prod. Order No.", ProductionOrder."No.");
        if ProdLineArchive.FindSet() then
            repeat
                ProdLineArchive2.TransferFields(ProdLineArchive);
                ProdLineArchive2.Status := ToStatus;
                ProdLineArchive2."Prod. Order No." := ToProductionOrder."No.";
                ProdLineArchive2.Insert();
            until ProdLineArchive.Next() = 0;

        ProdComponentArchive.SetRange(Status, ProductionOrder.Status);
        ProdComponentArchive.SetRange("Prod. Order No.", ProductionOrder."No.");
        if ProdComponentArchive.FindSet() then
            repeat
                ProdComponentArchive2.TransferFields(ProdComponentArchive);
                ProdComponentArchive2.Status := ToStatus;
                ProdComponentArchive2."Prod. Order No." := ToProductionOrder."No.";
                ProdComponentArchive2.Insert();
            until ProdComponentArchive.Next() = 0;

        ProdCommentLineArch.SetRange(Status, ProductionOrder.Status);
        ProdCommentLineArch.SetRange("Prod. Order No.", ProductionOrder."No.");
        if ProdCommentLineArch.FindSet() then
            repeat
                ProdCommentLineArch2.TransferFields(ProdCommentLineArch);
                ProdCommentLineArch2.Status := ToStatus;
                ProdCommentLineArch2."Prod. Order No." := ToProductionOrder."No.";
                ProdCommentLineArch2.Insert();
            until ProdCommentLineArch.Next() = 0;

        ProdRouteArchive.SetRange(Status, ProductionOrder.Status);
        ProdRouteArchive.SetRange("Prod. Order No.", ProductionOrder."No.");
        if ProdRouteArchive.FindSet() then
            repeat
                ProdRouteArchive2.TransferFields(ProdRouteArchive);
                ProdRouteArchive2.Status := ToStatus;
                ProdRouteArchive2."Prod. Order No." := ToProductionOrder."No.";
                ProdRouteArchive2.Insert();
            until ProdRouteArchive.Next() = 0;

        ProdCommentLineArch.DeleteAll();
        ProdRouteArchive.DeleteAll();
        ProdComponentArchive.DeleteAll();
        ProdLineArchive.DeleteAll();
        ProductionHeaderArchive.DeleteAll();

    end;



    var
        RecordLinkManagement: Codeunit "Record Link Management";
}
