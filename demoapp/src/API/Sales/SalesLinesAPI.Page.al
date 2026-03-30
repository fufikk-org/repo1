namespace Weibel.API;

using Microsoft.Sales.Document;

page 70191 "COL Sales Lines API"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'salesLine';
    EntitySetName = 'salesLines';
    PageType = API;
    SourceTable = "Sales Line";
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
                field(sellToCustomerNo; Rec."Sell-to Customer No.")
                {
                    Caption = 'Sell-to Customer No.', Locked = true;
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
                field(shipmentDate; Rec."Shipment Date")
                {
                    Caption = 'Shipment Date', Locked = true;
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
                field(qtyToShip; Rec."Qty. to Ship")
                {
                    Caption = 'Qty. to Ship', Locked = true;
                }
                field(unitPrice; Rec."Unit Price")
                {
                    Caption = 'Unit Price', Locked = true;
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
                field(customerPriceGroup; Rec."Customer Price Group")
                {
                    Caption = 'Customer Price Group', Locked = true;
                }
                field(jobNo; Rec."Job No.")
                {
                    Caption = 'Project No.', Locked = true;
                }
                field(workTypeCode; Rec."Work Type Code")
                {
                    Caption = 'Work Type Code', Locked = true;
                }
                field(recalculateInvoiceDisc; Rec."Recalculate Invoice Disc.")
                {
                    Caption = 'Recalculate Invoice Disc.', Locked = true;
                }
                field(outstandingAmount; Rec."Outstanding Amount")
                {
                    Caption = 'Outstanding Amount', Locked = true;
                }
                field(qtyShippedNotInvoiced; Rec."Qty. Shipped Not Invoiced")
                {
                    Caption = 'Qty. Shipped Not Invoiced', Locked = true;
                }
                field(shippedNotInvoiced; Rec."Shipped Not Invoiced")
                {
                    Caption = 'Shipped Not Invoiced', Locked = true;
                }
                field(quantityShipped; Rec."Quantity Shipped")
                {
                    Caption = 'Quantity Shipped', Locked = true;
                }
                field(quantityInvoiced; Rec."Quantity Invoiced")
                {
                    Caption = 'Quantity Invoiced', Locked = true;
                }
                field(shipmentNo; Rec."Shipment No.")
                {
                    Caption = 'Shipment No.', Locked = true;
                }
                field(shipmentLineNo; Rec."Shipment Line No.")
                {
                    Caption = 'Shipment Line No.', Locked = true;
                }
                field(profit; Rec."Profit %")
                {
                    Caption = 'Profit %', Locked = true;
                }
                field(billToCustomerNo; Rec."Bill-to Customer No.")
                {
                    Caption = 'Bill-to Customer No.', Locked = true;
                }
                field(invDiscountAmount; Rec."Inv. Discount Amount")
                {
                    Caption = 'Inv. Discount Amount', Locked = true;
                }
                field(purchaseOrderNo; Rec."Purchase Order No.")
                {
                    Caption = 'Purchase Order No.', Locked = true;
                }
                field(purchOrderLineNo; Rec."Purch. Order Line No.")
                {
                    Caption = 'Purch. Order Line No.', Locked = true;
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
                field(exitPoint; Rec."Exit Point")
                {
                    Caption = 'Exit Point', Locked = true;
                }
                field("area"; Rec."Area")
                {
                    Caption = 'Area', Locked = true;
                }
                field(transactionSpecification; Rec."Transaction Specification")
                {
                    Caption = 'Transaction Specification', Locked = true;
                }
                field(taxCategory; Rec."Tax Category")
                {
                    Caption = 'Tax Category', Locked = true;
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
                field(vatClauseCode; Rec."VAT Clause Code")
                {
                    Caption = 'VAT Clause Code', Locked = true;
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
                field(shippedNotInvoicedLCY; Rec."Shipped Not Invoiced (LCY)")
                {
                    Caption = 'Shipped Not Invoiced (LCY) Incl. VAT', Locked = true;
                }
                field(shippedNotInvLCYNoVAT; Rec."Shipped Not Inv. (LCY) No VAT")
                {
                    Caption = 'Shipped Not Invoiced (LCY)', Locked = true;
                }
                // field(reservedQuantity; Rec."Reserved Quantity")
                // {
                //     Caption = 'Reserved Quantity', Locked = true;
                // }
                field(reserve; Rec.Reserve)
                {
                    Caption = 'Reserve', Locked = true;
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
                field(prepmtAmountInvLCY; Rec."Prepmt. Amount Inv. (LCY)")
                {
                    Caption = 'Prepmt. Amount Inv. (LCY)', Locked = true;
                }
                field(icPartnerCode; Rec."IC Partner Code")
                {
                    Caption = 'IC Partner Code', Locked = true;
                }
                field(prepmtVATAmountInvLCY; Rec."Prepmt. VAT Amount Inv. (LCY)")
                {
                    Caption = 'Prepmt. VAT Amount Inv. (LCY)', Locked = true;
                }
                field(prepaymentVATDifference; Rec."Prepayment VAT Difference")
                {
                    Caption = 'Prepayment VAT Difference', Locked = true;
                }
                field(prepmtVATDiffToDeduct; Rec."Prepmt VAT Diff. to Deduct")
                {
                    Caption = 'Prepmt VAT Diff. to Deduct', Locked = true;
                }
                field(prepmtVATDiffDeducted; Rec."Prepmt VAT Diff. Deducted")
                {
                    Caption = 'Prepmt VAT Diff. Deducted', Locked = true;
                }
                field(icItemReferenceNo; Rec."IC Item Reference No.")
                {
                    Caption = 'IC Item Reference No.', Locked = true;
                }
                field(pmtDiscountAmount; Rec."Pmt. Discount Amount")
                {
                    Caption = 'Pmt. Discount Amount', Locked = true;
                }
                field(prepmtPmtDiscountAmount; Rec."Prepmt. Pmt. Discount Amount")
                {
                    Caption = 'Prepmt. Pmt. Discount Amount', Locked = true;
                }
                field(lineDiscountCalculation; Rec."Line Discount Calculation")
                {
                    Caption = 'Line Discount Calculation', Locked = true;
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID', Locked = true;
                }
                field(qtyToAssembleToOrder; Rec."Qty. to Assemble to Order")
                {
                    Caption = 'Qty. to Assemble to Order', Locked = true;
                }
                field(qtyToAsmToOrderBase; Rec."Qty. to Asm. to Order (Base)")
                {
                    Caption = 'Qty. to Asm. to Order (Base)', Locked = true;
                }
                // field(atoWhseOutstandingQty; Rec."ATO Whse. Outstanding Qty.")
                // {
                //     Caption = 'ATO Whse. Outstanding Qty.', Locked = true;
                // }
                // field(atoWhseOutstdQtyBase; Rec."ATO Whse. Outstd. Qty. (Base)")
                // {
                //     Caption = 'ATO Whse. Outstd. Qty. (Base)', Locked = true;
                // }
                field(jobTaskNo; Rec."Job Task No.")
                {
                    Caption = 'Project Task No.', Locked = true;
                }
                field(jobContractEntryNo; Rec."Job Contract Entry No.")
                {
                    Caption = 'Project Contract Entry No.', Locked = true;
                }
                // field(postingDate; Rec."Posting Date")
                // {
                //     Caption = 'Posting Date', Locked = true;
                // }
                field(deferralCode; Rec."Deferral Code")
                {
                    Caption = 'Deferral Code', Locked = true;
                }
                field(returnsDeferralStartDate; Rec."Returns Deferral Start Date")
                {
                    Caption = 'Returns Deferral Start Date', Locked = true;
                }
                field(selectedAllocAccountNo; Rec."Selected Alloc. Account No.")
                {
                    Caption = 'Allocation Account No.', Locked = true;
                }
                // field(allocAccModifiedByUser; Rec."Alloc. Acc. Modified by User")
                // {
                //     Caption = 'Allocation Account Distributions Modified', Locked = true;
                // }
                field(allocationAccountNo; Rec."Allocation Account No.")
                {
                    Caption = 'Posting Allocation Account No.', Locked = true;
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
                field(planned; Rec.Planned)
                {
                    Caption = 'Planned', Locked = true;
                }
                field(qtyRoundingPrecision; Rec."Qty. Rounding Precision")
                {
                    Caption = 'Qty. Rounding Precision', Locked = true;
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code', Locked = true;
                }
                field(qtyRoundingPrecisionBase; Rec."Qty. Rounding Precision (Base)")
                {
                    Caption = 'Qty. Rounding Precision (Base)', Locked = true;
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
                field(qtyToShipBase; Rec."Qty. to Ship (Base)")
                {
                    Caption = 'Qty. to Ship (Base)', Locked = true;
                }
                field(qtyShippedNotInvdBase; Rec."Qty. Shipped Not Invd. (Base)")
                {
                    Caption = 'Qty. Shipped Not Invd. (Base)', Locked = true;
                }
                field(qtyShippedBase; Rec."Qty. Shipped (Base)")
                {
                    Caption = 'Qty. Shipped (Base)', Locked = true;
                }
                field(qtyInvoicedBase; Rec."Qty. Invoiced (Base)")
                {
                    Caption = 'Qty. Invoiced (Base)', Locked = true;
                }
                // field(reservedQtyBase; Rec."Reserved Qty. (Base)")
                // {
                //     Caption = 'Reserved Qty. (Base)', Locked = true;
                // }
                field(faPostingDate; Rec."FA Posting Date")
                {
                    Caption = 'FA Posting Date', Locked = true;
                }
                field(depreciationBookCode; Rec."Depreciation Book Code")
                {
                    Caption = 'Depreciation Book Code', Locked = true;
                }
                field(deprUntilFAPostingDate; Rec."Depr. until FA Posting Date")
                {
                    Caption = 'Depr. until FA Posting Date', Locked = true;
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
                field(outOfStockSubstitution; Rec."Out-of-Stock Substitution")
                {
                    Caption = 'Out-of-Stock Substitution', Locked = true;
                }
                // field(substitutionAvailable; Rec."Substitution Available")
                // {
                //     Caption = 'Substitution Available', Locked = true;
                // }
                field(originallyOrderedNo; Rec."Originally Ordered No.")
                {
                    Caption = 'Originally Ordered No.', Locked = true;
                }
                field(originallyOrderedVarCode; Rec."Originally Ordered Var. Code")
                {
                    Caption = 'Originally Ordered Var. Code', Locked = true;
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
                field(specialOrderPurchaseNo; Rec."Special Order Purchase No.")
                {
                    Caption = 'Special Order Purchase No.', Locked = true;
                }
                field(specialOrderPurchLineNo; Rec."Special Order Purch. Line No.")
                {
                    Caption = 'Special Order Purch. Line No.', Locked = true;
                }
                field(itemReferenceNo; Rec."Item Reference No.")
                {
                    Caption = 'Item Reference No.', Locked = true;
                }
                field(itemReferenceUnitOfMeasure; Rec."Item Reference Unit of Measure")
                {
                    Caption = 'Reference Unit of Measure', Locked = true;
                }
                field(itemReferenceType; Rec."Item Reference Type")
                {
                    Caption = 'Item Reference Type', Locked = true;
                }
                field(itemReferenceTypeNo; Rec."Item Reference Type No.")
                {
                    Caption = 'Item Reference Type No.', Locked = true;
                }
                // field(whseOutstandingQty; Rec."Whse. Outstanding Qty.")
                // {
                //     Caption = 'Whse. Outstanding Qty.', Locked = true;
                // }
                // field(whseOutstandingQtyBase; Rec."Whse. Outstanding Qty. (Base)")
                // {
                //     Caption = 'Whse. Outstanding Qty. (Base)', Locked = true;
                // }
                field(completelyShipped; Rec."Completely Shipped")
                {
                    Caption = 'Completely Shipped', Locked = true;
                }
                field(requestedDeliveryDate; Rec."Requested Delivery Date")
                {
                    Caption = 'Requested Delivery Date', Locked = true;
                }
                field(promisedDeliveryDate; Rec."Promised Delivery Date")
                {
                    Caption = 'Promised Delivery Date', Locked = true;
                }
                field(shippingTime; Rec."Shipping Time")
                {
                    Caption = 'Shipping Time', Locked = true;
                }
                field(outboundWhseHandlingTime; Rec."Outbound Whse. Handling Time")
                {
                    Caption = 'Outbound Whse. Handling Time', Locked = true;
                }
                field(plannedDeliveryDate; Rec."Planned Delivery Date")
                {
                    Caption = 'Planned Delivery Date', Locked = true;
                }
                field(plannedShipmentDate; Rec."Planned Shipment Date")
                {
                    Caption = 'Planned Shipment Date', Locked = true;
                }
                field(shippingAgentCode; Rec."Shipping Agent Code")
                {
                    Caption = 'Shipping Agent Code', Locked = true;
                }
                field(shippingAgentServiceCode; Rec."Shipping Agent Service Code")
                {
                    Caption = 'Shipping Agent Service Code', Locked = true;
                }
                field(allowItemChargeAssignment; Rec."Allow Item Charge Assignment")
                {
                    Caption = 'Allow Item Charge Assignment', Locked = true;
                }
                // field(qtyToAssign; Rec."Qty. to Assign")
                // {
                //     Caption = 'Qty. to Assign', Locked = true;
                // }
                // field(qtyAssigned; Rec."Qty. Assigned")
                // {
                //     Caption = 'Qty. Assigned', Locked = true;
                // }
                field(returnQtyToReceive; Rec."Return Qty. to Receive")
                {
                    Caption = 'Return Qty. to Receive', Locked = true;
                }
                field(returnQtyToReceiveBase; Rec."Return Qty. to Receive (Base)")
                {
                    Caption = 'Return Qty. to Receive (Base)', Locked = true;
                }
                field(returnQtyRcdNotInvd; Rec."Return Qty. Rcd. Not Invd.")
                {
                    Caption = 'Return Qty. Rcd. Not Invd.', Locked = true;
                }
                field(retQtyRcdNotInvdBase; Rec."Ret. Qty. Rcd. Not Invd.(Base)")
                {
                    Caption = 'Ret. Qty. Rcd. Not Invd.(Base)', Locked = true;
                }
                field(returnRcdNotInvd; Rec."Return Rcd. Not Invd.")
                {
                    Caption = 'Return Rcd. Not Invd.', Locked = true;
                }
                field(returnRcdNotInvdLCY; Rec."Return Rcd. Not Invd. (LCY)")
                {
                    Caption = 'Return Rcd. Not Invd. (LCY)', Locked = true;
                }
                field(returnQtyReceived; Rec."Return Qty. Received")
                {
                    Caption = 'Return Qty. Received', Locked = true;
                }
                field(returnQtyReceivedBase; Rec."Return Qty. Received (Base)")
                {
                    Caption = 'Return Qty. Received (Base)', Locked = true;
                }
                field(applFromItemEntry; Rec."Appl.-from Item Entry")
                {
                    Caption = 'Appl.-from Item Entry', Locked = true;
                }
                // field(itemChargeQtyToHandle; Rec."Item Charge Qty. to Handle")
                // {
                //     Caption = 'Item Charge Qty. to Handle', Locked = true;
                // }
                field(bomItemNo; Rec."BOM Item No.")
                {
                    Caption = 'BOM Item No.', Locked = true;
                }
                field(returnReceiptNo; Rec."Return Receipt No.")
                {
                    Caption = 'Return Receipt No.', Locked = true;
                }
                field(returnReceiptLineNo; Rec."Return Receipt Line No.")
                {
                    Caption = 'Return Receipt Line No.', Locked = true;
                }
                field(returnReasonCode; Rec."Return Reason Code")
                {
                    Caption = 'Return Reason Code', Locked = true;
                }
                field(copiedFromPostedDoc; Rec."Copied From Posted Doc.")
                {
                    Caption = 'Copied From Posted Doc.', Locked = true;
                }
                field(priceCalculationMethod; Rec."Price Calculation Method")
                {
                    Caption = 'Price Calculation Method', Locked = true;
                }
                field(allowLineDisc; Rec."Allow Line Disc.")
                {
                    Caption = 'Allow Line Disc.', Locked = true;
                }
                field(customerDiscGroup; Rec."Customer Disc. Group")
                {
                    Caption = 'Customer Disc. Group', Locked = true;
                }
                field(subtype; Rec.Subtype)
                {
                    Caption = 'Subtype', Locked = true;
                }
                field(priceDescription; Rec."Price description")
                {
                    Caption = 'Price description', Locked = true;
                }
                // field(attachedDocCount; Rec."Attached Doc Count")
                // {
                //     Caption = 'Attached Doc Count', Locked = true;
                // }
                // field(attachedLinesCount; Rec."Attached Lines Count")
                // {
                //     Caption = 'Attached Lines Count', Locked = true;
                // }
                field(invoiceSetupNoPGS; Rec."Invoice Setup No. PGS")
                {
                    Caption = 'Invoice Setup No.', Locked = true;
                }
                field(pmShowPGS; Rec."PM Show PGS")
                {
                    Caption = 'PM Show', Locked = true;
                }
                field(usePaymentPGS; Rec."Use Payment PGS")
                {
                    Caption = 'Use Payment', Locked = true;
                }
                field(paymentPGS; Rec."Payment PGS")
                {
                    Caption = 'Payment', Locked = true;
                }
                field(expensePGS; Rec."Expense PGS")
                {
                    Caption = 'Expense', Locked = true;
                }
                field(expenseCodePGS; Rec."Expense Code PGS")
                {
                    Caption = 'Expense Code', Locked = true;
                }
                field(referencePGS; Rec."Reference PGS")
                {
                    Caption = 'Reference', Locked = true;
                }
                field(relatedToPMLinePGS; Rec."Related to PM Line PGS")
                {
                    Caption = 'Related to PM Line', Locked = true;
                }
                field(applToJobEntryPGS; Rec."Appl.-to Job Entry PGS")
                {
                    Caption = 'Appl.-to Project Entry', Locked = true;
                }
                field(jobAppliesToIDPGS; Rec."Job Applies-to ID PGS")
                {
                    Caption = 'Project Applies-to ID', Locked = true;
                }
                field(applyAndCloseJobPGS; Rec."Apply and Close (Job) PGS")
                {
                    Caption = 'Apply and Close (Project)', Locked = true;
                }
                field(hourBankNoPGS; Rec."Hour Bank No. PGS")
                {
                    Caption = 'Hour Bank No.', Locked = true;
                }
                field(costTypePGS; Rec."Cost Type PGS")
                {
                    Caption = 'Cost Type', Locked = true;
                }
                field(pmGroupPGS; Rec."PM Group PGS")
                {
                    Caption = 'PM Group', Locked = true;
                }
                field(negativeLinePGS; Rec."Negative Line PGS")
                {
                    Caption = 'Negative Line', Locked = true;
                }
                field(negativePMGroupLineNoPGS; Rec."Negative PM Group Line No. PGS")
                {
                    Caption = 'Negative PM Group Line No.', Locked = true;
                }
                field(projectTaskNoPGS; Rec."Project Task No. PGS")
                {
                    Caption = 'Project Task No.', Locked = true;
                }
                field(timePayTypePGS; Rec."Time Pay Type PGS")
                {
                    Caption = 'Time Pay Type', Locked = true;
                }
                field(shipToCodePGS; Rec."Ship-to Code PGS")
                {
                    Caption = 'Ship-to Code', Locked = true;
                }
                field(expenseEntryNoPGS; Rec."Expense Entry No. PGS")
                {
                    Caption = 'Expense Entry No.', Locked = true;
                }
                field(expenseDatePGS; Rec."Expense Date PGS")
                {
                    Caption = 'Expense Date', Locked = true;
                }
                field(expenseResourceNoPGS; Rec."Expense Resource No. PGS")
                {
                    Caption = 'Expense Resource No.', Locked = true;
                }
                field(retentionPGS; Rec."Retention % PGS")
                {
                    Caption = 'Retention %', Locked = true;
                }
                field(pmGroupLineNoPGS; Rec."PM Group Line No. PGS")
                {
                    Caption = 'PM Group Related Line No.', Locked = true;
                }
                field(pmLinePGS; Rec."PM Line PGS")
                {
                    Caption = 'PM Line', Locked = true;
                }
                field(percentCompletePGS; Rec."Percent Complete PGS")
                {
                    Caption = 'Percent Complete', Locked = true;
                }
                field(originalRelToPMLinePGS; Rec."Original Rel. to PM Line PGS")
                {
                    Caption = 'Original Related to PM Line', Locked = true;
                }
                field(attachmentsPGS; Rec."Attachments PGS")
                {
                    Caption = 'Attachments', Locked = true;
                }
                field(groupedByPGS; Rec."Grouped By PGS")
                {
                    Caption = 'Grouped By PGS', Locked = true;
                }
                field(reserveProjectTaskNoPGS; Rec."Reserve Project Task No. PGS")
                {
                    Caption = 'Reserve Project Task No.', Locked = true;
                }
                field(reserveProjectNoPGS; Rec."Reserve Project No. PGS")
                {
                    Caption = 'Reserve Project No.', Locked = true;
                }
                field(unitPriceHoldPGS; Rec."Unit Price Hold PGS")
                {
                    Caption = 'Unit Price Hold', Locked = true;
                }
                field(discountHoldPGS; Rec."Discount % Hold PGS")
                {
                    Caption = 'Discount % Hold', Locked = true;
                }
                field(salesOrderInvoicedPGS; Rec."Sales Order Invoiced PGS")
                {
                    Caption = 'Sales Order Invoiced', Locked = true;
                }
                field(salesOrderCreatesUsagePGS; Rec."Sales Order Creates Usage PGS")
                {
                    Caption = 'Sales Order Creates Usage', Locked = true;
                }
                field(salesInvCreatesUsagePGS; Rec."Sales Inv Creates Usage PGS")
                {
                    Caption = 'Sales Invoice Creates Usage', Locked = true;
                }
                field(projectPlanningLineNoPGS; Rec."Project Planning Line No. PGS")
                {
                    Caption = 'Project Planning Line No.', Locked = true;
                }
                field(progressBillingItemNoPGS; Rec."Progress Billing Item No. PGS")
                {
                    Caption = 'Progress Billing Item No.', Locked = true;
                }
                field(lotNoPGS; Rec."Lot No. PGS")
                {
                    Caption = 'Lot No.', Locked = true;
                }
                field(serialNoPGS; Rec."Serial No. PGS")
                {
                    Caption = 'Serial No.', Locked = true;
                }
                field(pctOfSplitBillingPGS; Rec."Pct of Split Billing PGS")
                {
                    Caption = '% of Split Billing', Locked = true;
                }
                field(hiddenLineGrpQtyPGS; Rec."Hidden Line Grp Qty PGS")
                {
                    Caption = 'Hidden Line Group Qty Zero PGS', Locked = true;
                }
                field(resGroupNoPGS; Rec."Res. Group No. PGS")
                {
                    Caption = 'Resource Group No.', Locked = true;
                }
                field(invoiceSetupSourcePGS; Rec."Invoice Setup Source PGS")
                {
                    Caption = 'Invoice Setup Source', Locked = true;
                }
                field(invoiceSetupModifiedAtPGS; Rec."Invoice Setup ModifiedAt PGS")
                {
                    Caption = 'Invoice Setup Modified At', Locked = true;
                }
                field(systemCreatedAt; Rec."SystemCreatedAt") { }

                field(systemCreatedBy; Rec."SystemCreatedBy") { }

                field(systemModifiedAt; Rec."SystemModifiedAt") { }

                field(systemModifiedBy; Rec."SystemModifiedBy") { }
            }
        }
    }
}
