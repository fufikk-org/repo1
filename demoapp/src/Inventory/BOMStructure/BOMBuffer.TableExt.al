namespace Weibel.Inventory.BOM;

using Microsoft.Inventory.BOM;
using Weibel.Inventory.Item;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Inventory.Costing;
using Microsoft.Foundation.UOM;
using Microsoft.Projects.Resources.Resource;
using Microsoft.Inventory.Planning;

tableextension 70151 "COL BOM Buffer" extends "BOM Buffer"
{
    fields
    {
        field(70100; "COL Product Life Cycle"; Enum "COL Product Life Cycle")
        {
            Caption = 'Product Life Cycle';
            ToolTip = 'Specifies product life cycle.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70101; "COL EU RoHS Dir. Compliant"; Enum "COL EU RoHS Dir. Compliant")
        {
            Caption = 'EU RoHS Directive Compliant';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the value of the EU RoHS Directive Compliant field.';
        }
        field(70102; "COL EU REACH Reg. Compliant"; Enum "COL EU REACH Reg. Compliant")
        {
            Caption = 'EU REACH Regulation Compliant';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the value of the EU REACH Regulation Compliant field.';
        }
        field(70103; "COL EU RoHS Status"; Text[20])
        {
            Caption = 'EU RoHS Status';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the value of the EU RoHS Status field.';
        }
    }

    procedure COLTransferFromSKU(var EntryNo: Integer; SKU: Record "Stockkeeping Unit"; DemandDate: Date)
    begin
        Init();
        EntryNo += 1;
        "Entry No." := EntryNo;
        Type := Type::Item;

        COLInitFromSKU(SKU);

        "Qty. per Parent" := 1;
        "Qty. per Top Item" := 1;
        "Needed by Date" := DemandDate;
        Indentation := 0;

        COLOnTransferFromSKUCopyFields(Rec, SKU);
        Insert(true);
    end;

    procedure COLInitFromSKU(SKU: Record "Stockkeeping Unit")
    var
        Item: Record Item;
        VersionMgt: Codeunit VersionManagement;
        ProductionBOMCheck: Codeunit "Production BOM-Check";
        VersionCode: Code[20];
    begin
        Item.Get(SKU."Item No.");
        Type := Type::Item;
        "No." := SKU."Item No.";
        Description := Item.Description;
        "Unit of Measure Code" := Item."Base Unit of Measure";
        "Variant Code" := SKU."Variant Code";

        "Production BOM No." := SKU."Production BOM No.";
        "Routing No." := SKU."Routing No.";
        "Replenishment System" := SKU."Replenishment System";
        if "Replenishment System" = "Replenishment System"::"Prod. Order" then begin
            VersionCode := VersionMgt.GetBOMVersion("Production BOM No.", WorkDate(), true);
            "BOM Unit of Measure Code" := VersionMgt.GetBOMUnitOfMeasure("Production BOM No.", VersionCode);
            ProductionBOMCheck.CheckBOM("Production BOM No.", VersionCode);
        end;

        "Lot Size" := SKU."Lot Size";
        "Scrap %" := SKU."Scrap %";
        "Indirect Cost %" := Item."Indirect Cost %";
        "Overhead Rate" := Item."Overhead Rate";
        "Low-Level Code" := Item."Low-Level Code";
        "Rounding Precision" := Item."Rounding Precision";
        "Lead Time Calculation" := SKU."Lead Time Calculation";
        "Safety Lead Time" := SKU."Safety Lead Time";
        "Inventoriable" := Item.IsInventoriableType();

        "Location Code" := SKU."Location Code";

        SetRange("Location Code");
        SetRange("Variant Code");

        COLOnAfterInitFromItem(Rec, Item, SKU);
    end;

    procedure COLTransferFromProdCompSKU(var EntryNo: Integer; ProdBOMLine: Record "Production BOM Line"; NewIndentation: Integer; ParentQtyPer: Decimal; ParentScrapQtyPer: Decimal; ParentScrapPct: Decimal; NeedByDate: Date; ParentLocationCode: Code[10]; ParentSKU: Record "Stockkeeping Unit"; BOMQtyPerUOM: Decimal)
    var
        BOMItemSKU: Record "Stockkeeping Unit";
        BOMItem: Record Item;
        MfgCostCalcMgt: Codeunit "Mfg. Cost Calculation Mgt.";
        UOMMgt: Codeunit "Unit of Measure Management";
        GetPlanningParameters: Codeunit "Planning-Get Parameters";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        // OnBeforeTransferFromProdComp(EntryNo, ProdBOMLine, NewIndentation, ParentQtyPer, ParentScrapQtyPer, ParentScrapPct, NeedByDate, ParentLocationCode, ParentSKU, BOMQtyPerUOM, IsHandled);
        if not IsHandled then begin
            Init();
            EntryNo += 1;
            "Entry No." := EntryNo;
            Type := Type::Item;

            if not BOMItemSKU.Get(ParentSKU."Location Code", ProdBOMLine."No.", ProdBOMLine."Variant Code") then
                GetPlanningParameters.AtSKU(
                    BOMItemSKU, ProdBOMLine."No.", ProdBOMLine."Variant Code", ParentSKU."Location Code");

            BOMItem.Get(ProdBOMLine."No.");
            // InitFromItem(BOMItemSKU);
            COLInitFromSKU(BOMItemSKU);

            if ParentSKU."Lot Size" = 0 then
                ParentSKU."Lot Size" := 1;

            Description := ProdBOMLine.Description;
            "Qty. per Parent" :=
              MfgCostCalcMgt.CalcCompItemQtyBase(
                ProdBOMLine, WorkDate(),
                MfgCostCalcMgt.CalcQtyAdjdForBOMScrap(ParentSKU."Lot Size", ParentScrapPct), ParentSKU."Routing No.", true) /
              UOMMgt.GetQtyPerUnitOfMeasure(BOMItem, ProdBOMLine."Unit of Measure Code") /
              BOMQtyPerUOM / ParentSKU."Lot Size";
            "Qty. per Top Item" := Round(ParentQtyPer * "Qty. per Parent", UOMMgt.QtyRndPrecision());
            "Qty. per Parent" := Round("Qty. per Parent", UOMMgt.QtyRndPrecision());

            "Scrap Qty. per Parent" := "Qty. per Parent" - (ProdBOMLine.Quantity / BOMQtyPerUOM);
            "Scrap Qty. per Top Item" :=
              "Qty. per Top Item" -
              Round((ParentQtyPer - ParentScrapQtyPer) * ("Qty. per Parent" - "Scrap Qty. per Parent"), UOMMgt.QtyRndPrecision());
            "Scrap Qty. per Parent" := Round("Scrap Qty. per Parent", UOMMgt.QtyRndPrecision());

            "Qty. per BOM Line" := ProdBOMLine."Quantity per";
            "Unit of Measure Code" := ProdBOMLine."Unit of Measure Code";
            "Variant Code" := ProdBOMLine."Variant Code";
            "Location Code" := ParentLocationCode;
            "Lead-Time Offset" := ProdBOMLine."Lead-Time Offset";
            "Needed by Date" := NeedByDate;
            Indentation := NewIndentation;
            if ProdBOMLine."Calculation Formula" = ProdBOMLine."Calculation Formula"::"Fixed Quantity" then
                "Calculation Formula" := ProdBOMLine."Calculation Formula";

            // OnTransferFromProdCompCopyFields(Rec, ProdBOMLine, ParentSKU, ParentQtyPer, ParentScrapQtyPer);
            Insert(true);
        end;
        // OnAfterTransferFromProdComp(Rec, ProdBOMLine, ParentSKU, EntryNo)
    end;

    procedure COLTransferFromBOMCompSKU(var EntryNo: Integer; BOMComp: Record "BOM Component"; NewIndentation: Integer; ParentQtyPer: Decimal; ParentScrapQtyPer: Decimal; NeedByDate: Date; ParentLocationCode: Code[10])
    var
        BOMItem: Record Item;
        BOMCompSKU: Record "Stockkeeping Unit";
        BOMRes: Record Resource;
        UOMMgt: Codeunit "Unit of Measure Management";
    begin
        Init();
        EntryNo += 1;
        "Entry No." := EntryNo;

        case BOMComp.Type of
            BOMComp.Type::Item:
                begin
                    BOMItem.Get(BOMComp."No.");
                    BOMCompSKU.Get(ParentLocationCode, BOMComp."No.", BOMComp."Variant Code");
                    InitFromItem(BOMItem);
                end;
            BOMComp.Type::Resource:
                begin
                    BOMRes.Get(BOMComp."No.");
                    InitFromRes(BOMRes);
                    "Resource Usage Type" := BOMComp."Resource Usage Type";
                end;
        end;

        Description := BOMComp.Description;
        "Qty. per Parent" := BOMComp."Quantity per";
        "Qty. per Top Item" := Round(BOMComp."Quantity per" * ParentQtyPer, UOMMgt.QtyRndPrecision());

        "Scrap Qty. per Top Item" :=
          "Qty. per Top Item" - Round((ParentQtyPer - ParentScrapQtyPer) * "Qty. per Parent", UOMMgt.QtyRndPrecision());

        "Unit of Measure Code" := BOMComp."Unit of Measure Code";
        "Variant Code" := BOMComp."Variant Code";
        "Location Code" := ParentLocationCode;
        "Lead-Time Offset" := BOMComp."Lead-Time Offset";
        "Needed by Date" := NeedByDate;
        Indentation := NewIndentation;

        // OnTransferFromBOMCompCopyFields(Rec, BOMComp);
        Insert(true);
    end;

    [IntegrationEvent(false, false)]
    local procedure COLOnTransferFromSKUCopyFields(var BOMBuffer: Record "BOM Buffer"; SKU: Record "Stockkeeping Unit")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure COLOnAfterInitFromItem(var BOMBuffer: Record "BOM Buffer"; Item: Record Item; StockkeepingUnit: Record "Stockkeeping Unit");
    begin
    end;
}