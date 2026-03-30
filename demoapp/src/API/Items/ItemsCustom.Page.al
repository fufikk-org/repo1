namespace Weibel.API;

using Microsoft.Inventory.Item;

page 70199 "COL Items Custom"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'itemCustom';
    EntitySetName = 'itemsCustom';
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
                field(no; Rec."No.") { }

                field(no2; Rec."No. 2") { }

                field(description; Rec."Description") { }

                field(searchDescription; Rec."Search Description") { }

                field(description2; Rec."Description 2") { }

                field(baseUnitOfMeasure; Rec."Base Unit of Measure") { }

                field(priceUnitConversion; Rec."Price Unit Conversion") { }

                field(type; Rec."Type") { }

                field(inventoryPostingGroup; Rec."Inventory Posting Group") { }

                field(shelfNo; Rec."Shelf No.") { }

                field(itemDiscGroup; Rec."Item Disc. Group") { }

                field(allowInvoiceDisc; Rec."Allow Invoice Disc.") { }

                field(statisticsGroup; Rec."Statistics Group") { }

                field(commissionGroup; Rec."Commission Group") { }

                field(unitPrice; Rec."Unit Price") { }

                field(priceProfitCalculation; Rec."Price/Profit Calculation") { }

                field(profit; Rec."Profit %") { }

                field(costingMethod; Rec."Costing Method") { }

                field(unitCost; Rec."Unit Cost") { }

                field(standardCost; Rec."Standard Cost") { }

                field(lastDirectCost; Rec."Last Direct Cost") { }

                field(indirectCost; Rec."Indirect Cost %") { }

                field(costIsAdjusted; Rec."Cost is Adjusted") { }

                field(allowOnlineAdjustment; Rec."Allow Online Adjustment") { }

                field(vendorNo; Rec."Vendor No.") { }

                field(vendorItemNo; Rec."Vendor Item No.") { }

                field(leadTimeCalculation; Rec."Lead Time Calculation") { }

                field(reorderPoint; Rec."Reorder Point") { }

                field(maximumInventory; Rec."Maximum Inventory") { }

                field(reorderQuantity; Rec."Reorder Quantity") { }

                field(alternativeItemNo; Rec."Alternative Item No.") { }

                field(unitListPrice; Rec."Unit List Price") { }

                field(dutyDue; Rec."Duty Due %") { }

                field(dutyCode; Rec."Duty Code") { }

                field(grossWeight; Rec."Gross Weight") { }

                field(netWeight; Rec."Net Weight") { }

                field(unitsPerParcel; Rec."Units per Parcel") { }

                field(unitVolume; Rec."Unit Volume") { }

                field(durability; Rec."Durability") { }

                field(freightType; Rec."Freight Type") { }

                field(tariffNo; Rec."Tariff No.") { }

                field(dutyUnitConversion; Rec."Duty Unit Conversion") { }

                field(countryRegionPurchasedCode; Rec."Country/Region Purchased Code") { }

                field(budgetQuantity; Rec."Budget Quantity") { }

                field(budgetedAmount; Rec."Budgeted Amount") { }

                field(budgetProfit; Rec."Budget Profit") { }

                field(blocked; Rec."Blocked") { }

                field(blockReason; Rec."Block Reason") { }

                field(lastDateTimeModified; Rec."Last DateTime Modified") { }

                field(lastDateModified; Rec."Last Date Modified") { }

                field(lastTimeModified; Rec."Last Time Modified") { }

                field(priceIncludesVAT; Rec."Price Includes VAT") { }

                field(vatBusPostingGrPrice; Rec."VAT Bus. Posting Gr. (Price)") { }

                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group") { }

                field(picture; Rec."Picture") { }

                field(countryRegionOfOriginCode; Rec."Country/Region of Origin Code") { }

                field(automaticExtTexts; Rec."Automatic Ext. Texts") { }

                field(noSeries; Rec."No. Series") { }

                field(taxGroupCode; Rec."Tax Group Code") { }

                field(vatProdPostingGroup; Rec."VAT Prod. Posting Group") { }

                field(reserve; Rec."Reserve") { }

                field(globalDimension1Code; Rec."Global Dimension 1 Code") { }

                field(globalDimension2Code; Rec."Global Dimension 2 Code") { }

                field(stockoutWarning; Rec."Stockout Warning") { }

                field(preventNegativeInventory; Rec."Prevent Negative Inventory") { }

                field(variantMandatoryIfExists; Rec."Variant Mandatory if Exists") { }

                field(applicationWkshUserID; Rec."Application Wksh. User ID") { }

                field(assemblyPolicy; Rec."Assembly Policy") { }

                field(gtin; Rec."GTIN") { }

                field(defaultDeferralTemplateCode; Rec."Default Deferral Template Code") { }

                field(lowLevelCode; Rec."Low-Level Code") { }

                field(lotSize; Rec."Lot Size") { }

                field(serialNos; Rec."Serial Nos.") { }

                field(lastUnitCostCalcDate; Rec."Last Unit Cost Calc. Date") { }

                field(rolledUpMaterialCost; Rec."Rolled-up Material Cost") { }

                field(rolledUpCapacityCost; Rec."Rolled-up Capacity Cost") { }

                field(scrap; Rec."Scrap %") { }

                field(inventoryValueZero; Rec."Inventory Value Zero") { }

                field(discreteOrderQuantity; Rec."Discrete Order Quantity") { }

                field(minimumOrderQuantity; Rec."Minimum Order Quantity") { }

                field(maximumOrderQuantity; Rec."Maximum Order Quantity") { }

                field(safetyStockQuantity; Rec."Safety Stock Quantity") { }

                field(orderMultiple; Rec."Order Multiple") { }

                field(safetyLeadTime; Rec."Safety Lead Time") { }

                field(flushingMethod; Rec."Flushing Method") { }

                field(replenishmentSystem; Rec."Replenishment System") { }

                field(roundingPrecision; Rec."Rounding Precision") { }

                field(salesUnitOfMeasure; Rec."Sales Unit of Measure") { }

                field(purchUnitOfMeasure; Rec."Purch. Unit of Measure") { }

                field(timeBucket; Rec."Time Bucket") { }

                field(reorderingPolicy; Rec."Reordering Policy") { }

                field(includeInventory; Rec."Include Inventory") { }

                field(manufacturingPolicy; Rec."Manufacturing Policy") { }

                field(reschedulingPeriod; Rec."Rescheduling Period") { }

                field(lotAccumulationPeriod; Rec."Lot Accumulation Period") { }

                field(dampenerPeriod; Rec."Dampener Period") { }

                field(dampenerQuantity; Rec."Dampener Quantity") { }

                field(overflowLevel; Rec."Overflow Level") { }

                field(manufacturerCode; Rec."Manufacturer Code") { }

                field(itemCategoryCode; Rec."Item Category Code") { }

                field(createdFromNonstockItem; Rec."Created From Nonstock Item") { }

                field(purchasingCode; Rec."Purchasing Code") { }

                field(excludedFromCostAdjustment; Rec."Excluded from Cost Adjustment") { }

                field(serviceItemGroup; Rec."Service Item Group") { }

                field(itemTrackingCode; Rec."Item Tracking Code") { }

                field(lotNos; Rec."Lot Nos.") { }

                field(expirationCalculation; Rec."Expiration Calculation") { }

                field(warehouseClassCode; Rec."Warehouse Class Code") { }

                field(specialEquipmentCode; Rec."Special Equipment Code") { }

                field(putAwayTemplateCode; Rec."Put-away Template Code") { }

                field(putAwayUnitOfMeasureCode; Rec."Put-away Unit of Measure Code") { }

                field(physInvtCountingPeriodCode; Rec."Phys Invt Counting Period Code") { }

                field(lastCountingPeriodUpdate; Rec."Last Counting Period Update") { }

                field(useCrossDocking; Rec."Use Cross-Docking") { }

                field(nextCountingStartDate; Rec."Next Counting Start Date") { }

                field(nextCountingEndDate; Rec."Next Counting End Date") { }

                field(unitOfMeasureId; Rec."Unit of Measure Id") { }

                field(taxGroupId; Rec."Tax Group Id") { }

                field(salesBlocked; Rec."Sales Blocked") { }

                field(purchasingBlocked; Rec."Purchasing Blocked") { }

                field(itemCategoryId; Rec."Item Category Id") { }

                field(inventoryPostingGroupId; Rec."Inventory Posting Group Id") { }

                field(genProdPostingGroupId; Rec."Gen. Prod. Posting Group Id") { }

                field(serviceBlocked; Rec."Service Blocked") { }

                field(overReceiptCode; Rec."Over-Receipt Code") { }

                field(colManufacturerItemNo; Rec."COL Manufacturer Item No.") { }

                field(colExportClassificationCode; Rec."COL Export Classification Code") { }

                field(colEUClassificationNo; Rec."COL EU Classification No.") { }

                field(colUSClassificationNo; Rec."COL US Classification No.") { }

                field(colEURoHSDirCompliant; Rec."COL EU RoHS Dir. Compliant") { }

                field(colEUREACHRegCompliant; Rec."COL EU REACH Reg. Compliant") { }

                field(colMoistureSensitivityLevel; Rec."COL Moisture Sensitivity Level") { }

                field(colNATOStockNo; Rec."COL NATO Stock No.") { }

                field(colCreatedByUser; Rec."COL Created By User") { }

                field(colCreationDate; Rec."COL Creation Date") { }

                field(colItemConfigurationType; Rec."COL Item Configuration Type") { }

                field(colProductionBlocked; Rec."COL Production Blocked") { }

                field(colProjectBlocked; Rec."COL Project Blocked") { }

                field(colEURoHSStatus; Rec."COL EU RoHS Status") { }

                field(colStandardPlacingCode; Rec."COL Standard Placing Code") { }

                field(colPlanningBlocked; Rec."COL Planning Blocked") { }

                field(colMTBFNo; Rec."COL MTBF No.") { }

                field(colMTBFComment; Rec."COL MTBF Comment") { }

                field(colMTBFNo2; Rec."COL MTBF No. 2") { }

                field(colMTBFComment2; Rec."COL MTBF Comment 2") { }

                field(costTypePGS; Rec."Cost Type PGS") { }

                field(routingNo; Rec."Routing No.") { }

                field(productionBOMNo; Rec."Production BOM No.") { }

                field(singleLevelMaterialCost; Rec."Single-Level Material Cost") { }

                field(singleLevelCapacityCost; Rec."Single-Level Capacity Cost") { }

                field(singleLevelSubcontrdCost; Rec."Single-Level Subcontrd. Cost") { }

                field(singleLevelCapOvhdCost; Rec."Single-Level Cap. Ovhd Cost") { }

                field(singleLevelMfgOvhdCost; Rec."Single-Level Mfg. Ovhd Cost") { }

                field(overheadRate; Rec."Overhead Rate") { }

                field(rolledUpSubcontractedCost; Rec."Rolled-up Subcontracted Cost") { }

                field(rolledUpMfgOvhdCost; Rec."Rolled-up Mfg. Ovhd Cost") { }

                field(rolledUpCapOverheadCost; Rec."Rolled-up Cap. Overhead Cost") { }

                field(orderTrackingPolicy; Rec."Order Tracking Policy") { }

                field(critical; Rec."Critical") { }

                field(commonItemNo; Rec."Common Item No.") { }

                field(colManufacturer; Rec."COL Manufacturer") { }

                field(systemId; Rec.SystemId) { }

                field(systemCreatedAt; Rec."SystemCreatedAt") { }

                field(systemCreatedBy; Rec."SystemCreatedBy") { }

                field(systemModifiedAt; Rec."SystemModifiedAt") { }

                field(systemModifiedBy; Rec."SystemModifiedBy") { }
            }
        }
    }
}
