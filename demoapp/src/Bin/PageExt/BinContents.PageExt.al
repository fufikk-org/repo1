namespace Weibel.Warehouse.Structure;

using Microsoft.Warehouse.Structure;
using Weibel.Inventory.Item;
using Microsoft.Warehouse.Ledger;
using Microsoft.Inventory.Tracking;

pageextension 70231 "COL Bin Contents" extends "Bin Contents"
{
    actions
    {
        addlast(navigation)
        {
            action("COL PLC Change Log")
            {
                Caption = 'Print  Weibel Item Label';
                ToolTip = 'Print weibel item label for the selected items';
                Image = PrintCover;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    PrintWeibelItemLabel();
                end;
            }
        }
    }

    local procedure PrintWeibelItemLabel()
    var
        WarehouseEntry: Record "Warehouse Entry";
        BinContent: Record "Bin Content";
        TempTrackingSpecification: Record "Tracking Specification" temporary;
        WeibelItemODCLabel: Report "COL Weibel Item ODC Label";
        EntryNo: Integer;
        CurrLine: Integer;
        i: Integer;
        ReqLines: Integer;
    begin
        BinContent.CopyFilters(Rec);
        Rec.FilterGroup(2);
        Rec.CopyFilter("Location Code", BinContent."Location Code");
        Rec.CopyFilter("Zone Code", BinContent."Zone Code");
        Rec.FilterGroup(0);
        EntryNo := 1;


        BinContent.SetAutoCalcFields("Quantity (Base)");
        if BinContent.FindSet() then
            repeat
                WarehouseEntry.Reset();
                WarehouseEntry.SetRange("Location Code", BinContent."Location Code");
                WarehouseEntry.SetRange("Bin Code", BinContent."Bin Code");
                WarehouseEntry.SetRange("Item No.", BinContent."Item No.");
                WarehouseEntry.SetRange("Variant Code", BinContent."Variant Code");
                WarehouseEntry.SetRange("Unit of Measure Code", BinContent."Unit of Measure Code");
                WarehouseEntry.SetFilter(Quantity, '>%1', 0);

                CurrLine := 0;
                if BinContent."Quantity (Base)" > 0 then
                    if WarehouseEntry.FindSet() then
                        repeat

                            TempTrackingSpecification.Reset();
                            TempTrackingSpecification."Entry No." := EntryNo;
                            TempTrackingSpecification."Item No." := WarehouseEntry."Item No.";
                            TempTrackingSpecification.Description := WarehouseEntry.Description;
                            TempTrackingSpecification."Source ID" := WarehouseEntry."Whse. Document No.";
                            TempTrackingSpecification."Source Subtype" := TempTrackingSpecification."Source Subtype"::"0";
                            TempTrackingSpecification."Serial No." := WarehouseEntry."Serial No.";
                            TempTrackingSpecification."Expiration Date" := WarehouseEntry."Expiration Date";
                            TempTrackingSpecification."Variant Code" := WarehouseEntry."Variant Code";
                            TempTrackingSpecification.Insert();
                            EntryNo += 1;
                            CurrLine += 1;

                        until (WarehouseEntry.Next() = 0) or (CurrLine = 10) or (CurrLine >= BinContent."Quantity (Base)");


                ReqLines := BinContent."Quantity (Base)" - CurrLine;
                if ReqLines > 10 then
                    ReqLines := 10; // Limit to 10 label

                if CurrLine < BinContent."Quantity (Base)" then
                    for i := 0 to ReqLines do
                        if CurrLine < 10 then begin

                            TempTrackingSpecification.Reset();
                            TempTrackingSpecification."Entry No." := EntryNo;
                            TempTrackingSpecification."Item No." := BinContent."Item No.";
                            TempTrackingSpecification.Description := WarehouseEntry.Description;
                            TempTrackingSpecification."Source ID" := WarehouseEntry."Whse. Document No."; // from last entry found 
                            TempTrackingSpecification."Source Subtype" := TempTrackingSpecification."Source Subtype"::"0";
                            TempTrackingSpecification."Serial No." := '';
                            TempTrackingSpecification."Expiration Date" := 0D;
                            TempTrackingSpecification."Variant Code" := BinContent."Variant Code";
                            TempTrackingSpecification.Insert();
                            EntryNo += 1;
                            CurrLine += 1;
                        end;

            until BinContent.Next() = 0;

        WeibelItemODCLabel.InitFrom(TempTrackingSpecification, true);
        WeibelItemODCLabel.RunModal();
    end;
}
