namespace Weibel.API;

using Weibel.Manufacturing.Archive;

page 70168 "COL Prod. Order Line Archive"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'prodOrderLineArchive';
    EntitySetName = 'prodOrderLineArchives';
    PageType = API;
    SourceTable = "COL Prod. Order Line Archive";
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
                field(lineNo; Rec."Line No.")
                {
                }
                field(itemNo; Rec."Item No.")
                {
                }
                field(variantCode; Rec."Variant Code")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(description2; Rec."Description 2")
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
                field(quantity; Rec.Quantity)
                {
                }
                field(finishedQuantity; Rec."Finished Quantity")
                {
                }
                field(remainingQuantity; Rec."Remaining Quantity")
                {
                }
                field(scrap; Rec."Scrap %")
                {
                }
                field(dueDate; Rec."Due Date")
                {
                }
                field(startingDate; Rec."Starting Date")
                {
                }
                field(startingTime; Rec."Starting Time")
                {
                }
                field(endingDate; Rec."Ending Date")
                {
                }
                field(endingTime; Rec."Ending Time")
                {
                }
                field(planningLevelCode; Rec."Planning Level Code")
                {
                }
                field(priority; Rec.Priority)
                {
                }
                field(productionBOMNo; Rec."Production BOM No.")
                {
                }
                field(routingNo; Rec."Routing No.")
                {
                }
                field(inventoryPostingGroup; Rec."Inventory Posting Group")
                {
                }
                field(routingReferenceNo; Rec."Routing Reference No.")
                {
                }
                field(unitCost; Rec."Unit Cost")
                {
                }
                field(costAmount; Rec."Cost Amount")
                {
                }
                field(reservedQuantity; Rec."Reserved Quantity")
                {
                }
                field(qtyRoundingPrecision; Rec."Qty. Rounding Precision")
                {
                }
                field(qtyRoundingPrecisionBase; Rec."Qty. Rounding Precision (Base)")
                {
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                }
                field(quantityBase; Rec."Quantity (Base)")
                {
                }
                field(finishedQtyBase; Rec."Finished Qty. (Base)")
                {
                }
                field(remainingQtyBase; Rec."Remaining Qty. (Base)")
                {
                }
                field(reservedQtyBase; Rec."Reserved Qty. (Base)")
                {
                }
                field(expectedOperationCostAmt; Rec."Expected Operation Cost Amt.")
                {
                }
                field(totalExpOperOutputQty; Rec."Total Exp. Oper. Output (Qty.)")
                {
                }
                field(expectedComponentCostAmt; Rec."Expected Component Cost Amt.")
                {
                }
                field(startingDateTime; Rec."Starting Date-Time")
                {
                }
                field(endingDateTime; Rec."Ending Date-Time")
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
                field(costAmountACY; Rec."Cost Amount (ACY)")
                {
                }
                field(unitCostACY; Rec."Unit Cost (ACY)")
                {
                }
                field(productionBOMVersionCode; Rec."Production BOM Version Code")
                {
                }
                field(routingVersionCode; Rec."Routing Version Code")
                {
                }
                field(routingType; Rec."Routing Type")
                {
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                }
                field(mpsOrder; Rec."MPS Order")
                {
                }
                field(planningFlexibility; Rec."Planning Flexibility")
                {
                }
                field(indirectCost; Rec."Indirect Cost %")
                {
                }
                field(overheadRate; Rec."Overhead Rate")
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
