namespace Weibel.Manufacturing.ProductionBOM;

using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Inventory.Item.Catalog;
using Weibel.Inventory.Item;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Location;

pageextension 70162 "COL Production BOM" extends "Production BOM"
{
    layout
    {
        addlast(General)
        {
            field("COL Peak Pack. Body Temp."; GetPeakPackBodyTemp(Rec."No."))
            {
                ApplicationArea = All;
                Caption = 'Peak Pack. Body Temp.';
                ToolTip = 'Peak Pack. Body Temp.';
                Editable = false;
                Importance = Additional;
                DecimalPlaces = 0 : 5;
                BlankZero = true;
                Visible = false;
            }

            field("COL EU RoHS Dir. Compliant"; GetEURoHSCompliant(Rec."No."))
            {
                ApplicationArea = All;
                Caption = 'EU RoHS Dir. Compliant';
                ToolTip = 'EU RoHS Dir. Compliant';
                Editable = false;
                Importance = Additional;
                Visible = false;
            }
        }
        addlast(factboxes)
        {
            part("COL Production BOM FactBox"; "COL Prod. BOM Line FactBox")
            {
                ApplicationArea = All;
                Provider = ProdBOMLine;
                SubPageLink = "Production BOM No." = field("Production BOM No."), "Version Code" = field("Version Code"), "Line No." = field("Line No.");
            }
        }
    }

    actions
    {
        addlast(Reporting)
        {
            action("COL Print BOM")
            {
                ApplicationArea = All;
                Caption = 'Print BOM';
                ToolTip = 'Print information about Production BOM.';
                Image = Report;

                trigger OnAction()
                begin
                    Rec.COLPrintBOM();
                end;

            }
            action("COL Import Production BOM")
            {
                ApplicationArea = All;
                Caption = 'Import Production BOM';
                ToolTip = 'Import Production BOM lines from a text file.';
                Image = Import;

                trigger OnAction()
                var
                    ImportProductionBOM: Codeunit "COL Import Prod. BOM Lines";
                begin
                    ImportProductionBOM.ImportProdBOMLines(Rec);
                    CurrPage.Update(true);
                end;
            }
        }
        addlast(Category_Process)
        {
            actionref("COL Print BOM_Promoted"; "COL Print BOM") { }
        }
    }

    local procedure GetPeakPackBodyTemp(ProductionBomHeaderNo: Code[20]): Decimal
    var
        Item: Record "Item";
        ItemReference: Record "Item Reference";
    begin
        if ProductionBomHeaderNo = '' then
            exit(0);

        Item.ReadIsolation := IsolationLevel::ReadUncommitted;
        ItemReference.ReadIsolation := IsolationLevel::ReadUncommitted;

        Item.SetLoadFields("No.");
        Item.SetRange("Production BOM No.", ProductionBomHeaderNo);
        if Item.FindFirst() then begin
            ItemReference.SetLoadFields("COL Peak Pack. Body Temp.");
            ItemReference.SetRange("Item No.", Item."No.");
            if ItemReference.FindFirst() then
                exit(ItemReference."COL Peak Pack. Body Temp.");
        end;
    end;

    local procedure GetEURoHSCompliant(ProductionBomHeaderNo: Code[20]): Enum "COL EU RoHS Dir. Compliant"
    var
        Item: Record "Item";
        StockKeepingUnit: Record "Stockkeeping Unit";
    begin
        if ProductionBomHeaderNo = '' then
            exit(Enum::"COL EU RoHS Dir. Compliant"::" ");

        StockKeepingUnit.ReadIsolation(IsolationLevel::ReadUncommitted);
        StockKeepingUnit.SetLoadFields("Production BOM No.", "Variant Code", "COL EU RoHS Dir. Compliant");
        StockKeepingUnit.SetAutoCalcFields("COL EU RoHS Dir. Compliant", "COL V.EU RoHS Dir. Compliant");
        StockKeepingUnit.SetRange("Production BOM No.", ProductionBomHeaderNo);
        if StockKeepingUnit.FindFirst() then
            if StockKeepingUnit."Variant Code" <> '' then
                exit(StockKeepingUnit."COL V.EU RoHS Dir. Compliant")
            else
                exit(StockKeepingUnit."COL EU RoHS Dir. Compliant");

        Item.ReadIsolation := IsolationLevel::ReadUncommitted;

        Item.SetLoadFields("COL EU RoHS Dir. Compliant");
        Item.SetRange("Production BOM No.", ProductionBomHeaderNo);
        if Item.FindFirst() then
            exit(Item."COL EU RoHS Dir. Compliant");
    end;
}
