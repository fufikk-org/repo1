namespace Weibel.API;

using Microsoft.Sales.Archive;

page 70229 "COL Sales Line Archives"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'salesLineArchive';
    EntitySetName = 'salesLineArchives';
    PageType = API;
    SourceTable = "Sales Line Archive";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(documentType; Rec."Document Type")
                {
                }
                field(sellToCustomerNo; Rec."Sell-to Customer No.")
                {
                }
                field(documentNo; Rec."Document No.")
                {
                }
                field(lineNo; Rec."Line No.")
                {
                }
                field(type; Rec.Type)
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
                field(quantityDiscCode; Rec."Quantity Disc. Code")
                {
                }
                field(shipmentDate; Rec."Shipment Date")
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
                field(outstandingQuantity; Rec."Outstanding Quantity")
                {
                }
                field(qtyToInvoice; Rec."Qty. to Invoice")
                {
                }
                field(qtyToShip; Rec."Qty. to Ship")
                {
                }
                field(unitPrice; Rec."Unit Price")
                {
                }
                field(unitCostLCY; Rec."Unit Cost (LCY)")
                {
                }
                field(vatPercent; Rec."VAT %")
                {
                }
                field(quantityDiscPercent; Rec."Quantity Disc. %")
                {
                }
                field(lineDiscountPercent; Rec."Line Discount %")
                {
                }
                field(lineDiscountAmount; Rec."Line Discount Amount")
                {
                }
                field(amount; Rec.Amount)
                {
                }
                field(amountIncludingVAT; Rec."Amount Including VAT")
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
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                }
                field(priceGroupCode; Rec."Price Group Code")
                {
                }
                field(allowQuantityDisc; Rec."Allow Quantity Disc.")
                {
                }
                field(jobNo; Rec."Job No.")
                {
                }
                field(workTypeCode; Rec."Work Type Code")
                {
                }
                field(custItemDiscPercent; Rec."Cust./Item Disc. %")
                {
                }
                field(outstandingAmount; Rec."Outstanding Amount")
                {
                }
                field(qtyShippedNotInvoiced; Rec."Qty. Shipped Not Invoiced")
                {
                }
                field(shippedNotInvoiced; Rec."Shipped Not Invoiced")
                {
                }
                field(quantityShipped; Rec."Quantity Shipped")
                {
                }
                field(quantityInvoiced; Rec."Quantity Invoiced")
                {
                }
                field(shipmentNo; Rec."Shipment No.")
                {
                }
                field(shipmentLineNo; Rec."Shipment Line No.")
                {
                }
                field(profitPercent; Rec."Profit %")
                {
                }
                field(billToCustomerNo; Rec."Bill-to Customer No.")
                {
                }
                field(invDiscountAmount; Rec."Inv. Discount Amount")
                {
                }
                field(purchaseOrderNo; Rec."Purchase Order No.")
                {
                }
                field(purchOrderLineNo; Rec."Purch. Order Line No.")
                {
                }
                field(dropShipment; Rec."Drop Shipment")
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
                field(exitPoint; Rec."Exit Point")
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
                field(vatClauseCode; Rec."VAT Clause Code")
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
                field(outstandingAmountLCY; Rec."Outstanding Amount (LCY)")
                {
                }
                field(shippedNotInvoicedLCY; Rec."Shipped Not Invoiced (LCY)")
                {
                }
                field(reserve; Rec.Reserve)
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
                field(systemCreatedEntry; Rec."System-Created Entry")
                {
                }
                field(lineAmount; Rec."Line Amount")
                {
                }
                field(vatDifference; Rec."VAT Difference")
                {
                }
                field(invDiscAmountToInvoice; Rec."Inv. Disc. Amount to Invoice")
                {
                }
                field(vatIdentifier; Rec."VAT Identifier")
                {
                }
                field(icPartnerRefType; Rec."IC Partner Ref. Type")
                {
                }
                field(icPartnerReference; Rec."IC Partner Reference")
                {
                }
                field(prepaymentPercent; Rec."Prepayment %")
                {
                }
                field(prepmtLineAmount; Rec."Prepmt. Line Amount")
                {
                }
                field(prepmtAmtInv; Rec."Prepmt. Amt. Inv.")
                {
                }
                field(prepmtAmtInclVAT; Rec."Prepmt. Amt. Incl. VAT")
                {
                }
                field(prepaymentAmount; Rec."Prepayment Amount")
                {
                }
                field(prepmtVATBaseAmt; Rec."Prepmt. VAT Base Amt.")
                {
                }
                field(prepaymentVATPercent; Rec."Prepayment VAT %")
                {
                }
                field(prepmtVATCalcType; Rec."Prepmt. VAT Calc. Type")
                {
                }
                field(prepaymentVATIdentifier; Rec."Prepayment VAT Identifier")
                {
                }
                field(prepaymentTaxAreaCode; Rec."Prepayment Tax Area Code")
                {
                }
                field(prepaymentTaxLiable; Rec."Prepayment Tax Liable")
                {
                }
                field(prepaymentTaxGroupCode; Rec."Prepayment Tax Group Code")
                {
                }
                field(prepmtAmtToDeduct; Rec."Prepmt Amt to Deduct")
                {
                }
                field(prepmtAmtDeducted; Rec."Prepmt Amt Deducted")
                {
                }
                field(prepaymentLine; Rec."Prepayment Line")
                {
                }
                field(prepmtAmountInvInclVAT; Rec."Prepmt. Amount Inv. Incl. VAT")
                {
                }
                field(icPartnerCode; Rec."IC Partner Code")
                {
                }
                field(icItemReferenceNo; Rec."IC Item Reference No.")
                {
                }
                field(pmtDiscountAmount; Rec."Pmt. Discount Amount")
                {
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                }
                field(jobTaskNo; Rec."Job Task No.")
                {
                }
                field(jobContractEntryNo; Rec."Job Contract Entry No.")
                {
                }
                field(deferralCode; Rec."Deferral Code")
                {
                }
                field(returnsDeferralStartDate; Rec."Returns Deferral Start Date")
                {
                }
                field(versionNo; Rec."Version No.")
                {
                }
                field(docNoOccurrence; Rec."Doc. No. Occurrence")
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
                field(planned; Rec.Planned)
                {
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                }
                field(quantityBase; Rec."Quantity (Base)")
                {
                }
                field(outstandingQtyBase; Rec."Outstanding Qty. (Base)")
                {
                }
                field(qtyToInvoiceBase; Rec."Qty. to Invoice (Base)")
                {
                }
                field(qtyToShipBase; Rec."Qty. to Ship (Base)")
                {
                }
                field(qtyShippedNotInvdBase; Rec."Qty. Shipped Not Invd. (Base)")
                {
                }
                field(qtyShippedBase; Rec."Qty. Shipped (Base)")
                {
                }
                field(qtyInvoicedBase; Rec."Qty. Invoiced (Base)")
                {
                }
                field(faPostingDate; Rec."FA Posting Date")
                {
                }
                field(depreciationBookCode; Rec."Depreciation Book Code")
                {
                }
                field(deprUntilFAPostingDate; Rec."Depr. until FA Posting Date")
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
                field(outOfStockSubstitution; Rec."Out-of-Stock Substitution")
                {
                }
                field(substitutionAvailable; Rec."Substitution Available")
                {
                }
                field(originallyOrderedNo; Rec."Originally Ordered No.")
                {
                }
                field(originallyOrderedVarCode; Rec."Originally Ordered Var. Code")
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
                field(specialOrder; Rec."Special Order")
                {
                }
                field(specialOrderPurchaseNo; Rec."Special Order Purchase No.")
                {
                }
                field(specialOrderPurchLineNo; Rec."Special Order Purch. Line No.")
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
                field(completelyShipped; Rec."Completely Shipped")
                {
                }
                field(requestedDeliveryDate; Rec."Requested Delivery Date")
                {
                }
                field(promisedDeliveryDate; Rec."Promised Delivery Date")
                {
                }
                field(shippingTime; Rec."Shipping Time")
                {
                }
                field(outboundWhseHandlingTime; Rec."Outbound Whse. Handling Time")
                {
                }
                field(plannedDeliveryDate; Rec."Planned Delivery Date")
                {
                }
                field(plannedShipmentDate; Rec."Planned Shipment Date")
                {
                }
                field(shippingAgentCode; Rec."Shipping Agent Code")
                {
                }
                field(shippingAgentServiceCode; Rec."Shipping Agent Service Code")
                {
                }
                field(allowItemChargeAssignment; Rec."Allow Item Charge Assignment")
                {
                }
                field(returnQtyToReceive; Rec."Return Qty. to Receive")
                {
                }
                field(returnQtyToReceiveBase; Rec."Return Qty. to Receive (Base)")
                {
                }
                field(returnQtyRcdNotInvd; Rec."Return Qty. Rcd. Not Invd.")
                {
                }
                field(retQtyRcdNotInvdBase; Rec."Ret. Qty. Rcd. Not Invd.(Base)")
                {
                }
                field(returnAmtRcdNotInvd; Rec."Return Amt. Rcd. Not Invd.")
                {
                }
                field(retAmtRcdNotInvdLCY; Rec."Ret. Amt. Rcd. Not Invd. (LCY)")
                {
                }
                field(returnQtyReceived; Rec."Return Qty. Received")
                {
                }
                field(returnQtyReceivedBase; Rec."Return Qty. Received (Base)")
                {
                }
                field(applFromItemEntry; Rec."Appl.-from Item Entry")
                {
                }
                field(bomItemNo; Rec."BOM Item No.")
                {
                }
                field(returnReceiptNo; Rec."Return Receipt No.")
                {
                }
                field(returnReceiptLineNo; Rec."Return Receipt Line No.")
                {
                }
                field(returnReasonCode; Rec."Return Reason Code")
                {
                }
                field(priceCalculationMethod; Rec."Price Calculation Method")
                {
                }
                field(allowLineDisc; Rec."Allow Line Disc.")
                {
                }
                field(customerDiscGroup; Rec."Customer Disc. Group")
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
