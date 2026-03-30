namespace Weibel.Warehouse.Document;

using Microsoft.Warehouse.Document;
using Weibel.Inventory.Item;
using Microsoft.Inventory.Item;

pageextension 70108 "COL Warehouse Receipt" extends "Warehouse Receipt"
{
    actions
    {
        addlast("F&unctions")
        {
            action("COL PrintODCLabels")
            {
                Caption = 'Print Weibel Item Label';
                ToolTip = 'Print weibel item label for the selected items';
                Image = PrintCover;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    PrintWeibelItemLabel();
                end;
            }
        }

        addlast(Category_Process)
        {
            actionref(COLPrintODCLabels_Promoted; "COL PrintODCLabels")
            {
            }
        }
    }

    local procedure PrintWeibelItemLabel()
    var
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        WeibelItemODCLabel: Report "COL Weibel Item ODC Label";
        NoLinesFoundToPrintErr: Label 'No lines found to print GTIN labels for';
    begin
        WarehouseReceiptLine.SetLoadFields("No.", "Item No.", "COL Print GTIN Label");
        WarehouseReceiptLine.SetRange("No.", Rec."No.");
        WarehouseReceiptLine.SetRange("COL Print GTIN Label", true);
        if WarehouseReceiptLine.IsEmpty() then
            Error(NoLinesFoundToPrintErr);

        WeibelItemODCLabel.InitFrom(Rec);
        WeibelItemODCLabel.RunModal();
    end;

#pragma warning disable AA0228
    local procedure PrintGTINLabels()
    var
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        Item: Record Item;
        WeibelItemGTINLabel: Report "COL Weibel Item GTIN Label";
        ItemFilterTxt: Text;
        NoLinesFoundToPrintErr: Label 'No lines found to print GTIN labels for';
    begin
        WarehouseReceiptLine.SetLoadFields("No.", "Item No.", "COL Print GTIN Label");
        WarehouseReceiptLine.SetRange("No.", Rec."No.");
        WarehouseReceiptLine.SetRange("COL Print GTIN Label", true);
        if not WarehouseReceiptLine.FindSet() then
            Error(NoLinesFoundToPrintErr);

        repeat
            ItemFilterTxt += WarehouseReceiptLine."Item No." + '|';
        until WarehouseReceiptLine.Next() = 0;

        ItemFilterTxt := DelChr(ItemFilterTxt, '>', '|');
        Item.SetFilter("No.", ItemFilterTxt);

        //WeibelItemGTINLabel.InitializeReport(ItemFilterTxt);
        WeibelItemGTINLabel.SetTableView(Item);
        WeibelItemGTINLabel.RunModal();
    end;
#pragma warning restore AA0228
}