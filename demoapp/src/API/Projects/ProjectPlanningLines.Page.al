namespace Weibel.API;

using Microsoft.Projects.Project.Planning;

page 70152 "COL Project Planning Lines"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'projectPlanningLine';
    EntitySetName = 'projectPlanningLines';
    PageType = API;
    SourceTable = "Job Planning Line";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(lineNo; Rec."Line No.")
                {
                }
                field(jobNo; Rec."Job No.")
                {
                }
                field(planningDate; Rec."Planning Date")
                {
                }
                field(documentNo; Rec."Document No.")
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
                field(quantity; Rec.Quantity)
                {
                }
                field(directUnitCostLCY; Rec."Direct Unit Cost (LCY)")
                {
                }
                field(unitCostLCY; Rec."Unit Cost (LCY)")
                {
                }
                field(totalCostLCY; Rec."Total Cost (LCY)")
                {
                }
                field(unitPriceLCY; Rec."Unit Price (LCY)")
                {
                }
                field(totalPriceLCY; Rec."Total Price (LCY)")
                {
                }
                field(resourceGroupNo; Rec."Resource Group No.")
                {
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                }
                field(qtyRoundingPrecision; Rec."Qty. Rounding Precision")
                {
                }
                field(qtyRoundingPrecisionBase; Rec."Qty. Rounding Precision (Base)")
                {
                }
                field(locationCode; Rec."Location Code")
                {
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                }
                field("userID"; Rec."User ID")
                {
                }
                field(workTypeCode; Rec."Work Type Code")
                {
                }
                field(customerPriceGroup; Rec."Customer Price Group")
                {
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                }
                field(documentDate; Rec."Document Date")
                {
                }
                field(planningDueDate; Rec."Planning Due Date")
                {
                }
                field(qtyToAssemble; Rec."Qty. to Assemble")
                {
                }
                field(qtyToAssembleBase; Rec."Qty. to Assemble (Base)")
                {
                }
                field(assembleToOrder; Rec."Assemble to Order")
                {
                }
                field(bomItemNo; Rec."BOM Item No.")
                {
                }
                field(attachedToLineNo; Rec."Attached to Line No.")
                {
                }
                field(jobTaskNo; Rec."Job Task No.")
                {
                }
                field(lineAmountLCY; Rec."Line Amount (LCY)")
                {
                }
                field(unitCost; Rec."Unit Cost")
                {
                }
                field(totalCost; Rec."Total Cost")
                {
                }
                field(unitPrice; Rec."Unit Price")
                {
                }
                field(totalPrice; Rec."Total Price")
                {
                }
                field(lineAmount; Rec."Line Amount")
                {
                }
                field(lineDiscountAmount; Rec."Line Discount Amount")
                {
                }
                field(lineDiscountAmountLCY; Rec."Line Discount Amount (LCY)")
                {
                }
                field(costFactor; Rec."Cost Factor")
                {
                }
                field(serialNo; Rec."Serial No.")
                {
                }
                field(lotNo; Rec."Lot No.")
                {
                }
                field(lineDiscount; Rec."Line Discount %")
                {
                }
                field(lineType; Rec."Line Type")
                {
                }
                field(currencyCode; Rec."Currency Code")
                {
                }
                field(currencyDate; Rec."Currency Date")
                {
                }
                field(currencyFactor; Rec."Currency Factor")
                {
                }
                field(scheduleLine; Rec."Schedule Line")
                {
                }
                field(contractLine; Rec."Contract Line")
                {
                }
                field(jobContractEntryNo; Rec."Job Contract Entry No.")
                {
                }
                field(invoicedAmountLCY; Rec."Invoiced Amount (LCY)")
                {
                }
                field(invoicedCostAmountLCY; Rec."Invoiced Cost Amount (LCY)")
                {
                }
                field(vatUnitPrice; Rec."VAT Unit Price")
                {
                }
                field(vatLineDiscountAmount; Rec."VAT Line Discount Amount")
                {
                }
                field(vatLineAmount; Rec."VAT Line Amount")
                {
                }
                field(vat; Rec."VAT %")
                {
                }
                field(description2; Rec."Description 2")
                {
                }
                field(jobLedgerEntryNo; Rec."Job Ledger Entry No.")
                {
                }
                field(status; Rec.Status)
                {
                }
                field(ledgerEntryType; Rec."Ledger Entry Type")
                {
                }
                field(ledgerEntryNo; Rec."Ledger Entry No.")
                {
                }
                field(systemCreatedEntry; Rec."System-Created Entry")
                {
                }
                field(usageLink; Rec."Usage Link")
                {
                }
                field(remainingQty; Rec."Remaining Qty.")
                {
                }
                field(remainingQtyBase; Rec."Remaining Qty. (Base)")
                {
                }
                field(remainingTotalCost; Rec."Remaining Total Cost")
                {
                }
                field(remainingTotalCostLCY; Rec."Remaining Total Cost (LCY)")
                {
                }
                field(remainingLineAmount; Rec."Remaining Line Amount")
                {
                }
                field(remainingLineAmountLCY; Rec."Remaining Line Amount (LCY)")
                {
                }
                field(qtyPosted; Rec."Qty. Posted")
                {
                }
                field(qtyToTransferToJournal; Rec."Qty. to Transfer to Journal")
                {
                }
                field(postedTotalCost; Rec."Posted Total Cost")
                {
                }
                field(postedTotalCostLCY; Rec."Posted Total Cost (LCY)")
                {
                }
                field(postedLineAmount; Rec."Posted Line Amount")
                {
                }
                field(postedLineAmountLCY; Rec."Posted Line Amount (LCY)")
                {
                }
                field(qtyTransferredToInvoice; Rec."Qty. Transferred to Invoice")
                {
                }
                field(qtyToTransferToInvoice; Rec."Qty. to Transfer to Invoice")
                {
                }
                field(qtyInvoiced; Rec."Qty. Invoiced")
                {
                }
                field(qtyToInvoice; Rec."Qty. to Invoice")
                {
                }
                field(reservedQuantity; Rec."Reserved Quantity")
                {
                }
                field(reservedQtyBase; Rec."Reserved Qty. (Base)")
                {
                }
                field(reserve; Rec.Reserve)
                {
                }
                field(planned; Rec.Planned)
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
                field(quantityBase; Rec."Quantity (Base)")
                {
                }
                field(requestedDeliveryDate; Rec."Requested Delivery Date")
                {
                }
                field(promisedDeliveryDate; Rec."Promised Delivery Date")
                {
                }
                field(plannedDeliveryDate; Rec."Planned Delivery Date")
                {
                }
                field(serviceOrderNo; Rec."Service Order No.")
                {
                }
                field(packageNo; Rec."Package No.")
                {
                }
                field(priceCalculationMethod; Rec."Price Calculation Method")
                {
                }
                field(costCalculationMethod; Rec."Cost Calculation Method")
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
                field(qtyOnJournal; Rec."Qty. on Journal")
                {
                }
                field(colPlanningApproved; Rec."COL Planning Approved")
                {
                }
                field(colItemLeadTimeCalculation; Rec."COL Item Lead Time Calculation")
                {
                }
                field(colPOPlannedReceiptDate; Rec."COL PO Planned Receipt Date")
                {
                }
                field(colPOExpectedReceiptDate; Rec."COL PO Expected Receipt Date")
                {
                }
                field(colNo; Rec."COL No.")
                {
                }
                field(colSOShipmentDate; Rec."COL SO Shipment Date")
                {
                }
                field(colAssemblyBOM; Rec."COL Assembly BOM")
                {
                }
                field(vendorNoPGS; Rec."Vendor No. PGS")
                {
                }
                field(vendorNamePGS; Rec."Vendor Name PGS")
                {
                }
                field(purchaseOrderNoPGS; Rec."Purchase Order No. PGS")
                {
                }
                field(purchaseOrderLineNoPGS; Rec."Purchase Order Line No. PGS")
                {
                }
                field(purchaseOrderActionPGS; Rec."Purchase Order Action PGS")
                {
                }
                field(purchaseOrderStatusPGS; Rec."Purchase Order Status PGS")
                {
                }
                field(budgetEntryNoPGS; Rec."Budget Entry No. PGS")
                {
                }
                field(budgetVersionPGS; Rec."Budget Version PGS")
                {
                }
                field(expenseCodePGS; Rec."Expense Code PGS")
                {
                }
                field(expensePaymentTypePGS; Rec."Expense Payment Type PGS")
                {
                }
                field(salesOrderNoPGS; Rec."Sales Order No. PGS")
                {
                }
                field(salesOrderLineNoPGS; Rec."Sales Order Line No. PGS")
                {
                }
                field(salesOrderActionPGS; Rec."Sales Order Action PGS")
                {
                }
                field(shipmentDatePGS; Rec."Shipment Date PGS")
                {
                }
                field(salesOrderStatusPGS; Rec."Sales Order Status PGS")
                {
                }
                field(customerNoPGS; Rec."Customer No. PGS")
                {
                }
                field(customerNamePGS; Rec."Customer Name PGS")
                {
                }
                field(linkedPGS; Rec."Linked PGS")
                {
                }
                field(originalBudgetDatePGS; Rec."Original Budget Date PGS")
                {
                }
                field(originalBudgetTypePGS; Rec."Original Budget Type PGS")
                {
                }
                field(originalBudgetNoPGS; Rec."Original Budget No. PGS")
                {
                }
                field(originalBudgetCurrencyPGS; Rec."Original Budget Currency PGS")
                {
                }
                field(dimensionSetIDPGS; Rec."Dimension Set ID PGS")
                {
                }
                field(shortcutDimension1CodePGS; Rec."Shortcut Dimension 1 Code PGS")
                {
                }
                field(shortcutDimension2CodePGS; Rec."Shortcut Dimension 2 Code PGS")
                {
                }
                field(salesOrderErrorPGS; Rec."Sales Order Error PGS")
                {
                }
                field(purchOrderErrorPGS; Rec."Purch Order Error PGS")
                {
                }
                field(qtyToTransferPGS; Rec."Qty. to Transfer PGS")
                {
                }
                field(usageQtyPostedPGS; Rec."Usage Qty. Posted PGS")
                {
                }
                field(linkedBudgetExistsPGS; Rec."Linked Budget Exists PGS")
                {
                }
                field(replenishmentTypePGS; Rec."Replenishment Type PGS")
                {
                }
                field(replenishmentDocumentNoPGS; Rec."Replenishment Document No. PGS")
                {
                }
                field(planningStatusPGS; Rec."Planning Status. PGS")
                {
                }
                field(prodOrderStatusPGS; Rec."Prod Order Status PGS")
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
