namespace Weibel.Manufacturing.Reports;

using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Warehouse.Structure;
using Microsoft.Inventory.Location;
using Microsoft.Foundation.Company;
using Microsoft.Inventory.Item;

report 70110 "COL Production BOM"
{
    Caption = 'Production BOM';
    AdditionalSearchTerms = 'BOM';
    PreviewMode = Normal;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DataAccessIntent = ReadOnly;
    DefaultLayout = RDLC;
    RDLCLayout = '.\src\Manufacturing\Report\ProductionBOM.Layout.rdl';

    dataset
    {
        dataitem("Production BOM Header"; "Production BOM Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";

            column(No_ProductionBOMHeader; "Production BOM Header"."No.")
            {
            }
            column(ItemGenProdPostGroup; HeaderItemInfo2)
            {
            }
            column(HeaderItemInfo; HeaderItemInfo)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(ItemNoCaption; ItemNoLbl)
            {
            }
            column(ItemGroupCaption; ItemGroupLbl)
            {
            }
            column(BOMCaption; BOMLbl)
            {
            }
            column(PageCaption; PageCaptionCapLbl)
            {
            }
            dataitem("Production BOM Line"; "Production BOM Line")
            {
                DataItemLink = "Production BOM No." = field("No.");
                DataItemTableView = sorting("Production BOM No.", "Version Code", "Line No.") where("Version Code" = filter(''), "No." = filter(<> ''));

                dataitem("Production BOM Comment Line"; "Production BOM Comment Line")
                {
                    DataItemLink = "Production BOM No." = field("Production BOM No."), "BOM Line No." = field("Line No.");
                    DataItemTableView = sorting("Production BOM No.", "BOM Line No.", "Version Code", "Line No.") where("Version Code" = filter(''));

                    trigger OnAfterGetRecord();
                    begin
                        TempProdBOMLine.Init();
                        TempProdBOMLine."Production BOM No." := "Production BOM Line"."Production BOM No.";
                        TempProdBOMLine."Version Code" := "Production BOM Line"."Version Code";
                        NewTempBOMLineNo += 10000;
                        TempProdBOMLine."Line No." := NewTempBOMLineNo;
                        TempProdBOMLine."Variant Code" := 'COMMENT'; // this value is used in report layout to determine line visibility
                        TempProdBOMLine.Description := "Production BOM Comment Line".Comment;
                        TempProdBOMLine.Insert();
                    end;
                }

                trigger OnAfterGetRecord();
                var
                    ListOfLines: List of [Text];
                    i: Integer;
                begin

                    ListOfLines := SplitPositionTextIntoLines("Production BOM Line"."COL Position");

                    // first temp BOM line contains info from the actual bom line, but with first element from "Position" and additionally info about the bin
                    TempProdBOMLine := "Production BOM Line";
                    TempProdBOMLine."COL Position" := CopyStr(ListOfLines.Get(1), 1, MaxStrLen(TempProdBOMLine."COL Position"));
                    TempProdBOMLine."COL Position 3" := GetDefaultBinCode("Production BOM Line");
                    NewTempBOMLineNo += 10000;
                    TempProdBOMLine."Line No." := NewTempBOMLineNo;
                    TempProdBOMLine.Insert();

                    // if there are more lines from "Position" create additional dummy lines that just contain the text
                    for i := 2 to ListOfLines.Count() do begin
                        TempProdBOMLine.Init();
                        TempProdBOMLine."Production BOM No." := "Production BOM Line"."Production BOM No.";
                        TempProdBOMLine."Version Code" := "Production BOM Line"."Version Code";
                        NewTempBOMLineNo += 10000;
                        TempProdBOMLine."Line No." := NewTempBOMLineNo;
                        TempProdBOMLine."Variant Code" := 'POS';
                        TempProdBOMLine."COL Position" := CopyStr(ListOfLines.Get(i), 1, MaxStrLen(TempProdBOMLine."COL Position"));
                        TempProdBOMLine.Insert();
                    end;
                end;
            }
            dataitem(TempProdBOMLine; "Production BOM Line")
            {
                UseTemporary = true;
                column(LineNumber; TempProdBOMLine."Line No.")
                {
                }
                column(BomLineQty; TempProdBOMLine.Quantity)
                {
                }
                column(BomLineUOM; TempProdBOMLine."Unit of Measure Code")
                {
                }
                column(BomLineNo; TempProdBOMLine."No.")
                {
                }
                column(BomLineDescription; TempProdBOMLine.Description)
                {
                }
                column(BomLinePosition; TempProdBOMLine."COL Position")
                {
                }
                column(BomLineShelf; TempProdBOMLine."COL Position 3")
                {
                }
                column(BomLineVariant; TempProdBOMLine."Variant Code")
                {
                }
                column(InternComment; TempProdBOMLine.Description)
                {
                }
                column(BomLineQtyCaption; TempProdBOMLine.FieldCaption(Quantity))
                {
                }
                column(BomLineUOMCaption; UOMLbl)
                {
                }
                column(BomLineNoCaption; TempProdBOMLine.FieldCaption("No."))
                {
                }
                column(BomLineDescriptionCaption; TempProdBOMLine.FieldCaption(Description))
                {
                }
                column(BomLinePositionCaption; TempProdBOMLine.FieldCaption(Position))
                {
                }
                column(BomLineShelfCaption; PlacementLbl)
                {
                }
            }

            trigger OnAfterGetRecord();
            var
                Item: Record Item;
            begin
                Item.SetLoadFields(Description, "Description 2", "Gen. Prod. Posting Group");
                Item.ReadIsolation := IsolationLevel::ReadUncommitted;
                if not Item.Get("Production BOM Header"."No.") then
                    Clear(Item);

                HeaderItemInfo := "Production BOM Header"."No." + '  ' + Item.Description + ' ' + Item."Description 2";
                HeaderItemInfo2 := Item."Gen. Prod. Posting Group";

                TempProdBOMLine.Reset();
                TempProdBOMLine.DeleteAll();
                NewTempBOMLineNo := 0;
            end;
        }
    }

    requestpage
    {

        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(LocationCodeCtrl; LocationCode)
                    {
                        Caption = 'Location Code';
                        ToolTip = 'Specify location to search for default bin.';
                        TableRelation = Location;
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
    end;

    /// <summary>
    /// Split the position string into elements separated by comma.
    /// Then join it back into lines with max 32 characters
    /// and also trim white characters and remove commas from the end of lines.
    /// If the line does not have commas, just use it as is
    /// </summary>
    local procedure SplitPositionTextIntoLines(PositionText: Text): List of [Text]
    var
        PositionElement: Text;
        PositionElements, ListOfLines : List of [Text];
        LineBuilder: TextBuilder;
    begin
        Clear(ListOfLines);
        if PositionText <> '' then begin
            PositionElements := PositionText.Trim().Split(',');
            foreach PositionElement in PositionElements do
                if LineBuilder.Length() + StrLen(PositionElement) + 1 < 32 then
                    LineBuilder.Append(PositionElement + ',')
                else begin
                    if LineBuilder.Length() > 0 then
                        ListOfLines.Add(LineBuilder.ToText().TrimEnd(','));
                    Clear(LineBuilder);
                    LineBuilder.Append(PositionElement + ',');
                end;
            if LineBuilder.Length() > 0 then
                ListOfLines.Add(LineBuilder.ToText().TrimEnd(','));
        end else
            ListOfLines.Add('');
        exit(ListOfLines);
    end;

    local procedure GetDefaultBinCode(var ProductionBOMLine: Record "Production BOM Line"): Code[20]
    var
        BinContent: Record "Bin Content";
    begin
        if ProductionBOMLine.Type = ProductionBOMLine.Type::Item then begin
            BinContent.SetLoadFields("Bin Code");
            BinContent.ReadIsolation := IsolationLevel::ReadUncommitted;
            BinContent.SetRange("Location Code", LocationCode);
            BinContent.SetRange("Item No.", ProductionBOMLine."No.");
            BinContent.SetRange(Default, true);
            if BinContent.FindFirst() then
                exit(BinContent."Bin Code");
        end;
    end;

    var
        CompanyInfo: Record "Company Information";
        LocationCode: Code[10];
        HeaderItemInfo, HeaderItemInfo2 : Text;
        NewTempBOMLineNo: Integer;
        PlacementLbl: Label 'Placement';
        UOMLbl: Label 'UOM';
        ItemNoLbl: Label 'Item No.:';
        ItemGroupLbl: Label 'Item Group:';
        BOMLbl: Label 'BOM';
        PageCaptionCapLbl: Label 'Page %1 of %2', Comment = '%1 = page no.; %2 = total pages';
}

