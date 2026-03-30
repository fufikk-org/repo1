namespace Weibel.Manufacturing.ProductionBOM;

using Microsoft.Inventory.Location;
using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Manufacturing.Routing;

codeunit 70174 "COL Create BOM and Routing"
{
    TableNo = "Stockkeeping Unit";

    var
        Item: Record Item;
        AlreadyExistsErr: Label '%1 - %2 - already exists.', Comment = '%1 = table caption, %2 = no. value';
        RoutingCreatedLbl: Label 'Routing %1 created.', Comment = '%1 = routing no.';
        BOMCreatedLbl: Label 'BOM %1 created.', Comment = '%1 = BOM no.';
        AutomaticNumberErr: Label 'The automatic number created for ''%1'' is too long: %2.', Comment = '%1 = field caption; %2 = created number';

    trigger OnRun()
    var
        ModifyNeeded, BOMCreated, RoutingCreated : Boolean;
    begin
        Rec.TestField("Item No.");
        Rec.TestField("Replenishment System", Enum::"Replenishment System"::"Prod. Order");
        GetItem(Rec);

        if Rec."Production BOM No." = '' then begin
            Rec.Validate("Production BOM No.", CreateProductionBOM(Rec));
            BOMCreated := true;
            ModifyNeeded := true;
        end;

        if Rec."Routing No." = '' then begin
            Rec.Validate("Routing No.", CreateRouting(Rec));
            RoutingCreated := true;
            ModifyNeeded := true;
        end;

        if ModifyNeeded then
            Rec.Modify(true);

        if GuiAllowed() then
            case true of
                BomCreated and RoutingCreated:
                    Message('%1\%2', StrSubstNo(BOMCreatedLbl, Rec."Production BOM No."), StrSubstNo(RoutingCreatedLbl, Rec."Routing No."));
                BOMCreated:
                    Message(BOMCreatedLbl, Rec."Production BOM No.");
                RoutingCreated:
                    Message(RoutingCreatedLbl, Rec."Routing No.");
            end;
    end;

    local procedure CreateProductionBOM(SKU: Record "Stockkeeping Unit"): Code[20]
    var
        ProductionBOMHeader: Record "Production BOM Header";
        NewBOMNo: Code[20];
    begin
        NewBOMNo := CreateBOMNo(SKU."Item No.", SKU."Variant Code");
        ProductionBOMHeader.SetRange("No.", NewBOMNo);
        if not ProductionBOMHeader.IsEmpty() then
            Error(AlreadyExistsErr, ProductionBOMHeader.TableCaption(), NewBOMNo);

        ProductionBOMHeader.Init();
        ProductionBOMHeader."No." := NewBOmNo;
        ProductionBOMHeader.Validate("Description", SKU.Description);
        ProductionBOMHeader."Description 2" := SKU."Description 2";
        ProductionBOMHeader.Validate("Unit of Measure Code", Item."Base Unit of Measure");
        ProductionBOMHeader.Insert(true);
        exit(ProductionBOMHeader."No.");
    end;

    local procedure CreateRouting(SKU: Record "Stockkeeping Unit"): Code[20]
    var
        RoutingHeader: Record "Routing Header";
        NewRoutingNo: Code[20];
    begin
        NewRoutingNo := CreateRoutingNo(SKU."Item No.", SKU."Variant Code");
        RoutingHeader.SetRange("No.", NewRoutingNo);
        if not RoutingHeader.IsEmpty() then
            Error(AlreadyExistsErr, RoutingHeader.TableCaption(), NewRoutingNo);

        RoutingHeader.Init();
        RoutingHeader."No." := NewRoutingNo;
        RoutingHeader.Validate("Description", SKU.Description);
        RoutingHeader."Description 2" := SKU."Description 2";
        RoutingHeader.Insert(true);
        exit(RoutingHeader."No.");
    end;

    local procedure GetItem(SKU: Record "Stockkeeping Unit")
    begin
        if SKU."Item No." <> Item."No." then begin
            Item.Get(SKU."Item No.");
            Item.TestField("Base Unit of Measure");
            Item.TestField(Description);
            if Item.IsVariantMandatory() then
                SKU.TestField("Variant Code");
        end;
    end;

    local procedure CreateBOMNo(ItemNo: Code[20]; VariantCode: Code[10]): Code[20]
    var
        StockkeepingUnit: Record "Stockkeeping Unit";
        NewBOMNo: Code[20];
        SuffixLbl: Label '-%1', Locked = true, Comment = '%1 = variant code';
    begin
        if VariantCode = '' then
            exit(ItemNo);
        NewBOMNo := StrSubstNo(SuffixLbl, VariantCode);

        if StrLen(ItemNo + NewBOMNo) > MaxStrLen(StockkeepingUnit."Production BOM No.") then
            Error(AutomaticNumberErr, StockkeepingUnit.FieldCaption("Production BOM No."), ItemNo + NewBOMNo);

        NewBOMNo := CopyStr(ItemNo, 1, MaxStrLen(NewBOMNo) - StrLen(NewBOMNo)) + NewBOMNo;
        exit(NewBOMNo);
    end;

    local procedure CreateRoutingNo(ItemNo: Code[20]; VariantCode: Code[10]): Code[20]
    var
        StockkeepingUnit: Record "Stockkeeping Unit";
        NewBOMNo: Code[20];
        SuffixLbl: Label '-%1', Locked = true, Comment = '%1 = variant code';
    begin
        if VariantCode = '' then
            exit(ItemNo);
        NewBOMNo := StrSubstNo(SuffixLbl, VariantCode);

        if StrLen(ItemNo + NewBOMNo) > MaxStrLen(StockkeepingUnit."Routing No.") then
            Error(AutomaticNumberErr, StockkeepingUnit.FieldCaption("Routing No."), ItemNo + NewBOMNo);

        NewBOMNo := CopyStr(ItemNo, 1, MaxStrLen(NewBOMNo) - StrLen(NewBOMNo)) + NewBOMNo;
        exit(NewBOMNo);
    end;
}