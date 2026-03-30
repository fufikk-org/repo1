namespace Weibel.Inventory.Item;

using System.Text;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Location;
using System.Utilities;

report 70100 "COL Weibel Item GTIN Label"
{
    UsageCategory = Tasks;
    ApplicationArea = All;
    Caption = 'Weibel Item GTIN Label';
    WordMergeDataItem = Items;
    DefaultRenderingLayout = Rdlc;

    dataset
    {
        dataitem(Items; Item)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Items';

            column(No_; Items."No.")
            {
            }
            column(Description; Items.Description)
            {
            }
            column(Description2; Items."Description 2")
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
            column(GTIN; GTINBarCode)
            {
            }
            column(GTIN_2D; GTINQRCode)
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
                    BarcodeFontProvider2D: Interface "Barcode Font Provider 2D";
                begin
                    // Declare the barcode provider using the barcode provider interface and enum
                    BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                    BarcodeFontProvider2D := Enum::"Barcode Font Provider 2D"::IDAutomation2D;

                    // Set data string source 
                    if Items.GTIN <> '' then begin
                        BarcodeString := Items.GTIN;
                        // Validate the input
                        BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                        // Encode the data string to the barcode font
                        GTINBarCode := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
                        GTINQRCode := BarcodeFontProvider2D.EncodeFont(BarcodeString, BarcodeSymbology2D);
                    end
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopiesToPrint) + 1;
                    if NoOfLoops <= 0 then
                        NoOfLoops := 1;
                    SetRange(Number, 1, NoOfLoops);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if Items."COL Standard Placing Code" = '' then
                    StandardPlacingCodeCon := StandardPlacingCodeTxt
                else
                    StandardPlacingCodeCon := Items."COL Standard Placing Code";

                PoCon := PoLbl + PoTxt;
                ExtCon := ExpLbl + ExpTxt;
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
                    field(ManualStandardPlacingCode; StandardPlacingCodeTxt)
                    {
                        ApplicationArea = Service;
                        Caption = 'Standard Placing Code';
                        ToolTip = 'this is manual Standard Placing Code if it is empty on item card.';
                        TableRelation = Location;
                    }
                    field(Po; PoTxt)
                    {
                        ApplicationArea = Service;
                        Caption = 'PO No.';
                        ToolTip = 'Specifies free PO text.';
                    }
                    field(Exp; ExpTxt)
                    {
                        ApplicationArea = Service;
                        Caption = 'EXP Date';
                        ToolTip = 'Specifies free EXP text.';
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
            LayoutFile = './src/LabelReports/Layout/COLItemGTINLabel.rdl';
        }
    }

    var
        BarcodeSymbology: Enum "Barcode Symbology";
        BarcodeSymbology2D: Enum "Barcode Symbology 2D";
        GTINBarCode: Text;
        GTINQRCode: Text;
        ItemFilterTxt: Text;
        PoTxt, PoCon : Text;
        ExpTxt, ExtCon : Text;
        StandardPlacingCodeTxt, StandardPlacingCodeCon : Text;
        NoOfCopiesToPrint, NoOfLoops : Integer;
        PoLbl: Label 'PO: ';
        ExpLbl: Label 'EXP: ';

    trigger OnInitReport()
    begin
        BarcodeSymbology := Enum::"Barcode Symbology"::Code39;
        BarcodeSymbology2D := Enum::"Barcode Symbology 2D"::"QR-Code";
    end;

    procedure InitializeReport(pItemFilterTxt: Text)
    begin
        ItemFilterTxt := pItemFilterTxt;
    end;
}
