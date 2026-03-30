namespace Weibel.Inventory.Item;

using System.Text;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Location;
using System.Utilities;
using Microsoft.Purchases.Document;
using Microsoft.Warehouse.Document;
using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Tracking;
using Weibel.Common;
using Microsoft.Warehouse.Activity;

report 70109 "COL Weibel Item ODC Label"
{
    Caption = 'Weibel Item Label';
    UsageCategory = Tasks;
    ApplicationArea = All;
    WordMergeDataItem = ReceiptLine;
    DefaultRenderingLayout = Rdlc;

    dataset
    {
        dataitem(ReceiptLine; "Warehouse Receipt Line")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Items';
            UseTemporary = true;

            column(No_; Item."No.")
            {
            }
            column(FakeNo_; ReceiptLine."Description 2")
            {
            }
            column(Description; Item.Description)
            {
            }
            column(Description2; Item."Description 2")
            {
            }
            column(StandardPlacingCode; StandardPlacingCodeCon)
            {
            }
            column(PO; PoCon)
            {
            }
            column(EXT; ExtCon)
            {
            }
            column(SerialCtr; SerCon)
            {
            }
            column(SerialNoBarCodeCtr; SerialNoBarCode)
            {
            }
            column(NoBarCodeCtr; NoBarCode)
            {
            }
            column(VarCtr; VarCon)
            {
            }
            column(WorkDateCtr; Format(WorkDate(), 0, 9))
            {
            }
            column(ItemTrackingCodeCtr; ItemTrackingCode)
            {
            }


            // trigger OnPreDataItem()
            // begin
            //     Items.SetFilter("No.", ItemFilterTxt);
            // end;

            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number) order(ascending);

                column(CopyNo; Number)
                {
                }

                trigger OnAfterGetRecord()
                var
                    BarcodeString: Text;
                    BarcodeFontProvider: Interface "Barcode Font Provider";
                    pSerial: Text;
                    pExpDate: Date;
                begin
                    if not Item.Get(ReceiptLine."Item No.") then
                        Item.Init();

                    GetITL(pSerial, pExpDate);

                    PoCon := PoLbl + ReceiptLine."Source No.";
                    if ExpDate <> 0D then
                        ExtCon := ExpLbl + Format(ExpDate, 0, 9)
                    else
                        ExtCon := ExpLbl + Format(pExpDate, 0, 9);

                    VarCon := VarLbl + ReceiptLine."Variant Code";
                    if pSerial <> '' then
                        SerCon := SerLbl + pSerial
                    else
                        SerCon := '';

                    ItemTrackingCode := '';
                    if Item."Item Tracking Code" <> '' then
                        ItemTrackingCode := Item.FieldCaption("Item Tracking Code") + ': ' + Item."Item Tracking Code";

                    BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                    BarcodeSymbology := Enum::"Barcode Symbology"::Code128;

                    BarcodeString := ReceiptLine."Item No.";
                    if ReceiptLine."Variant Code" <> '' then
                        BarcodeString += '-' + ReceiptLine."Variant Code";
                    BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                    NoBarCode := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);

                    SerialNoBarCode := '';
                    if pSerial <> '' then begin
                        BarcodeString := pSerial;
                        BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                        SerialNoBarCode := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopiesToPrint) + 1;
                    if NoOfLoops <= 0 then
                        NoOfLoops := 1;
                    SetRange(Number, 1, NoOfLoops);
                end;
            }

            trigger OnPreDataItem()
            var
                WarehouseReceiptLine: Record "Warehouse Receipt Line";
            begin
                if not InitFromRecord then begin
                    WarehouseReceiptLine.CopyFilters(ReceiptLine);
                    if WarehouseReceiptLine.FindSet() then
                        repeat
                            ReceiptLine.TransferFields(WarehouseReceiptLine);
                            ReceiptLine.Insert();
                        until WarehouseReceiptLine.Next() = 0;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopiesToPrint)
                    {
                        ApplicationArea = Service;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }
                    // field(Po; PoTxt)
                    // {
                    //     ApplicationArea = Service;
                    //     Caption = 'PO No.';
                    //     ToolTip = 'Specifies free PO text.';
                    //     Visible = IsUseRequestData;
                    // }
                    field(Exp; ExpDate)
                    {
                        ApplicationArea = Service;
                        Caption = 'EXP Date';
                        ToolTip = 'Specifies free EXP text.';
                    }
                    field(VariantCode; VariantCodeReq)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Variant Code';
                        ToolTip = 'Select Variant for to print.';
                        visible = VariantToSelected;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            ItemVariant: Record "Item Variant";
                            ItemVariants: Page "Item Variants";
                        begin
                            ItemVariant.SetRange("Item No.", CurrItemNo);
                            ItemVariants.SetTableView(ItemVariant);
                            ItemVariants.LookupMode := true;
                            if ItemVariants.RunModal() = Action::LookupOK then begin
                                ItemVariants.GetRecord(ItemVariant);
                                VariantCodeReq := ItemVariant."Code";
                                if ReceiptLine.FindFirst() then begin
                                    ReceiptLine."Variant Code" := VariantCodeReq;
                                    ReceiptLine.Modify(false);
                                end;
                            end;
                        end;

                        trigger OnValidate()
                        var
                            ItemVariant: Record "Item Variant";
                        begin
                            if ReceiptLine.FindFirst() then begin
                                ItemVariant.Get(ReceiptLine."Item No.", VariantCodeReq);
                                ReceiptLine."Variant Code" := VariantCodeReq;
                                ReceiptLine.Modify(false);
                            end;
                        end;
                    }
                }
            }
        }
    }

    rendering
    {
        layout(Rdlc)
        {
            Type = RDLC;
            Caption = 'Weibel Item Label';
            LayoutFile = './src/LabelReports/Layout/COLItemODCLabel.rdl';
        }
    }

    var
        Item: Record Item;
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeSymbology2D: Enum "Barcode Symbology 2D";
        VariantToSelected: Boolean;
        VariantCodeReq: Code[10];
        CurrItemNo: Code[20];
        SerialNoBarCode: Text;
        ItemTrackingCode: Text;
        NoBarCode: Text;
        ItemFilterTxt: Text;
        PoTxt, PoCon : Text;
        ExtCon: Text;
        ExpDate: Date;
        VarCon, SerCon : Text;
        StandardPlacingCodeTxt, StandardPlacingCodeCon : Text;
        NoOfCopiesToPrint, NoOfLoops : Integer;
        InitFromRecord: Boolean;
        initSource: Enum "COL Init Source";
        PoLbl: Label 'PO: ';
        ExpLbl: Label 'EXP: ';
        VarLbl: Label 'Variant: ';
        SerLbl: Label 'Serial: ';

    trigger OnInitReport()
    begin
        BarcodeSymbology := Enum::"Barcode Symbology"::Code39;
        BarcodeSymbology2D := Enum::"Barcode Symbology 2D"::"QR-Code";
    end;

    local procedure GetITL(var pSerial: Text; var pExpDate: Date)
    var
        TrackingSpecification: Record "Tracking Specification";
        PurchaseLine: Record "Purchase Line";
        ProdOrderLine: Record "Prod. Order Line";
        PurchLineReserve: Codeunit "Purch. Line-Reserve";
        ProdOrderLineReserve: Codeunit "Prod. Order Line-Reserve";
        ItemTrackingLines: Page "Item Tracking Lines";
        SecondSourceQtyArray: array[3] of Decimal;
    begin
        Clear(pSerial);
        Clear(pExpDate);

        if Item."Item Tracking Code" = '' then
            exit;

        case initSource of
            initSource::"Prod. Order Line":
                begin
                    if not ProdOrderLine.Get(ReceiptLine."Source Subtype", ReceiptLine."Source No.", ReceiptLine."Source Line No.") then
                        exit;

                    ProdOrderLineReserve.InitFromProdOrderLine(TrackingSpecification, ProdOrderLine);
                    ItemTrackingLines.SetSourceSpec(TrackingSpecification, ProdOrderLine."Due Date");
                    ItemTrackingLines.SetInbound(ProdOrderLine.IsInbound());
                    ItemTrackingLines.COLGetTrackingData(pSerial, pExpDate);
                end;

            initSource::"Warehouse Receipt Header":
                begin
                    if not PurchaseLine.Get(ReceiptLine."Source Subtype", ReceiptLine."Source No.", ReceiptLine."Source Line No.") then
                        exit;

                    SecondSourceQtyArray[1] := Database::"Warehouse Receipt Line";
                    SecondSourceQtyArray[2] := ReceiptLine."Qty. to Receive (Base)";
                    SecondSourceQtyArray[3] := 0;

                    PurchLineReserve.InitFromPurchLine(TrackingSpecification, PurchaseLine);
                    ItemTrackingLines.SetSourceSpec(TrackingSpecification, PurchaseLine."Expected Receipt Date");
                    ItemTrackingLines.SetSecondSourceQuantity(SecondSourceQtyArray);
                    ItemTrackingLines.COLGetTrackingData(pSerial, pExpDate);
                end;

            initSource::"Tracking Specification":
                begin
                    pSerial := ReceiptLine."COL Serial No.";
                    pExpDate := ReceiptLine."Due Date";
                end;

        end;

    end;

    procedure InitializeReport(pItemFilterTxt: Text)
    begin
        ItemFilterTxt := pItemFilterTxt;
    end;

    procedure InitFrom(var Rec: Record "Warehouse Shipment Header")
    var
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
    begin

        initSource := initSource::"Warehouse Shipment Header";

        InitFromRecord := true;
        WarehouseShipmentLine.SetLoadFields("No.", "Item No.", "Source No.", "Source Subtype", "Source Line No.", "Variant Code", Description);
        WarehouseShipmentLine.SetRange("No.", Rec."No.");
        if warehouseShipmentLine.FindSet() then
            repeat
                if PoTxt = '' then
                    PoTxt := WarehouseShipmentLine."Source No.";

                ReceiptLine."No." := WarehouseShipmentLine."No.";
                ReceiptLine."Line No." := WarehouseShipmentLine."Line No.";
                ReceiptLine."Item No." := WarehouseShipmentLine."Item No.";
                ReceiptLine."Variant Code" := WarehouseShipmentLine."Variant Code";
                ReceiptLine.Description := WarehouseShipmentLine.Description;
                ReceiptLine.Insert();
            until WarehouseShipmentLine.Next() = 0;
    end;

    procedure InitFrom(var Rec: Record "Warehouse Receipt Header")
    var
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        TrackingSpecification: Record "Tracking Specification";
        tempTrackingSpecification: Record "Tracking Specification" temporary;
        PurchaseLine: Record "Purchase Line";
        lItem: Record Item;
        PurchLineReserve: Codeunit "Purch. Line-Reserve";
        ItemTrackingLines: Page "Item Tracking Lines";
        SecondSourceQtyArray: array[3] of Decimal;
        FoundRecord: Boolean;
    begin
        initSource := initSource::"Warehouse Receipt Header";

        InitFromRecord := true;
        WarehouseReceiptLine.SetLoadFields("No.", "Item No.", "COL Print GTIN Label", "Source No.", "Source Subtype", "Source Line No.");
        WarehouseReceiptLine.SetRange("No.", Rec."No.");
        WarehouseReceiptLine.SetRange("COL Print GTIN Label", true);

        if WarehouseReceiptLine.FindSet() then
            repeat
                if PoTxt = '' then
                    PoTxt := WarehouseReceiptLine."Source No.";

                if not lItem.Get(WarehouseReceiptLine."Item No.") then
                    lItem.Init();

                FoundRecord := false;
                if (lItem."Item Tracking Code" <> '') and (PurchaseLine.Get(WarehouseReceiptLine."Source Subtype", WarehouseReceiptLine."Source No.", WarehouseReceiptLine."Source Line No.")) then begin

                    Clear(SecondSourceQtyArray);
                    Clear(PurchLineReserve);
                    Clear(ItemTrackingLines);
                    Clear(TrackingSpecification);
                    SecondSourceQtyArray[1] := Database::"Warehouse Receipt Line";
                    SecondSourceQtyArray[2] := ReceiptLine."Qty. to Receive (Base)";
                    SecondSourceQtyArray[3] := 0;

                    PurchLineReserve.InitFromPurchLine(TrackingSpecification, PurchaseLine);
                    ItemTrackingLines.SetSourceSpec(TrackingSpecification, PurchaseLine."Expected Receipt Date");
                    ItemTrackingLines.SetSecondSourceQuantity(SecondSourceQtyArray);
                    if ItemTrackingLines.COLGetTrackingData(tempTrackingSpecification) then  // in case that Warehouse Receipt Line exist but without TS
                        FoundRecord := true;
                end;

                if not FoundRecord then begin
                    ReceiptLine.TransferFields(WarehouseReceiptLine);
                    ReceiptLine.Insert();
                end;
            until WarehouseReceiptLine.Next() = 0;

        tempTrackingSpecification.Reset();
        InitFrom(tempTrackingSpecification);
    end;

    procedure InitFrom(var Rec: Record "Warehouse Activity Header")
    var
        WarehouseActivityLine: Record "Warehouse Activity Line";
        TrackingSpecification: Record "Tracking Specification";
        tempTrackingSpecification: Record "Tracking Specification" temporary;
        PurchaseLine: Record "Purchase Line";
        lItem: Record Item;
        PurchLineReserve: Codeunit "Purch. Line-Reserve";
        ItemTrackingLines: Page "Item Tracking Lines";
        SecondSourceQtyArray: array[3] of Decimal;
        FoundRecord: Boolean;
    begin
        initSource := initSource::"Warehouse Activity Header";

        InitFromRecord := true;
        WarehouseActivityLine.SetRange("No.", Rec."No.");
        WarehouseActivityLine.SetRange("COL Print GTIN Label", true);
        WarehouseActivityLine.SetRange("Activity Type", Rec.Type);

        if WarehouseActivityLine.FindSet() then
            repeat
                if PoTxt = '' then
                    PoTxt := WarehouseActivityLine."Source No.";

                if not lItem.Get(WarehouseActivityLine."Item No.") then
                    lItem.Init();

                FoundRecord := false;
                if (lItem."Item Tracking Code" <> '') and (PurchaseLine.Get(WarehouseActivityLine."Source Subtype", WarehouseActivityLine."Source No.", WarehouseActivityLine."Source Line No.")) then begin

                    Clear(SecondSourceQtyArray);
                    Clear(PurchLineReserve);
                    Clear(ItemTrackingLines);
                    Clear(TrackingSpecification);
                    SecondSourceQtyArray[1] := Database::"Warehouse Activity Line";
                    SecondSourceQtyArray[2] := ReceiptLine."Qty. to Receive (Base)";
                    SecondSourceQtyArray[3] := 0;

                    PurchLineReserve.InitFromPurchLine(TrackingSpecification, PurchaseLine);
                    ItemTrackingLines.SetSourceSpec(TrackingSpecification, PurchaseLine."Expected Receipt Date");
                    ItemTrackingLines.SetSecondSourceQuantity(SecondSourceQtyArray);
                    if ItemTrackingLines.COLGetTrackingData(tempTrackingSpecification, WarehouseActivityLine."Serial No.") then  // in case that Warehouse Receipt Line exist but without TS
                        FoundRecord := true;
                end;

                if not FoundRecord then begin

                    ReceiptLine."No." := WarehouseActivityLine."Whse. Document No.";
                    ReceiptLine."Line No." := WarehouseActivityLine."Line No.";
                    ReceiptLine."Item No." := WarehouseActivityLine."Item No.";
                    ReceiptLine."Description" := WarehouseActivityLine."Description";
                    ReceiptLine."Source No." := '';
                    ReceiptLine."Source Subtype" := ReceiptLine."Source Subtype"::"0";
                    ReceiptLine."Source Line No." := 0;
                    ReceiptLine."Due Date" := WarehouseActivityLine."Due Date";
                    ReceiptLine."Variant Code" := WarehouseActivityLine."Variant Code";
                    ReceiptLine.Insert();

                end;
            until WarehouseActivityLine.Next() = 0;

        tempTrackingSpecification.Reset();
        InitFrom(tempTrackingSpecification);
    end;

    procedure InitFrom(var
                           Rec: Record "Prod. Order Line")
    begin
        initSource := initSource::"Prod. Order Line";

        InitFromRecord := true;

        ReceiptLine."No." := 'XX';
        ReceiptLine."Line No." := 10000;
        ReceiptLine."Item No." := Rec."Item No.";
        ReceiptLine."Description" := Rec."Description";
        ReceiptLine."Source No." := Rec."Prod. Order No.";
        ReceiptLine."Source Subtype" := Rec.Status.AsInteger();
        ReceiptLine."Source Line No." := Rec."Line No.";
        ReceiptLine."Due Date" := Rec."Due Date";
        ReceiptLine."Variant Code" := Rec."Variant Code";
        ReceiptLine.Insert();

    end;

    procedure InitFrom(var Rec: Record "Item")
    begin
        initSource := initSource::"Item";

        InitFromRecord := true;
        CurrItemNo := Rec."No.";
        VariantToSelected := true;

        ReceiptLine."No." := 'XX';
        ReceiptLine."Line No." := 10000;
        ReceiptLine."Item No." := Rec."No.";
        ReceiptLine."Description" := Rec."Description";
        ReceiptLine."Source No." := '';
        ReceiptLine."Source Subtype" := ReceiptLine."Source Subtype"::"0";
        ReceiptLine."Source Line No." := 0;
        ReceiptLine."Due Date" := 0D;
        ReceiptLine."Variant Code" := '';
        ReceiptLine.Insert();

    end;

    procedure InitFrom(var Rec: Record "Item"; pVariantCode: code[10])
    begin
        initSource := initSource::"Item";

        InitFromRecord := true;
        CurrItemNo := Rec."No.";
        VariantToSelected := true;

        ReceiptLine."No." := 'XX';
        ReceiptLine."Line No." := 10000;
        ReceiptLine."Item No." := Rec."No.";
        ReceiptLine."Description" := Rec."Description";
        ReceiptLine."Source No." := '';
        ReceiptLine."Source Subtype" := ReceiptLine."Source Subtype"::"0";
        ReceiptLine."Source Line No." := 0;
        ReceiptLine."Due Date" := 0D;
        ReceiptLine."Variant Code" := pVariantCode;
        ReceiptLine.Insert();

    end;

    procedure SetNoOfCopy(i: Integer)
    begin
        NoOfCopiesToPrint := i;
    end;

    procedure InitFrom(var Rec: Record "Stockkeeping Unit")
    var
        lineNo: Integer;
    begin
        initSource := initSource::"Stockkeeping Unit";
        InitFromRecord := true;
        lineNo := 10000;

        if Rec.FindSet() then
            repeat

                ReceiptLine."No." := 'XX';
                ReceiptLine."Line No." := lineNo;
                ReceiptLine."Item No." := Rec."Item No.";
                ReceiptLine."Description" := Rec."Description";
                ReceiptLine."Source No." := '';
                ReceiptLine."Source Subtype" := ReceiptLine."Source Subtype"::"0";
                ReceiptLine."Source Line No." := 0;
                ReceiptLine."Due Date" := 0D;
                ReceiptLine."Variant Code" := Rec."Variant Code";
                ReceiptLine.Insert();
                lineNo += 1;

            until Rec.Next() = 0;

    end;

    procedure InitFrom(var Rec: Record "Tracking Specification")
    begin
        InitFrom(Rec, false);
    end;

    procedure InitFrom(var Rec: Record "Tracking Specification"; Ungrouped: Boolean)
    var
        lineNo: Integer;
        i: Integer;
    begin
        initSource := initSource::"Tracking Specification";
        InitFromRecord := true;
        lineNo := 10000;

        i := 0;
        if Rec.FindSet() then
            repeat

                ReceiptLine."No." := 'XX';
                ReceiptLine."Line No." := lineNo;
                ReceiptLine."Item No." := Rec."Item No.";
                ReceiptLine."Description" := Rec."Description";
                ReceiptLine."Source No." := Rec."Source ID";
                ReceiptLine."Source Subtype" := ReceiptLine."Source Subtype"::"0";
                ReceiptLine."Source Line No." := 0;
                ReceiptLine."Due Date" := Rec."Expiration Date";
                ReceiptLine."COL Serial No." := Rec."Serial No.";
                ReceiptLine."Variant Code" := Rec."Variant Code";
                if Ungrouped then
                    ReceiptLine."Description 2" := Format(i) // to ungroup when print multiple labels withaut serial no 
                else
                    ReceiptLine."Description 2" := '';
                ReceiptLine.Insert();
                lineNo += 1;
                i += 1;

            until Rec.Next() = 0;

    end;
}
