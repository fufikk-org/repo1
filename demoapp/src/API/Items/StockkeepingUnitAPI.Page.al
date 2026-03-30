namespace Weibel.API;

using Microsoft.Inventory.Location;

page 70219 "COL Stockkeeping Unit API"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'stockkeepingUnit';
    EntitySetName = 'stockkeepingUnits';
    PageType = API;
    SourceTable = "Stockkeeping Unit";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(itemNo; Rec."Item No.")
                {
                }
                field(variantCode; Rec."Variant Code")
                {
                }
                field(locationCode; Rec."Location Code")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(description2; Rec."Description 2")
                {
                }
                field(replenishmentSystem; Rec."Replenishment System")
                {
                }
                field(routingNo; Rec."Routing No.")
                {
                }
                field(productionBOMNo; Rec."Production BOM No.")
                {
                }
                field(unitCost; Rec."Unit Cost")
                {
                }
                field(leadTimeCalculation; Rec."Lead Time Calculation")
                {
                }
                field(reorderingPolicy; Rec."Reordering Policy")
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


                field(assemblyBOM; Rec."Assembly BOM")
                {
                }
                field(assemblyPolicy; Rec."Assembly Policy")
                {
                }
                field(colChangedBy; Rec."COL Changed By")
                {
                }
                field(colCreatedByUser; Rec."COL Created By User")
                {
                }
                field(colCreationDate; Rec."COL Creation Date")
                {
                }
                field(colDateChanged; Rec."COL Date Changed")
                {
                }
                field(colEUREACHRegCompliant; Rec."COL EU REACH Reg. Compliant")
                {
                }
                field(colEURoHSDirCompliant; Rec."COL EU RoHS Dir. Compliant")
                {
                }
                field(colEURoHSStatus; Rec."COL EU RoHS Status")
                {
                }
                field(colItemCreatedByUser; Rec."COL Item Created By User")
                {
                }
                field(colItemReference; Rec."COL Item Reference")
                {
                }
                field(colProductLifeCycle; Rec."COL Product Life Cycle")
                {
                }
                field(colSKUPreventNegativeInv; Rec."COL SKU Prevent Negative Inv.")
                {
                }
                field(colVEUREACHRegCompliant; Rec."COL V.EU REACH Reg. Compliant")
                {
                }
                field(colVEURoHSDirCompliant; Rec."COL V.EU RoHS Dir. Compliant")
                {
                }
                field(colVEURoHSStatus; Rec."COL V.EU RoHS Status")
                {
                }
                field(comment; Rec.Comment)
                {
                }
                field(componentsAtLocation; Rec."Components at Location")
                {
                }
                field(dampenerPeriod; Rec."Dampener Period")
                {
                }
                field(dampenerQuantity; Rec."Dampener Quantity")
                {
                }
                field(discreteOrderQuantity; Rec."Discrete Order Quantity")
                {
                }
                field(fpOrderReceiptQty; Rec."FP Order Receipt (Qty.)")
                {
                }
                field(flushingMethod; Rec."Flushing Method")
                {
                }
                field(includeInventory; Rec."Include Inventory")
                {
                }
                field(inventory; Rec.Inventory)
                {
                }
                field(lastCountingPeriodUpdate; Rec."Last Counting Period Update")
                {
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                }
                field(lastDirectCost; Rec."Last Direct Cost")
                {
                }
                field(lastPhysInvtDate; Rec."Last Phys. Invt. Date")
                {
                }
                field(lotAccumulationPeriod; Rec."Lot Accumulation Period")
                {
                }
                field(lotSize; Rec."Lot Size")
                {
                }
                field(manufacturingPolicy; Rec."Manufacturing Policy")
                {
                }
                field(maximumInventory; Rec."Maximum Inventory")
                {
                }
                field(maximumOrderQuantity; Rec."Maximum Order Quantity")
                {
                }
                field(minimumOrderQuantity; Rec."Minimum Order Quantity")
                {
                }
                field(nextCountingEndDate; Rec."Next Counting End Date")
                {
                }
                field(nextCountingStartDate; Rec."Next Counting Start Date")
                {
                }
                field(orderMultiple; Rec."Order Multiple")
                {
                }
                field(overflowLevel; Rec."Overflow Level")
                {
                }
                field(physInvtCountingPeriodCode; Rec."Phys Invt Counting Period Code")
                {
                }
                field(planMinimalSupply; Rec."Plan Minimal Supply")
                {
                }
                field(plannedOrderReceiptQty; Rec."Planned Order Receipt (Qty.)")
                {
                }
                field(plannedOrderReleaseQty; Rec."Planned Order Release (Qty.)")
                {
                }
                field(purchReqReceiptQty; Rec."Purch. Req. Receipt (Qty.)")
                {
                }
                field(purchReqReleaseQty; Rec."Purch. Req. Release (Qty.)")
                {
                }
                field(putAwayTemplateCode; Rec."Put-away Template Code")
                {
                }
                field(putAwayUnitOfMeasureCode; Rec."Put-away Unit of Measure Code")
                {
                }
                field(qtyInTransit; Rec."Qty. in Transit")
                {
                }
                field(qtyOnAsmComponent; Rec."Qty. on Asm. Component")
                {
                }
                field(qtyOnAssemblyOrder; Rec."Qty. on Assembly Order")
                {
                }
                field(qtyOnComponentLines; Rec."Qty. on Component Lines")
                {
                }
                field(qtyOnJobOrder; Rec."Qty. on Job Order")
                {
                }
                field(qtyOnProdOrder; Rec."Qty. on Prod. Order")
                {
                }
                field(qtyOnPurchOrder; Rec."Qty. on Purch. Order")
                {
                }
                field(qtyOnSalesOrder; Rec."Qty. on Sales Order")
                {
                }
                field(qtyOnServiceOrder; Rec."Qty. on Service Order")
                {
                }
                field(relOrderReceiptQty; Rec."Rel. Order Receipt (Qty.)")
                {
                }
                field(reorderPoint; Rec."Reorder Point")
                {
                }
                field(reorderQuantity; Rec."Reorder Quantity")
                {
                }
                field(reschedulingPeriod; Rec."Rescheduling Period")
                {
                }
                field(rolledUpCapOverheadCost; Rec."Rolled-up Cap. Overhead Cost")
                {
                }
                field(rolledUpCapacityCost; Rec."Rolled-up Capacity Cost")
                {
                }
                field(rolledUpMatNonInvtCost; Rec."Rolled-up Mat. Non-Invt. Cost")
                {
                }
                field(rolledUpMaterialCost; Rec."Rolled-up Material Cost")
                {
                }
                field(rolledUpMfgOvhdCost; Rec."Rolled-up Mfg. Ovhd Cost")
                {
                }
                field(rolledUpSubcontractedCost; Rec."Rolled-up Subcontracted Cost")
                {
                }
                field(safetyLeadTime; Rec."Safety Lead Time")
                {
                }
                field(safetyStockQuantity; Rec."Safety Stock Quantity")
                {
                }
                field(scheduledReceiptQty; Rec."Scheduled Receipt (Qty.)")
                {
                }
                field(scrap; Rec."Scrap %")
                {
                }
                field(shelfNo; Rec."Shelf No.")
                {
                }
                field(singleLevelCapOvhdCost; Rec."Single-Level Cap. Ovhd Cost")
                {
                }
                field(singleLevelCapacityCost; Rec."Single-Level Capacity Cost")
                {
                }
                field(singleLevelMaterialCost; Rec."Single-Level Material Cost")
                {
                }
                field(singleLevelMfgOvhdCost; Rec."Single-Level Mfg. Ovhd Cost")
                {
                }
                field(singleLevelSubcontrdCost; Rec."Single-Level Subcontrd. Cost")
                {
                }
                field(singleLvlMatNonInvtCost; Rec."Single-Lvl Mat. Non-Invt. Cost")
                {
                }
                field(specialEquipmentCode; Rec."Special Equipment Code")
                {
                }
                field(standardCost; Rec."Standard Cost")
                {
                }
                field(timeBucket; Rec."Time Bucket")
                {
                }
                field(transOrdReceiptQty; Rec."Trans. Ord. Receipt (Qty.)")
                {
                }
                field(transOrdShipmentQty; Rec."Trans. Ord. Shipment (Qty.)")
                {
                }
                field(transferLevelCode; Rec."Transfer-Level Code")
                {
                }
                field(transferFromCode; Rec."Transfer-from Code")
                {
                }
                field(useCrossDocking; Rec."Use Cross-Docking")
                {
                }
                field(vendorItemNo; Rec."Vendor Item No.")
                {
                }
                field(vendorNo; Rec."Vendor No.")
                {
                }
            }
        }
    }
}
