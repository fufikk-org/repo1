namespace Weibel.Inventory.Item;

using Microsoft.Inventory.Item;
using Microsoft.Inventory.Location;
using Microsoft.Manufacturing.Setup;
using System.Text;

report 70108 "COL SMD Label"
{
    ApplicationArea = All;
    Caption = 'SMD Label';
    UsageCategory = Administration;
    RDLCLayout = './src/LabelReports/Layout/COLsmdLabel.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Stockkeeping Unit"; "Stockkeeping Unit")
        {
            RequestFilterFields = "Item No.", "Variant Code";

            column(No; ItemNoOnly)
            {
            }
            column(VariantCode; "Variant Code")
            {
            }
            column(NoBarcode; NoEncodedText)
            {
            }
            column(Description; Description)
            {
            }
            column(StandardPlacingCode; 'xxxx')
            {
            }
            column(PartTxt; PartLbl)
            {
            }
            column(QtyTxt; QtyText)
            {
            }
            column(QtyBarcode; QtyEncodedText)
            {
            }
            column(Quantity; '1')
            {
            }
            column(BATCHTxt; BATCHLbl)
            {
            }
            column(SMDTxt; SmdText)
            {
            }
            column(SmdBarcode; SmdEncodedText)
            {
            }
            column(DefaultBinTxt; DefaultBinText)
            {
            }
            column(DefaultBinCode; DefaultBinCode)
            {
            }

            trigger OnAfterGetRecord()
            var
                ManufacturingTech: Record "COL Manufacturing Tech Setup";
                BarcodeString: Text;
                BarcodeSymbology: Enum "Barcode Symbology";
                BarcodeFontProvider: Interface "Barcode Font Provider";
            begin
                "Stockkeeping Unit".CalcFields("COL Default Bin Code");
                DefaultBinCode := "Stockkeeping Unit"."COL Default Bin Code";
                if DefaultBinCode <> '' then
                    DefaultBinText := DefaultBinLbl
                else
                    DefaultBinText := '';

                ItemNoOnly := "Item No.";

                QtyText := StrSubstNo(QtyLbl, Format(QuantityVal, 0, 9));

                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;

                BarcodeSymbology := Enum::"Barcode Symbology"::Code128;

                BarcodeString := PartPrefixLbl + "Item No.";
                BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                NoEncodedText := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);

                BarcodeString := QtyPrefixLbl + Format(QuantityVal, 0, 9);
                BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                QtyEncodedText := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);


                if not ManufacturingTech.Get() then begin
                    ManufacturingTech.Init();
                    ManufacturingTech.Insert();
                end
                else
                    SmdText := ManufacturingTech."COL SMD Batch Code";

                if SmdText = '' then
                    SmdText := SmdBaseLbl
                else
                    SmdText := IncStr(SmdText);

                ManufacturingTech."COL SMD Batch Code" := SmdText;
                ManufacturingTech.Modify();

                BarcodeString := BatchPrefixLbl + SmdText;
                BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                SmdEncodedText := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(QuantityCtr; QuantityVal)
                    {
                        Caption = 'Quantity';
                        ToolTip = 'Specifies Quantity on prints';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        QuantityVal := 1;
    end;

    var
        NoEncodedText: Text;
        QtyEncodedText: Text;
        SmdEncodedText: Text;
        DefaultBinText: Text;
        DefaultBinCode: Text;
        ItemNoOnly: Text;
        SmdText: Code[20];
        QtyText: Text;
        SmdBaseLbl: Label '110000001', Locked = true;
        PartLbl: Label '(1P) PART#SPRL:', Locked = true;
        PartPrefixLbl: Label '1P', Locked = true;
        QtyLbl: Label '(Q) QTY: %1', Locked = true, Comment = '%1 = Quantity';
        QtyPrefixLbl: Label 'Q', Locked = true;
        BATCHLbl: Label '(1T) BATCH#SPRL:', Locked = true;
        BatchPrefixLbl: Label '1T', Locked = true;
        DefaultBinLbl: Label 'Default Bin:';
        QuantityVal: Decimal;
}
