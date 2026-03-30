namespace Weibel.Inventory.Ledger;


using Microsoft.Inventory.Tracking;
using Microsoft.Foundation.Company;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Ledger;
using Microsoft.Foundation.Address;
using System.Text;
using Microsoft.Manufacturing.Document;

report 70112 "COL SN Label"
{

    ApplicationArea = All;
    Caption = 'COL SN Label';
    UsageCategory = Administration;
    DefaultRenderingLayout = Rdlc;

    dataset
    {
        dataitem(TmpTrackingSpecification; "Tracking Specification")
        {
            UseTemporary = true;

            column(CompanyPicture; CompanyInformation.Picture)
            {
            }
            column(CompanyAddress; CompanyAddressTxt)
            {
            }
            column(CompanyEmail; CompanyInformation."Home Page")
            {
            }

            column(TypeLbl_; TypeLbl)
            {
            }
            column(RevLbl_; RevLbl)
            {
            }
            column(DateLbl_; DateLbl)
            {
            }
            column(EIDLbl_; EIDLbl)
            {
            }
            column(SerialLbl_; SerialLbl)
            {
            }

            column(TypeVal_; TypeTxt)
            {
            }
            column(RevVal_; TmpTrackingSpecification."Variant Code")
            {
            }
            column(DateVal_; PrefixEIDLbl)
            {
            }
            column(EIDVal_; PrefixEIDLbl)
            {
            }
            column(SerialVal_; SerialTxt)
            {
            }
            column(BarCode; BarcodeString)
            {
            }

            trigger OnAfterGetRecord()
            var
                BarcodeSymbology2D: Enum "Barcode Symbology 2D";
                BarcodeFontProvider2D: Interface "Barcode Font Provider 2D";
                ToBarCodeTxt: Text;
            begin
                TypeTxt := StrSubstNo(prefixTypeLbl, TmpTrackingSpecification."Item No.");
                SerialTxt := StrSubstNo(PrefixSerialLbl, TmpTrackingSpecification."Serial No.");

                //"[)>0617V", "(17V)R1121", "1P", Item description, "S", SerialNo) // value from specification
                ToBarCodeTxt := StrSubstNo(PrefixBarCodeLbl, TmpTrackingSpecification."Item No.", TmpTrackingSpecification."Serial No.");

                BarcodeString := '';
                if ToBarCodeTxt <> '' then begin
                    BarcodeFontProvider2D := Enum::"Barcode Font Provider 2D"::IDAutomation2D;
                    BarcodeSymbology2D := Enum::"Barcode Symbology 2D"::"QR-Code";
                    BarcodeString := BarcodeFontProvider2D.EncodeFont(ToBarCodeTxt, BarcodeSymbology2D);
                end;

                if LabelNo > 1 then
                    Clear(CompanyInformation);
                LabelNo += 1;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
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
            LayoutFile = './src/LabelReports/Layout/COLSNLabel.rdl';
        }
    }

    var
        CompanyInformation: Record "Company Information";
        CountryRegion: Record "Country/Region";
        BarcodeSymbology2D: Enum "Barcode Symbology 2D";
        LabelNo: Integer;
        TypeTxt: Text;
        BarcodeString: Text;
        SerialTxt: Text;
        CompanyAddressTxt: Text;
        TypeLbl: Label 'P/N:', Locked = true;
        prefixTypeLbl: Label '%1', Comment = '%1 - val', Locked = true;
        RevLbl: Label 'REV:', Locked = true;
        DateLbl: Label 'MFR:', Locked = true;
        EIDLbl: Label 'ODA:', Locked = true;
        PrefixEIDLbl: Label 'R1121', Locked = true;
        SerialLbl: Label 'S/N:', Locked = true;
        PrefixSerialLbl: Label '%1', Comment = '%1 - val', Locked = true;
        //PrefixBarCodeLbl: Label '[)>0617V(17V)R11211P%1S%2)', Comment = '%1 - Item description, %2 - Serial No'; // TODO just in case consultant changed mind
        PrefixBarCodeLbl: Label '[)>0617VR11211P%1S%2)', Comment = '%1 - Item description, %2 - Serial No', Locked = true;

    trigger OnInitReport()
    begin
        BarcodeSymbology2D := Enum::"Barcode Symbology 2D"::"QR-Code";
    end;

    procedure InitFromILE(var Rec: Record "Production Order")
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        LineNo: Integer;
        NoSerialNo: Boolean;
        NoSerialNoErr: Label 'Serial No. is missing in some Item Ledger Entry of Production Order %1', Comment = '%1 - Prod. Order No.';
    begin
        LineNo := 1;
        ItemLedgerEntry.SetCurrentKey("Order Type", "Order No.");
        ItemLedgerEntry.SetRange("Order Type", ItemLedgerEntry."Order Type"::Production);
        ItemLedgerEntry.SetRange("Order No.", Rec."No.");
        ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Output);
        ItemLedgerEntry.SetAutoCalcFields("Item Description");
        if ItemLedgerEntry.FindSet() then
            repeat
                TmpTrackingSpecification."Entry No." := LineNo;
                TmpTrackingSpecification."Item No." := ItemLedgerEntry."Item No.";
                TmpTrackingSpecification.Description := ItemLedgerEntry."Item Description";
                TmpTrackingSpecification."Variant Code" := ItemLedgerEntry."Variant Code";
                TmpTrackingSpecification."Creation Date" := ItemLedgerEntry."Posting Date";
                TmpTrackingSpecification."Serial No." := ItemLedgerEntry."Serial No.";
                TmpTrackingSpecification.Insert();
                LineNo += 1;

                if ItemLedgerEntry."Serial No." = '' then
                    NoSerialNo := true;
            until ItemLedgerEntry.Next() = 0;


        if NoSerialNo then
            Message(NoSerialNoErr, Rec."No.");
    end;

    procedure InitFrom(var Rec: Record "Production Order")
    var
        Item: Record Item;
        ProdOrderLine: Record "Prod. Order Line";
        TrackingSpecification: Record "Tracking Specification";
        tempLocalTrackingSpecification: Record "Tracking Specification" temporary;
        ProdLineReserve: Codeunit "Prod. Order Line-Reserve";
        ItemTrackingLines: Page "Item Tracking Lines";
        SecondSourceQtyArray: array[3] of Decimal;
        LineNo: Integer;
        NoSerialNoErr: Label 'Serial No. must be added in Item Tracking Lines of Production Order %1', Comment = '%1 - Prod. Order No.';
    begin
        ProdOrderLine.SetRange(Status, Rec.Status);
        ProdOrderLine.SetRange("Prod. Order No.", Rec."No.");
        ProdOrderLine.SetFilter("Item No.", '<>%1', '');

        LineNo := 1;
        if ProdOrderLine.FindSet() then
            repeat
                if not Item.Get(ProdOrderLine."Item No.") then
                    Item.Init();

                tempLocalTrackingSpecification.Reset();
                tempLocalTrackingSpecification.DeleteAll();
                Clear(SecondSourceQtyArray);
                Clear(ProdLineReserve);
                Clear(ItemTrackingLines);
                Clear(TrackingSpecification);
                SecondSourceQtyArray[1] := Database::"Prod. Order Line";
                SecondSourceQtyArray[2] := ProdOrderLine."Quantity (Base)";
                SecondSourceQtyArray[3] := 0;


                ProdLineReserve.InitFromProdOrderLine(TrackingSpecification, ProdOrderLine);
                ItemTrackingLines.SetSourceSpec(TrackingSpecification, ProdOrderLine."Due Date");
                ItemTrackingLines.SetSecondSourceQuantity(SecondSourceQtyArray);
                ItemTrackingLines.COLGetTrackingData(tempLocalTrackingSpecification);

                if tempLocalTrackingSpecification.FindSet() then
                    repeat
                        TmpTrackingSpecification.TransferFields(tempLocalTrackingSpecification);
                        TmpTrackingSpecification."Entry No." := LineNo;
                        TmpTrackingSpecification."Item No." := ProdOrderLine."Item No.";
                        TmpTrackingSpecification.Description := Item.Description;
                        TmpTrackingSpecification."Variant Code" := ProdOrderLine."Variant Code";
                        TmpTrackingSpecification."Creation Date" := ProdOrderLine."Due Date";
                        TmpTrackingSpecification.Insert();
                        LineNo += 1;
                    until tempLocalTrackingSpecification.Next() = 0;

            until ProdOrderLine.Next() = 0;

        if TmpTrackingSpecification.Count = 0 then
            Error(NoSerialNoErr, Rec."No.");
    end;

    procedure InitFrom(var Rec: Record "Serial No. Information")
    var
        LineNo: Integer;
    begin
        LineNo := 1;
        if Rec.FindSet() then
            repeat

                TmpTrackingSpecification."Entry No." := LineNo;
                TmpTrackingSpecification."Item No." := Rec."Item No.";
                TmpTrackingSpecification.Description := Rec."Description";
                TmpTrackingSpecification."Variant Code" := Rec."Variant Code";
                TmpTrackingSpecification."Creation Date" := Rec.SystemCreatedAt.Date();
                TmpTrackingSpecification."Serial No." := Rec."Serial No.";
                TmpTrackingSpecification.Insert();
                LineNo += 1;

            until Rec.Next() = 0;
    end;

    trigger OnPreReport()
    begin
        if not CompanyInformation.Get() then
            CompanyInformation.Init();

        CompanyInformation.CalcFields(Picture);
        LabelNo := 1;

        CompanyAddressTxt := CompanyInformation.Address;
        if CompanyInformation."Post Code" <> '' then
            CompanyAddressTxt += ', ' + CompanyInformation."Post Code";
        if CompanyInformation.City <> '' then
            CompanyAddressTxt += ', ' + CompanyInformation.City;
        if CountryRegion.Get(CompanyInformation."Country/Region Code") then
            CompanyAddressTxt += ', ' + CountryRegion.Name;

    end;
}
