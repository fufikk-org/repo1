namespace Weibel.Manufacturing.Reports;

using Microsoft.Inventory.Item;
using Microsoft.Inventory.Location;
using Microsoft.Manufacturing.ProductionBOM;
using System.Utilities;
using Weibel.Manufacturing.ProductionBOM;

report 70116 "COL SKU Compare List"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Manufacturing\Report\SKUCompareList.rdl';
    ApplicationArea = Manufacturing;
    Caption = 'SKU BOM Compare List';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(ItemLoop; "Integer")
        {
            DataItemTableView = sorting(Number);
            MaxIteration = 1;

            trigger OnPreDataItem()
            begin
                TestBOMs();
                CheckSku(1);
                CheckSku(2);

                CompareMgt.GenerateCompareLines(sku);
                CompareMgt.GetData(BOMLoop);

            end;
        }
        dataitem(BOMLoop; "Production Matrix BOM Line")
        {
            UseTemporary = true;
            column(CompanyName; COMPANYPROPERTY.DisplayName())
            {
            }
            column(AsOfCalcDate; AsOfLbl + Format(CalculateDate))
            {
            }
            column(TodayFormatted; Format(Today, 0, 4))
            {
            }
            column(Item1No; sku[1]."Item No.")
            {
            }
            column(Item2No; sku[2]."Item No.")
            {
            }
            column(ItemVar1No; sku[1]."Variant Code")
            {
            }
            column(ItemVar2No; sku[2]."Variant Code")
            {
            }
            column(BOMMatrixListItemNo; BOMLoop."Item No.")
            {
            }
            column(BOMMatrixListDesc; BOMLoop.Description)
            {
            }
            column(CompItemUnitCost; BOMLoop."COL Unit Cost")
            {
                AutoFormatType = 2;
            }
            column(Qty1; BOMLoop."COL Exploded Quantity 1")
            {
                DecimalPlaces = 0 : 5;
            }
            column(Cost1; BOMLoop."COL Cost Share 1")
            {
                AutoFormatType = 1;
            }
            column(Qty2; BOMLoop."COL Exploded Quantity 2")
            {
                DecimalPlaces = 0 : 5;
            }
            column(Cost2; BOMLoop."COL Cost Share 2")
            {
                AutoFormatType = 1;
            }
            column(CostDiff; BOMLoop."COL Difference Cost")
            {
                AutoFormatType = 1;
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(CompareListCaption; CompareListCaptionLbl)
            {
            }
            column(BOMMatrixListItemNoCapt; BOMMatrixListItemNoCaptLbl)
            {
            }
            column(BOMMatrixListDescCapt; BOMMatrixListDescCaptLbl)
            {
            }
            column(CompItemUnitCostCapt; CompItemUnitCostCaptLbl)
            {
            }
            column(CostDiffCaption; CostDiffCaptionLbl)
            {
            }
            column(Item1NoCaption; Item1NoCaptionLbl)
            {
            }
            column(Item1VariantCaption; Item1VariantCaptionLbl)
            {
            }
            column(Item2NoCaption; Item2NoCaptionLbl)
            {
            }
            column(Item2VariantCaption; Item2VariantCaptionLbl)
            {
            }
            column(TotalCostDifferenceCapt; TotalCostDifferenceCaptLbl)
            {
            }
            column(VariantCaption; VariantLbl)
            {
            }
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
                    field(ItemNo1; sku[1]."Item No.")
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Item No. 1';
                        NotBlank = true;
                        ToolTip = 'Specifies the number of the first item you want to compare, when comparing components for two items.';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            sku[1].SetCurrentKey("Production BOM No.");
                            sku[1].SetFilter("Production BOM No.", '<>%1', '');
                            sku[1].SetFilter("Variant Code", '<>%1', '');
                            if Page.RunModal(Page::"Stockkeeping Unit List", sku[1]) = Action::LookupOK then begin
                                Text := sku[1]."Item No.";
                                exit(true);
                            end;
                            exit(false);
                        end;

                        trigger OnValidate()
                        var
                            iv: Record "Stockkeeping Unit";
                        begin
                            iv.SetRange("Item No.", sku[1]."Item No.");
                            iv.SetRange("Variant Code", sku[1]."Variant Code");
                            if iv.IsEmpty() then
                                Error(skuNotExistErr, sku[1]."Item No.", sku[1]."Variant Code");

                            if (sku[1]."Item No." = sku[2]."Item No.") and (sku[1]."Variant Code" = sku[2]."Variant Code") then
                                sku[1].FieldError("Item No.");
                        end;
                    }
                    field(ItemNoVar1; sku[1]."Variant Code")
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Item Variant 1';
                        Editable = false;
                        ToolTip = 'Specifies the variant of the first item you want to compare, when comparing components for two items.';
                    }
                    field(locationCode1; sku[1]."Location Code")
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Location Code 1';
                        Editable = false;
                        Visible = false;
                        ToolTip = 'Specifies the location of the first item you want to compare.';
                    }
                    field(ItemNo2; sku[2]."Item No.")
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Item No. 2';
                        NotBlank = true;
                        ToolTip = 'Specifies the number of the second item you want to compare, when comparing components for two items.';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            sku[2].SetCurrentKey("Production BOM No.");
                            sku[2].SetFilter("Production BOM No.", '<>%1', '');
                            sku[2].SetFilter("Variant Code", '<>%1', '');
                            if Page.RunModal(Page::"Stockkeeping Unit List", sku[2]) = Action::LookupOK then begin
                                Text := sku[2]."Item No.";
                                exit(true);
                            end;
                            exit(false);
                        end;

                        trigger OnValidate()
                        var
                            iv: Record "Stockkeeping Unit";
                        begin
                            iv.SetRange("Item No.", sku[2]."Item No.");
                            iv.SetRange("Variant Code", sku[2]."Variant Code");
                            if iv.IsEmpty() then
                                Error(skuNotExistErr, sku[2]."Item No.", sku[2]."Variant Code");

                            if (sku[1]."Item No." = sku[2]."Item No.") and (sku[1]."Variant Code" = sku[2]."Variant Code") then
                                sku[1].FieldError("Item No.");
                        end;
                    }
                    field(ItemNoVar2; sku[2]."Variant Code")
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Item Variant 2';
                        NotBlank = true;
                        Editable = false;
                        ToolTip = 'Specifies the variant of the second item you want to compare, when comparing components for two items.';
                    }
                    field(locationCode2; sku[2]."Location Code")
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Location Code 2';
                        Editable = false;
                        Visible = false;
                        ToolTip = 'Specifies the location of the first item you want to compare.';
                    }
                    field(CalculationDt; CalculateDate)
                    {
                        ApplicationArea = Manufacturing;
                        Caption = 'Calculation Date';
                        ToolTip = 'Specifies the date for which you want to make the comparison. The program automatically enters the working date.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            CalculateDate := WorkDate();
        end;
    }

    labels
    {
        Qty1Caption = 'Exploded Quantity';
        Cost1Caption = 'Cost Share';
    }

    var
        CompareMgt: CodeUnit "COL Compare Mgt.";
        CalculateDate: Date;
        i: Integer;
        AsOfLbl: Label 'As of ';
        CurrReportPageNoCaptionLbl: Label 'Page';
        CompareListCaptionLbl: Label 'SKU Compare List';
        BOMMatrixListItemNoCaptLbl: Label 'No.';
        BOMMatrixListDescCaptLbl: Label 'Description';
        CompItemUnitCostCaptLbl: Label 'Unit Cost';
        CostDiffCaptionLbl: Label 'Difference Cost';
        Item1NoCaptionLbl: Label 'Item No. 1';
        Item1VariantCaptionLbl: Label 'Variant No. 1';
        Item2NoCaptionLbl: Label 'Item No. 2';
        Item2VariantCaptionLbl: Label 'Variant No. 2';
        TotalCostDifferenceCaptLbl: Label 'Total Cost Difference';
        VariantLbl: Label 'Variant';
        skuNotExistErr: Label 'The SKU with Item No. %1 and Variant Code %2 does not exist.', Comment = '%1=Item No., %2=Variant Code';

    protected var
        sku: array[2] of Record "Stockkeeping Unit";

    procedure InitializeRequest(var StockkeepingUnit: Record "Stockkeeping Unit"; NewCalculateDate: Date)
    begin
        if StockkeepingUnit.FindFirst() then begin
            sku[1]."Item No." := StockkeepingUnit."Item No.";
            sku[1]."Variant Code" := StockkeepingUnit."Variant Code";
            sku[1]."Location Code" := StockkeepingUnit."Location Code";
        end;
        CalculateDate := NewCalculateDate;
    end;

    local procedure CheckSku(pos: Integer)
    var
        StockkeepingUnit: Record "Stockkeeping Unit";
        StockkeepingUnitErr: Label 'The SKU with Item No. %1 and Variant Code %2 does not exist.', Comment = '%1=Item No., %2=Variant Code';
    begin
        StockkeepingUnit.SetRange("Item No.", sku[pos]."Item No.");
        StockkeepingUnit.SetRange("Variant Code", sku[pos]."Variant Code");
        if StockkeepingUnit.IsEmpty() then
            Error(StockkeepingUnitErr, sku[pos]."Item No.", sku[pos]."Variant Code");
    end;

    local procedure TestBOMs()
    var
        StockkeepingUnit: Record "Stockkeeping Unit";
    begin
        for i := 1 to 2 do begin
            StockkeepingUnit.SetRange("Item No.", sku[i]."Item No.");
            StockkeepingUnit.SetRange("Variant Code", sku[i]."Variant Code");
            StockkeepingUnit.SetRange("Location Code", sku[i]."Location Code");
            StockkeepingUnit.FindFirst();
            StockkeepingUnit.TestField("Production BOM No.");
        end;
    end;
}
