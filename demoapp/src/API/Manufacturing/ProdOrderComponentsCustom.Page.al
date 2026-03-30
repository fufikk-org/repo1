namespace Weibel.API;

using Microsoft.Manufacturing.Document;

page 70206 "COL ProdOrderComponents Custom"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'prodOrderComponentCustom';
    EntitySetName = 'prodOrderComponentsCustom';
    PageType = API;
    SourceTable = "Prod. Order Component";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(status; Rec."Status") { }

                field(prodOrderNo; Rec."Prod. Order No.") { }

                field(prodOrderLineNo; Rec."Prod. Order Line No.") { }

                field(lineNo; Rec."Line No.") { }

                field(itemNo; Rec."Item No.") { }

                field(description; Rec."Description") { }

                field(unitOfMeasureCode; Rec."Unit of Measure Code") { }

                field(quantity; Rec."Quantity") { }

                field(position; Rec."Position") { }

                field(position2; Rec."Position 2") { }

                field(position3; Rec."Position 3") { }

                field(leadTimeOffset; Rec."Lead-Time Offset") { }

                field(routingLinkCode; Rec."Routing Link Code") { }

                field(scrap; Rec."Scrap %") { }

                field(variantCode; Rec."Variant Code") { }

                field(qtyRoundingPrecision; Rec."Qty. Rounding Precision") { }

                field(qtyRoundingPrecisionBase; Rec."Qty. Rounding Precision (Base)") { }

                field(expectedQuantity; Rec."Expected Quantity") { }

                field(remainingQuantity; Rec."Remaining Quantity") { }

                field(flushingMethod; Rec."Flushing Method") { }

                field(locationCode; Rec."Location Code") { }

                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code") { }

                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code") { }

                field(binCode; Rec."Bin Code") { }

                field(suppliedByLineNo; Rec."Supplied-by Line No.") { }

                field(planningLevelCode; Rec."Planning Level Code") { }

                field(itemLowLevelCode; Rec."Item Low-Level Code") { }

                field(length; Rec."Length") { }

                field(width; Rec."Width") { }

                field(weight; Rec."Weight") { }

                field(depth; Rec."Depth") { }

                field(calculationFormula; Rec."Calculation Formula") { }

                field(quantityPer; Rec."Quantity per") { }

                field(unitCost; Rec."Unit Cost") { }

                field(costAmount; Rec."Cost Amount") { }

                field(dueDate; Rec."Due Date") { }

                field(dueTime; Rec."Due Time") { }

                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure") { }

                field(remainingQtyBase; Rec."Remaining Qty. (Base)") { }

                field(quantityBase; Rec."Quantity (Base)") { }

                field(expectedQtyBase; Rec."Expected Qty. (Base)") { }

                field(dueDateTime; Rec."Due Date-Time") { }

                field(dimensionSetID; Rec."Dimension Set ID") { }

                field(originalItemNo; Rec."Original Item No.") { }

                field(originalVariantCode; Rec."Original Variant Code") { }

                field(qtyPicked; Rec."Qty. Picked") { }

                field(qtyPickedBase; Rec."Qty. Picked (Base)") { }

                field(completelyPicked; Rec."Completely Picked") { }

                field(directUnitCost; Rec."Direct Unit Cost") { }

                field(indirectCost; Rec."Indirect Cost %") { }

                field(overheadRate; Rec."Overhead Rate") { }

                field(directCostAmount; Rec."Direct Cost Amount") { }

                field(overheadAmount; Rec."Overhead Amount") { }

                field(id; Rec.SystemId) { }
                field(systemCreatedAt; Rec."SystemCreatedAt") { }

                field(systemCreatedBy; Rec."SystemCreatedBy") { }

                field(systemModifiedAt; Rec."SystemModifiedAt") { }

                field(systemModifiedBy; Rec."SystemModifiedBy") { }
            }
        }
    }
}
