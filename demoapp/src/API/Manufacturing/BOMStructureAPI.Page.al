namespace Weibel.API;

using Microsoft.Inventory.BOM;
using Microsoft.Inventory.Item;
using Weibel.Inventory.BOM.Tree;
using Microsoft.Inventory.Location;
using Microsoft.Manufacturing.Setup;

page 70222 "COL BOM Structure API"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'bomStructure';
    EntitySetName = 'bomStructure';
    PageType = API;
    SourceTable = "BOM Buffer";
    SourceTableTemporary = true;
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = "Entry No.";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(entryNo; Rec."Entry No.")
                {
                }
                field(indentation; Rec.Indentation)
                {
                }
                field(type; Rec."Type")
                {
                }
                field(no; Rec."No.")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(variantCode; Rec."Variant Code")
                {
                }
                field(productionBOMNo; Rec."Production BOM No.")
                {
                }
                field(locationCode; Rec."Location Code")
                {
                }
                field(colProductLifeCycle; Rec."COL Product Life Cycle")
                {
                }
                field(colEURoHSDirCompliant; Rec."COL EU RoHS Dir. Compliant")
                {
                }
                field(colEUREACHRegCompliant; Rec."COL EU REACH Reg. Compliant")
                {
                }
                field(colEURoHSStatus; Rec."COL EU RoHS Status")
                {
                }
                field(qtyPerParent; Rec."Qty. per Parent")
                {
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                }
                field(replenishmentSystem; Rec."Replenishment System")
                {
                }
                field(itemSystemId; ItemSystemGuid) { }
                field(itemVariantSystemId; ItemVariantSystemGuid) { }
                field(stockkeepingUnitSystemId; StockkeepingUnitSystemGuid) { }
            }
        }
    }
    var
        ItemSystemGuid, ItemVariantSystemGuid, StockkeepingUnitSystemGuid : Guid;

    trigger OnAfterGetRecord()
    var
        Item: Record Item;
        ItemVariant: Record "Item Variant";
        StockkeepingUnit: Record "Stockkeeping Unit";
    begin
        Item.SetLoadFields(SystemId);
        Item.ReadIsolation := IsolationLevel::ReadUncommitted;
        ItemVariant.SetLoadFields(SystemId);
        ItemVariant.ReadIsolation := IsolationLevel::ReadUncommitted;
        StockkeepingUnit.SetLoadFields(SystemId);
        StockkeepingUnit.ReadIsolation := IsolationLevel::ReadUncommitted;

        Clear(ItemSystemGuid);
        Clear(ItemVariantSystemGuid);
        Clear(StockkeepingUnitSystemGuid);

        if (Rec.Type = Rec.Type::Item) and (Rec."No." <> '') then begin
            if Item.Get(Rec."No.") then
                ItemSystemGuid := Item.SystemId;

            if Rec."Variant Code" <> '' then
                if ItemVariant.Get(Rec."No.", Rec."Variant Code") then
                    ItemVariantSystemGuid := ItemVariant.SystemId;

            if StockkeepingUnit.Get(Rec."Location Code", Rec."No.", Rec."Variant Code") then
                StockkeepingUnitSystemGuid := StockkeepingUnit.SystemId;
        end;
    end;

    trigger OnOpenPage()
    var
        ManufacturingSetup: Record "Manufacturing Setup";
        StockkeepingUnit: Record "Stockkeeping Unit";
        CalculateSKUTree: Codeunit "COL Calculate SKU Tree";
        BOMItemNo: Code[20];
        BOMVariantCode, BOMLocationCode : Code[10];
        ItemNoFilterErr: Label 'Filter for ''no'' field is required to specify item number.';
        InvalidNoFilterErr: Label 'Filter for ''no'' is invalid, single value needs to be specified.';
        VariantCodeFilterErr: Label 'Filter for ''variantCode'' field is required to specify item variant code.';
        InvalidVariantCodeFilterErr: Label 'Filter for ''variantCode'' is invalid, single value needs to be specified.';
        InvalidLocationCodeFilterErr: Label 'Filter for ''locationCode'' is invalid, single value needs to be specified.';
        MissingLocationErr: Label 'Either filter for ''locationCode'' needs to be specified, or value for ''%1'' field in ''%2'' needs to be setup in BC.', Comment = '%1 = field caption; %2 = table caption';
    begin
        Rec.DeleteAll();

        if Rec.GetFilter("No.") = '' then
            Error(ItemNoFilterErr);
        if Rec.GetRangeMax("No.") <> Rec.GetRangeMin("No.") then
            Error(InvalidNoFilterErr);
        BOMItemNo := Rec.GetRangeMax("No.");

        if Rec.GetFilter("Variant Code") = '' then
            Error(VariantCodeFilterErr);
        if Rec.GetRangeMax("Variant Code") <> Rec.GetRangeMin("Variant Code") then
            Error(InvalidVariantCodeFilterErr);

        BOMVariantCode := Rec.GetRangeMax("Variant Code");

        if Rec.GetFilter("Location Code") = '' then begin
            ManufacturingSetup.GetRecordOnce();
            if ManufacturingSetup."COL Def.Loc. for BOM Structure" = '' then
                Error(MissingLocationErr, ManufacturingSetup.FieldCaption("COL Def.Loc. for BOM Structure"), ManufacturingSetup.TableCaption());
            BOMLocationCode := ManufacturingSetup."COL Def.Loc. for BOM Structure";
        end else begin
            if Rec.GetRangeMax("Location Code") <> Rec.GetRangeMin("Location Code") then
                Error(InvalidLocationCodeFilterErr);
            BOMLocationCode := Rec.GetRangeMax("Location Code");
        end;

        Rec.SetRange("No.");
        Rec.SetRange("Location Code");
        Rec.SetRange("Variant Code");

        StockkeepingUnit.Get(BOMLocationCode, BOMItemNo, BOMVariantCode);
        CalculateSKUTree.GenerateTree(StockkeepingUnit, Rec);
        if Rec.FindFirst() then;
    end;
}