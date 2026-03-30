namespace Weibel.API;

using Weibel.Manufacturing.Archive;

page 70167 "COL Prod. Order Component Arch"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'prodOrderComponentArchive';
    EntitySetName = 'prodOrderComponentArchives';
    PageType = API;
    SourceTable = "COL Prod. Order Component Arch";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(status; Rec.Status)
                {
                }
                field(prodOrderNo; Rec."Prod. Order No.")
                {
                }
                field(prodOrderLineNo; Rec."Prod. Order Line No.")
                {
                }
                field(lineNo; Rec."Line No.")
                {
                }
                field(itemNo; Rec."Item No.")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                }
                field(quantity; Rec.Quantity)
                {
                }
                field(position; Rec.Position)
                {
                }
                field(position2; Rec."Position 2")
                {
                }
                field(position3; Rec."Position 3")
                {
                }
                field(leadTimeOffset; Rec."Lead-Time Offset")
                {
                }
                field(routingLinkCode; Rec."Routing Link Code")
                {
                }
                field(scrap; Rec."Scrap %")
                {
                }
                field(variantCode; Rec."Variant Code")
                {
                }
                field(qtyRoundingPrecision; Rec."Qty. Rounding Precision")
                {
                }
                field(qtyRoundingPrecisionBase; Rec."Qty. Rounding Precision (Base)")
                {
                }
                field(expectedQuantity; Rec."Expected Quantity")
                {
                }
                field(remainingQuantity; Rec."Remaining Quantity")
                {
                }
                field(actConsumptionQty; Rec."Act. Consumption (Qty)")
                {
                }
                field(flushingMethod; Rec."Flushing Method")
                {
                }
                field(locationCode; Rec."Location Code")
                {
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                }
                field(binCode; Rec."Bin Code")
                {
                }
                field(suppliedByLineNo; Rec."Supplied-by Line No.")
                {
                }
                field(planningLevelCode; Rec."Planning Level Code")
                {
                }
                field(itemLowLevelCode; Rec."Item Low-Level Code")
                {
                }
                field(length; Rec.Length)
                {
                }
                field(width; Rec.Width)
                {
                }
                field(weight; Rec.Weight)
                {
                }
                field(depth; Rec.Depth)
                {
                }
                field(calculationFormula; Rec."Calculation Formula")
                {
                }
                field(quantityPer; Rec."Quantity per")
                {
                }
                field(unitCost; Rec."Unit Cost")
                {
                }
                field(costAmount; Rec."Cost Amount")
                {
                }
                field(dueDate; Rec."Due Date")
                {
                }
                field(dueTime; Rec."Due Time")
                {
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                }
                field(remainingQtyBase; Rec."Remaining Qty. (Base)")
                {
                }
                field(quantityBase; Rec."Quantity (Base)")
                {
                }
                field(reservedQtyBase; Rec."Reserved Qty. (Base)")
                {
                }
                field(reservedQuantity; Rec."Reserved Quantity")
                {
                }
                field(expectedQtyBase; Rec."Expected Qty. (Base)")
                {
                }
                field(dueDateTime; Rec."Due Date-Time")
                {
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                }
                field(versionNo; Rec."Version No.")
                {
                }
                field(docNoOccurrence; Rec."Doc. No. Occurrence")
                {
                }
                field(substitutionAvailable; Rec."Substitution Available")
                {
                }
                field(originalItemNo; Rec."Original Item No.")
                {
                }
                field(originalVariantCode; Rec."Original Variant Code")
                {
                }
                field(pickQty; Rec."Pick Qty.")
                {
                }
                field(qtyPicked; Rec."Qty. Picked")
                {
                }
                field(qtyPickedBase; Rec."Qty. Picked (Base)")
                {
                }
                field(completelyPicked; Rec."Completely Picked")
                {
                }
                field(pickQtyBase; Rec."Pick Qty. (Base)")
                {
                }
                field(colPosition; Rec."COL Position")
                {
                }
                field(colPosition3; Rec."COL Position 3")
                {
                }
                field(directUnitCost; Rec."Direct Unit Cost")
                {
                }
                field(indirectCost; Rec."Indirect Cost %")
                {
                }
                field(overheadRate; Rec."Overhead Rate")
                {
                }
                field(directCostAmount; Rec."Direct Cost Amount")
                {
                }
                field(overheadAmount; Rec."Overhead Amount")
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
