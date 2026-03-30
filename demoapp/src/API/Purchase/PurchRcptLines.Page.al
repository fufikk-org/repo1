namespace Weibel.API;

using Microsoft.Purchases.History;

page 70248 "COL Purch. Rcpt. Lines"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'purchRcptLine';
    EntitySetName = 'purchRcptLines';
    PageType = API;
    SourceTable = "Purch. Rcpt. Line";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(buyFromVendorNo; Rec."Buy-from Vendor No.")
                {
                }
                field(documentNo; Rec."Document No.")
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
                field(locationCode; Rec."Location Code")
                {
                }
                field(postingGroup; Rec."Posting Group")
                {
                }
                field(expectedReceiptDate; Rec."Expected Receipt Date")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(description2; Rec."Description 2")
                {
                }
                field(unitOfMeasure; Rec."Unit of Measure")
                {
                }
                field(quantity; Rec.Quantity)
                {
                }
                field(directUnitCost; Rec."Direct Unit Cost")
                {
                }
                field(unitCostLCY; Rec."Unit Cost (LCY)")
                {
                }
                field(vat; Rec."VAT %")
                {
                }
                field(lineDiscount; Rec."Line Discount %")
                {
                }
                field(unitPriceLCY; Rec."Unit Price (LCY)")
                {
                }
                field(allowInvoiceDisc; Rec."Allow Invoice Disc.")
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
                field(applToItemEntry; Rec."Appl.-to Item Entry")
                {
                }
                field(itemRcptEntryNo; Rec."Item Rcpt. Entry No.")
                {
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                }
                field(jobNo; Rec."Job No.")
                {
                }
                field(indirectCost; Rec."Indirect Cost %")
                {
                }
                field(qtyRcdNotInvoiced; Rec."Qty. Rcd. Not Invoiced")
                {
                }
                field(quantityInvoiced; Rec."Quantity Invoiced")
                {
                }
                field(orderNo; Rec."Order No.")
                {
                }
                field(orderLineNo; Rec."Order Line No.")
                {
                }
                field(payToVendorNo; Rec."Pay-to Vendor No.")
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
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                }
                field(vatCalculationType; Rec."VAT Calculation Type")
                {
                }
                field(transactionType; Rec."Transaction Type")
                {
                }
                field(transportMethod; Rec."Transport Method")
                {
                }
                field(attachedToLineNo; Rec."Attached to Line No.")
                {
                }
                field(entryPoint; Rec."Entry Point")
                {
                }
                field("area"; Rec."Area")
                {
                }
                field(transactionSpecification; Rec."Transaction Specification")
                {
                }
                field(taxAreaCode; Rec."Tax Area Code")
                {
                }
                field(taxLiable; Rec."Tax Liable")
                {
                }
                field(taxGroupCode; Rec."Tax Group Code")
                {
                }
                field(useTax; Rec."Use Tax")
                {
                }
                field(vatBusPostingGroup; Rec."VAT Bus. Posting Group")
                {
                }
                field(vatProdPostingGroup; Rec."VAT Prod. Posting Group")
                {
                }
                field(currencyCode; Rec."Currency Code")
                {
                }
                field(blanketOrderNo; Rec."Blanket Order No.")
                {
                }
                field(blanketOrderLineNo; Rec."Blanket Order Line No.")
                {
                }
                field(vatBaseAmount; Rec."VAT Base Amount")
                {
                }
                field(unitCost; Rec."Unit Cost")
                {
                }
                field(icPartnerRefType; Rec."IC Partner Ref. Type")
                {
                }
                field(icPartnerReference; Rec."IC Partner Reference")
                {
                }
                field(postingDate; Rec."Posting Date")
                {
                }
                field(icItemReferenceNo; Rec."IC Item Reference No.")
                {
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                }
                field(jobTaskNo; Rec."Job Task No.")
                {
                }
                field(jobLineType; Rec."Job Line Type")
                {
                }
                field(jobUnitPrice; Rec."Job Unit Price")
                {
                }
                field(jobTotalPrice; Rec."Job Total Price")
                {
                }
                field(jobLineAmount; Rec."Job Line Amount")
                {
                }
                field(jobLineDiscountAmount; Rec."Job Line Discount Amount")
                {
                }
                field(jobLineDiscount; Rec."Job Line Discount %")
                {
                }
                field(jobUnitPriceLCY; Rec."Job Unit Price (LCY)")
                {
                }
                field(jobTotalPriceLCY; Rec."Job Total Price (LCY)")
                {
                }
                field(jobLineAmountLCY; Rec."Job Line Amount (LCY)")
                {
                }
                field(jobLineDiscAmountLCY; Rec."Job Line Disc. Amount (LCY)")
                {
                }
                field(jobCurrencyFactor; Rec."Job Currency Factor")
                {
                }
                field(jobCurrencyCode; Rec."Job Currency Code")
                {
                }
                field(jobPlanningLineNo; Rec."Job Planning Line No.")
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
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                }
                field(quantityBase; Rec."Quantity (Base)")
                {
                }
                field(qtyInvoicedBase; Rec."Qty. Invoiced (Base)")
                {
                }
                field(faPostingDate; Rec."FA Posting Date")
                {
                }
                field(faPostingType; Rec."FA Posting Type")
                {
                }
                field(depreciationBookCode; Rec."Depreciation Book Code")
                {
                }
                field(salvageValue; Rec."Salvage Value")
                {
                }
                field(deprUntilFAPostingDate; Rec."Depr. until FA Posting Date")
                {
                }
                field(deprAcquisitionCost; Rec."Depr. Acquisition Cost")
                {
                }
                field(maintenanceCode; Rec."Maintenance Code")
                {
                }
                field(insuranceNo; Rec."Insurance No.")
                {
                }
                field(budgetedFANo; Rec."Budgeted FA No.")
                {
                }
                field(duplicateInDepreciationBook; Rec."Duplicate in Depreciation Book")
                {
                }
                field(useDuplicationList; Rec."Use Duplication List")
                {
                }
                field(responsibilityCenter; Rec."Responsibility Center")
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
                field(specialOrderSalesNo; Rec."Special Order Sales No.")
                {
                }
                field(specialOrderSalesLineNo; Rec."Special Order Sales Line No.")
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
                field(requestedReceiptDate; Rec."Requested Receipt Date")
                {
                }
                field(promisedReceiptDate; Rec."Promised Receipt Date")
                {
                }
                field(leadTimeCalculation; Rec."Lead Time Calculation")
                {
                }
                field(inboundWhseHandlingTime; Rec."Inbound Whse. Handling Time")
                {
                }
                field(plannedReceiptDate; Rec."Planned Receipt Date")
                {
                }
                field(orderDate; Rec."Order Date")
                {
                }
                field(itemChargeBaseAmount; Rec."Item Charge Base Amount")
                {
                }
                field(correction; Rec.Correction)
                {
                }
                field(returnReasonCode; Rec."Return Reason Code")
                {
                }
                field(priceCalculationMethod; Rec."Price Calculation Method")
                {
                }
                field(documentId; Rec."Document Id")
                {
                }
                field(overReceiptQuantity; Rec."Over-Receipt Quantity")
                {
                }
                field(overReceiptCode2; Rec."Over-Receipt Code 2")
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