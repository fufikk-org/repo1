namespace Weibel.Kardex;

using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.Journal;
using Microsoft.Warehouse.Setup;
using Microsoft.Warehouse.Activity;
using Microsoft.Warehouse.Document;
using Microsoft.Warehouse.Request;
using Microsoft.Warehouse.Structure;
using Microsoft.Inventory.Tracking;
using Microsoft.Inventory.Location;
using Microsoft.Manufacturing.Document;

codeunit 70219 "COL Kardex Event Sub."
{
    var
        ExcludeKardex: Boolean; //TODO to handle how to activate
        MustBeEqualErr: Label '%1 (%8) must be equal to %2 (%9) for %3: %4 (Batch %5, Template %6, Line %7)', Comment = '%1 must be equal to %2 for %3: %4, %5, %6, %7, %8, %9';
        MissingUpdateFromKardexErr: Label '%1 is missing update from Kardex (%2) %3: %4', Comment = '%1 must be equal to %2 for %3: %4';
        MustBeSentErr: Label 'A Log must be sent to Kardex when %1 = %2 for %3: %4', Comment = '%1 must be equal to %2 for %3: %4';
        MustBeSent2Err: Label 'A Log must be sent to Kardex when %1 = %2', Comment = '%1 must be equal to %2';

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Check Line", OnAfterGetItem, '', false, false)]
    local procedure OnAfterGetItem(Item: Record Item; var ItemJournalLine: Record "Item Journal Line"; var IsHandled: Boolean)
    var
        WarehouseSetup: Record "Warehouse Setup";
        KardexLogLine: Record "COL Kardex Log Line";
    begin
        if not WarehouseSetup.Get() then
            WarehouseSetup.Init();

        if (ItemJournalLine."Item Charge No." = '') and
           (ItemJournalLine."Value Entry Type" = ItemJournalLine."Value Entry Type"::"Direct Cost") and
           (ItemJournalLine.Quantity <> 0) and
           not ItemJournalLine.Adjustment
        then
            if (ItemJournalLine."COL Kardex Log No." <> 0) then begin
                if KardexLogLine.Get(ItemJournalLine."COL Kardex Log No.") then
                    if not KardexLogLine."Skip Update From File" then begin
                        if not KardexLogLine."Inventory Document Updated" then
                            Error(MissingUpdateFromKardexErr, ItemJournalLine.TableCaption(), ItemJournalLine."COL Kardex Log No.", ItemJournalLine.FieldCaption("Item No."), ItemJournalLine."Item No.");
                        if ItemJournalLine."COL Kardex Quantity To Confirm" <> ItemJournalLine."COL Kardex Quantity" then
                            Error(MustBeEqualErr,
                              ItemJournalLine.FieldCaption(Quantity), ItemJournalLine.FieldCaption("COL Kardex Quantity"),
                              ItemJournalLine.FieldCaption("Item No."), ItemJournalLine."Item No.", ItemJournalLine."Journal Batch Name",
                              ItemJournalLine."Journal Template Name", ItemJournalLine."Line No.",
                              ItemJournalLine."COL Kardex Quantity To Confirm", ItemJournalLine."COL Kardex Quantity");
                    end;
            end else // "Kardex File No." = 0
                if not WarehouseSetup."COL Kardex Skip Request" then
                    if ItemJournalLine."Entry Type" in [ItemJournalLine."Entry Type"::"Positive Adjmt.", ItemJournalLine."Entry Type"::"Negative Adjmt.", ItemJournalLine."Entry Type"::Transfer] then begin
                        if (ItemJournalLine."Bin Code" = WarehouseSetup."COL Kardex Bin Code") then
                            Error(MustBeSent2Err, ItemJournalLine.FieldCaption("Bin Code"), ItemJournalLine."Bin Code");
                        if (ItemJournalLine."New Bin Code" = WarehouseSetup."COL Kardex Bin Code") then
                            Error(MustBeSentErr, ItemJournalLine.FieldCaption("New Bin Code"), ItemJournalLine."New Bin Code", ItemJournalLine.FieldCaption("Item No."), ItemJournalLine."Item No.");
                    end;

    end;


    [EventSubscriber(ObjectType::Page, Page::"Production Journal", OnBeforeActionEvent, 'Post', false, false)]
    local procedure OnAfterActionEventPostJrn(var Rec: Record "Item Journal Line")
    begin
        CheckManualPosting(Rec);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Production Journal", OnBeforeActionEvent, 'PreviewPosting', false, false)]
    local procedure OnAfterActionEventPrevPostJrn(var Rec: Record "Item Journal Line")
    begin
        CheckManualPosting(Rec);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Production Journal", OnBeforeActionEvent, 'Post and &Print', false, false)]
    local procedure OnAfterActionEventPostAndPrintJrn(var Rec: Record "Item Journal Line")
    begin
        CheckManualPosting(Rec);
    end;

    local procedure CheckManualPosting(var ItemJnlLine: Record "Item Journal Line")
    var
        WarehouseSetup: Record "Warehouse Setup";
        DirectPostForbiddenFromProdErr: Label 'Not allowed to post Production Jrn. directly to or from Kardex Bin: %1 for this transaction [%2]', Comment = '%1 is not allowed for %2 entry type';
    begin
        if not WarehouseSetup.Get() then
            WarehouseSetup.Init();

        if (ItemJnlLine."Order Type" = ItemJnlLine."Order Type"::Production) and (ItemJnlLine."Order No." <> '') then
            if ((ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Output) and (ItemJnlLine."Output Quantity" <> 0)) or (ItemJnlLine."Entry Type" <> ItemJnlLine."Entry Type"::Output) then
                if (ItemJnlLine."Bin Code" <> '') and (ItemJnlLine."Bin Code" = WarehouseSetup."COL Kardex Bin Code") then
                    Error(DirectPostForbiddenFromProdErr, ItemJnlLine."Bin Code", ItemJnlLine."Entry Type");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Check Line", OnAfterCheckItemJnlLine, '', false, false)]
    local procedure OnAfterCheckItemJnlLine(var ItemJnlLine: Record "Item Journal Line"; CalledFromInvtPutawayPick: Boolean; CalledFromAdjustment: Boolean)
    var
        WarehouseSetup: Record "Warehouse Setup";
        DirectPostForbiddenErr: Label 'Not allowed to post directly to or from Kardex Bin: %1 for this transaction [%2]', Comment = '%1 is not allowed for %2 entry type';

    begin
        if not WarehouseSetup.Get() then
            WarehouseSetup.Init();

        if (ItemJnlLine."Entry Type" in [ItemJnlLine."Entry Type"::Consumption, ItemJnlLine."Entry Type"::Output]) and
                (not (ItemJnlLine."Value Entry Type" = ItemJnlLine."Value Entry Type"::Revaluation)) then
            if not CalledFromInvtPutawayPick then
                if ((ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Output) and (ItemJnlLine."Output Quantity" <> 0)) or (ItemJnlLine."Entry Type" <> ItemJnlLine."Entry Type"::Output) then
                    if (ItemJnlLine."Bin Code" <> '') and (ItemJnlLine."Bin Code" = WarehouseSetup."COL Kardex Bin Code") then
                        Error(DirectPostForbiddenErr, ItemJnlLine."Bin Code", ItemJnlLine."Entry Type");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Warehouse Activity Line", 'OnAfterValidateEvent', 'Qty. to Handle', true, true)]
    local procedure OnAfterValidateQtyToHandle(Rec: Record "Warehouse Activity Line")
    var
        KardexMgt: Codeunit "COL Kardex Mgt.";
    begin
        KardexMgt.DeleteWhseActivLineCheck(Rec, Rec."Qty. to Handle");
    end;

    [EventSubscriber(ObjectType::Report, Report::"Whse.-Shipment - Create Pick", 'OnBeforeSortWhseActivHeaders', '', true, true)]
    local procedure OnBeforeSortWhseActivHeaders(var WhseActivHeader: Record "Warehouse Activity Header"; FirstActivityNo: Code[20]; LastActivityNo: Code[20]; var HideNothingToHandleError: Boolean)
    var
        KardexMgt: Codeunit "COL Kardex Mgt.";
    begin
        if WhseActivHeader.FindSet() then
            repeat
                Clear(KardexMgt);
                if WhseActivHeader."COL Kardex Log No." = 0 then
                    KardexMgt.SendToKardex(WhseActivHeader, false);
            until WhseActivHeader.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Inventory Put-away", OnAfterAutoCreatePutAway, '', false, false)]
    local procedure OnAfterAutoCreatePutAway(var WarehouseRequest: Record "Warehouse Request"; LineCreated: Boolean; var WarehouseActivityHeader: Record "Warehouse Activity Header")
    var
        KardexMgt: Codeunit "COL Kardex Mgt.";
    begin
        if LineCreated then
            if WarehouseActivityHeader."COL Kardex Log No." = 0 then
                KardexMgt.SendToKardex(WarehouseActivityHeader, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Inventory Pick/Movement", OnBeforeFindFromBinContent, '', false, false)]
    local procedure OnBeforeFindFromBinContent(var FromBinContent: Record "Bin Content"; var WarehouseActivityLine: Record "Warehouse Activity Line"; FromBinCode: Code[20]; BinCode: Code[20]; IsInvtMovement: Boolean; IsBlankInvtMovement: Boolean; DefaultBin: Boolean; WhseItemTrackingSetup: Record "Item Tracking Setup"; var WarehouseActivityHeader: Record "Warehouse Activity Header"; var WarehouseRequest: Record "Warehouse Request")
    var
        WarehouseSetup: Record "Warehouse Setup";
    begin
        if not WarehouseSetup.Get() then
            WarehouseSetup.Init();

        if WarehouseSetup."COL Kardex Location Code" = '' then
            exit;

        if ExcludeKardex and (WarehouseSetup."COL Kardex Location Code" = WarehouseActivityLine."Location Code") then begin
            FromBinContent.FilterGroup := 2;
            FromBinContent.SetFilter("Bin Code", '<>%1', WarehouseSetup."COL Kardex Bin Code");
            FromBinContent.FilterGroup := 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Inventory Pick/Movement", OnAfterAutoCreatePickOrMove, '', false, false)]
    local procedure OnAfterAutoCreatePickOrMove(var WarehouseRequest: Record "Warehouse Request"; LineCreated: Boolean; var WarehouseActivityHeader: Record "Warehouse Activity Header"; Location: Record Location; HideDialog: Boolean)
    var
        KardexMgt: Codeunit "COL Kardex Mgt.";
    begin
        if LineCreated then
            if WarehouseActivityHeader."COL Kardex Log No." = 0 then
                KardexMgt.SendToKardex(WarehouseActivityHeader, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Pick", OnCreateWhseDocumentOnBeforeClearFilters, '', false, false)]
    local procedure OnCreateWhseDocumentOnBeforeClearFilters(var TempWarehouseActivityLine: Record "Warehouse Activity Line" temporary; var WhseActivHeader: Record "Warehouse Activity Header")
    var
        KardexMgt: Codeunit "COL Kardex Mgt.";
    begin
        if WhseActivHeader."COL Kardex Log No." = 0 then
            KardexMgt.SendToKardex(WhseActivHeader, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Put-away", OnAfterCode, '', false, false)]
    local procedure OnAfterCode(WhseActivHeader: Record "Warehouse Activity Header")
    var
        KardexMgt: Codeunit "COL Kardex Mgt.";
    begin
        if WhseActivHeader."COL Kardex Log No." = 0 then
            KardexMgt.SendToKardex(WhseActivHeader, false);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Released Production Order", OnAfterActionEvent, 'Create Warehouse Put-Away', false, false)]
    local procedure CreateWarehousePutAway(Rec: Record "Production Order")
    var
        WhseActivHeader: Record "Warehouse Activity Header";
        WarehouseActivityLine: Record "Warehouse Activity Line";
        KardexMgt: Codeunit "COL Kardex Mgt.";
    begin
        WarehouseActivityLine.SetRange("Activity Type", WarehouseActivityLine."Activity Type"::"Put-away");
        WarehouseActivityLine.SetRange("Source No.", Rec."No.");
        WarehouseActivityLine.SetRange("Source Type", Database::"Prod. Order Line");
        WarehouseActivityLine.SetRange("Source Subtype", Rec.Status.AsInteger());

        if WarehouseActivityLine.FindFirst() then
            if WhseActivHeader.Get(WarehouseActivityLine."Activity Type", WarehouseActivityLine."No.") then
                if WhseActivHeader."COL Kardex Log No." = 0 then
                    KardexMgt.SendToKardex(WhseActivHeader, false);

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Post", OnBeforeCode, '', false, false)]
    local procedure OnBeforeCode(var WarehouseActivityLine: Record "Warehouse Activity Line"; var SuppressCommit: Boolean; var IsHandled: Boolean)
    var
        KardexMgt: Codeunit "COL Kardex Mgt.";
    begin
        KardexMgt.WhseActivLinesPostingCheck(WarehouseActivityLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Act.-Register (Yes/No)", OnBeforeCode, '', false, false)]
    local procedure OnBeforeCode2(var WarehouseActivityLine: Record "Warehouse Activity Line"; var IsHandled: Boolean)
    var
        KardexMgt: Codeunit "COL Kardex Mgt.";
    begin
        KardexMgt.WhseActivLinesPostingCheck(WarehouseActivityLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Activity-Register", OnBeforeCode, '', false, false)]
    local procedure OnBeforeCode3(var WarehouseActivityLine: Record "Warehouse Activity Line")
    var
        KardexMgt: Codeunit "COL Kardex Mgt.";
    begin
        KardexMgt.WhseActivLinesPostingCheck(WarehouseActivityLine);
    end;

}
