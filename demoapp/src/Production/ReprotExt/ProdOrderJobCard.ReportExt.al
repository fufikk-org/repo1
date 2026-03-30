namespace Weibel.Manufacturing.Document;

using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Item;
using System.Utilities;
using Weibel.Inventory.Item;
using System.Text;

reportextension 70110 "COL Prod. Order - Job Card" extends "Prod. Order - Job Card"
{
    dataset
    {
        add("Production Order")
        {
            column(COLProdOrderNoLbl; ProdOrderNoLbl) { }
            column(COLROHSLbl; ROHSLbl) { }
            column(COLSourceNoLbl; "Production Order".FieldCaption("Source No.")) { }
            column(COLQuantityLbl; "Production Order".FieldCaption("Quantity")) { }
            column(COLDescriptionLbl; "Production Order".FieldCaption(Description)) { }
            column(COLPriorityLbl; PriorityLbl) { }
            column(COLRouteLbl; RouteLbl) { }
            column(COLOperationLbl; OperationLbl) { }
            column(COLSetupTimeLbl; SetupTimeLbl) { }
            column(COLRouteTimeLbl; RouteTimeLbl) { }
            column(COLInitLbl; InitLbl) { }

            column(COLWarehouseLbl; WarehouseLbl) { }
            column(COLStandardWarehouseLbl; StandardWarehouseLbl) { }
            column(COLQtyLbl; QtyLbl) { }
            column(COLPlacedOnLbl; PlacedOnLbl) { }
            column(COLLimitationsLbl; LimitationsLbl) { }

            column(COLRoHS; EURohsDirCompliant) { }
            column(COLStdLocation; StdLoc) { }
            column(COLPO_Quantity; Format("Production Order".Quantity, 0, '<Precision,0:2><Standard Format,9>')) { }
            column(COLPO_SourceNo; "Production Order"."Source No.") { }
            column(COLPO_Desc; "Production Order".Description) { }
            column(COLBarCodeCtr; BarCode) { }
            column(COLVariantCode; "Production Order"."Variant Code") { }
            column(COLVariantCodeLbl; "Production Order".FieldCaption("Variant Code")) { }

        }

        add("Prod. Order Routing Line")
        {
            column(COLRoute; true) { } // route line indicator
            column(COLRouteOperation; "Prod. Order Routing Line"."Operation No.") { }
            column(COLRouteDescription; "Prod. Order Routing Line".Description) { }
            column(COLRouteSetupTime; Format("Prod. Order Routing Line"."Setup Time", 0, '<Precision,0:2><Standard Format,9>')) { }
            column(COLRouteRunTime; Format("Prod. Order Routing Line"."Run Time", 0, '<Precision,0:2><Standard Format,9>')) { }
        }

        addlast("Production Order")
        {
            dataitem("COL Comments"; "Integer")
            {
                DataItemTableView = sorting(Number);

                column(COLCommentNo; "COL Comments".Number) { }

                column(COLCommentProdNo; CommentProdNo) { }
                column(COLCommentDate; CommentDate) { }
                column(COLCommentText; CommentTxt) { }

                trigger OnPreDataItem()
                var
                    maxCommentLines: Integer;
                begin
                    ProdOrderCommentLine.SetRange("Prod. Order No.", "Production Order"."No.");
                    ProdOrderCommentLine.SetRange(Status, "Production Order".Status);
                    TotalComments := ProdOrderCommentLine.Count();
                    CurrentComment := 1;

                    maxCommentLines := 14 - "Prod. Order Routing Line".Count();
                    if maxCommentLines < 1 then
                        maxCommentLines := 1;

                    "COL Comments".SetFilter(Number, '1..%1', maxCommentLines);
                end;

                trigger OnAfterGetRecord()
                begin
                    CommentDate := 0D;
                    CommentTxt := '';
                    CommentProdNo := "Production Order"."No.";

                    if CurrentComment <= TotalComments then begin

                        if CurrentComment = 1 then
                            ProdOrderCommentLine.FindFirst()
                        else
                            ProdOrderCommentLine.Next();

                        CurrentComment += 1;
                        CommentDate := ProdOrderCommentLine.Date;
                        CommentTxt := ProdOrderCommentLine.Comment;
                    end;
                end;
            }
        }

        // addlast("Production Order")
        // {
        //     dataitem("COL Prod. Order Line"; "Prod. Order Line")
        //     {
        //         DataItemLink = Status = field(Status), "Prod. Order No." = field("No.");
        //         DataItemTableView = sorting(Status, "Prod. Order No.", "Line No.");

        //         dataitem("COL Prod. Order Routing"; "Prod. Order Routing Line")
        //         {
        //             DataItemLink = Status = field(Status), "Prod. Order No." = field("Prod. Order No."), "Routing No." = field("Routing No."),
        //                            "Routing Reference No." = field("Routing Reference No.");
        //             DataItemTableView = sorting(Status, "Prod. Order No.", "Operation No.");

        //             column(COLRoute; true) { } // route line indicator
        //             column(COLRouteOperation; "COL Prod. Order Routing"."Operation No.") { }
        //             column(COLRouteDescription; "COL Prod. Order Routing".Description) { }
        //             column(COLRouteSetupTime; "COL Prod. Order Routing"."Setup Time") { }
        //             column(COLRouteRunTime; "COL Prod. Order Routing"."Run Time") { }
        //         }
        //     }
        // }

        modify("Production Order")
        {
            trigger OnAfterAfterGetRecord()
            var
                ItemVariant: Record "Item Variant";
                BarcodeFontProvider: Interface "Barcode Font Provider";
            begin
                EURohsDirCompliant := Enum::"COL EU RoHS Dir. Compliant"::" ";
                if not Item.Get("Production Order"."Source No.") then
                    Item.Init();

                if "Production Order"."Variant Code" <> '' then begin
                    ItemVariant.SetLoadFields("COL EU RoHS Dir. Compliant");
                    if ItemVariant.Get("Production Order"."Source No.", "Production Order"."Variant Code") then
                        EURohsDirCompliant := ItemVariant."COL EU RoHS Dir. Compliant";
                end else
                    EURohsDirCompliant := Item."COL EU RoHS Dir. Compliant";


                StdLoc := "Production Order"."Location Code";
                if "Production Order"."Bin Code" <> '' then
                    StdLoc := StdLoc + BinLbl + "Production Order"."Bin Code";


                BarcodeFontProvider := Enum::"Barcode Font Provider"::IDAutomation1D;
                BarcodeSymbology := Enum::"Barcode Symbology"::Code128;

                BarcodeString := "Production Order"."No.";
                BarcodeFontProvider.ValidateInput(BarcodeString, BarcodeSymbology);
                BarCode := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
            end;
        }
    }

    rendering
    {
        layout(COLRdlc)
        {
            Caption = 'Weibel Layout';
            Type = RDLC;
            LayoutFile = './src/Production/Layout/COLProdOrderJobCard.rdl';
        }
    }

    var
        ProdOrderCommentLine: Record "Prod. Order Comment Line";
        Item: Record "Item";
        EURohsDirCompliant: Enum "COL EU RoHS Dir. Compliant";
        BarcodeSymbology: Enum "Barcode Symbology";
        TotalComments: Integer;
        CurrentComment: Integer;
        CommentTxt: Text;
        CommentDate: Date;
        CommentProdNo: Code[20];
        BarcodeString: Text;
        StdLoc: Text;
        BarCode: Text;
        ProdOrderNoLbl: Label 'Production Order No.';
        PriorityLbl: Label 'Priority:';
        ROHSLbl: Label 'ROHS';
        RouteLbl: Label 'Route:';
        OperationLbl: Label 'Operation';
        SetupTimeLbl: Label 'Setup Time';
        RouteTimeLbl: Label 'Routing Run Time';
        InitLbl: Label 'Init.';
        WarehouseLbl: Label 'Warehouse:';
        StandardWarehouseLbl: Label 'Standard warehouse location:';
        QtyLbl: Label 'Quantity:';
        PlacedOnLbl: Label 'Placed on location:';
        LimitationsLbl: Label 'Comments from productions';
        BinLbl: Label ' Bin: ';
}
