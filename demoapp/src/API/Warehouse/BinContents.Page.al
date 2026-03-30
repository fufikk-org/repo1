namespace Weibel.API;

using Microsoft.Warehouse.Structure;

page 70247 "COL Bin Contents"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'binContent';
    EntitySetName = 'binContents';
    PageType = API;
    SourceTable = "Bin Content";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(locationCode; Rec."Location Code")
                {
                }
                field(zoneCode; Rec."Zone Code")
                {
                }
                field(binCode; Rec."Bin Code")
                {
                }
                field(itemNo; Rec."Item No.")
                {
                }
                field(variantCode; Rec."Variant Code")
                {
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                }
                field(quantity; Rec.Quantity)
                {
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                }
                field(quantityBase; Rec."Quantity (Base)")
                {
                }
                field(fixed; Rec.Fixed)
                {
                }
                field(defaultBin; Rec."Default")
                {
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                }
                field(systemId; Rec.SystemId)
                {
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                }
            }
        }
    }
}