namespace Weibel.Manufacturing.ProductionBOM;

using Microsoft.Inventory.Item;
using Microsoft.Inventory.Location;
using Microsoft.Manufacturing.ProductionBOM;
using System.Utilities;
using Weibel.Inventory.BOM;

codeunit 70237 "COL Compare Mgt."
{
    Permissions = TableData "Production Matrix BOM Line" = rimd;

    var
        TempGlobalMatrixBOMLine: Record "Production Matrix BOM Line" temporary;
        GenBOMStructure: Codeunit "COL Gen. BOM Structure";


    procedure GenerateCompareLines(var sku: array[2] of Record "Stockkeeping Unit")
    var
        sku1: Record "Stockkeeping Unit";
        sku2: Record "Stockkeeping Unit";
        TempBOMStructure1: Record "COL BOM Structure" temporary;
        TempBOMStructure2: Record "COL BOM Structure" temporary;
    begin
        sku1.Get(sku[1]."Location Code", sku[1]."Item No.", sku[1]."Variant Code");
        sku2.Get(sku[2]."Location Code", sku[2]."Item No.", sku[2]."Variant Code");

        GenBOMStructure.GetBomDataForSKU(sku1, TempBOMStructure1);
        Clear(GenBOMStructure);
        GenBOMStructure.GetBomDataForSKU(sku2, TempBOMStructure2);

        if TempBOMStructure1.FindSet() then
            repeat
                AddLine(TempBOMStructure1, true);
            until TempBOMStructure1.Next() = 0;

        if TempBOMStructure2.FindSet() then
            repeat
                AddLine(TempBOMStructure2, false);
            until TempBOMStructure2.Next() = 0;
    end;

    local procedure AddLine(var TempBOMStructure: Record "COL BOM Structure" temporary; FirstSku: Boolean)
    var
        CompItem: Record Item;
    begin
        if TempBOMStructure.Indentation = 0 then
            exit;

        if TempBOMStructure.Type <> TempBOMStructure.Type::Item then
            exit;

        if not TempGlobalMatrixBOMLine.Get(TempBOMStructure."No.", TempBOMStructure."Variant Code") then begin
            TempGlobalMatrixBOMLine.Init();
            TempGlobalMatrixBOMLine."Item No." := TempBOMStructure."No.";
            TempGlobalMatrixBOMLine."Variant Code" := TempBOMStructure."Variant Code";
            TempGlobalMatrixBOMLine.Description := TempBOMStructure.Description;
            TempGlobalMatrixBOMLine.Insert();
        end;

        CompItem.Get(TempBOMStructure."No.");
        TempGlobalMatrixBOMLine."COL Unit Cost" := CompItem."Unit Cost";

        if FirstSku then begin
            TempGlobalMatrixBOMLine."COL Cost Share 1" := CompItem."Unit Cost" * TempBOMStructure."Qty. per Parent";
            TempGlobalMatrixBOMLine."COL Exploded Quantity 1" := TempBOMStructure."Qty. per Parent";
        end
        else begin
            TempGlobalMatrixBOMLine."COL Cost Share 2" := CompItem."Unit Cost" * TempBOMStructure."Qty. per Parent";
            TempGlobalMatrixBOMLine."COL Exploded Quantity 2" := TempBOMStructure."Qty. per Parent";
        end;
        TempGlobalMatrixBOMLine."COL Difference Cost" := TempGlobalMatrixBOMLine."COL Cost Share 1" - TempGlobalMatrixBOMLine."COL Cost Share 2";
        TempGlobalMatrixBOMLine.Modify();
    end;

    procedure GetData(var MatrixBOMLine: Record "Production Matrix BOM Line")
    begin
        TempGlobalMatrixBOMLine.Reset();
        if TempGlobalMatrixBOMLine.FindSet() then
            repeat
                MatrixBOMLine := TempGlobalMatrixBOMLine;
                MatrixBOMLine.Insert();
            until TempGlobalMatrixBOMLine.Next() = 0;
    end;
}
