namespace Weibel.Manufacturing.ProductionBOM;

using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Inventory.Item;

codeunit 70212 "COL Production BOM Unit Price"
{
    trigger OnRun()
    begin
        UpdateProdBOMLineUnitPrice();
    end;

    internal procedure UpdateProdBOMLineUnitPrice()
    var
        ProductionBOMLine: Record "Production BOM Line";
        Item: Record Item;
        Window: Dialog;
        ProgressLbl: Label 'Updating unit prices & costs\Item No.: #1#', Comment = '#1 = item no.';
    begin
        ProductionBOMLine.SetCurrentKey(Type, "No.");
        ProductionBOMLine.SetRange(Type, Enum::"Production BOM Line Type"::Item);

        Item.SetLoadFields("Unit Price", "Unit Cost");

        if ProductionBOMLine.IsEmpty() then
            exit;

        Window.Open(ProgressLbl);

        ProductionBOMLine.FindFirst();
        repeat
            Window.Update(1, ProductionBOMLine."No.");
            ProductionBOMLine.SetRange("No.", ProductionBOMLine."No.");
            if (ProductionBOMLine."No." <> '') and Item.Get(ProductionBOMLine."No.") then begin
                if Item."Unit Price" <> 0 then
                    ProductionBOMLine.ModifyAll("COL Unit Price", Item."Unit Price");

                if Item."Unit Cost" <> 0 then
                    ProductionBOMLine.ModifyAll("COL Unit Cost", Item."Unit Cost");
            end;

            ProductionBOMLine.FindLast();
            ProductionBOMLine.SetRange("No.");

        until ProductionBOMLine.Next() = 0;

        Window.Close();
    end;
}