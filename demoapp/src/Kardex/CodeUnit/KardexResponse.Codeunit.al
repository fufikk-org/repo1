namespace Weibel.Kardex;

using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Item;
using Microsoft.Foundation.AuditCodes;
using Microsoft.Inventory.Ledger;
using Microsoft.Warehouse.Structure;
using Microsoft.Warehouse.Setup;
using Microsoft.Inventory.Tracking;
using Microsoft.Warehouse.Activity;

codeunit 70201 "COL Kardex Response"
{
    var
        WarehouseSetup: Record "Warehouse Setup";
        WarehouseSetupActive: Boolean;
        CurrEntryNo, CurrRelatedEntryNo : Integer;
        AdHocTagLbl: Label 'ADHOC', Locked = true;
        CorrectionTagLbl: Label 'CORRECTION', Locked = true;

    trigger OnRun()
    var
        KardexMsgHeader: Record "COL Kardex Msg. Header";
    begin
        KardexMsgHeader.Get(CurrEntryNo, CurrRelatedEntryNo);
        HandleIncomeMessage(KardexMsgHeader);
    end;

    procedure SetCurrHeader(pCurrEntryNo: Integer; pCurrRelatedEntryNo: Integer)
    begin
        CurrEntryNo := pCurrEntryNo;
        CurrRelatedEntryNo := pCurrRelatedEntryNo;
    end;

    procedure HandleIncomeMessage(var Rec: Record "COL Kardex Msg. Header")
    begin
        if Rec.Processed then
            exit; // Already processed

        // Handel Journal Messages path
        if not Rec."Skip Handling" then
            HandleJrnMessage(Rec);

        Rec.Processed := true;
        Rec.Modify(true);
    end;

    local procedure HandleJrnMessage(var Rec: Record "COL Kardex Msg. Header")
    var
        KardexLogLine: Record "COL Kardex Log Line";
    begin
        GetSetup();
        KardexLogLine.Get(Rec."Related Log Line");

        if Rec."Response Type" in [Rec."Response Type"::DeletePickingOrder, Rec."Response Type"::DeleteStoringOrder] then
            KardexLogLine."Delete Confirmed" := true
        else begin
            if (KardexLogLine."Journal Batch Name" <> '') and (KardexLogLine."Journal Template Name" <> '') then
                if Rec."Response Type" in [Rec."Response Type"::PickingLineProgress, Rec."Response Type"::StoringLineProgress] then
                    if Rec."Order Number 1" = AdHocTagLbl then
                        CreateJrnlline(Rec) // AdHoc Tag
                    else
                        UpdateItemJrnlLine(Rec);

            if (KardexLogLine."Journal Batch Name" = '') or (KardexLogLine."Journal Template Name" = '') then
                UpdateWarehousePick(Rec);
        end;

        KardexLogLine."Inventory Document Updated" := true; // Mark as updated
        KardexLogLine.Modify(true);
    end;

    local procedure UpdateWarehousePick(var Rec: Record "COL Kardex Msg. Header")
    var
        WhseActivLine: Record "Warehouse Activity Line";
        WhseActivLine2: Record "Warehouse Activity Line";
        KardexLogLine: Record "COL Kardex Log Line";
        KardexMsgLine: Record "COL Kardex Msg. Line";
        currActivityType: Enum "Warehouse Activity Type";
        NewQty: Decimal;
    begin
        GetSetup();
        KardexLogLine.Get(Rec."Related Log Line");

        KardexMsgLine.SetRange("Entry No.", Rec."Entry No.");
        KardexMsgLine.SetRange("Related Log Line", Rec."Related Log Line");
        KardexMsgLine.FindFirst();

        Evaluate(currActivityType, Rec."Order Number 2"); // error if not a valid activity type

        if not WhseActivLine.Get(currActivityType, Rec."Order Number 1", KardexMsgLine."Jrn. Line No.") then
            exit; // No activity line found

        NewQty := WhseActivLine."Qty. to Handle (Base)" + KardexMsgLine.Quantity;
        if NewQty > WhseActivLine.Quantity then
            NewQty := WhseActivLine.Quantity;

        if WhseActivLine."Activity Type" in [WhseActivLine."Activity Type"::"Invt. Put-away", WhseActivLine."Activity Type"::"Invt. Pick"] then begin
            // Response Qty
            WhseActivLine.COL_SetSkipKardexCheck(true);
            WhseActivLine.Validate("Qty. to Handle (Base)", NewQty);
            if KardexMsgLine."Serial Number" <> '' then
                WhseActivLine.Validate("Serial No.", KardexMsgLine."Serial Number");
            WhseActivLine.Modify(true);
        end;
        if WhseActivLine."Activity Type" = WhseActivLine."Activity Type"::Pick then begin
            // Response Qty
            // Update Take
            WhseActivLine.COL_SetSkipKardexCheck(true);
            WhseActivLine.Validate("Qty. to Handle (Base)", NewQty);
            if KardexMsgLine."Serial Number" <> '' then
                WhseActivLine.Validate("Serial No.", KardexMsgLine."Serial Number");
            WhseActivLine.Modify(true);

            // Update Place
            WhseActivLine2.Reset();
            WhseActivLine2.SetRange("Activity Type", WhseActivLine."Activity Type");
            WhseActivLine2.SetRange("No.", WhseActivLine."No.");
            WhseActivLine2.SetRange("Whse. Document No.", WhseActivLine."Whse. Document No.");
            WhseActivLine2.SetRange("Whse. Document Line No.", WhseActivLine."Whse. Document Line No.");
            WhseActivLine2.SetRange("Action Type", WhseActivLine2."Action Type"::Place);
            WhseActivLine2.SetFilter("Line No.", '>%1', WhseActivLine."Line No.");
            if WhseActivLine2.FindFirst() then begin

                WhseActivLine2.COL_SetSkipKardexCheck(true);
                WhseActivLine2.Validate("Qty. to Handle", NewQty);
                if KardexMsgLine."Serial Number" <> '' then
                    WhseActivLine2.Validate("Serial No.", KardexMsgLine."Serial Number");
                WhseActivLine2.Modify(true);
            end;
        end;

    end;

    local procedure CreateJrnlline(var Rec: Record "COL Kardex Msg. Header")
    var
        KardexLogLine: Record "COL Kardex Log Line";
        KardexMsgLine: Record "COL Kardex Msg. Line";
        Item: Record Item;
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlLine: Record "Item Journal Line";
        SourceCodeSetup: Record "Source Code Setup";
        ItemLedgEntry: Record "Item Ledger Entry";
        BinContentQty: Decimal;
        LineNo: Integer;
    begin
        GetSetup();
        KardexLogLine.Get(Rec."Related Log Line");
        KardexLogLine.TestField("Journal Batch Name");
        KardexLogLine.TestField("Journal Template Name");

        KardexMsgLine.SetRange("Entry No.", Rec."Entry No.");
        KardexMsgLine.SetRange("Related Log Line", Rec."Related Log Line");
        KardexMsgLine.FindFirst();

        Item.Get(KardexMsgLine."Item ID");
        ItemJnlTemplate.Get(KardexLogLine."Journal Template Name");
        ItemJnlBatch.Get(KardexLogLine."Journal Template Name", KardexLogLine."Journal Batch Name");
        SourceCodeSetup.Get();

        BinContentQty := GetKardexBinContent(Item);

        LineNo := GetJrnlNextLineNo(ItemJnlBatch."Journal Template Name", ItemJnlBatch.Name);

        ItemJnlLine.Init();
        ItemJnlLine."Journal Template Name" := ItemJnlBatch."Journal Template Name";
        ItemJnlLine."Journal Batch Name" := ItemJnlBatch.Name;
        ItemJnlLine."Line No." := LineNo;
        ItemJnlLine.Validate("Posting Date", Today());

        if Rec."Response Type" = Rec."Response Type"::InventoryCorrection then begin
            ItemJnlLine."Document No." := CorrectionTagLbl;
            ItemJnlLine.Validate("Entry Type", ItemJnlLine."Entry Type"::"Positive Adjmt.");
            ItemJnlLine."COL Kardex Quantity" := KardexMsgLine."New Quantity";
        end
        else begin
            ItemJnlLine."Document No." := AdHocTagLbl;
            ItemJnlLine.Validate("Entry Type", ItemJnlLine."Entry Type"::"Positive Adjmt.");
            ItemJnlLine."COL Kardex Quantity" := KardexMsgLine.Quantity;
        end;

        if Rec."Response Type" = Rec."Response Type"::StoringLineProgress then
            ItemJnlLine.Validate("Entry Type", ItemJnlLine."Entry Type"::"Positive Adjmt.")
        else
            if Rec."Response Type" = Rec."Response Type"::PickingLineProgress then
                ItemJnlLine.Validate("Entry Type", ItemJnlLine."Entry Type"::"Negative Adjmt.");

        ItemJnlLine.Validate("Item No.", Item."No.");
        ItemJnlLine.Validate("Variant Code", KardexMsgLine."Item Variant");

        ItemJnlLine.Validate("Location Code", WarehouseSetup."COL Kardex Location Code");
        ItemJnlLine.Validate("Bin Code", WarehouseSetup."COL Kardex Bin Code");
        if ItemJnlTemplate.Type = ItemJnlTemplate.Type::"Phys. Inventory" then begin
            ItemJnlLine.Validate("Source Code", SourceCodeSetup."Phys. Inventory Journal");
            ItemJnlLine."Phys. Inventory" := true;
            if Rec."Response Type" = Rec."Response Type"::InventoryCorrection then
                ItemJnlLine.Validate("Qty. (Phys. Inventory)", KardexMsgLine."New Quantity")
            else
                ItemJnlLine.Validate("Qty. (Phys. Inventory)", KardexMsgLine.Quantity);
            ItemJnlLine.Validate("Qty. (Calculated)", BinContentQty);
            ItemLedgEntry.Reset();
            ItemLedgEntry.SetCurrentKey("Item No.");
            ItemLedgEntry.SetRange("Item No.", Item."No.");
            if ItemLedgEntry.FindLast() then
                ItemJnlLine."Last Item Ledger Entry No." := ItemLedgEntry."Entry No."
            else
                ItemJnlLine."Last Item Ledger Entry No." := 0;
        end else begin
            ItemJnlLine.Validate("Source Code", ItemJnlTemplate."Source Code");
            if Rec."Response Type" = Rec."Response Type"::InventoryCorrection then
                ItemJnlLine.Validate(Quantity, KardexMsgLine."New Quantity")
            else
                ItemJnlLine.Validate(Quantity, KardexMsgLine.Quantity);
        end;

        ItemJnlLine."Posting No. Series" := ItemJnlBatch."Posting No. Series";
        ItemJnlLine."Reason Code" := ItemJnlBatch."Reason Code";

        //TODO
        //ItemJnlLine."Shelf No." := Item."Shelf No.";
        ItemJnlLine."COL Kardex Log No." := Rec."Related Log Line";

        ItemJnlLine."COL Logia User ID" := KardexMsgLine."User Id";
        ItemJnlLine.Insert(true);

        if (KardexMsgLine."Serial Number" <> '') then
            AddItemTrkgToItemJnlLine(ItemJnlLine, '', KardexMsgLine."Serial Number", '', '', 0D);

    end;

    local procedure AddItemTrkgToItemJnlLine(var ItemJnlLine: Record "Item Journal Line"; LotNo: Code[20]; SerialNo: Code[50]; NewLotNo: Code[20]; NewSerialNo: Code[50]; ExpirationDate: Date)
    var
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        ItemJnlLineReserve: Codeunit "Item Jnl. Line-Reserve";
        ItemTrackingLines: Page "Item Tracking Lines";
    begin
        if (ItemJnlLine.Quantity = 0) then
            exit;

        if (LotNo = '') AND (SerialNo = '') AND (NewLotNo = '') AND (NewSerialNo = '') then
            exit;

        ItemJnlLineReserve.InitFromItemJnlLine(TempTrackingSpecification, ItemJnlLine);
        if ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Transfer then begin
            TempTrackingSpecification."New Lot No." := NewLotNo;
            TempTrackingSpecification."New Serial No." := NewSerialNo;
            ItemTrackingLines.SetRunMode("Item Tracking Run Mode"::"Reclass");
        end;

        TempTrackingSpecification."Lot No." := LotNo;
        TempTrackingSpecification."Serial No." := SerialNo;
        TempTrackingSpecification."Expiration Date" := ExpirationDate;
        TempTrackingSpecification.Insert();

        ItemTrackingLines.SetBlockCommit(true);

        ItemTrackingLines.RegisterItemTrackingLines(
          TempTrackingSpecification, ItemJnlLine."Posting Date", TempTrackingSpecification);
    end;

    local procedure UpdateItemJrnlLine(var Rec: Record "COL Kardex Msg. Header")
    var
        KardexLogLine: Record "COL Kardex Log Line";
        KardexMsgLine: Record "COL Kardex Msg. Line";
        Item: Record Item;
        ItemJnlBatch: Record "Item Journal Batch";
        ItemJnlTemplate: Record "Item Journal Template";
        ItemJnlLine: Record "Item Journal Line";
    begin
        GetSetup();

        KardexLogLine.Get(Rec."Related Log Line");
        KardexLogLine.TestField("Journal Batch Name");
        KardexLogLine.TestField("Journal Template Name");

        KardexMsgLine.SetRange("Entry No.", Rec."Entry No.");
        KardexMsgLine.SetRange("Related Log Line", Rec."Related Log Line");
        KardexMsgLine.FindFirst();

        Item.Get(KardexMsgLine."Item ID");
        ItemJnlTemplate.Get(KardexLogLine."Journal Template Name");
        ItemJnlBatch.Get(KardexLogLine."Journal Template Name", KardexLogLine."Journal Batch Name");

        ItemJnlLine.SetRange("Journal Template Name", KardexLogLine."Journal Template Name");
        ItemJnlLine.SetRange("Journal Batch Name", KardexLogLine."Journal Batch Name");
        ItemJnlLine.SetRange("Line No.", KardexMsgLine."Jrn. Line No.");
        ItemJnlLine.SetRange("Item No.", Item."No.");
        ItemJnlLine.SetRange("Variant Code", KardexMsgLine."Item Variant");
        ItemJnlLine.SetRange("COL Kardex Log No.", KardexLogLine."Entry No.");
        if ItemJnlLine.FindFirst() then begin
            ItemJnlLine."COL Kardex Quantity" := ItemJnlLine."COL Kardex Quantity" + KardexMsgLine.Quantity;
            ItemJnlLine."COL Logia User ID" := KardexMsgLine."User Id";
            ItemJnlLine.Modify();
        end;

        // Do not use for storing in KARDEX because Serial Nos was assigned before export to Kardex
        // Do use if Move from Kardex
        if ItemJnlLine."Entry Type" = ItemJnlLine."Entry Type"::Transfer then
            if ItemJnlLine."Bin Code" = WarehouseSetup."COL Kardex Bin Code" then // Move from Kardex
                if (KardexMsgLine."Serial Number" <> '') then
                    AddItemTrkgToItemJnlLine(
                      ItemJnlLine,
                      '', KardexMsgLine."Serial Number",
                      '', KardexMsgLine."Serial Number", 0D);
    end;

    procedure HandleKardexResponse(xmlAsText: Text)
    var
        KardexInputLog: Record "COL Kardex Input Log";
        XMLdoc: XmlDocument;
        xmlElement_: XmlElement;
        DocNumber: Text;
        ResponseType: Enum "COL Kardex Res. Type";
        OrderDone, UpdateFileLog, SkipHandling : Boolean;
        CorrectionLbl: Label 'CORRECTION', Locked = true;
        UnknownResponseErr: Label 'Unknown response type: %1', Comment = '%1 is the response type';
    begin
#pragma warning disable AA0206
        KardexInputLog.CreateLog(xmlAsText);
        Commit();

        SkipHandling := false;
        XmlDocument.ReadFrom(xmlAsText, XMLdoc);
        XMLdoc.GetRoot(xmlElement_);
        case xmlElement_.Name of
            'PickingOrderDoneResponse':
                begin
                    OrderDone := true;
                    UpdateFileLog := true;
                    ResponseType := "COL Kardex Res. Type"::PickingOrderDone;
                end;
            'PickingLineDoneResponse':
                begin
                    OrderDone := false;
                    SkipHandling := true; // Just move file
                    ResponseType := "COL Kardex Res. Type"::PickingLineDone;
                end;
            'PickingLineProgressResponse':
                begin
                    OrderDone := false;
                    ResponseType := "COL Kardex Res. Type"::PickingLineProgress;
                end;
            'StoringOrderDoneResponse':
                begin
                    OrderDone := true;
                    UpdateFileLog := true;
                    ResponseType := "COL Kardex Res. Type"::StoringOrderDone;
                end;
            'StoringLineDoneResponse':
                begin
                    OrderDone := false;
                    SkipHandling := true; // Just move file\
                    ResponseType := "COL Kardex Res. Type"::StoringLineDone;
                end;
            'StoringLineProgressResponse':
                begin
                    OrderDone := false;
                    ResponseType := "COL Kardex Res. Type"::StoringLineProgress;
                end;
            'InventoryCorrectionResponse':
                begin
                    DocNumber := CorrectionLbl;
                    SkipHandling := true; // Just move file
                                          // Normally only 1 file
                    ResponseType := "COL Kardex Res. Type"::InventoryCorrection;
                end;
            'ItemInventoryResult':
                begin
                    SkipHandling := true; // Just move file
                    ResponseType := "COL Kardex Res. Type"::ItemInventoryResult;
                end;
            'StockBalanceResult':
                begin
                    SkipHandling := true; // Just move file
                    ResponseType := "COL Kardex Res. Type"::StockBalanceResult;
                end;
            'DeletePickingOrder':
                begin
                    SkipHandling := false;
                    ResponseType := "COL Kardex Res. Type"::DeletePickingOrder;
                end;
            'DeleteStoringOrder':
                begin
                    SkipHandling := false;
                    ResponseType := "COL Kardex Res. Type"::DeleteStoringOrder;
                end;
        end;

        if ResponseType = "COL Kardex Res. Type"::" " then
            Error(UnknownResponseErr, xmlElement_.Name);

        HandleXml(XMLdoc, ResponseType, SkipHandling);
#pragma warning restore AA0206
    end;

    local procedure HandleXml(var XMLdoc: XmlDocument; ResponseType: Enum "COL Kardex Res. Type"; SkipHandling: Boolean)
    var
        KardexMsgHeader: Record "COL Kardex Msg. Header";
        KardexMsgHeader2: Record "COL Kardex Msg. Header";
        KardexMsgLine: Record "COL Kardex Msg. Line";
        KardexLogLine: Record "COL Kardex Log Line";
        tempKardexMsgLine: Record "COL Kardex Msg. Line" temporary;
        KardexMgt: Codeunit "COL Kardex Mgt.";
        xmlElement_: XmlElement;
        xmlNodList: XmlNodeList;
        xmlNodList2: XmlNodeList;
        xmlNodBody: XmlNode;
        xmlNodBody2: XmlNode;
        txtValue: Text;
        LogNo: Integer;
        xml: Text;
        CRLF: Text[2];
    begin
        GetSetup();
        if ResponseType = "COL Kardex Res. Type"::" " then
            exit;

        if ResponseType = "COL Kardex Res. Type"::InventoryCorrection then
            exit;

        KardexMsgHeader.Init();
        KardexMsgHeader."Entry No." := 100; // Dummy value
        KardexMsgHeader."Related Log Line" := 0; // Dummy value
        KardexMsgHeader."Response Type" := ResponseType; // Default type
        KardexMsgHeader.Response := true;
        KardexMsgHeader."Skip Handling" := SkipHandling;

        XMLdoc.GetRoot(xmlElement_);
        xmlNodList := xmlElement_.GetChildNodes();
        foreach xmlNodBody in xmlNodList do
            if xmlNodBody.IsXmlElement() then begin
                txtValue := xmlNodBody.AsXmlElement().InnerText();
                case xmlNodBody.AsXmlElement().Name of
                    'OrderKey':
                        begin
                            Clear(xmlNodList2);
                            xmlNodList2 := xmlNodBody.AsXmlElement().GetChildNodes();
                            foreach xmlNodBody2 in xmlNodList2 do
                                if xmlNodBody2.IsXmlElement() then
                                    case xmlNodBody2.AsXmlElement().Name of
                                        'OrderNumber1':
                                            KardexMsgHeader."Order Number 1" := CopyStr(xmlNodBody2.AsXmlElement().InnerText(), 1, 20);
                                        'OrderNumber2':
                                            KardexMsgHeader."Order Number 2" := CopyStr(xmlNodBody2.AsXmlElement().InnerText(), 1, 20);
                                        'OrderNumber3':
                                            KardexMsgHeader."Order Number 3" := CopyStr(xmlNodBody2.AsXmlElement().InnerText(), 1, 20);
                                    end;
                        end;
                    'LineNumber':
                        tempKardexMsgLine."Jrn. Line No." := GetValueAsInt(txtValue);
                    'ItemID':
                        tempKardexMsgLine."Item ID" := CopyStr(txtValue, 1, 50);
                    'SecondaryItemID':
                        tempKardexMsgLine."Item Variant" := CopyStr(txtValue, 1, 20);
                    'PickedQuantity':
                        tempKardexMsgLine.Quantity := GetValueAsDec(txtValue);
                    'StoredQuantity':
                        tempKardexMsgLine.Quantity := GetValueAsDec(txtValue);
                    'NewQuantity':
                        tempKardexMsgLine."New Quantity" := GetValueAsDec(txtValue);
                    'SerialNo':
                        tempKardexMsgLine."Serial Number" := CopyStr(txtValue, 1, 50);
                    'UserID':
                        tempKardexMsgLine."User Id" := CopyStr(txtValue, 1, 50);

                end;
            end;

        if Evaluate(LogNo, KardexMsgHeader."Order Number 3") then
            if KardexLogLine.Get(LogNo) then
                KardexMsgHeader."Related Log Line" := KardexLogLine."Entry No.";

        if KardexMsgHeader."Order Number 1" = AdHocTagLbl then begin
            //TODO check if not exist ?
            KardexMgt.AddLogLine(KardexLogLine, WarehouseSetup."COL Journal Template Name", WarehouseSetup."COL Journal Batch Name", KardexMsgHeader."Order Number 2", enum::"COL Kardex Type"::"Sorting Item Jrn");
            KardexMsgHeader."Related Log Line" := KardexLogLine."Entry No.";
        end
        else
            if WarehouseSetup."COL Kardex Skip Request" then
                KardexMsgHeader."Skip Handling" := true;

        if KardexMsgHeader."Related Log Line" <> 0 then begin // Skip if no log line found 

            KardexMsgHeader2.SetRange("Related Log Line", KardexMsgHeader."Related Log Line");
            if KardexMsgHeader2.FindLast() then
                KardexMsgHeader."Entry No." := KardexMsgHeader2."Entry No." + 1
            else
                KardexMsgHeader."Entry No." := 1;

            KardexMsgHeader.Insert(true);
            KardexMsgLine.TransferFields(tempKardexMsgLine);
            KardexMsgLine."Entry No." := KardexMsgHeader."Entry No.";
            KardexMsgLine."Related Log Line" := KardexMsgHeader."Related Log Line";
            KardexMsgLine."Line No." := 1000;
            KardexMsgLine.Insert(true);

            KardexLogLine.Get(KardexMsgHeader."Related Log Line");
            KardexLogLine."Received Date And Time" := CurrentDateTime();
            KardexLogLine.Modify(true);

            CRLF[1] := 13;
            CRLF[2] := 10;
            xmlElement_.WriteTo(xml);
            xml := xml.Replace(CRLF, '');
            xml := xml.Trim();

            KardexMsgHeader.SetRawMessage(xml);

        end;
    end;

    local procedure GetJrnlNextLineNo(JrnlTemplateName: Code[10]; JrnlBatchName: Code[10]): Integer
    var
        ItemJnlLine: Record "Item Journal Line";
        LineNo: Integer;
    begin
        ItemJnlLine.SetRange("Journal Template Name", JrnlTemplateName);
        ItemJnlLine.SetRange("Journal Batch Name", JrnlBatchName);
        if ItemJnlLine.FindLast() then
            LineNo := ItemJnlLine."Line No." + 10000
        else
            LineNo := 10000;

        exit(LineNo);
    end;

    local procedure GetKardexBinContent(var Item: Record Item): Decimal
    var
        BinContent: Record "Bin Content";
    begin
        GetSetup();
        BinContent.SetRange("Location Code", WarehouseSetup."COL Kardex Location Code");
        BinContent.SetRange("Bin Code", WarehouseSetup."COL Kardex Bin Code");
        BinContent.SetRange("Item No.", Item."No.");
        BinContent.SetRange("Unit of Measure Code", Item."Base Unit of Measure");
        if BinContent.FindFirst() then begin
            BinContent.CalcFields("Quantity (Base)");
            exit(BinContent."Quantity (Base)");
        end else
            exit(0);
    end;

    local procedure GetSetup()
    begin
        if WarehouseSetupActive then
            exit;

        WarehouseSetup.Get();
        WarehouseSetup.TestField("COL Kardex Location Code");
        WarehouseSetup.TestField("COL Kardex Bin Code");
        //WarehouseSetup.TestField("COL Kardex Zone Code");
    end;

    local procedure GetValueAsDec(txt: Text): Decimal
    var
        ret: Decimal;
    begin
        if not Evaluate(ret, txt) then
            exit(0);

        exit(ret);
    end;

    local procedure GetValueAsInt(txt: Text): Integer
    var
        ret: Integer;
    begin
        if not Evaluate(ret, txt) then
            exit(0);

        exit(ret);
    end;
}
