namespace Weibel.Manufacturing.ProductionBOM;

using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Inventory.Item;

codeunit 70205 "COL Process BOM Line Import"
{
    TableNo = "COL Prod. BOM Line Buffer";

    var
        ProductionBOMHeader: Record "Production BOM Header";

    trigger OnRun()
    begin
        CreateBOMLine(Rec);
    end;

    internal procedure SetProductionBOMHeader(var NewProductionBOMHeader: Record "Production BOM Header")
    begin
        ProductionBOMHeader := NewProductionBOMHeader;
    end;

    local procedure CreateBOMLine(var TempProdBOMLineBuffer: Record "COL Prod. BOM Line Buffer" temporary)
    var
        ProductionBOMLine: Record "Production BOM Line";
        ItemVariant: Record "Item Variant";
        NewLineNo, VariantCount : Integer;
        TooManyVariantsLbl: Label 'There is more than one variant for item %1. No variant was set on the line.', Comment = '%1 = item no.';
        MissingVariantsLbl: Label 'There are no variants for item %1. No variant was set on the line.', Comment = '%1 = item no.';
    begin
        ProductionBOMLine.SetRange("Production BOM No.", ProductionBOMHeader."No.");
        ProductionBOMLine.SetRange("Version Code", '');
        if ProductionBOMLine.FindLast() then
            NewLineNo := ProductionBOMLine."Line No.";

        NewLineNo += 10000;
        Clear(ProductionBOMLine);

        ProductionBOMLine.Init();
        ProductionBOMLine."Production BOM No." := ProductionBOMHeader."No.";
        ProductionBOMLine."Line No." := NewLineNo;
        ProductionBOMLine."Version Code" := '';
        ProductionBOMLine.Validate(Type, Enum::"Production BOM Line Type"::Item);
        ProductionBOMLine.Validate("No.", TempProdBOMLineBuffer."Item No.");
        ProductionBOMLine.Validate("Quantity per", TempProdBOMLineBuffer.Quantity);
        ProductionBOMLine.Validate("COL Position", CopyStr(TempProdBOMLineBuffer.Position, 1, MaxStrLen(ProductionBOMLine."COL Position")));
        ProductionBOMLine.Insert(true);

        ItemVariant.SetLoadFields(Code);
        ItemVariant.SetRange("Item No.", ProductionBOMLine."No.");
        ItemVariant.SetRange(Blocked, false);
        VariantCount := ItemVariant.Count();
        case true of
            VariantCount = 1:
                begin
                    ProductionBOMLine.Validate("Variant Code", ItemVariant.Code);
                    ProductionBOMLine.Modify(true);
                end;
            VariantCount > 1:
                Error(ErrorInfo.Create(StrSubstNo(TooManyVariantsLbl, ProductionBOMLine."No."), true));
            VariantCount = 0:
                Error(ErrorInfo.Create(StrSubstNo(MissingVariantsLbl, ProductionBOMLine."No."), true));
        end;
    end;
}