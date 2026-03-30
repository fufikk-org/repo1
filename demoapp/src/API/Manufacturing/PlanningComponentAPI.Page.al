namespace Weibel.API;

using Microsoft.Inventory.Planning;

page 70257 "COL Planning Component API"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'planningComponent';
    EntitySetName = 'planningComponents';
    PageType = API;
    SourceTable = "Planning Component";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                }
                field(worksheetTemplateName; Rec."Worksheet Template Name")
                {
                }
                field(worksheetBatchName; Rec."Worksheet Batch Name")
                {
                }
                field(worksheetLineNo; Rec."Worksheet Line No.")
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
                field(refOrderStatus; Rec."Ref. Order Status")
                {
                }
                field(refOrderNo; Rec."Ref. Order No.")
                {
                }
                field(refOrderLineNo; Rec."Ref. Order Line No.")
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
                field(refOrderType; Rec."Ref. Order Type")
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
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
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
                field(expectedQuantityBase; Rec."Expected Quantity (Base)")
                {
                }
                field(originalExpectedQtyBase; Rec."Original Expected Qty. (Base)")
                {
                }
                field(netQuantityBase; Rec."Net Quantity (Base)")
                {
                }
                field(dueDateTime; Rec."Due Date-Time")
                {
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                }
                field(colPosition; Rec."COL Position")
                {
                }
                field(colPosition3; Rec."COL Position 3")
                {
                }
                field(critical; Rec.Critical)
                {
                }
                field(planningLineOrigin; Rec."Planning Line Origin")
                {
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
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
