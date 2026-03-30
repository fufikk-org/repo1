namespace Weibel.API;

using Microsoft.Inventory.Item;

page 70142 "COL Items"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'item';
    EntitySetName = 'items';
    PageType = API;
    SourceTable = Item;
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                }
                field(no2; Rec."No. 2")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(searchDescription; Rec."Search Description")
                {
                }
                field(description2; Rec."Description 2")
                {
                }
                field(assemblyBOM; Rec."Assembly BOM")
                {
                }
                field(baseUnitOfMeasure; Rec."Base Unit of Measure")
                {
                }
                field(priceUnitConversion; Rec."Price Unit Conversion")
                {
                }
                field(type; Rec."Type")
                {
                }
                field(inventoryPostingGroup; Rec."Inventory Posting Group")
                {
                }
                field(shelfNo; Rec."Shelf No.")
                {
                }
                field(itemDiscGroup; Rec."Item Disc. Group")
                {
                }
                field(allowInvoiceDisc; Rec."Allow Invoice Disc.")
                {
                }
                field(statisticsGroup; Rec."Statistics Group")
                {
                }
                field(commissionGroup; Rec."Commission Group")
                {
                }
                field(unitPrice; Rec."Unit Price")
                {
                }
                field(priceProfitCalculation; Rec."Price/Profit Calculation")
                {
                }
                field(profit; Rec."Profit %")
                {
                }
                field(costingMethod; Rec."Costing Method")
                {
                }
                field(unitCost; Rec."Unit Cost")
                {
                }
                field(standardCost; Rec."Standard Cost")
                {
                }
                field(lastDirectCost; Rec."Last Direct Cost")
                {
                }
                field(indirectCost; Rec."Indirect Cost %")
                {
                }
                field(costIsAdjusted; Rec."Cost is Adjusted")
                {
                }
                field(allowOnlineAdjustment; Rec."Allow Online Adjustment")
                {
                }
                field(vendorNo; Rec."Vendor No.")
                {
                }
                field(vendorItemNo; Rec."Vendor Item No.")
                {
                }
                field(leadTimeCalculation; Rec."Lead Time Calculation")
                {
                }
                field(reorderPoint; Rec."Reorder Point")
                {
                }
                field(maximumInventory; Rec."Maximum Inventory")
                {
                }
                field(reorderQuantity; Rec."Reorder Quantity")
                {
                }
                field(alternativeItemNo; Rec."Alternative Item No.")
                {
                }
                field(unitListPrice; Rec."Unit List Price")
                {
                }
                field(dutyDue; Rec."Duty Due %")
                {
                }
                field(dutyCode; Rec."Duty Code")
                {
                }
                field(grossWeight; Rec."Gross Weight")
                {
                }
                field(netWeight; Rec."Net Weight")
                {
                }
                field(unitsPerParcel; Rec."Units per Parcel")
                {
                }
                field(unitVolume; Rec."Unit Volume")
                {
                }
                field(durability; Rec.Durability)
                {
                }
                field(freightType; Rec."Freight Type")
                {
                }
                field(tariffNo; Rec."Tariff No.")
                {
                }
                field(dutyUnitConversion; Rec."Duty Unit Conversion")
                {
                }
                field(countryRegionPurchasedCode; Rec."Country/Region Purchased Code")
                {
                }
                field(budgetQuantity; Rec."Budget Quantity")
                {
                }
                field(budgetedAmount; Rec."Budgeted Amount")
                {
                }
                field(budgetProfit; Rec."Budget Profit")
                {
                }
                field(comment; Rec.Comment)
                {
                }
                field(blocked; Rec.Blocked)
                {
                }
                field(costIsPostedToGL; Rec."Cost is Posted to G/L")
                {
                }
                field(blockReason; Rec."Block Reason")
                {
                }
                field(lastDateTimeModified; Rec."Last DateTime Modified")
                {
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                }
                field(lastTimeModified; Rec."Last Time Modified")
                {
                }
                field(inventory; Rec.Inventory)
                {
                }
                field(netInvoicedQty; Rec."Net Invoiced Qty.")
                {
                }
                field(netChange; Rec."Net Change")
                {
                }
                field(purchasesQty; Rec."Purchases (Qty.)")
                {
                }
                field(salesQty; Rec."Sales (Qty.)")
                {
                }
                field(positiveAdjmtQty; Rec."Positive Adjmt. (Qty.)")
                {
                }
                field(negativeAdjmtQty; Rec."Negative Adjmt. (Qty.)")
                {
                }
                field(purchasesLCY; Rec."Purchases (LCY)")
                {
                }
                field(salesLCY; Rec."Sales (LCY)")
                {
                }
                field(positiveAdjmtLCY; Rec."Positive Adjmt. (LCY)")
                {
                }
                field(negativeAdjmtLCY; Rec."Negative Adjmt. (LCY)")
                {
                }
                field(cogsLCY; Rec."COGS (LCY)")
                {
                }
                field(qtyOnPurchOrder; Rec."Qty. on Purch. Order")
                {
                }
                field(qtyOnSalesOrder; Rec."Qty. on Sales Order")
                {
                }
                field(priceIncludesVAT; Rec."Price Includes VAT")
                {
                }
                field(vatBusPostingGrPrice; Rec."VAT Bus. Posting Gr. (Price)")
                {
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                }
                field(picture; Rec.Picture)
                {
                }
                field(transferredQty; Rec."Transferred (Qty.)")
                {
                }
                field(transferredLCY; Rec."Transferred (LCY)")
                {
                }
                field(countryRegionOfOriginCode; Rec."Country/Region of Origin Code")
                {
                }
                field(automaticExtTexts; Rec."Automatic Ext. Texts")
                {
                }
                field(noSeries; Rec."No. Series")
                {
                }
                field(taxGroupCode; Rec."Tax Group Code")
                {
                }
                field(vatProdPostingGroup; Rec."VAT Prod. Posting Group")
                {
                }
                field(reserve; Rec.Reserve)
                {
                }
                field(reservedQtyOnInventory; Rec."Reserved Qty. on Inventory")
                {
                }
                field(reservedQtyOnPurchOrders; Rec."Reserved Qty. on Purch. Orders")
                {
                }
                field(reservedQtyOnSalesOrders; Rec."Reserved Qty. on Sales Orders")
                {
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                }
                field(resQtyOnOutboundTransfer; Rec."Res. Qty. on Outbound Transfer")
                {
                }
                field(resQtyOnInboundTransfer; Rec."Res. Qty. on Inbound Transfer")
                {
                }
                field(resQtyOnSalesReturns; Rec."Res. Qty. on Sales Returns")
                {
                }
                field(resQtyOnPurchReturns; Rec."Res. Qty. on Purch. Returns")
                {
                }
                field(stockoutWarning; Rec."Stockout Warning")
                {
                }
                field(preventNegativeInventory; Rec."Prevent Negative Inventory")
                {
                }
                field(variantMandatoryIfExists; Rec."Variant Mandatory if Exists")
                {
                }
                field(costOfOpenProductionOrders; Rec."Cost of Open Production Orders")
                {
                }
                field(applicationWkshUserID; Rec."Application Wksh. User ID")
                {
                }
                field(coupledToDataverse; Rec."Coupled to Dataverse")
                {
                }
                field(assemblyPolicy; Rec."Assembly Policy")
                {
                }
                field(resQtyOnAssemblyOrder; Rec."Res. Qty. on Assembly Order")
                {
                }
                field(resQtyOnAsmComp; Rec."Res. Qty. on  Asm. Comp.")
                {
                }
                field(qtyOnAssemblyOrder; Rec."Qty. on Assembly Order")
                {
                }
                field(qtyOnAsmComponent; Rec."Qty. on Asm. Component")
                {
                }
                field(qtyOnJobOrder; Rec."Qty. on Job Order")
                {
                }
                field(resQtyOnJobOrder; Rec."Res. Qty. on Job Order")
                {
                }
                field(gtin; Rec.GTIN)
                {
                }
                field(defaultDeferralTemplateCode; Rec."Default Deferral Template Code")
                {
                }
                field(lowLevelCode; Rec."Low-Level Code")
                {
                }
                field(lotSize; Rec."Lot Size")
                {
                }
                field(serialNos; Rec."Serial Nos.")
                {
                }
                field(lastUnitCostCalcDate; Rec."Last Unit Cost Calc. Date")
                {
                }
                field(rolledUpMaterialCost; Rec."Rolled-up Material Cost")
                {
                }
                field(rolledUpCapacityCost; Rec."Rolled-up Capacity Cost")
                {
                }
                field(scrap; Rec."Scrap %")
                {
                }
                field(inventoryValueZero; Rec."Inventory Value Zero")
                {
                }
                field(discreteOrderQuantity; Rec."Discrete Order Quantity")
                {
                }
                field(minimumOrderQuantity; Rec."Minimum Order Quantity")
                {
                }
                field(maximumOrderQuantity; Rec."Maximum Order Quantity")
                {
                }
                field(safetyStockQuantity; Rec."Safety Stock Quantity")
                {
                }
                field(orderMultiple; Rec."Order Multiple")
                {
                }
                field(safetyLeadTime; Rec."Safety Lead Time")
                {
                }
                field(flushingMethod; Rec."Flushing Method")
                {
                }
                field(replenishmentSystem; Rec."Replenishment System")
                {
                }
                field(scheduledReceiptQty; Rec."Scheduled Receipt (Qty.)")
                {
                }
                field(roundingPrecision; Rec."Rounding Precision")
                {
                }
                field(salesUnitOfMeasure; Rec."Sales Unit of Measure")
                {
                }
                field(purchUnitOfMeasure; Rec."Purch. Unit of Measure")
                {
                }
                field(timeBucket; Rec."Time Bucket")
                {
                }
                field(reservedQtyOnProdOrder; Rec."Reserved Qty. on Prod. Order")
                {
                }
                field(resQtyOnProdOrderComp; Rec."Res. Qty. on Prod. Order Comp.")
                {
                }
                field(resQtyOnReqLine; Rec."Res. Qty. on Req. Line")
                {
                }
                field(reorderingPolicy; Rec."Reordering Policy")
                {
                }
                field(includeInventory; Rec."Include Inventory")
                {
                }
                field(manufacturingPolicy; Rec."Manufacturing Policy")
                {
                }
                field(reschedulingPeriod; Rec."Rescheduling Period")
                {
                }
                field(lotAccumulationPeriod; Rec."Lot Accumulation Period")
                {
                }
                field(dampenerPeriod; Rec."Dampener Period")
                {
                }
                field(dampenerQuantity; Rec."Dampener Quantity")
                {
                }
                field(overflowLevel; Rec."Overflow Level")
                {
                }
                field(planningTransferShipQty; Rec."Planning Transfer Ship. (Qty).")
                {
                }
                field(planningWorksheetQty; Rec."Planning Worksheet (Qty.)")
                {
                }
                field(stockkeepingUnitExists; Rec."Stockkeeping Unit Exists")
                {
                }
                field(manufacturerCode; Rec."Manufacturer Code")
                {
                }
                field(itemCategoryCode; Rec."Item Category Code")
                {
                }
                field(createdFromNonstockItem; Rec."Created From Nonstock Item")
                {
                }
                field(substitutesExist; Rec."Substitutes Exist")
                {
                }
                field(qtyInTransit; Rec."Qty. in Transit")
                {
                }
                field(transOrdReceiptQty; Rec."Trans. Ord. Receipt (Qty.)")
                {
                }
                field(transOrdShipmentQty; Rec."Trans. Ord. Shipment (Qty.)")
                {
                }
                field(purchasingCode; Rec."Purchasing Code")
                {
                }
                field(qtyAssignedToShip; Rec."Qty. Assigned to ship")
                {
                }
                field(qtyPicked; Rec."Qty. Picked")
                {
                }
                field(excludedFromCostAdjustment; Rec."Excluded from Cost Adjustment")
                {
                }
                field(serviceItemGroup; Rec."Service Item Group")
                {
                }
                field(qtyOnServiceOrder; Rec."Qty. on Service Order")
                {
                }
                field(resQtyOnServiceOrders; Rec."Res. Qty. on Service Orders")
                {
                }
                field(itemTrackingCode; Rec."Item Tracking Code")
                {
                }
                field(lotNos; Rec."Lot Nos.")
                {
                }
                field(expirationCalculation; Rec."Expiration Calculation")
                {
                }
                field(qtyOnPurchReturn; Rec."Qty. on Purch. Return")
                {
                }
                field(qtyOnSalesReturn; Rec."Qty. on Sales Return")
                {
                }
                field(noOfSubstitutes; Rec."No. of Substitutes")
                {
                }
                field(warehouseClassCode; Rec."Warehouse Class Code")
                {
                }
                field(specialEquipmentCode; Rec."Special Equipment Code")
                {
                }
                field(putAwayTemplateCode; Rec."Put-away Template Code")
                {
                }
                field(putAwayUnitOfMeasureCode; Rec."Put-away Unit of Measure Code")
                {
                }
                field(physInvtCountingPeriodCode; Rec."Phys Invt Counting Period Code")
                {
                }
                field(lastCountingPeriodUpdate; Rec."Last Counting Period Update")
                {
                }
                field(lastPhysInvtDate; Rec."Last Phys. Invt. Date")
                {
                }
                field(useCrossDocking; Rec."Use Cross-Docking")
                {
                }
                field(nextCountingStartDate; Rec."Next Counting Start Date")
                {
                }
                field(nextCountingEndDate; Rec."Next Counting End Date")
                {
                }
                field(unitGroupExists; Rec."Unit Group Exists")
                {
                }
                field(identifierCode; Rec."Identifier Code")
                {
                }
                field(unitOfMeasureId; Rec."Unit of Measure Id")
                {
                }
                field(taxGroupId; Rec."Tax Group Id")
                {
                }
                field(salesBlocked; Rec."Sales Blocked")
                {
                }
                field(purchasingBlocked; Rec."Purchasing Blocked")
                {
                }
                field(itemCategoryId; Rec."Item Category Id")
                {
                }
                field(inventoryPostingGroupId; Rec."Inventory Posting Group Id")
                {
                }
                field(genProdPostingGroupId; Rec."Gen. Prod. Posting Group Id")
                {
                }
                field(serviceBlocked; Rec."Service Blocked")
                {
                }
                field(overReceiptCode; Rec."Over-Receipt Code")
                {
                }
                field(colManufacturerItemNo; Rec."COL Manufacturer Item No.")
                {
                }
                field(colOutQtyBlankPurchOrder; Rec."COL Out.Qty.Blank.Purch.Order")
                {
                }
                field(colQtyPurchOrder; Rec."COL Qty. Purch.Order")
                {
                }
                field(colExportClassificationCode; Rec."COL Export Classification Code")
                {
                }
                field(colEUClassificationNo; Rec."COL EU Classification No.")
                {
                }
                field(colUSClassificationNo; Rec."COL US Classification No.")
                {
                }
                field(colEURoHSDirCompliant; Rec."COL EU RoHS Dir. Compliant")
                {
                }
                field(colEUREACHRegCompliant; Rec."COL EU REACH Reg. Compliant")
                {
                }
                field(colMoistureSensitivityLevel; Rec."COL Moisture Sensitivity Level")
                {
                }
                field(colNATOStockNo; Rec."COL NATO Stock No.")
                {
                }
                field(colCreatedByUser; Rec."COL Created By User")
                {
                }
                field(colCreationDate; Rec."COL Creation Date")
                {
                }
                field(colItemConfigurationType; Rec."COL Item Configuration Type")
                {
                }
                field(colProductionBlocked; Rec."COL Production Blocked")
                {
                }
                field(colProjectBlocked; Rec."COL Project Blocked")
                {
                }
                field(colEURoHSStatus; Rec."COL EU RoHS Status")
                {
                }
                field(colStandardPlacingCode; Rec."COL Standard Placing Code")
                {
                }
                field(colPlanningBlocked; Rec."COL Planning Blocked")
                {
                }
                field(colMTBFNo; Rec."COL MTBF No.")
                {
                }
                field(colMTBFComment; Rec."COL MTBF Comment")
                {
                }
                field(colMTBFNo2; Rec."COL MTBF No. 2")
                {
                }
                field(colMTBFComment2; Rec."COL MTBF Comment 2")
                {
                }
                field(costTypePGS; Rec."Cost Type PGS")
                {
                }
                field(routingNo; Rec."Routing No.")
                {
                }
                field(productionBOMNo; Rec."Production BOM No.")
                {
                }
                field(singleLevelMaterialCost; Rec."Single-Level Material Cost")
                {
                }
                field(singleLevelCapacityCost; Rec."Single-Level Capacity Cost")
                {
                }
                field(singleLevelSubcontrdCost; Rec."Single-Level Subcontrd. Cost")
                {
                }
                field(singleLevelCapOvhdCost; Rec."Single-Level Cap. Ovhd Cost")
                {
                }
                field(singleLevelMfgOvhdCost; Rec."Single-Level Mfg. Ovhd Cost")
                {
                }
                field(overheadRate; Rec."Overhead Rate")
                {
                }
                field(rolledUpSubcontractedCost; Rec."Rolled-up Subcontracted Cost")
                {
                }
                field(rolledUpMfgOvhdCost; Rec."Rolled-up Mfg. Ovhd Cost")
                {
                }
                field(rolledUpCapOverheadCost; Rec."Rolled-up Cap. Overhead Cost")
                {
                }
                field(planningIssuesQty; Rec."Planning Issues (Qty.)")
                {
                }
                field(planningReceiptQty; Rec."Planning Receipt (Qty.)")
                {
                }
                field(plannedOrderReceiptQty; Rec."Planned Order Receipt (Qty.)")
                {
                }
                field(fpOrderReceiptQty; Rec."FP Order Receipt (Qty.)")
                {
                }
                field(relOrderReceiptQty; Rec."Rel. Order Receipt (Qty.)")
                {
                }
                field(planningReleaseQty; Rec."Planning Release (Qty.)")
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
                field(orderTrackingPolicy; Rec."Order Tracking Policy")
                {
                }
                field(prodForecastQuantityBase; Rec."Prod. Forecast Quantity (Base)")
                {
                }
                field(qtyOnProdOrder; Rec."Qty. on Prod. Order")
                {
                }
                field(qtyOnComponentLines; Rec."Qty. on Component Lines")
                {
                }
                field(critical; Rec.Critical)
                {
                }
                field(commonItemNo; Rec."Common Item No.")
                {
                }
                field(colManufacturer; Rec."COL Manufacturer") { }
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
