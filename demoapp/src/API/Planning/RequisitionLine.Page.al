namespace Weibel.API;

using Microsoft.Inventory.Requisition;

page 70174 "COL Requisition Line"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'requisitionLine';
    EntitySetName = 'requisitionLines';
    PageType = API;
    SourceTable = "Requisition Line";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(worksheetTemplateName; Rec."Worksheet Template Name")
                {
                }
                field(journalBatchName; Rec."Journal Batch Name")
                {
                }
                field(lineNo; Rec."Line No.")
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
                field(description2; Rec."Description 2")
                {
                }
                field(quantity; Rec.Quantity)
                {
                }
                field(vendorNo; Rec."Vendor No.")
                {
                }
                field(directUnitCost; Rec."Direct Unit Cost")
                {
                }
                field(dueDate; Rec."Due Date")
                {
                }
                field(requesterID; Rec."Requester ID")
                {
                }
                field(confirmed; Rec.Confirmed)
                {
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                }
                field(locationCode; Rec."Location Code")
                {
                }
                field(recurringMethod; Rec."Recurring Method")
                {
                }
                field(expirationDate; Rec."Expiration Date")
                {
                }
                field(recurringFrequency; Rec."Recurring Frequency")
                {
                }
                field(orderDate; Rec."Order Date")
                {
                }
                field(vendorItemNo; Rec."Vendor Item No.")
                {
                }
                field(salesOrderNo; Rec."Sales Order No.")
                {
                }
                field(salesOrderLineNo; Rec."Sales Order Line No.")
                {
                }
                field(sellToCustomerNo; Rec."Sell-to Customer No.")
                {
                }
                field(shipToCode; Rec."Ship-to Code")
                {
                }
                field(orderAddressCode; Rec."Order Address Code")
                {
                }
                field(currencyCode; Rec."Currency Code")
                {
                }
                field(currencyFactor; Rec."Currency Factor")
                {
                }
                field(reservedQuantity; Rec."Reserved Quantity")
                {
                }
                field(purchaserCode; Rec."Purchaser Code")
                {
                }
                field(dropShipment; Rec."Drop Shipment")
                {
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                }
                field(prodOrderNo; Rec."Prod. Order No.")
                {
                }
                field(variantCode; Rec."Variant Code")
                {
                }
                field(binCode; Rec."Bin Code")
                {
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
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
                field(reservedQtyBase; Rec."Reserved Qty. (Base)")
                {
                }
                field(demandType; Rec."Demand Type")
                {
                }
                field(demandSubtype; Rec."Demand Subtype")
                {
                }
                field(demandOrderNo; Rec."Demand Order No.")
                {
                }
                field(demandLineNo; Rec."Demand Line No.")
                {
                }
                field(demandRefNo; Rec."Demand Ref. No.")
                {
                }
                field(status; Rec.Status)
                {
                }
                field(demandDate; Rec."Demand Date")
                {
                }
                field(demandQuantity; Rec."Demand Quantity")
                {
                }
                field(demandQuantityBase; Rec."Demand Quantity (Base)")
                {
                }
                field(neededQuantity; Rec."Needed Quantity")
                {
                }
                field(neededQuantityBase; Rec."Needed Quantity (Base)")
                {
                }
                field(reserve; Rec.Reserve)
                {
                }
                field(qtyPerUOMDemand; Rec."Qty. per UOM (Demand)")
                {
                }
                field(unitOfMeasureCodeDemand; Rec."Unit Of Measure Code (Demand)")
                {
                }
                field(supplyFrom; Rec."Supply From")
                {
                }
                field(originalItemNo; Rec."Original Item No.")
                {
                }
                field(originalVariantCode; Rec."Original Variant Code")
                {
                }
                field(level; Rec.Level)
                {
                }
                field(demandQtyAvailable; Rec."Demand Qty. Available")
                {
                }
                field("userID"; Rec."User ID")
                {
                }
                field(itemCategoryCode; Rec."Item Category Code")
                {
                }
                field(nonstock; Rec.Nonstock)
                {
                }
                field(purchasingCode; Rec."Purchasing Code")
                {
                }
                field(transferFromCode; Rec."Transfer-from Code")
                {
                }
                field(transferShipmentDate; Rec."Transfer Shipment Date")
                {
                }
                field(priceCalculationMethod; Rec."Price Calculation Method")
                {
                }
                field(lineDiscount; Rec."Line Discount %")
                {
                }
                field(blanketPurchOrderExists; Rec."Blanket Purch. Order Exists")
                {
                }
                field(customSortingOrder; Rec."Custom Sorting Order")
                {
                }
                field(colNo; Rec."No.")
                {
                }
                field(routingNo; Rec."Routing No.")
                {
                }
                field(operationNo; Rec."Operation No.")
                {
                }
                field(workCenterNo; Rec."Work Center No.")
                {
                }
                field(prodOrderLineNo; Rec."Prod. Order Line No.")
                {
                }
                field(mpsOrder; Rec."MPS Order")
                {
                }
                field(planningFlexibility; Rec."Planning Flexibility")
                {
                }
                field(routingReferenceNo; Rec."Routing Reference No.")
                {
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                }
                field(genBusinessPostingGroup; Rec."Gen. Business Posting Group")
                {
                }
                field(lowLevelCode; Rec."Low-Level Code")
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
                field(originalQuantity; Rec."Original Quantity")
                {
                }
                field(finishedQuantity; Rec."Finished Quantity")
                {
                }
                field(remainingQuantity; Rec."Remaining Quantity")
                {
                }
                field(originalDueDate; Rec."Original Due Date")
                {
                }
                field(scrap; Rec."Scrap %")
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
                field(productionBOMNo; Rec."Production BOM No.")
                {
                }
                field(indirectCost; Rec."Indirect Cost %")
                {
                }
                field(overheadRate; Rec."Overhead Rate")
                {
                }
                field(unitCost; Rec."Unit Cost")
                {
                }
                field(costAmount; Rec."Cost Amount")
                {
                }
                field(replenishmentSystem; Rec."Replenishment System")
                {
                }
                field(refOrderNo; Rec."Ref. Order No.")
                {
                }
                field(refOrderType; Rec."Ref. Order Type")
                {
                }
                field(refOrderStatus; Rec."Ref. Order Status")
                {
                }
                field(refLineNo; Rec."Ref. Line No.")
                {
                }
                field(noSeries; Rec."No. Series")
                {
                }
                field(expectedOperationCostAmt; Rec."Expected Operation Cost Amt.")
                {
                }
                field(expectedComponentCostAmt; Rec."Expected Component Cost Amt.")
                {
                }
                field(finishedQtyBase; Rec."Finished Qty. (Base)")
                {
                }
                field(remainingQtyBase; Rec."Remaining Qty. (Base)")
                {
                }
                field(relatedToPlanningLine; Rec."Related to Planning Line")
                {
                }
                field(planningLevel; Rec."Planning Level")
                {
                }
                field(planningLineOrigin; Rec."Planning Line Origin")
                {
                }
                field(actionMessage; Rec."Action Message")
                {
                }
                field(acceptActionMessage; Rec."Accept Action Message")
                {
                }
                field(netQuantityBase; Rec."Net Quantity (Base)")
                {
                }
                field(startingDateTime; Rec."Starting Date-Time")
                {
                }
                field(endingDateTime; Rec."Ending Date-Time")
                {
                }
                field(orderPromisingID; Rec."Order Promising ID")
                {
                }
                field(orderPromisingLineNo; Rec."Order Promising Line No.")
                {
                }
                field(orderPromisingLineID; Rec."Order Promising Line ID")
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
