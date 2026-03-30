namespace Weibel.API;

using Microsoft.Inventory.Journal;

page 70258 "COL Item Journal Line API"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'itemJournalLine';
    EntitySetName = 'itemJournalLines';
    PageType = API;
    SourceTable = "Item Journal Line";
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
                field(journalTemplateName; Rec."Journal Template Name")
                {
                }
                field(lineNo; Rec."Line No.")
                {
                }
                field(itemNo; Rec."Item No.")
                {
                }
                field(postingDate; Rec."Posting Date")
                {
                }
                field(entryType; Rec."Entry Type")
                {
                }
                field(sourceNo; Rec."Source No.")
                {
                }
                field(documentNo; Rec."Document No.")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(locationCode; Rec."Location Code")
                {
                }
                field(inventoryPostingGroup; Rec."Inventory Posting Group")
                {
                }
                field(sourcePostingGroup; Rec."Source Posting Group")
                {
                }
                field(quantity; Rec.Quantity)
                {
                }
                field(invoicedQuantity; Rec."Invoiced Quantity")
                {
                }
                field(unitAmount; Rec."Unit Amount")
                {
                }
                field(unitCost; Rec."Unit Cost")
                {
                }
                field(amount; Rec.Amount)
                {
                }
                field(discountAmount; Rec."Discount Amount")
                {
                }
                field(salespersPurchCode; Rec."Salespers./Purch. Code")
                {
                }
                field(sourceCode; Rec."Source Code")
                {
                }
                field(appliesToEntry; Rec."Applies-to Entry")
                {
                }
                field(itemShptEntryNo; Rec."Item Shpt. Entry No.")
                {
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                }
                field(indirectCost; Rec."Indirect Cost %")
                {
                }
                field(sourceType; Rec."Source Type")
                {
                }
                field(shptMethodCode; Rec."Shpt. Method Code")
                {
                }
                field(journalBatchName; Rec."Journal Batch Name")
                {
                }
                field(reasonCode; Rec."Reason Code")
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
                field(dropShipment; Rec."Drop Shipment")
                {
                }
                field(transactionType; Rec."Transaction Type")
                {
                }
                field(transportMethod; Rec."Transport Method")
                {
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                }
                field(newLocationCode; Rec."New Location Code")
                {
                }
                field(newShortcutDimension1Code; Rec."New Shortcut Dimension 1 Code")
                {
                }
                field(newShortcutDimension2Code; Rec."New Shortcut Dimension 2 Code")
                {
                }
                field(qtyCalculated; Rec."Qty. (Calculated)")
                {
                }
                field(qtyPhysInventory; Rec."Qty. (Phys. Inventory)")
                {
                }
                field(lastItemLedgerEntryNo; Rec."Last Item Ledger Entry No.")
                {
                }
                field(physInventory; Rec."Phys. Inventory")
                {
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                }
                field(entryExitPoint; Rec."Entry/Exit Point")
                {
                }
                field(documentDate; Rec."Document Date")
                {
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                }
                field("area"; Rec."Area")
                {
                }
                field(transactionSpecification; Rec."Transaction Specification")
                {
                }
                field(postingNoSeries; Rec."Posting No. Series")
                {
                }
                field(reservedQuantity; Rec."Reserved Quantity")
                {
                }
                field(unitCostACY; Rec."Unit Cost (ACY)")
                {
                }
                field(sourceCurrencyCode; Rec."Source Currency Code")
                {
                }
                field(documentType; Rec."Document Type")
                {
                }
                field(documentLineNo; Rec."Document Line No.")
                {
                }
                field(vatReportingDate; Rec."VAT Reporting Date")
                {
                }
                field(orderType; Rec."Order Type")
                {
                }
                field(orderNo; Rec."Order No.")
                {
                }
                field(orderLineNo; Rec."Order Line No.")
                {
                }
                field(appliesToRemQuantity; Rec."Applies-to Rem. Quantity")
                {
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                }
                field(newDimensionSetID; Rec."New Dimension Set ID")
                {
                }
                field(assembleToOrder; Rec."Assemble to Order")
                {
                }
                field(jobNo; Rec."Job No.")
                {
                }
                field(jobTaskNo; Rec."Job Task No.")
                {
                }
                field(jobPurchase; Rec."Job Purchase")
                {
                }
                field(jobContractEntryNo; Rec."Job Contract Entry No.")
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
                field(newBinCode; Rec."New Bin Code")
                {
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                }
                field(derivedFromBlanketOrder; Rec."Derived from Blanket Order")
                {
                }
                field(qtyRoundingPrecision; Rec."Qty. Rounding Precision")
                {
                }
                field(qtyRoundingPrecisionBase; Rec."Qty. Rounding Precision (Base)")
                {
                }
                field(quantityBase; Rec."Quantity (Base)")
                {
                }
                field(invoicedQtyBase; Rec."Invoiced Qty. (Base)")
                {
                }
                field(reservedQtyBase; Rec."Reserved Qty. (Base)")
                {
                }
                field(level; Rec.Level)
                {
                }
                field(flushingMethod; Rec."Flushing Method")
                {
                }
                field(changedByUser; Rec."Changed by User")
                {
                }
                field(originallyOrderedNo; Rec."Originally Ordered No.")
                {
                }
                field(originallyOrderedVarCode; Rec."Originally Ordered Var. Code")
                {
                }
                field(outOfStockSubstitution; Rec."Out-of-Stock Substitution")
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
                field(itemReferenceNo; Rec."Item Reference No.")
                {
                }
                field(itemReferenceUnitOfMeasure; Rec."Item Reference Unit of Measure")
                {
                }
                field(itemReferenceType; Rec."Item Reference Type")
                {
                }
                field(itemReferenceTypeNo; Rec."Item Reference Type No.")
                {
                }
                field(plannedDeliveryDate; Rec."Planned Delivery Date")
                {
                }
                field(orderDate; Rec."Order Date")
                {
                }
                field(valueEntryType; Rec."Value Entry Type")
                {
                }
                field(itemChargeNo; Rec."Item Charge No.")
                {
                }
                field(inventoryValueCalculated; Rec."Inventory Value (Calculated)")
                {
                }
                field(inventoryValueRevalued; Rec."Inventory Value (Revalued)")
                {
                }
                field(varianceType; Rec."Variance Type")
                {
                }
                field(inventoryValuePer; Rec."Inventory Value Per")
                {
                }
                field(partialRevaluation; Rec."Partial Revaluation")
                {
                }
                field(appliesFromEntry; Rec."Applies-from Entry")
                {
                }
                field(invoiceNo; Rec."Invoice No.")
                {
                }
                field(unitCostCalculated; Rec."Unit Cost (Calculated)")
                {
                }
                field(unitCostRevalued; Rec."Unit Cost (Revalued)")
                {
                }
                field(appliedAmount; Rec."Applied Amount")
                {
                }
                field(updateStandardCost; Rec."Update Standard Cost")
                {
                }
                field(amountACY; Rec."Amount (ACY)")
                {
                }
                field(correction; Rec.Correction)
                {
                }
                field(adjustment; Rec.Adjustment)
                {
                }
                field(appliesToValueEntry; Rec."Applies-to Value Entry")
                {
                }
                field(invoiceToSourceNo; Rec."Invoice-to Source No.")
                {
                }
                field(type; Rec."Type")
                {
                }
                field(no; Rec."No.")
                {
                }
                field(operationNo; Rec."Operation No.")
                {
                }
                field(workCenterNo; Rec."Work Center No.")
                {
                }
                field(setupTime; Rec."Setup Time")
                {
                }
                field(runTime; Rec."Run Time")
                {
                }
                field(stopTime; Rec."Stop Time")
                {
                }
                field(outputQuantity; Rec."Output Quantity")
                {
                }
                field(scrapQuantity; Rec."Scrap Quantity")
                {
                }
                field(concurrentCapacity; Rec."Concurrent Capacity")
                {
                }
                field(setupTimeBase; Rec."Setup Time (Base)")
                {
                }
                field(runTimeBase; Rec."Run Time (Base)")
                {
                }
                field(stopTimeBase; Rec."Stop Time (Base)")
                {
                }
                field(outputQuantityBase; Rec."Output Quantity (Base)")
                {
                }
                field(scrapQuantityBase; Rec."Scrap Quantity (Base)")
                {
                }
                field(capUnitOfMeasureCode; Rec."Cap. Unit of Measure Code")
                {
                }
                field(qtyPerCapUnitOfMeasure; Rec."Qty. per Cap. Unit of Measure")
                {
                }
                field(startingTime; Rec."Starting Time")
                {
                }
                field(endingTime; Rec."Ending Time")
                {
                }
                field(routingNo; Rec."Routing No.")
                {
                }
                field(routingReferenceNo; Rec."Routing Reference No.")
                {
                }
                field(prodOrderCompLineNo; Rec."Prod. Order Comp. Line No.")
                {
                }
                field(finished; Rec.Finished)
                {
                }
                field(unitCostCalculation; Rec."Unit Cost Calculation")
                {
                }
                field(subcontracting; Rec.Subcontracting)
                {
                }
                field(stopCode; Rec."Stop Code")
                {
                }
                field(scrapCode; Rec."Scrap Code")
                {
                }
                field(workCenterGroupCode; Rec."Work Center Group Code")
                {
                }
                field(workShiftCode; Rec."Work Shift Code")
                {
                }
                field(serialNo; Rec."Serial No.")
                {
                }
                field(lotNo; Rec."Lot No.")
                {
                }
                field(warrantyDate; Rec."Warranty Date")
                {
                }
                field(newSerialNo; Rec."New Serial No.")
                {
                }
                field(newLotNo; Rec."New Lot No.")
                {
                }
                field(newItemExpirationDate; Rec."New Item Expiration Date")
                {
                }
                field(itemExpirationDate; Rec."Item Expiration Date")
                {
                }
                field(packageNo; Rec."Package No.")
                {
                }
                field(newPackageNo; Rec."New Package No.")
                {
                }
                field(returnReasonCode; Rec."Return Reason Code")
                {
                }
                field(priceCalculationMethod; Rec."Price Calculation Method")
                {
                }
                field(warehouseAdjustment; Rec."Warehouse Adjustment")
                {
                }
                field(directTransfer; Rec."Direct Transfer")
                {
                }
                field(physInvtCountingPeriodCode; Rec."Phys Invt Counting Period Code")
                {
                }
                field(physInvtCountingPeriodType; Rec."Phys Invt Counting Period Type")
                {
                }
                field(colExportClassificationCode; Rec."COL Export Classification Code")
                {
                }
                field(colKardexLogNo; Rec."COL Kardex Log No.")
                {
                }
                field(colKardexQuantity; Rec."COL Kardex Quantity")
                {
                }
                field(colLogiaUserID; Rec."COL Logia User ID")
                {
                }
                field(colKardexQuantityToConfirm; Rec."COL Kardex Quantity To Confirm")
                {
                }
                field(itemEntryNoPGS; Rec."Item Entry No. PGS")
                {
                }
                field(sourceRefPGS; Rec."Source Ref. PGS")
                {
                }
                field(overheadRate; Rec."Overhead Rate")
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
                field(rolledUpMaterialCost; Rec."Rolled-up Material Cost")
                {
                }
                field(rolledUpCapacityCost; Rec."Rolled-up Capacity Cost")
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
                field(singleLvlMatNonInvtCost; Rec."Single-Lvl Mat. Non-Invt. Cost")
                {
                }
                field(rolledUpMatNonInvtCost; Rec."Rolled-up Mat. Non-Invt. Cost")
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
