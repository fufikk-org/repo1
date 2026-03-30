namespace Weibel.API;

using Microsoft.Purchases.Archive;

page 70232 "COL Purchase Line Archives"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'purchaseLineArchive';
    EntitySetName = 'purchaseLineArchives';
    PageType = API;
    SourceTable = "Purchase Line Archive";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'SystemId', Locked = true;
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type', Locked = true;
                }
                field(buyFromVendorNo; Rec."Buy-from Vendor No.")
                {
                    Caption = 'Buy-from Vendor No.', Locked = true;
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.', Locked = true;
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.', Locked = true;
                }
                field(type; Rec."Type")
                {
                    Caption = 'Type', Locked = true;
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.', Locked = true;
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code', Locked = true;
                }
                field(postingGroup; Rec."Posting Group")
                {
                    Caption = 'Posting Group', Locked = true;
                }
                field(expectedReceiptDate; Rec."Expected Receipt Date")
                {
                    Caption = 'Expected Receipt Date', Locked = true;
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description', Locked = true;
                }
                field(description2; Rec."Description 2")
                {
                    Caption = 'Description 2', Locked = true;
                }
                field(unitOfMeasure; Rec."Unit of Measure")
                {
                    Caption = 'Unit of Measure', Locked = true;
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity', Locked = true;
                }
                field(outstandingQuantity; Rec."Outstanding Quantity")
                {
                    Caption = 'Outstanding Quantity', Locked = true;
                }
                field(qtyToInvoice; Rec."Qty. to Invoice")
                {
                    Caption = 'Qty. to Invoice', Locked = true;
                }
                field(qtyToReceive; Rec."Qty. to Receive")
                {
                    Caption = 'Qty. to Receive', Locked = true;
                }
                field(directUnitCost; Rec."Direct Unit Cost")
                {
                    Caption = 'Direct Unit Cost', Locked = true;
                }
                field(unitCostLCY; Rec."Unit Cost (LCY)")
                {
                    Caption = 'Unit Cost (LCY)', Locked = true;
                }
                field(vat; Rec."VAT %")
                {
                    Caption = 'VAT %', Locked = true;
                }
                field(lineDiscount; Rec."Line Discount %")
                {
                    Caption = 'Line Discount %', Locked = true;
                }
                field(lineDiscountAmount; Rec."Line Discount Amount")
                {
                    Caption = 'Line Discount Amount', Locked = true;
                }
                field(amount; Rec.Amount)
                {
                    Caption = 'Amount', Locked = true;
                }
                field(amountIncludingVAT; Rec."Amount Including VAT")
                {
                    Caption = 'Amount Including VAT', Locked = true;
                }
                field(unitPriceLCY; Rec."Unit Price (LCY)")
                {
                    Caption = 'Unit Price (LCY)', Locked = true;
                }
                field(allowInvoiceDisc; Rec."Allow Invoice Disc.")
                {
                    Caption = 'Allow Invoice Disc.', Locked = true;
                }
                field(grossWeight; Rec."Gross Weight")
                {
                    Caption = 'Gross Weight', Locked = true;
                }
                field(netWeight; Rec."Net Weight")
                {
                    Caption = 'Net Weight', Locked = true;
                }
                field(unitsPerParcel; Rec."Units per Parcel")
                {
                    Caption = 'Units per Parcel', Locked = true;
                }
                field(unitVolume; Rec."Unit Volume")
                {
                    Caption = 'Unit Volume', Locked = true;
                }
                field(applToItemEntry; Rec."Appl.-to Item Entry")
                {
                    Caption = 'Appl.-to Item Entry', Locked = true;
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code', Locked = true;
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code', Locked = true;
                }
                field(jobNo; Rec."Job No.")
                {
                    Caption = 'Project No.', Locked = true;
                }
                field(indirectCost; Rec."Indirect Cost %")
                {
                    Caption = 'Indirect Cost %', Locked = true;
                }
                field(outstandingAmount; Rec."Outstanding Amount")
                {
                    Caption = 'Outstanding Amount', Locked = true;
                }
                field(qtyRcdNotInvoiced; Rec."Qty. Rcd. Not Invoiced")
                {
                    Caption = 'Qty. Rcd. Not Invoiced', Locked = true;
                }
                field(amtRcdNotInvoiced; Rec."Amt. Rcd. Not Invoiced")
                {
                    Caption = 'Amt. Rcd. Not Invoiced', Locked = true;
                }
                field(quantityReceived; Rec."Quantity Received")
                {
                    Caption = 'Quantity Received', Locked = true;
                }
                field(quantityInvoiced; Rec."Quantity Invoiced")
                {
                    Caption = 'Quantity Invoiced', Locked = true;
                }
                field(receiptNo; Rec."Receipt No.")
                {
                    Caption = 'Receipt No.', Locked = true;
                }
                field(receiptLineNo; Rec."Receipt Line No.")
                {
                    Caption = 'Receipt Line No.', Locked = true;
                }
                field(profit; Rec."Profit %")
                {
                    Caption = 'Profit %', Locked = true;
                }
                field(payToVendorNo; Rec."Pay-to Vendor No.")
                {
                    Caption = 'Pay-to Vendor No.', Locked = true;
                }
                field(invDiscountAmount; Rec."Inv. Discount Amount")
                {
                    Caption = 'Inv. Discount Amount', Locked = true;
                }
                field(vendorItemNo; Rec."Vendor Item No.")
                {
                    Caption = 'Vendor Item No.', Locked = true;
                }
                field(salesOrderNo; Rec."Sales Order No.")
                {
                    Caption = 'Sales Order No.', Locked = true;
                }
                field(salesOrderLineNo; Rec."Sales Order Line No.")
                {
                    Caption = 'Sales Order Line No.', Locked = true;
                }
                field(dropShipment; Rec."Drop Shipment")
                {
                    Caption = 'Drop Shipment', Locked = true;
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    Caption = 'Gen. Bus. Posting Group', Locked = true;
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                    Caption = 'Gen. Prod. Posting Group', Locked = true;
                }
                field(vatCalculationType; Rec."VAT Calculation Type")
                {
                    Caption = 'VAT Calculation Type', Locked = true;
                }
                field(transactionType; Rec."Transaction Type")
                {
                    Caption = 'Transaction Type', Locked = true;
                }
                field(transportMethod; Rec."Transport Method")
                {
                    Caption = 'Transport Method', Locked = true;
                }
                field(attachedToLineNo; Rec."Attached to Line No.")
                {
                    Caption = 'Attached to Line No.', Locked = true;
                }
                field(entryPoint; Rec."Entry Point")
                {
                    Caption = 'Entry Point', Locked = true;
                }
                field("area"; Rec."Area")
                {
                    Caption = 'Area', Locked = true;
                }
                field(transactionSpecification; Rec."Transaction Specification")
                {
                    Caption = 'Transaction Specification', Locked = true;
                }
                field(taxAreaCode; Rec."Tax Area Code")
                {
                    Caption = 'Tax Area Code', Locked = true;
                }
                field(taxLiable; Rec."Tax Liable")
                {
                    Caption = 'Tax Liable', Locked = true;
                }
                field(taxGroupCode; Rec."Tax Group Code")
                {
                    Caption = 'Tax Group Code', Locked = true;
                }
                field(useTax; Rec."Use Tax")
                {
                    Caption = 'Use Tax', Locked = true;
                }
                field(vatBusPostingGroup; Rec."VAT Bus. Posting Group")
                {
                    Caption = 'VAT Bus. Posting Group', Locked = true;
                }
                field(vatProdPostingGroup; Rec."VAT Prod. Posting Group")
                {
                    Caption = 'VAT Prod. Posting Group', Locked = true;
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code', Locked = true;
                }
                field(outstandingAmountLCY; Rec."Outstanding Amount (LCY)")
                {
                    Caption = 'Outstanding Amount (LCY)', Locked = true;
                }
                field(amtRcdNotInvoicedLCY; Rec."Amt. Rcd. Not Invoiced (LCY)")
                {
                    Caption = 'Amt. Rcd. Not Invoiced (LCY)', Locked = true;
                }

                field(blanketOrderNo; Rec."Blanket Order No.")
                {
                    Caption = 'Blanket Order No.', Locked = true;
                }
                field(blanketOrderLineNo; Rec."Blanket Order Line No.")
                {
                    Caption = 'Blanket Order Line No.', Locked = true;
                }
                field(vatBaseAmount; Rec."VAT Base Amount")
                {
                    Caption = 'VAT Base Amount', Locked = true;
                }
                field(unitCost; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost', Locked = true;
                }
                field(systemCreatedEntry; Rec."System-Created Entry")
                {
                    Caption = 'System-Created Entry', Locked = true;
                }
                field(lineAmount; Rec."Line Amount")
                {
                    Caption = 'Line Amount', Locked = true;
                }
                field(vatDifference; Rec."VAT Difference")
                {
                    Caption = 'VAT Difference', Locked = true;
                }
                field(invDiscAmountToInvoice; Rec."Inv. Disc. Amount to Invoice")
                {
                    Caption = 'Inv. Disc. Amount to Invoice', Locked = true;
                }
                field(vatIdentifier; Rec."VAT Identifier")
                {
                    Caption = 'VAT Identifier', Locked = true;
                }
                field(icPartnerRefType; Rec."IC Partner Ref. Type")
                {
                    Caption = 'IC Partner Ref. Type', Locked = true;
                }
                field(icPartnerReference; Rec."IC Partner Reference")
                {
                    Caption = 'IC Partner Reference', Locked = true;
                }
                field(prepayment; Rec."Prepayment %")
                {
                    Caption = 'Prepayment %', Locked = true;
                }
                field(prepmtLineAmount; Rec."Prepmt. Line Amount")
                {
                    Caption = 'Prepmt. Line Amount', Locked = true;
                }
                field(prepmtAmtInv; Rec."Prepmt. Amt. Inv.")
                {
                    Caption = 'Prepmt. Amt. Inv.', Locked = true;
                }
                field(prepmtAmtInclVAT; Rec."Prepmt. Amt. Incl. VAT")
                {
                    Caption = 'Prepmt. Amt. Incl. VAT', Locked = true;
                }
                field(prepaymentAmount; Rec."Prepayment Amount")
                {
                    Caption = 'Prepayment Amount', Locked = true;
                }
                field(prepmtVATBaseAmt; Rec."Prepmt. VAT Base Amt.")
                {
                    Caption = 'Prepmt. VAT Base Amt.', Locked = true;
                }
                field(prepaymentVAT; Rec."Prepayment VAT %")
                {
                    Caption = 'Prepayment VAT %', Locked = true;
                }
                field(prepmtVATCalcType; Rec."Prepmt. VAT Calc. Type")
                {
                    Caption = 'Prepmt. VAT Calc. Type', Locked = true;
                }
                field(prepaymentVATIdentifier; Rec."Prepayment VAT Identifier")
                {
                    Caption = 'Prepayment VAT Identifier', Locked = true;
                }
                field(prepaymentTaxAreaCode; Rec."Prepayment Tax Area Code")
                {
                    Caption = 'Prepayment Tax Area Code', Locked = true;
                }
                field(prepaymentTaxLiable; Rec."Prepayment Tax Liable")
                {
                    Caption = 'Prepayment Tax Liable', Locked = true;
                }
                field(prepaymentTaxGroupCode; Rec."Prepayment Tax Group Code")
                {
                    Caption = 'Prepayment Tax Group Code', Locked = true;
                }
                field(prepmtAmtToDeduct; Rec."Prepmt Amt to Deduct")
                {
                    Caption = 'Prepmt Amt to Deduct', Locked = true;
                }
                field(prepmtAmtDeducted; Rec."Prepmt Amt Deducted")
                {
                    Caption = 'Prepmt Amt Deducted', Locked = true;
                }
                field(prepaymentLine; Rec."Prepayment Line")
                {
                    Caption = 'Prepayment Line', Locked = true;
                }
                field(prepmtAmountInvInclVAT; Rec."Prepmt. Amount Inv. Incl. VAT")
                {
                    Caption = 'Prepmt. Amount Inv. Incl. VAT', Locked = true;
                }
                field(icPartnerCode; Rec."IC Partner Code")
                {
                    Caption = 'IC Partner Code', Locked = true;
                }
                field(icItemReferenceNo; Rec."IC Item Reference No.")
                {
                    Caption = 'IC Item Reference No.', Locked = true;
                }
                field(pmtDiscountAmount; Rec."Pmt. Discount Amount")
                {
                    Caption = 'Pmt. Discount Amount', Locked = true;
                }

                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID', Locked = true;
                }
                field(jobTaskNo; Rec."Job Task No.")
                {
                    Caption = 'Project Task No.', Locked = true;
                }
                field(jobLineType; Rec."Job Line Type")
                {
                    Caption = 'Project Line Type', Locked = true;
                }
                field(jobUnitPrice; Rec."Job Unit Price")
                {
                    Caption = 'Project Unit Price', Locked = true;
                }
                field(jobTotalPrice; Rec."Job Total Price")
                {
                    Caption = 'Project Total Price', Locked = true;
                }
                field(jobLineAmount; Rec."Job Line Amount")
                {
                    Caption = 'Project Line Amount', Locked = true;
                }
                field(jobLineDiscountAmount; Rec."Job Line Discount Amount")
                {
                    Caption = 'Project Line Discount Amount', Locked = true;
                }
                field(jobLineDiscount; Rec."Job Line Discount %")
                {
                    Caption = 'Project Line Discount %', Locked = true;
                }
                field(jobUnitPriceLCY; Rec."Job Unit Price (LCY)")
                {
                    Caption = 'Project Unit Price (LCY)', Locked = true;
                }
                field(jobTotalPriceLCY; Rec."Job Total Price (LCY)")
                {
                    Caption = 'Project Total Price (LCY)', Locked = true;
                }
                field(jobLineAmountLCY; Rec."Job Line Amount (LCY)")
                {
                    Caption = 'Project Line Amount (LCY)', Locked = true;
                }
                field(jobLineDiscAmountLCY; Rec."Job Line Disc. Amount (LCY)")
                {
                    Caption = 'Project Line Disc. Amount (LCY)', Locked = true;
                }
                field(jobCurrencyFactor; Rec."Job Currency Factor")
                {
                    Caption = 'Project Currency Factor', Locked = true;
                }
                field(jobCurrencyCode; Rec."Job Currency Code")
                {
                    Caption = 'Project Currency Code', Locked = true;
                }
                field(jobPlanningLineNo; Rec."Job Planning Line No.")
                {
                    Caption = 'Project Planning Line No.', Locked = true;
                }
                field(jobRemainingQty; Rec."Job Remaining Qty.")
                {
                    Caption = 'Project Remaining Qty.', Locked = true;
                }
                field(jobRemainingQtyBase; Rec."Job Remaining Qty. (Base)")
                {
                    Caption = 'Project Remaining Qty. (Base)', Locked = true;
                }
                field(deferralCode; Rec."Deferral Code")
                {
                    Caption = 'Deferral Code', Locked = true;
                }
                field(returnsDeferralStartDate; Rec."Returns Deferral Start Date")
                {
                    Caption = 'Returns Deferral Start Date', Locked = true;
                }
                field(prodOrderNo; Rec."Prod. Order No.")
                {
                    Caption = 'Prod. Order No.', Locked = true;
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code', Locked = true;
                }
                field(binCode; Rec."Bin Code")
                {
                    Caption = 'Bin Code', Locked = true;
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                    Caption = 'Qty. per Unit of Measure', Locked = true;
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code', Locked = true;
                }
                field(quantityBase; Rec."Quantity (Base)")
                {
                    Caption = 'Quantity (Base)', Locked = true;
                }
                field(outstandingQtyBase; Rec."Outstanding Qty. (Base)")
                {
                    Caption = 'Outstanding Qty. (Base)', Locked = true;
                }
                field(qtyToInvoiceBase; Rec."Qty. to Invoice (Base)")
                {
                    Caption = 'Qty. to Invoice (Base)', Locked = true;
                }
                field(qtyToReceiveBase; Rec."Qty. to Receive (Base)")
                {
                    Caption = 'Qty. to Receive (Base)', Locked = true;
                }
                field(qtyRcdNotInvoicedBase; Rec."Qty. Rcd. Not Invoiced (Base)")
                {
                    Caption = 'Qty. Rcd. Not Invoiced (Base)', Locked = true;
                }
                field(qtyReceivedBase; Rec."Qty. Received (Base)")
                {
                    Caption = 'Qty. Received (Base)', Locked = true;
                }
                field(qtyInvoicedBase; Rec."Qty. Invoiced (Base)")
                {
                    Caption = 'Qty. Invoiced (Base)', Locked = true;
                }
                field(faPostingDate; Rec."FA Posting Date")
                {
                    Caption = 'FA Posting Date', Locked = true;
                }
                field(faPostingType; Rec."FA Posting Type")
                {
                    Caption = 'FA Posting Type', Locked = true;
                }
                field(depreciationBookCode; Rec."Depreciation Book Code")
                {
                    Caption = 'Depreciation Book Code', Locked = true;
                }
                field(salvageValue; Rec."Salvage Value")
                {
                    Caption = 'Salvage Value', Locked = true;
                }
                field(deprUntilFAPostingDate; Rec."Depr. until FA Posting Date")
                {
                    Caption = 'Depr. until FA Posting Date', Locked = true;
                }
                field(deprAcquisitionCost; Rec."Depr. Acquisition Cost")
                {
                    Caption = 'Depr. Acquisition Cost', Locked = true;
                }
                field(maintenanceCode; Rec."Maintenance Code")
                {
                    Caption = 'Maintenance Code', Locked = true;
                }
                field(insuranceNo; Rec."Insurance No.")
                {
                    Caption = 'Insurance No.', Locked = true;
                }
                field(budgetedFANo; Rec."Budgeted FA No.")
                {
                    Caption = 'Budgeted FA No.', Locked = true;
                }
                field(duplicateInDepreciationBook; Rec."Duplicate in Depreciation Book")
                {
                    Caption = 'Duplicate in Depreciation Book', Locked = true;
                }
                field(useDuplicationList; Rec."Use Duplication List")
                {
                    Caption = 'Use Duplication List', Locked = true;
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center', Locked = true;
                }
                field(itemCategoryCode; Rec."Item Category Code")
                {
                    Caption = 'Item Category Code', Locked = true;
                }
                field(nonstock; Rec.Nonstock)
                {
                    Caption = 'Catalog', Locked = true;
                }
                field(purchasingCode; Rec."Purchasing Code")
                {
                    Caption = 'Purchasing Code', Locked = true;
                }
                field(specialOrder; Rec."Special Order")
                {
                    Caption = 'Special Order', Locked = true;
                }
                field(specialOrderSalesNo; Rec."Special Order Sales No.")
                {
                    Caption = 'Special Order Sales No.', Locked = true;
                }
                field(specialOrderSalesLineNo; Rec."Special Order Sales Line No.")
                {
                    Caption = 'Special Order Sales Line No.', Locked = true;
                }
                field(itemReferenceNo; Rec."Item Reference No.")
                {
                    Caption = 'Item Reference No.', Locked = true;
                }
                field(itemReferenceUnitOfMeasure; Rec."Item Reference Unit of Measure")
                {
                    Caption = 'Item Reference Unit of Measure', Locked = true;
                }
                field(itemReferenceType; Rec."Item Reference Type")
                {
                    Caption = 'Item Reference Type', Locked = true;
                }
                field(itemReferenceTypeNo; Rec."Item Reference Type No.")
                {
                    Caption = 'Item Reference Type No.', Locked = true;
                }
                field(completelyReceived; Rec."Completely Received")
                {
                    Caption = 'Completely Received', Locked = true;
                }
                field(requestedReceiptDate; Rec."Requested Receipt Date")
                {
                    Caption = 'Requested Receipt Date', Locked = true;
                }
                field(promisedReceiptDate; Rec."Promised Receipt Date")
                {
                    Caption = 'Promised Receipt Date', Locked = true;
                }
                field(leadTimeCalculation; Rec."Lead Time Calculation")
                {
                    Caption = 'Lead Time Calculation', Locked = true;
                }
                field(inboundWhseHandlingTime; Rec."Inbound Whse. Handling Time")
                {
                    Caption = 'Inbound Whse. Handling Time', Locked = true;
                }
                field(plannedReceiptDate; Rec."Planned Receipt Date")
                {
                    Caption = 'Planned Receipt Date', Locked = true;
                }
                field(orderDate; Rec."Order Date")
                {
                    Caption = 'Order Date', Locked = true;
                }
                field(allowItemChargeAssignment; Rec."Allow Item Charge Assignment")
                {
                    Caption = 'Allow Item Charge Assignment', Locked = true;
                }
                field(returnQtyToShip; Rec."Return Qty. to Ship")
                {
                    Caption = 'Return Qty. to Ship', Locked = true;
                }
                field(returnQtyToShipBase; Rec."Return Qty. to Ship (Base)")
                {
                    Caption = 'Return Qty. to Ship (Base)', Locked = true;
                }
                field(returnQtyShippedNotInvd; Rec."Return Qty. Shipped Not Invd.")
                {
                    Caption = 'Return Qty. Shipped Not Invd.', Locked = true;
                }
                field(retQtyShpdNotInvdBase; Rec."Ret. Qty. Shpd Not Invd.(Base)")
                {
                    Caption = 'Ret. Qty. Shpd Not Invd.(Base)', Locked = true;
                }
                field(returnShpdNotInvd; Rec."Return Shpd. Not Invd.")
                {
                    Caption = 'Return Shpd. Not Invd.', Locked = true;
                }
                field(returnShpdNotInvdLCY; Rec."Return Shpd. Not Invd. (LCY)")
                {
                    Caption = 'Return Shpd. Not Invd. (LCY)', Locked = true;
                }
                field(returnQtyShipped; Rec."Return Qty. Shipped")
                {
                    Caption = 'Return Qty. Shipped', Locked = true;
                }
                field(returnQtyShippedBase; Rec."Return Qty. Shipped (Base)")
                {
                    Caption = 'Return Qty. Shipped (Base)', Locked = true;
                }
                field(nonDeductibleVAT; Rec."Non-Deductible VAT %")
                {
                    Caption = 'Non-Deductible VAT %', Locked = true;
                }
                field(nonDeductibleVATBase; Rec."Non-Deductible VAT Base")
                {
                    Caption = 'Non-Deductible VAT Base', Locked = true;
                }
                field(nonDeductibleVATAmount; Rec."Non-Deductible VAT Amount")
                {
                    Caption = 'Non-Deductible VAT Amount', Locked = true;
                }
                field(nonDeductibleVATDiff; Rec."Non-Deductible VAT Diff.")
                {
                    Caption = 'Non-Deductible VAT Difference', Locked = true;
                }
                field(returnShipmentNo; Rec."Return Shipment No.")
                {
                    Caption = 'Return Shipment No.', Locked = true;
                }
                field(returnShipmentLineNo; Rec."Return Shipment Line No.")
                {
                    Caption = 'Return Shipment Line No.', Locked = true;
                }
                field(returnReasonCode; Rec."Return Reason Code")
                {
                    Caption = 'Return Reason Code', Locked = true;
                }
                field(priceCalculationMethod; Rec."Price Calculation Method")
                {
                    Caption = 'Price Calculation Method', Locked = true;
                }
                field(expenseCodePGS; Rec."Expense Code PGS")
                {
                    Caption = 'Expense Code', Locked = true;
                }
                field(resourceNoPGS; Rec."Resource No. PGS")
                {
                    Caption = 'Resource No.', Locked = true;
                }
                field(reserveProjectNoPGS; Rec."Reserve Project No. PGS")
                {
                    Caption = 'Reserve Project No.', Locked = true;
                }
                field(reserveProjectTaskNoPGS; Rec."Reserve Project Task No. PGS")
                {
                    Caption = 'Reserve Project Task No.', Locked = true;
                }
                field(routingNo; Rec."Routing No.")
                {
                    Caption = 'Routing No.', Locked = true;
                }
                field(operationNo; Rec."Operation No.")
                {
                    Caption = 'Operation No.', Locked = true;
                }
                field(workCenterNo; Rec."Work Center No.")
                {
                    Caption = 'Work Center No.', Locked = true;
                }
                field(finished; Rec.Finished)
                {
                    Caption = 'Finished', Locked = true;
                }
                field(prodOrderLineNo; Rec."Prod. Order Line No.")
                {
                    Caption = 'Prod. Order Line No.', Locked = true;
                }
                field(overheadRate; Rec."Overhead Rate")
                {
                    Caption = 'Overhead Rate', Locked = true;
                }
                field(mpsOrder; Rec."MPS Order")
                {
                    Caption = 'MPS Order', Locked = true;
                }
                field(planningFlexibility; Rec."Planning Flexibility")
                {
                    Caption = 'Planning Flexibility', Locked = true;
                }
                field(safetyLeadTime; Rec."Safety Lead Time")
                {
                    Caption = 'Safety Lead Time', Locked = true;
                }
                field(routingReferenceNo; Rec."Routing Reference No.")
                {
                    Caption = 'Routing Reference No.', Locked = true;
                }
            }
        }
    }
}
