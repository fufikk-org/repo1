namespace Weibel.Kardex;

using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Tracking;
using Microsoft.Warehouse.Setup;
using Microsoft.Warehouse.Activity;
using Weibel.Common.WebService;

codeunit 70200 "COL Kardex Mgt."
{
    var
        WarehouseSetup: Record "Warehouse Setup";
        WarehouseSetupActive: Boolean;
        TransferLbl: Label 'Transfer';
        PositiveAdjmtLbl: Label 'Positive Adjmt.';
        NegativeAdjmtLbl: Label 'Negative Adjmt.';
        ExportToKardexLbl: Label 'Export to Kardex?';
        SendToKardexLbl: Label 'Send delete request to Kardex?';
        NoKardexExistErr: Label 'No relevant lines exist for Kardex';
        AlreadySentToKardexErr: Label 'Document has already been sent to Kardex.', Comment = '%1, %2 - field captions and values for error message';
        NorelLinesErr: Label 'No relevant lines exist for Kardex with %1: %2', Comment = '%1, %2 - field captions and values for error message';
        NorelLines2Err: Label 'No relevant lines exist for Kardex with %1: %2 and %3: %4', Comment = '%1, %2,%3, %4- field captions and values for error message';
        MissingSnErr: Label 'On %1 %2 [%3: %4] at least one Serial No. is missing', Comment = '%1, %2, %3, %4 - field captions and values for error message';
        SerialNosErr: Label '%1 %2 [%3: %4] is Serial No. tracked why Qty. must be 1. The Serial No is specified in Kardex.', Comment = '%1, %2, %3, %4 - field captions and values for error message';
        SerialNosNotAllowedErr: Label 'On %1 %2 [%3: %4] not allowed to specify Serial Nos. It is done in Kardex.', Comment = '%1, %2, %3, %4 - field captions and values for error message';

        MissingUpdateErr: Label 'This %1 for Item No. %2 is missing update from Kardex.', Comment = '%1, %2 - field captions and values for error message';

    procedure SendToKardex(var Rec: Record "Item Journal Line")
    var
        KardexLogLine: Record "COL Kardex Log Line";
    begin
        if Rec."COL Kardex Log No." <> 0 then
            Error(AlreadySentToKardexErr);

        if not Confirm(ExportToKardexLbl, false) then
            exit;

        // normal jrn check
        if Rec."Entry Type" <> Rec."Entry Type"::"Negative Adjmt." then
            if not RelevantJrnlLines(Rec) then
                if Rec."Entry Type" = Rec."Entry Type"::Transfer then
                    Error(NorelLinesErr, Rec.FieldCaption("New Bin Code"), WarehouseSetup."COL Kardex Bin Code")
                else
                    Error(NorelLines2Err,
                      Rec.FieldCaption("Bin Code"), WarehouseSetup."COL Kardex Bin Code",
                      Rec.FieldCaption("Entry Type"), Rec."Entry Type"::"Positive Adjmt.");

        JrnlLinesTrackingNoCheck(Rec);
        // normal jrn check end

        AddLogLine(KardexLogLine, Rec."Journal Template Name", Rec."Journal Batch Name", '', Enum::"COL Kardex Type"::"Sorting Item Jrn");
        CreateSortingMessage(Rec, KardexLogLine."Entry No.");

        SendLog(KardexLogLine);
    end;

    procedure SendFileFromItemReclassJrnl(var Rec: Record "Item Journal Line")
    var
        KardexLogLine: Record "COL Kardex Log Line";
        ToKardexLinesExist, FromKardexLinesExist : Boolean;
    begin
        if not Confirm(ExportToKardexLbl, false) then
            exit;

        GetSetup();

        // Maybe to files
        // SOLVANG BIN -> KARDEX (STORING / MOVE)
        if RelevantReclassJrnlLines(Rec, true) then begin
            ToKardexLinesExist := true;

            // Check for missing Serial Nos
            ReclassJrnlLinesTrackingNoCheck(Rec, true);

            AddLogLine(KardexLogLine, Rec."Journal Template Name", Rec."Journal Batch Name", '', Enum::"COL Kardex Type"::"Sorting Item Jrn");

            // Create File
            CreateSortingMessage(Rec, KardexLogLine."Entry No.");
            SendLog(KardexLogLine);

            Commit();
        end;

        // KARDEX -> SOLVANG BIN (PICKING / MOVE)
        if RelevantReclassJrnlLines(Rec, false) then begin
            FromKardexLinesExist := true;

            // Check for assigned Serial Nos
            ReclassJrnlLinesTrackingNoCheck(Rec, false);

            AddLogLine(KardexLogLine, Rec."Journal Template Name", Rec."Journal Batch Name", '', Enum::"COL Kardex Type"::"Picking Item Jrn");

            // Create File
            CreatePickingMessage(Rec, KardexLogLine."Entry No.");
            SendLog(KardexLogLine);

            Commit();
        end;

        if not ToKardexLinesExist and not FromKardexLinesExist then
            Error(NoKardexExistErr);
    end;

    procedure SendDeleteReqToKardex(var KardexLogLine: Record "COL Kardex Log Line")
    var
        KardexMsgHeader2: Record "COL Kardex Msg. Header";
        CantSendDeleteErr: Label 'You cannot send a delete request for this log line.';
        OnlySelectedErr: Label 'You can only send a delete request for log lines marked as "Skip Update From File".';
        DeleteExistErr: Label 'A delete request message has already been sent for this log line.';
        NoMsgToDeleteErr: Label 'No message was sent for this log so delete was confirmed automatically.';
    begin
        if not Confirm(SendToKardexLbl, false) then
            exit;

        GetSetup();

        KardexLogLine.CalcFields("Response Messages");
        if KardexLogLine."Response Messages" > 0 then
            Error(CantSendDeleteErr);

        if not KardexLogLine."Skip Update From File" then
            Error(OnlySelectedErr);

        KardexMsgHeader2.SetRange("Related Log Line", KardexLogLine."Entry No.");
        KardexMsgHeader2.SetRange(Response, false);
        KardexMsgHeader2.SetRange("Delete Req. Message", true);
        if not KardexMsgHeader2.IsEmpty() then
            Error(DeleteExistErr);

        KardexMsgHeader2.Reset();
        KardexMsgHeader2.SetRange("Related Log Line", KardexLogLine."Entry No.");
        if KardexMsgHeader2.IsEmpty() then begin
            KardexLogLine."Delete Confirmed" := true;
            KardexLogLine."Inventory Document Updated" := true;
            KardexLogLine.Modify(true);
            Message(NoMsgToDeleteErr);
            exit;
        end;

        CreateDeleteMessage(KardexLogLine."Entry No.");
        SendLog(KardexLogLine);
    end;

    procedure SendToKardex(var Rec: Record "Warehouse Activity Header"; ManualSend: Boolean)
    var
        KardexLog: Record "COL Kardex Log Line";
    begin
        if not (Rec.Type in [Rec.Type::Pick, Rec.Type::"Invt. Put-away", Rec.Type::"Invt. Pick", Rec.Type::"Put-away"]) then
            exit;

        if Rec."COL Kardex Log No." <> 0 then
            Error(AlreadySentToKardexErr);

        GetSetup();
        if WarehouseSetup."COL Kardex Location Code" <> Rec."Location Code" then
            exit;

        // Kardex Bin Code must exist
        if not RelevantWhseActivLineExist(Rec) then
            exit;

        case Rec.Type of
            Rec.Type::Pick:
                begin
                    // Advanced Pick from Sale
                    // Created from Whse Shipment Header

                    CreateFileLogWhse(Rec, KardexLog, Enum::"COL Kardex Type"::"Picking Order");
                    // Create File and sent by API
                    CreateWhMessage(Rec, KardexLog."Entry No.", true);
                    SendLog(KardexLog);
                end;
            Rec.Type::"Put-away":
                if ManualSend then begin
                    CreateFileLogWhse(Rec, KardexLog, Enum::"COL Kardex Type"::"Sorting Order");

                    // Create File and sent by API
                    CreateWhMessage(Rec, KardexLog."Entry No.", false);
                    SendLog(KardexLog);
                end;
            Rec.Type::"Invt. Put-away":
                case Rec."Source Document" of
                    Rec."Source Document"::"Purchase Order", Rec."Source Document"::"Prod. Output":
                        if ManualSend then begin
                            CreateFileLogWhse(Rec, KardexLog, Enum::"COL Kardex Type"::"Sorting Order");

                            // Create File and sent by API
                            CreateWhMessage(Rec, KardexLog."Entry No.", false);
                            SendLog(KardexLog);
                        end;
                end;
            Rec.Type::"Invt. Pick":
                case Rec."Source Document" of
                    Rec."Source Document"::"Prod. Consumption":
                        begin
                            CreateFileLogWhse(Rec, KardexLog, Enum::"COL Kardex Type"::"Picking Order");

                            // Create File and sent by API
                            CreateWhMessage(Rec, KardexLog."Entry No.", true);
                            SendLog(KardexLog);
                        end;
                end;
        end;

    end;

    procedure WhseActivLinesPostingCheck(WhseActivLine: Record "Warehouse Activity Line")
    var
        WhseActivHeader: Record "Warehouse Activity Header";
        WhseActivLine2: Record "Warehouse Activity Line";
        KardexLog: Record "COL Kardex Log Line";
    begin
        if not WhseActivHeader.Get(WhseActivLine."Activity Type", WhseActivLine."No.") then
            exit;

        GetSetup();
        if WarehouseSetup."COL Kardex Location Code" <> WhseActivHeader."Location Code" then
            exit;

        if WhseActivHeader."COL Kardex Log No." = 0 then
            exit;

        if KardexLog.Get(WhseActivHeader."COL Kardex Log No.") then begin
            if KardexLog."Entry No." = 0 then
                exit;

            if KardexLog."Skip Update From File" then
                exit;

            if not KardexLog."Inventory Document Updated" then
                Error(MissingUpdateErr, WhseActivLine.TableCaption(), WhseActivLine."Item No.");
        end;

        // Check if one relevant line exist not update
        WhseActivLine2.Reset();
        WhseActivLine2.SetRange("Activity Type", WhseActivHeader.Type);
        WhseActivLine2.SetRange("No.", WhseActivHeader."No.");
        WhseActivLine2.SetRange("Location Code", WarehouseSetup."COL Kardex Location Code");
        WhseActivLine2.SetRange("Bin Code", WarehouseSetup."COL Kardex Bin Code");
        WhseActivLine2.SetRange("Qty. to Handle", 0);
        if not WhseActivLine2.IsEmpty() then
            if not KardexLog."Inventory Document Updated" then
                Error(MissingUpdateErr, WhseActivLine.TableCaption(), WhseActivLine."Item No.");
    end;

    local procedure CreateFileLogWhse(var Rec: Record "Warehouse Activity Header"; var KardexFileLog: Record "COL Kardex Log Line"; LogType: Enum "COL Kardex Type")
    var
        WhseActivLine: Record "Warehouse Activity Line";
        entryNo: Integer;
    begin
        GetSetup();
        entryNo := 1;
        KardexFileLog.Reset();
        if KardexFileLog.FindLast() then
            entryNo := KardexFileLog."Entry No." + 1;

        if entryNo <= WarehouseSetup."COL Kardex Last Log No." then
            entryNo := WarehouseSetup."COL Kardex Last Log No." + 1;

        Clear(KardexFileLog);
        KardexFileLog.Init();
        KardexFileLog."Entry No." := entryNo;
        KardexFileLog.Type := LogType;
        KardexFileLog."Send Date And Time" := CurrentDateTime();

        KardexFileLog."Whs. Type" := Rec.Type;
        KardexFileLog."No." := Rec."No.";
        KardexFileLog."Source No." := Rec."Source No.";
        KardexFileLog."Source Document" := Rec."Source Document";
        KardexFileLog."Source Type" := Rec."Source Type";
        KardexFileLog."Source Subtype" := Rec."Source Subtype";
        if Rec.Type = Rec.Type::Pick then begin
            WhseActivLine.Reset();
            WhseActivLine.SetRange("Activity Type", Rec.Type);
            WhseActivLine.SetRange("No.", Rec."No.");
            if WhseActivLine.FindFirst() then begin
                KardexFileLog."Source No." := WhseActivLine."Source No.";
                KardexFileLog."Source Document" := WhseActivLine."Source Document";
                KardexFileLog."Source Type" := WhseActivLine."Source Type";
                KardexFileLog."Source Subtype" := WhseActivLine."Source Subtype";
            end;
        end;
        KardexFileLog.Insert(true);

        Rec."COL Kardex Log No." := KardexFileLog."Entry No.";
        Rec.Modify(false);

        WarehouseSetup."COL Kardex Last Log No." := entryNo;
        WarehouseSetup.Modify();
    end;

    local procedure RelevantWhseActivLineExist(var Rec: Record "Warehouse Activity Header"): Boolean
    var
        WhseActivLine: Record "Warehouse Activity Line";
    begin
        GetSetup();
        if WarehouseSetup."COL Kardex Location Code" <> Rec."Location Code" then
            exit(false);

        WhseActivLine.Reset();
        WhseActivLine.SetRange("Activity Type", Rec.Type);
        WhseActivLine.SetRange("No.", Rec."No.");
        WhseActivLine.SetFilter("Qty. Outstanding", '<>%1', 0);
        WhseActivLine.SetRange("Location Code", WarehouseSetup."COL Kardex Location Code");
        WhseActivLine.SetRange("Bin Code", WarehouseSetup."COL Kardex Bin Code");
        exit(not WhseActivLine.IsEmpty());
    end;

    procedure SendToKardex(var Rec: Record "Warehouse Activity Header"; isPick: Boolean; test: Boolean)
    var
        KardexLogLine: Record "COL Kardex Log Line";
    begin
        if Rec."COL Kardex Log No." <> 0 then
            Error(AlreadySentToKardexErr);

        if not Confirm(ExportToKardexLbl, false) then
            exit;

        if isPick then
            AddLogLine(KardexLogLine, '', '', '', Enum::"COL Kardex Type"::"Picking Order")
        else
            AddLogLine(KardexLogLine, '', '', '', Enum::"COL Kardex Type"::"Sorting Order");

        CreateWhMessage(Rec, KardexLogLine."Entry No.", isPick);

        SendLog(KardexLogLine);
    end;

    local procedure RelevantReclassJrnlLines(Rec: Record "Item Journal Line"; ToKardex: Boolean): Boolean
    var
        ItemJnlLine: Record "Item Journal Line";
    begin
        GetSetup();

        ItemJnlLine.Reset();
        ItemJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
        ItemJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        ItemJnlLine.SetRange("Entry Type", ItemJnlLine."Entry Type"::Transfer);
        if ToKardex then begin // To Kardex
            ItemJnlLine.SetRange("New Location Code", WarehouseSetup."COL Kardex Location Code");
            ItemJnlLine.SetRange("New Bin Code", WarehouseSetup."COL Kardex Bin Code");
            ItemJnlLine.SetFilter("Bin Code", '<>%1', WarehouseSetup."COL Kardex Bin Code");
        end else begin // From kardex
            ItemJnlLine.SetRange("Location Code", WarehouseSetup."COL Kardex Location Code");
            ItemJnlLine.SetRange("Bin Code", WarehouseSetup."COL Kardex Bin Code");
            ItemJnlLine.SetFilter("New Bin Code", '<>%1', WarehouseSetup."COL Kardex Bin Code");
        end;
        ItemJnlLine.SetFilter("Quantity (Base)", '<>%1', 0);
        ItemJnlLine.SetRange("COL Kardex Log No.", 0);
        exit(not ItemJnlLine.IsEmpty());
    end;

    local procedure ReclassJrnlLinesTrackingNoCheck(Rec: Record "Item Journal Line"; ToKardex: Boolean): Boolean
    var
        ItemJnlLine: Record "Item Journal Line";
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        NoOfSerialNos: Integer;
        SerialNoArray: List of [Code[50]];
    begin
        GetSetup();

        ItemJnlLine.Reset();
        ItemJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
        ItemJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        ItemJnlLine.SetRange("Entry Type", ItemJnlLine."Entry Type"::Transfer);
        if ToKardex then begin // To Kardex
            ItemJnlLine.SetRange("New Location Code", WarehouseSetup."COL Kardex Location Code");
            ItemJnlLine.SetRange("New Bin Code", WarehouseSetup."COL Kardex Bin Code");
            ItemJnlLine.SetFilter("Bin Code", '<>%1', WarehouseSetup."COL Kardex Bin Code");
        end else begin // From kardex
            ItemJnlLine.SetRange("Location Code", WarehouseSetup."COL Kardex Location Code");
            ItemJnlLine.SetRange("Bin Code", WarehouseSetup."COL Kardex Bin Code");
            ItemJnlLine.SetFilter("New Bin Code", '<>%1', WarehouseSetup."COL Kardex Bin Code");
        end;
        ItemJnlLine.SetFilter("Quantity (Base)", '<>%1', 0);
        ItemJnlLine.SetRange("COL Kardex Log No.", 0);
        if ItemJnlLine.FindSet() then
            repeat
                Item.Get(ItemJnlLine."Item No.");
                if Item."Item Tracking Code" <> '' then begin
                    ItemTrackingCode.Get(Item."Item Tracking Code");
                    if ItemTrackingCode."SN Specific Tracking" then begin
                        Clear(SerialNoArray);
                        NoOfSerialNos := GetSerialNos(ItemJnlLine, SerialNoArray);
                        if ToKardex then begin
                            if NoOfSerialNos <> ItemJnlLine."Quantity (Base)" then
                                Error(MissingSnErr, ItemJnlLine.TableCaption(), ItemJnlLine."Line No.", ItemJnlLine.FIELDCAPTION("Item No."), ItemJnlLine."Item No.");

                        end else begin // From Kardex

                            if ItemJnlLine."Quantity (Base)" <> 1 then
                                Error(SerialNosErr, ItemJnlLine.TableCaption(), ItemJnlLine."Line No.", ItemJnlLine.FIELDCAPTION("Item No."), ItemJnlLine."Item No.");
                            if NoOfSerialNos > 0 then
                                Error(SerialNosNotAllowedErr, ItemJnlLine.TableCaption(), ItemJnlLine."Line No.", ItemJnlLine.FIELDCAPTION("Item No."), ItemJnlLine."Item No.");
                        end;
                    end;
                end;
            until ItemJnlLine.Next() = 0;
    end;

    local procedure JrnlLinesTrackingNoCheck(var Rec: Record "Item Journal Line")
    var
        ItemJnlLine: Record "Item Journal Line";
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        NoOfSerialNos: Integer;
        SerialNoArray: List of [Code[50]];
    begin
        GetSetup();

        ItemJnlLine.Reset();
        ItemJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
        ItemJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        if Rec."Entry Type" = Rec."Entry Type"::Transfer then begin
            ItemJnlLine.SetRange("Entry Type", ItemJnlLine."Entry Type"::Transfer);
            ItemJnlLine.SetRange("New Location Code", WarehouseSetup."COL Kardex Location Code");
            ItemJnlLine.SetRange("New Bin Code", WarehouseSetup."COL Kardex Bin Code");
            ItemJnlLine.SetFilter("Bin Code", '<>%1', WarehouseSetup."COL Kardex Bin Code");
        end else begin
            ItemJnlLine.SetRange("Entry Type", ItemJnlLine."Entry Type"::"Positive Adjmt.");
            ItemJnlLine.SetRange("Location Code", WarehouseSetup."COL Kardex Location Code");
            ItemJnlLine.SetRange("Bin Code", WarehouseSetup."COL Kardex Bin Code");
        end;

        ItemJnlLine.SetRange("COL Kardex Log No.", 0);
        if ItemJnlLine.FindSet() then
            repeat
                Item.Get(ItemJnlLine."Item No.");
                ItemJnlLine.TestField(Quantity);
                if Item."Item Tracking Code" <> '' then begin
                    ItemTrackingCode.Get(Item."Item Tracking Code");
                    if ItemTrackingCode."SN Specific Tracking" then begin

                        Clear(SerialNoArray);
                        NoOfSerialNos := GetSerialNos(ItemJnlLine, SerialNoArray);

                        if NoOfSerialNos <> ItemJnlLine."Quantity (Base)" then
                            Error(MissingSnErr, ItemJnlLine.TableCaption(), ItemJnlLine."Line No.", ItemJnlLine.FieldCaption("Item No."), ItemJnlLine."Item No.");
                    end;
                end;
            until ItemJnlLine.Next() = 0;
    end;

    local procedure RelevantJrnlLines(var Rec: Record "Item Journal Line"): Boolean
    var
        ItemJnlLine: Record "Item Journal Line";
    begin
        GetSetup();
        ItemJnlLine.Reset();
        ItemJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
        ItemJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        if Rec."Entry Type" = Rec."Entry Type"::Transfer then begin
            ItemJnlLine.SetRange("Entry Type", Rec."Entry Type"::Transfer);
            ItemJnlLine.SetRange("New Location Code", WarehouseSetup."COL Kardex Location Code");
            ItemJnlLine.SetRange("New Bin Code", WarehouseSetup."COL Kardex Bin Code");
        end else begin
            ItemJnlLine.SetRange("Entry Type", Rec."Entry Type"::"Positive Adjmt.");
            ItemJnlLine.SetRange("Location Code", WarehouseSetup."COL Kardex Location Code");
            ItemJnlLine.SetRange("Bin Code", WarehouseSetup."COL Kardex Bin Code");
        end;
        ItemJnlLine.SetFilter("Quantity (Base)", '<>%1', 0);
        ItemJnlLine.SetRange("COL Kardex Log No.", 0);
        exit(not ItemJnlLine.IsEmpty());
    end;

    procedure AddLogLine(var KardexLog: Record "COL Kardex Log Line"; Template: Code[10]; Batch: Code[10]; AdHocNo: Code[20]; LogType: Enum "COL Kardex Type")
    var
        entryNo: Integer;
    begin
        GetSetup();
        entryNo := 1;
        KardexLog.Reset();
        if KardexLog.FindLast() then
            entryNo := KardexLog."Entry No." + 1;

        if entryNo <= WarehouseSetup."COL Kardex Last Log No." then
            entryNo := WarehouseSetup."COL Kardex Last Log No." + 1;

        KardexLog.Reset();
        KardexLog.Init();
        KardexLog."Entry No." := entryNo;
        KardexLog."Journal Batch Name" := Batch;
        KardexLog."Journal Template Name" := Template;
        KardexLog.Type := LogType;
        KardexLog."Ad Hoc No." := AdHocNo;
        if KardexLog."Ad Hoc No." <> '' then
            KardexLog."Ad Hoc" := true;
        KardexLog."Send Date And Time" := CurrentDateTime();
        KardexLog.Insert(true);

        WarehouseSetup."COL Kardex Last Log No." := entryNo;
        WarehouseSetup.Modify();
    end;

    procedure GeneratePickDeleteMessage(var Rec: Record "COL Kardex Msg. Header")
    var
        tBuilder: TextBuilder;
    begin
        tBuilder.Append('<?xml version="1.0" encoding="UTF-8"?>');
        tBuilder.Append('<DeletePickingOrder xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">');
        tBuilder.Append('<OrderKey>');
        tBuilder.Append(CreateTagString('OrderNumber1', Rec."Order Number 1"));
        tBuilder.Append(CreateTagString('OrderNumber2', Rec."Order Number 2"));
        tBuilder.Append(CreateTagString('OrderNumber3', Rec."Order Number 3"));
        tBuilder.Append('</OrderKey>');
        tBuilder.Append('</DeletePickingOrder>');

        Rec.SetRawMessage(tBuilder.ToText());
        Rec.Processed := true;
        Rec.Modify(true);
    end;

    procedure GenerateSortDeleteMessage(var Rec: Record "COL Kardex Msg. Header")
    var
        tBuilder: TextBuilder;
    begin
        tBuilder.Append('<?xml version="1.0" encoding="UTF-8"?>');
        tBuilder.Append('<DeleteStoringOrder xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">');
        tBuilder.Append('<OrderKey>');
        tBuilder.Append(CreateTagString('OrderNumber1', Rec."Order Number 1"));
        tBuilder.Append(CreateTagString('OrderNumber2', Rec."Order Number 2"));
        tBuilder.Append(CreateTagString('OrderNumber3', Rec."Order Number 3"));
        tBuilder.Append('</OrderKey>');
        tBuilder.Append('</DeleteStoringOrder>');

        Rec.SetRawMessage(tBuilder.ToText());
        Rec.Processed := true;
        Rec.Modify(true);
    end;

    procedure GeneratePickMessage(var Rec: Record "COL Kardex Msg. Header")
    var
        KardexMsgLine: Record "COL Kardex Msg. Line";
        tBuilder: TextBuilder;
    begin
        tBuilder.Append('<?xml version="1.0" encoding="UTF-8"?>');
        tBuilder.Append('<PickingOrder xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">');
        tBuilder.Append('<OrderKey>');
        tBuilder.Append(CreateTagString('OrderNumber1', Rec."Order Number 1"));
        tBuilder.Append(CreateTagString('OrderNumber2', Rec."Order Number 2"));
        tBuilder.Append(CreateTagString('OrderNumber3', Rec."Order Number 3"));
        tBuilder.Append('</OrderKey>');
        tBuilder.Append('<PickingOrderLineCollection>');

        KardexMsgLine.SetRange("Entry No.", Rec."Entry No.");
        KardexMsgLine.SetRange("Related Log Line", Rec."Related Log Line");
        if KardexMsgLine.FindSet() then
            repeat
                tBuilder.Append('<PickingOrderLine>');
                tBuilder.Append(CreateTagString('LineNumber', Format(KardexMsgLine."Jrn. Line No.")));
                tBuilder.Append('<Item>');
                tBuilder.Append(CreateTagString('ItemID', KardexMsgLine."Item ID"));
                tBuilder.Append(CreateTagString('SecondaryItemID', KardexMsgLine."Item Variant"));
                tBuilder.Append(CreateTagString('Text', ClearXMLText(KardexMsgLine."Item Text")));
                tBuilder.Append('</Item>');
                tBuilder.Append(CreateTagString('Quantity', DecToTxt(KardexMsgLine.Quantity)));
                tBuilder.Append(CreateTagString('SerialNumberMode', KardexMsgLine."Serial Number Mode"));
                if KardexMsgLine."Serial Number" <> '' then
                    tBuilder.Append(CreateTagString('SerialNumber', KardexMsgLine."Serial Number"));

                tBuilder.Append('</PickingOrderLine>');
            until KardexMsgLine.Next() = 0;

        tBuilder.Append('</PickingOrderLineCollection>');
        tBuilder.Append('</PickingOrder>');

        Rec.SetRawMessage(tBuilder.ToText());
        Rec.Processed := true;
        Rec.Modify(true);
    end;

    procedure GenerateSortMessage(var Rec: Record "COL Kardex Msg. Header")
    var
        KardexMsgLine: Record "COL Kardex Msg. Line";
        tBuilder: TextBuilder;
    begin
        tBuilder.Append('<?xml version="1.0" encoding="UTF-8"?>');
        tBuilder.Append('<StoringOrder xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">');
        tBuilder.Append('<OrderKey>');
        tBuilder.Append(CreateTagString('OrderNumber1', Rec."Order Number 1"));
        tBuilder.Append(CreateTagString('OrderNumber2', Rec."Order Number 2"));
        tBuilder.Append(CreateTagString('OrderNumber3', Rec."Order Number 3"));
        tBuilder.Append('</OrderKey>');
        tBuilder.Append('<StoringOrderLineCollection>');

        KardexMsgLine.SetRange("Entry No.", Rec."Entry No.");
        KardexMsgLine.SetRange("Related Log Line", Rec."Related Log Line");
        if KardexMsgLine.FindSet() then
            repeat
                tBuilder.Append('<StoringOrderLine>');
                tBuilder.Append(CreateTagString('LineNumber', Format(KardexMsgLine."Jrn. Line No.")));
                tBuilder.Append('<Item>');
                tBuilder.Append(CreateTagString('ItemID', KardexMsgLine."Item ID"));
                tBuilder.Append(CreateTagString('SecondaryItemID', KardexMsgLine."Item Variant"));
                tBuilder.Append(CreateTagString('Text', ClearXMLText(KardexMsgLine."Item Text")));
                tBuilder.Append('</Item>');
                tBuilder.Append(CreateTagString('Quantity', DecToTxt(KardexMsgLine.Quantity)));
                tBuilder.Append(CreateTagString('SerialNumberMode', KardexMsgLine."Serial Number Mode"));
                if KardexMsgLine."Serial Number" <> '' then begin
                    tBuilder.Append(CreateTagString('SerialNumber', KardexMsgLine."Serial Number"));
                    tBuilder.Append(CreateTagString('PositionNumber', KardexMsgLine."Position Number"));
                end;
                tBuilder.Append('</StoringOrderLine>');
            until KardexMsgLine.Next() = 0;

        tBuilder.Append('</StoringOrderLineCollection>');
        tBuilder.Append('</StoringOrder>');

        Rec.SetRawMessage(tBuilder.ToText());
        Rec.Processed := true;
        Rec.Modify(true);
    end;

    local procedure ClearXMLText(oldText: Text): Text
    var
        newText: Text;
    begin
        NewText := DelChr(oldText, '=', '''<>&"');
        exit(NewText);
    end;

    local procedure CreateTagString(tagName: Text; tagValue: Text): Text
    var
        tagLine: Text;
        tagLbl: Label '<%1>%2</%1>', Comment = '%1, %2 tag name and value';
    begin
        tagLine := StrSubstNo(tagLbl, tagName, tagValue);
        exit(tagLine);
    end;

    procedure CreateDeleteMessage(KardexLogLine: Integer)
    var
        KardexMsgHeader: Record "COL Kardex Msg. Header";
        KardexMsgHeader2: Record "COL Kardex Msg. Header";
        KardexLogLineLine: Record "COL Kardex Log Line";
        EntryNo: Integer;
    begin
        GetSetup();
        EntryNo := 1;

        KardexLogLineLine.Get(KardexLogLine);

        KardexMsgHeader.SetRange("Related Log Line", KardexLogLine);
        if KardexMsgHeader.FindLast() then
            EntryNo := KardexMsgHeader."Entry No." + 1;

        KardexMsgHeader.Reset();

        KardexMsgHeader."Entry No." := EntryNo;
        KardexMsgHeader."Related Log Line" := KardexLogLine;

        KardexMsgHeader2.SetRange("Related Log Line", KardexLogLine);
        KardexMsgHeader2.SetRange(Response, false);
        KardexMsgHeader2.FindFirst();

        KardexMsgHeader."Order Number 1" := KardexMsgHeader2."Order Number 1";
        KardexMsgHeader."Order Number 2" := KardexMsgHeader2."Order Number 2";
        KardexMsgHeader."Order Number 3" := KardexMsgHeader2."Order Number 3";

        KardexMsgHeader.Response := false;
        KardexMsgHeader."Delete Req. Message" := true;

        KardexMsgHeader."Kardex Type" := KardexMsgHeader2."Kardex Type";
        KardexMsgHeader.Insert(true);

        if KardexLogLineLine.Type in [KardexLogLineLine.Type::"Picking Order", KardexLogLineLine.Type::"Picking Item Jrn"] then
            GeneratePickDeleteMessage(KardexMsgHeader)
        else
            GenerateSortDeleteMessage(KardexMsgHeader);
    end;

    procedure CreateWhMessage(var Rec: Record "Warehouse Activity Header"; KardexLogLine: Integer; isPick: Boolean)
    var
        WhseActivLine: Record "Warehouse Activity Line";
        KardexMsgHeader: Record "COL Kardex Msg. Header";
        EntryNo: Integer;
        LineNo: Integer;
    begin
        GetSetup();
        EntryNo := 1;

        KardexMsgHeader.SetRange("Related Log Line", KardexLogLine);
        if KardexMsgHeader.FindLast() then
            EntryNo := KardexMsgHeader."Entry No." + 1;

        KardexMsgHeader.Reset();

        KardexMsgHeader."Entry No." := EntryNo;
        KardexMsgHeader."Related Log Line" := KardexLogLine;

        KardexMsgHeader."Order Number 1" := Rec."No.";
        KardexMsgHeader."Order Number 2" := Format(Rec.Type);
        KardexMsgHeader."Order Number 3" := Format(KardexLogLine);
        if isPick then
            KardexMsgHeader."Kardex Type" := KardexMsgHeader."Kardex Type"::"Picking Order"
        else
            KardexMsgHeader."Kardex Type" := KardexMsgHeader."Kardex Type"::"Sorting Order";
        KardexMsgHeader.Insert(true);

        WhseActivLine.Reset();
        WhseActivLine.SetRange("Activity Type", Rec.Type);
        WhseActivLine.SetRange("No.", Rec."No.");
        WhseActivLine.SetFilter("Qty. Outstanding", '<>%1', 0);
        WhseActivLine.SetRange("Action Type", WhseActivLine."Action Type"::Take);
        if isPick then
            WhseActivLine.SetRange("Action Type", WhseActivLine."Action Type"::Take)
        else
            WhseActivLine.SetRange("Action Type", WhseActivLine."Action Type"::Place);

        WhseActivLine.SetRange("Location Code", WarehouseSetup."COL Kardex Location Code");
        WhseActivLine.SetRange("Bin Code", WarehouseSetup."COL Kardex Bin Code");
        if WhseActivLine.FindSet() then
            repeat
                AddPickLine(KardexMsgHeader, WhseActivLine, LineNo);
            until WhseActivLine.Next() = 0;

        Rec."COL Kardex Log No." := KardexLogLine;
        Rec.Modify(false);

        if isPick then
            GeneratePickMessage(KardexMsgHeader)
        else
            GenerateSortMessage(KardexMsgHeader);
    end;

    procedure CreatePickingMessage(var Rec: Record "Item Journal Line"; KardexLogLine: Integer)
    var
        KardexMsgHeader: Record "COL Kardex Msg. Header";
        ItemJnlLine: Record "Item Journal Line";
        EntryNo: Integer;
        LineNo: Integer;
    begin
        GetSetup();
        EntryNo := 1;

        KardexMsgHeader.SetRange("Related Log Line", KardexLogLine);
        if KardexMsgHeader.FindLast() then
            EntryNo := KardexMsgHeader."Entry No." + 1;

        KardexMsgHeader.Reset();

        KardexMsgHeader."Entry No." := EntryNo;
        KardexMsgHeader."Related Log Line" := KardexLogLine;


        KardexMsgHeader."Order Number 1" := Rec."Journal Batch Name";
        if Rec."Entry Type" = Rec."Entry Type"::Transfer then
            KardexMsgHeader."Order Number 2" := TransferLbl;

        KardexMsgHeader."Order Number 3" := Format(KardexLogLine);
        KardexMsgHeader."Kardex Type" := KardexMsgHeader."Kardex Type"::"Picking Item Jrn";
        KardexMsgHeader.Insert(true);

        LineNo := 1000;
        ItemJnlLine.Reset();
        ItemJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
        ItemJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        ItemJnlLine.SetRange("Entry Type", ItemJnlLine."Entry Type"::Transfer);
        ItemJnlLine.SetRange("Location Code", WarehouseSetup."COL Kardex Location Code");
        ItemJnlLine.SetRange("Bin Code", WarehouseSetup."COL Kardex Bin Code");
        ItemJnlLine.SetFilter("New Bin Code", '<>%1', WarehouseSetup."COL Kardex Bin Code");
        ItemJnlLine.SetFilter("Quantity (Base)", '<>%1', 0);
        ItemJnlLine.SetRange("COL Kardex Log No.", 0);
        if ItemJnlLine.FindSet() then
            repeat
                AddPickLine(KardexMsgHeader, ItemJnlLine, LineNo);

            until ItemJnlLine.Next() = 0;

        ItemJnlLine.ModifyAll("COL Kardex Log No.", KardexLogLine);

        GeneratePickMessage(KardexMsgHeader);
    end;

    procedure CreateSortingMessage(var Rec: Record "Item Journal Line"; KardexLogLine: Integer)
    var
        KardexMsgHeader: Record "COL Kardex Msg. Header";
        ItemJnlLine: Record "Item Journal Line";
        EntryNo: Integer;
        LineNo: Integer;
        NoOfSerialNos: Integer;
        SerialNoArray: List of [Code[50]];
        SerialNo: Code[50];
        EntryTypeErr: Label 'Invalid Entry Type %1', Comment = '%1=Type';
    begin
        GetSetup();
        EntryNo := 1;

        KardexMsgHeader.SetRange("Related Log Line", KardexLogLine);
        if KardexMsgHeader.FindLast() then
            EntryNo := KardexMsgHeader."Entry No." + 1;

        KardexMsgHeader.Reset();

        KardexMsgHeader."Entry No." := EntryNo;
        KardexMsgHeader."Related Log Line" := KardexLogLine;


        KardexMsgHeader."Order Number 1" := Rec."Journal Batch Name";


        KardexMsgHeader."Order Number 3" := Format(KardexLogLine);
        KardexMsgHeader."Kardex Type" := KardexMsgHeader."Kardex Type"::"Sorting Item Jrn";
        KardexMsgHeader.Insert(true);

        LineNo := 1000;
        ItemJnlLine.Reset();
        ItemJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
        ItemJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");

        case Rec."Entry Type" of
            Rec."Entry Type"::Transfer:
                begin
                    ItemJnlLine.SetRange("Entry Type", ItemJnlLine."Entry Type"::Transfer);
                    ItemJnlLine.SetRange("New Location Code", WarehouseSetup."COL Kardex Location Code");
                    ItemJnlLine.SetRange("New Bin Code", WarehouseSetup."COL Kardex Bin Code");
                    ItemJnlLine.SetFilter("Bin Code", '<>%1', WarehouseSetup."COL Kardex Bin Code");
                    KardexMsgHeader."Order Number 2" := TransferLbl;
                end;
            Rec."Entry Type"::"Positive Adjmt.":
                begin
                    ItemJnlLine.SetRange("Entry Type", ItemJnlLine."Entry Type"::"Positive Adjmt.");
                    ItemJnlLine.SetRange("Location Code", WarehouseSetup."COL Kardex Location Code");
                    ItemJnlLine.SetRange("Bin Code", WarehouseSetup."COL Kardex Bin Code");
                    KardexMsgHeader."Order Number 2" := PositiveAdjmtLbl;
                end;
            Rec."Entry Type"::"Negative Adjmt.":
                begin
                    ItemJnlLine.SetRange("Entry Type", ItemJnlLine."Entry Type"::"Negative Adjmt.");
                    ItemJnlLine.SetRange("Location Code", WarehouseSetup."COL Kardex Location Code");
                    ItemJnlLine.SetRange("Bin Code", WarehouseSetup."COL Kardex Bin Code");
                    KardexMsgHeader."Order Number 2" := NegativeAdjmtLbl;
                end;
            else
                Error(EntryTypeErr, Rec."Entry Type");
        end;

        ItemJnlLine.SetFilter("Quantity (Base)", '<>%1', 0);
        ItemJnlLine.SetRange("COL Kardex Log No.", 0);
        if ItemJnlLine.FindSet() then
            repeat
                Clear(SerialNoArray);
                NoOfSerialNos := GetSerialNos(ItemJnlLine, SerialNoArray);
                if NoOfSerialNos = 0 then
                    AddSortLine(KardexMsgHeader, ItemJnlLine, LineNo, '')
                else
                    foreach SerialNo in SerialNoArray do
                        AddSortLine(KardexMsgHeader, ItemJnlLine, LineNo, SerialNo);

            until ItemJnlLine.Next() = 0;

        ItemJnlLine.ModifyAll("COL Kardex Log No.", KardexLogLine);

        GenerateSortMessage(KardexMsgHeader);
    end;

    local procedure AddPickLine(var KardexMsgHeader: Record "COL Kardex Msg. Header"; var WhseActivLine: Record "Warehouse Activity Line"; var LineNo: Integer)
    var
        KardexMsgLine: Record "COL Kardex Msg. Line";
        Item: Record Item;
        SerialNoMode: Code[1];
    begin
        Item.Get(WhseActivLine."Item No.");
        Clear(KardexMsgLine);
        KardexMsgLine.Init();
        KardexMsgLine."Entry No." := KardexMsgHeader."Entry No.";
        KardexMsgLine."Related Log Line" := KardexMsgHeader."Related Log Line";
        KardexMsgLine."Line No." := LineNo;

        SerialNoMode := GetSerialNoMode(Item."Item Tracking Code", WhseActivLine."Serial No.");

        KardexMsgLine."Jrn. Line No." := WhseActivLine."Line No.";
        KardexMsgLine."Item ID" := WhseActivLine."Item No.";
        KardexMsgLine."Item Variant" := WhseActivLine."Variant Code";
        KardexMsgLine."Item Text" := CopyStr(WhseActivLine.Description, 1, 40); // Max 40
        KardexMsgLine.Quantity := WhseActivLine."Qty. Outstanding (Base)";

        KardexMsgLine."Serial Number Mode" := SerialNoMode;
        KardexMsgLine."Serial Number" := WhseActivLine."Serial No.";
        KardexMsgLine.Insert();

        LineNo += 1000;
    end;

    local procedure AddPickLine(var KardexMsgHeader: Record "COL Kardex Msg. Header"; var ItemJnlLine: Record "Item Journal Line"; var LineNo: Integer)
    var
        KardexMsgLine: Record "COL Kardex Msg. Line";
        Item: Record Item;
        SerialNoMode: Code[1];
    begin
        Item.Get(ItemJnlLine."Item No.");
        Clear(KardexMsgLine);
        KardexMsgLine.Init();
        KardexMsgLine."Entry No." := KardexMsgHeader."Entry No.";
        KardexMsgLine."Related Log Line" := KardexMsgHeader."Related Log Line";
        KardexMsgLine."Line No." := LineNo;

        SerialNoMode := GetSerialNoMode(Item."Item Tracking Code", '');

        KardexMsgLine."Jrn. Line No." := ItemJnlLine."Line No.";
        KardexMsgLine."Item ID" := ItemJnlLine."Item No.";
        KardexMsgLine."Item Variant" := ItemJnlLine."Variant Code";
        KardexMsgLine."Item Text" := CopyStr(ItemJnlLine.Description, 1, 40); // Max 40
        KardexMsgLine.Quantity := ItemJnlLine."Quantity (Base)";

        KardexMsgLine."Serial Number Mode" := SerialNoMode;
        KardexMsgLine.Insert();

        LineNo += 1000;
    end;

    local procedure AddSortLine(var KardexMsgHeader: Record "COL Kardex Msg. Header"; var ItemJnlLine: Record "Item Journal Line"; var LineNo: Integer; SerialNo: Code[50])
    var
        KardexMsgLine: Record "COL Kardex Msg. Line";
        Item: Record Item;
        SerialNoMode: Code[1];
    begin
        Item.Get(ItemJnlLine."Item No.");
        Clear(KardexMsgLine);
        KardexMsgLine.Init();
        KardexMsgLine."Entry No." := KardexMsgHeader."Entry No.";
        KardexMsgLine."Related Log Line" := KardexMsgHeader."Related Log Line";
        KardexMsgLine."Line No." := LineNo;

        SerialNoMode := GetSerialNoMode(Item."Item Tracking Code", SerialNo);

        KardexMsgLine."Jrn. Line No." := ItemJnlLine."Line No.";
        KardexMsgLine."Item ID" := ItemJnlLine."Item No.";
        KardexMsgLine."Item Variant" := ItemJnlLine."Variant Code";
        KardexMsgLine."Item Text" := CopyStr(ItemJnlLine.Description, 1, 40); // Max 40

        if SerialNo <> '' then
            KardexMsgLine.Quantity := 1
        else
            KardexMsgLine.Quantity := ItemJnlLine."Quantity (Base)";

        KardexMsgLine."Serial Number Mode" := SerialNoMode;
        if SerialNo <> '' then begin
            KardexMsgLine."Serial Number" := SerialNo;
            KardexMsgLine."Position Number" := SerialNo;
        end;
        KardexMsgLine.Insert();

        LineNo += 1000;
    end;

    local procedure DecToTxt(VarDecimal: Decimal): Text
    begin
        exit(Format(VarDecimal, 0, '<Precision,0:2><Sign><Integer><Decimals><Comma,.>'));
    end;

    local procedure GetSerialNoMode(ItemTrackCode: Code[20]; SerialNo: Code[50]): Code[1]
    begin
        if ItemTrackCode = '' then
            exit('N');

        if SerialNo <> '' then
            exit('S')
        else
            exit('R');

        exit('N');
    end;

    local procedure GetSerialNos(var ItemJnlLine: Record "Item Journal Line"; var SerialNoList: List of [Code[50]]): Integer
    var
        ResEntry: Record "Reservation Entry";
    begin
        Clear(SerialNoList);

        ResEntry.Reset();
        ResEntry.SetRange("Source Type", Database::"Item Journal Line");
        ResEntry.SetRange("Source Subtype", ItemJnlLine."Entry Type");
        ResEntry.SetRange("Source ID", ItemJnlLine."Journal Template Name");
        ResEntry.SetRange("Source Batch Name", ItemJnlLine."Journal Batch Name");
        ResEntry.SetRange("Source Prod. Order Line", 0);
        ResEntry.SetRange("Source Ref. No.", ItemJnlLine."Line No.");
        if ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Transfer then
            ResEntry.SetFilter("New Serial No.", '<>%1', '')
        else
            ResEntry.SetFilter("Serial No.", '<>%1', '');
        if ResEntry.FindSet() then
            repeat
                if ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Transfer then
                    SerialNoList.Add(ResEntry."New Serial No.")
                else
                    SerialNoList.Add(ResEntry."Serial No.");

            until ResEntry.Next() = 0;

        exit(SerialNoList.Count());
    end;

    local procedure GetSetup()
    begin
        if WarehouseSetupActive then
            exit;

        WarehouseSetup.Get();
        WarehouseSetup.TestField("COL Kardex Location Code");
        WarehouseSetup.TestField("COL Kardex Bin Code");
        WarehouseSetup.TestField("COL Kardex Input WS");
        WarehouseSetup.TestField("COL Kardex WS User");
        WarehouseSetup.TestField("COL Kardex WS Password");
        //WarehouseSetup.TestField("COL Kardex Zone Code");
    end;

    procedure OpenLog(entryNo: Integer)
    var
        KardexLogLine: Record "COL Kardex Log Line";
        KardexLogLines: Page "COL Kardex Log Lines";
    begin
        if entryNo = 0 then
            exit;

        KardexLogLine.SetRange("Entry No.", entryNo);
        KardexLogLines.SetTableView(KardexLogLine);
        KardexLogLines.RunModal();
    end;

    procedure SendLog(var KardexMsgHeader: Record "COL Kardex Msg. Header")
    var
        KardexLog: Record "COL Kardex Log Line";
    begin
        if KardexLog.Get(KardexMsgHeader."Related Log Line") then
            SendLog(KardexLog);
    end;

    procedure SendLog(var KardexLog: Record "COL Kardex Log Line")
    var
        KardexMsgHeader: Record "COL Kardex Msg. Header";
        WebServiceMgt: Codeunit "COL Web Service Mgt";
        JsonText: Text;
        ReqBody: Text;
    begin

        if KardexLog.IsEmpty() then
            exit;

        KardexMsgHeader.SetRange("Related Log Line", KardexLog."Entry No.");
        KardexMsgHeader.SetRange(Response, false);
        if KardexMsgHeader.IsEmpty() then
            exit;

        KardexMsgHeader.FindLast();
        KardexMsgHeader.LoadRawMessage(ReqBody);

        if ReqBody = '' then
            exit;

        GetSetup();

        JsonText := WebServiceMgt.CallWebService(
        ReqBody
        , WarehouseSetup."COL Kardex Input WS"
        , "COL HTTP Methods"::POST
        , WarehouseSetup."COL Kardex WS User"
        , WarehouseSetup."COL Kardex WS Password"
        , 'application/xml'
        , "COL API Authentication"::Basic);
    end;

    procedure DeleteWhseActivHeaderCheck(var WhseActivityHeader: Record "Warehouse Activity Header")
    var
        WhseActivLine: Record "Warehouse Activity Line";
        KardexLogLine: Record "COL Kardex Log Line";
        NotAllowedToDelWhseDocErr: Label 'It is not allowed to delete warehouse document: %1, because a Kardex File is attached.', Comment = '%1 - document no.';
    begin
        GetSetup();

        if WarehouseSetup."COL Kardex Location Code" <> WhseActivityHeader."Location Code" then
            exit;

        // Check if lines exist
        WhseActivLine.Reset();
        WhseActivLine.SetRange("Activity Type", WhseActivityHeader.Type);
        WhseActivLine.SetRange("No.", WhseActivityHeader."No.");
        if WhseActivLine.IsEmpty() then
            exit;

        if KardexLogLine.Get(WhseActivityHeader."COL Kardex Log No.") then
            if KardexLogLine."Entry No." <> 0 then begin
                if KardexLogLine."Inventory Document Updated" then
                    exit;
                if (KardexLogLine."Skip Update From File") and (KardexLogLine."Delete Confirmed") then
                    exit;

                Error(NotAllowedToDelWhseDocErr, WhseActivityHeader."No.");
            end;

    end;

    procedure DeleteJrnLineCheck(var ItemJournalLine: Record "Item Journal Line")
    var
        KardexLogLine: Record "COL Kardex Log Line";
        isKardex: Boolean;
        JrnCantBeDelErr: Label 'Journal with location/bin from Kardex must first sent to kardex a delete confirmation to be deleted manual. (Batch %1, Template %2, Line No %3)', Comment = '%1 - Journal Batch Name, %2 - Journal Template Name, %3 - Line No';
    begin
        GetSetup();

        isKardex := false;
        if (WarehouseSetup."COL Kardex Bin Code" = ItemJournalLine."Bin Code") or (WarehouseSetup."COL Kardex Bin Code" = ItemJournalLine."New Bin Code") then
            isKardex := true;

        if not isKardex then
            exit;

        if KardexLogLine.Get(ItemJournalLine."COL Kardex Log No.") then
            if KardexLogLine."Entry No." <> 0 then begin
                if KardexLogLine."Inventory Document Updated" then
                    exit;
                if (KardexLogLine."Skip Update From File") and (KardexLogLine."Delete Confirmed") then
                    exit;

                Error(JrnCantBeDelErr, ItemJournalLine."Journal Batch Name", ItemJournalLine."Journal Template Name", ItemJournalLine."Line No.");
            end;
    end;

    procedure DeleteWhseActivLineCheck(var WhseActivLine: Record "Warehouse Activity Line"; ChangedFieldName: Integer)
    var
        WhseActivityHeader: Record "Warehouse Activity Header";
        KardexLogLine: Record "COL Kardex Log Line";
        MaintainedByKardexErr: Label 'The field: %1 is maintained by Kardex for Item No. %2', Comment = '%1 - field name, %2 - item no.';
        LineMaintainedByKardexErr: Label 'This %1 for Item No. %2 is maintained by Kardex.', Comment = '%1 - field name, %2 - item no.';
    begin
        GetSetup();

        if not WhseActivityHeader.Get(WhseActivLine."Activity Type", WhseActivLine."No.") then
            exit;

        if WarehouseSetup."COL Kardex Location Code" <> WhseActivLine."Location Code" then
            exit;

        if WarehouseSetup."COL Kardex Bin Code" <> WhseActivLine."Bin Code" then
            exit;

        if KardexLogLine.Get(WhseActivityHeader."COL Kardex Log No.") then
            if KardexLogLine."Entry No." <> 0 then begin
                if KardexLogLine."Inventory Document Updated" then
                    exit;
                if (KardexLogLine."Skip Update From File") and (KardexLogLine."Delete Confirmed") then
                    exit;

                case ChangedFieldName of
                    WhseActivLine.FieldNo("Qty. to Handle"):
                        Error(MaintainedByKardexErr, ChangedFieldName, WhseActivLine."Item No.");
                    WhseActivLine.FieldNo("Qty. to Handle (Base)"):
                        Error(MaintainedByKardexErr, ChangedFieldName, WhseActivLine."Item No.");
                    -1:
                        Error(LineMaintainedByKardexErr, WhseActivLine.TableCaption(), WhseActivLine."Item No.");
                end;
            end;
    end;

    procedure WhseActivLineBinCheck(var WhseActivLine: Record "Warehouse Activity Line"; xWhseActivLine: Record "Warehouse Activity Line")
    var
        WhseActivityHeader: Record "Warehouse Activity Header";
        KardexLogLine: Record "COL Kardex Log Line";
        NotAllowedToChangeErr: Label '%1: cannot be changed for Item No. %2 \\ Log all ready send to Kardex.', Comment = '%1 - field name, %2 - item no.';
        NotAllowedToChange2Err: Label '%1: cannot be %2 \\ This Bin Code must be selected before the Inventory Journal is created.', Comment = '%1 - field name, %2 - bin code';
    begin
        GetSetup();

        if not WhseActivityHeader.Get(WhseActivLine."Activity Type", WhseActivLine."No.") then
            exit;

        if WarehouseSetup."COL Kardex Location Code" <> WhseActivityHeader."Location Code" then
            exit;

        if (WarehouseSetup."COL Kardex Bin Code" <> WhseActivLine."Bin Code") and (WarehouseSetup."COL Kardex Bin Code" <> xWhseActivLine."Bin Code") then
            exit;   // Nothing to Check

        if KardexLogLine.Get(WhseActivityHeader."COL Kardex Log No.") then
            if KardexLogLine."Entry No." <> 0 then begin
                if KardexLogLine."Skip Update From File" then
                    exit;
                if WarehouseSetup."COL Kardex Bin Code" <> WhseActivLine."Bin Code" then // Changed away for Kardex
                    Error(NotAllowedToChangeErr, WhseActivLine.FieldCaption("Bin Code"), WhseActivLine."Item No.");
            end else
                if WarehouseSetup."COL Kardex Bin Code" = WhseActivLine."Bin Code" then
                    Error(NotAllowedToChange2Err, WhseActivLine.FieldCaption("Bin Code"), WarehouseSetup."COL Kardex Bin Code");

    end;

}
