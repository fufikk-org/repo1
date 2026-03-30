namespace Weibel.Inventory.Item;

using System.Text;
using Microsoft.Inventory.Item;
using System.Utilities;
using Microsoft.Warehouse.Document;
using Weibel.Common;
using Microsoft.Warehouse.Activity;

report 70117 "COL Warehouse Doc. Label"
{
    Caption = 'Shipment Item Label';
    UsageCategory = Tasks;
    ApplicationArea = All;
    WordMergeDataItem = ShipmentLine;
    DefaultRenderingLayout = Rdlc;

    dataset
    {
        dataitem(ShipmentLine; "Warehouse Shipment Line")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Warehouse Shipment Lines';
            UseTemporary = true;

            column(No_; Item."No.")
            {
            }
            column(FakeNo_; ShipmentLine."Description 2")
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
            column(POValue; PoVal)
            {
            }
            column(EXT; ExtCon)
            {
            }
            column(SerialCtr; SerCon)
            {
            }
            column(SerialNoBarCodeCtr; SourceNoNoBarCode)
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
                begin
                    if not Item.Get(ShipmentLine."Item No.") then
                        Item.Init();

                    PoCon := PoLbl;
                    VarCon := VarLbl + ShipmentLine."Variant Code";
                    PoVal := ShipmentLine."Source No.";

                    ItemTrackingCode := '';
                    if Item."Item Tracking Code" <> '' then
                        ItemTrackingCode := Item.FieldCaption("Item Tracking Code") + ': ' + Item."Item Tracking Code";

                    BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                    BarcodeSymbology := Enum::"Barcode Symbology"::Code128;

                    BarcodeString := ShipmentLine."Item No.";
                    if ShipmentLine."Variant Code" <> '' then
                        BarcodeString += '-' + ShipmentLine."Variant Code";
                    BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                    NoBarCode := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);

                    SourceNoNoBarCode := '';
                    if PoVal <> '' then begin
                        BarcodeString := PoVal;
                        BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                        SourceNoNoBarCode := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
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
                WarehouseReceiptLine: Record "Warehouse Shipment Line";
            begin
                if not InitFromRecord then begin
                    WarehouseReceiptLine.CopyFilters(ShipmentLine);
                    if WarehouseReceiptLine.FindSet() then
                        repeat
                            ShipmentLine.TransferFields(WarehouseReceiptLine);
                            ShipmentLine.Insert();
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
                    field(VariantCode; VariantCodeReq)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Variant Code';
                        Visible = false;
                        ToolTip = 'Select Variant for to print.';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            ItemVariant: Record "Item Variant";
                            ItemVariants: Page "Item Variants";
                        begin
#pragma warning disable AA0205
                            ItemVariant.SetRange("Item No.", CurrItemNo);
#pragma warning restore AA0205
                            ItemVariants.SetTableView(ItemVariant);
                            ItemVariants.LookupMode := true;
                            if ItemVariants.RunModal() = Action::LookupOK then begin
                                ItemVariants.GetRecord(ItemVariant);
                                VariantCodeReq := ItemVariant."Code";
                                if ShipmentLine.FindFirst() then begin
                                    ShipmentLine."Variant Code" := VariantCodeReq;
                                    ShipmentLine.Modify(false);
                                end;
                            end;
                        end;

                        trigger OnValidate()
                        var
                            ItemVariant: Record "Item Variant";
                        begin
                            if ShipmentLine.FindFirst() then begin
                                ItemVariant.Get(ShipmentLine."Item No.", VariantCodeReq);
                                ShipmentLine."Variant Code" := VariantCodeReq;
                                ShipmentLine.Modify(false);
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
            Caption = 'Warehouse Item Label';
            LayoutFile = './src/LabelReports/Layout/COLWarehouseDocLabel.rdl';
        }
    }

    var
        Item: Record Item;
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeSymbology2D: Enum "Barcode Symbology 2D";
        VariantCodeReq: Code[10];
        CurrItemNo: Code[20];
        SourceNoNoBarCode: Text;
        ItemTrackingCode: Text;
        NoBarCode: Text;
        ItemFilterTxt: Text;
        PoTxt, PoCon, PoVal : Text;
        ExtCon: Text;
        VarCon, SerCon : Text;
        StandardPlacingCodeTxt, StandardPlacingCodeCon : Text;
        NoOfCopiesToPrint, NoOfLoops : Integer;
        InitFromRecord: Boolean;
        initSource: Enum "COL Init Source";
        PoLbl: Label 'PO:';
        VarLbl: Label 'Variant: ';

    trigger OnInitReport()
    begin
        BarcodeSymbology := Enum::"Barcode Symbology"::Code39;
        BarcodeSymbology2D := Enum::"Barcode Symbology 2D"::"QR-Code";
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

                ShipmentLine."No." := WarehouseShipmentLine."No.";
                ShipmentLine."Line No." := WarehouseShipmentLine."Line No.";
                ShipmentLine."Item No." := WarehouseShipmentLine."Item No.";
                ShipmentLine."Variant Code" := WarehouseShipmentLine."Variant Code";
                ShipmentLine.Description := WarehouseShipmentLine.Description;
                ShipmentLine."Source No." := WarehouseShipmentLine."Source No.";
                ShipmentLine.Insert();
            until WarehouseShipmentLine.Next() = 0;
    end;

    procedure SetNoOfCopy(i: Integer)
    begin
        NoOfCopiesToPrint := i;
    end;

}
