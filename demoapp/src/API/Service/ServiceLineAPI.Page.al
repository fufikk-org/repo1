namespace Weibel.API;

using Microsoft.Service.Document;

page 70259 "COL Service Line API"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'serviceLine';
    EntitySetName = 'serviceLines';
    PageType = API;
    SourceTable = "Service Line";
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
                field(documentType; Rec."Document Type")
                {
                }
                field(customerNo; Rec."Customer No.")
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
                field(vat; Rec."VAT %")
                {
                }
                field(lineDiscount; Rec."Line Discount %")
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
                field(customerPriceGroup; Rec."Customer Price Group")
                {
                }
                field(jobNo; Rec."Job No.")
                {
                }
                field(jobTaskNo; Rec."Job Task No.")
                {
                }
                field(jobLineType; Rec."Job Line Type")
                {
                }
                field(workTypeCode; Rec."Work Type Code")
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
                field(orderNo; Rec."Order No.")
                {
                }
                field(billToCustomerNo; Rec."Bill-to Customer No.")
                {
                }
                field(invDiscountAmount; Rec."Inv. Discount Amount")
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
                field(reservedQuantity; Rec."Reserved Quantity")
                {
                }
                field(reserve; Rec.Reserve)
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
                field(pmtDiscountAmount; Rec."Pmt. Discount Amount")
                {
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                }
                field(timeSheetNo; Rec."Time Sheet No.")
                {
                }
                field(timeSheetLineNo; Rec."Time Sheet Line No.")
                {
                }
                field(timeSheetDate; Rec."Time Sheet Date")
                {
                }
                field(jobPlanningLineNo; Rec."Job Planning Line No.")
                {
                }
                field(jobRemainingQty; Rec."Job Remaining Qty.")
                {
                }
                field(jobRemainingQtyBase; Rec."Job Remaining Qty. (Base)")
                {
                }
                field(jobRemainingTotalCost; Rec."Job Remaining Total Cost")
                {
                }
                field(jobRemainingTotalCostLCY; Rec."Job Remaining Total Cost (LCY)")
                {
                }
                field(jobRemainingLineAmount; Rec."Job Remaining Line Amount")
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
                field(qtyRoundingPrecision; Rec."Qty. Rounding Precision")
                {
                }
                field(qtyRoundingPrecisionBase; Rec."Qty. Rounding Precision (Base)")
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
                field(reservedQtyBase; Rec."Reserved Qty. (Base)")
                {
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                }
                field(substitutionAvailable; Rec."Substitution Available")
                {
                }
                field(itemCategoryCode; Rec."Item Category Code")
                {
                }
                field(nonstock; Rec.Nonstock)
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
                field(whseOutstandingQtyBase; Rec."Whse. Outstanding Qty. (Base)")
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
                field(plannedDeliveryDate; Rec."Planned Delivery Date")
                {
                }
                field(shippingAgentCode; Rec."Shipping Agent Code")
                {
                }
                field(shippingAgentServiceCode; Rec."Shipping Agent Service Code")
                {
                }
                field(applFromItemEntry; Rec."Appl.-from Item Entry")
                {
                }
                field(serviceItemNo; Rec."Service Item No.")
                {
                }
                field(applToServiceEntry; Rec."Appl.-to Service Entry")
                {
                }
                field(serviceItemLineNo; Rec."Service Item Line No.")
                {
                }
                field(serviceItemSerialNo; Rec."Service Item Serial No.")
                {
                }
                field(serviceItemLineDescription; Rec."Service Item Line Description")
                {
                }
                field(servPriceAdjmtGrCode; Rec."Serv. Price Adjmt. Gr. Code")
                {
                }
                field(postingDate; Rec."Posting Date")
                {
                }
                field(orderDate; Rec."Order Date")
                {
                }
                field(neededByDate; Rec."Needed by Date")
                {
                }
                field(shipToCode; Rec."Ship-to Code")
                {
                }
                field(qtyToConsume; Rec."Qty. to Consume")
                {
                }
                field(quantityConsumed; Rec."Quantity Consumed")
                {
                }
                field(qtyToConsumeBase; Rec."Qty. to Consume (Base)")
                {
                }
                field(qtyConsumedBase; Rec."Qty. Consumed (Base)")
                {
                }
                field(servicePriceGroupCode; Rec."Service Price Group Code")
                {
                }
                field(faultAreaCode; Rec."Fault Area Code")
                {
                }
                field(symptomCode; Rec."Symptom Code")
                {
                }
                field(faultCode; Rec."Fault Code")
                {
                }
                field(resolutionCode; Rec."Resolution Code")
                {
                }
                field(excludeWarranty; Rec."Exclude Warranty")
                {
                }
                field(warranty; Rec.Warranty)
                {
                }
                field(contractNo; Rec."Contract No.")
                {
                }
                field(contractDisc; Rec."Contract Disc. %")
                {
                }
                field(warrantyDisc; Rec."Warranty Disc. %")
                {
                }
                field(componentLineNo; Rec."Component Line No.")
                {
                }
                field(sparePartAction; Rec."Spare Part Action")
                {
                }
                field(faultReasonCode; Rec."Fault Reason Code")
                {
                }
                field(replacedItemNo; Rec."Replaced Item No.")
                {
                }
                field(excludeContractDiscount; Rec."Exclude Contract Discount")
                {
                }
                field(replacedItemType; Rec."Replaced Item Type")
                {
                }
                field(priceAdjmtStatus; Rec."Price Adjmt. Status")
                {
                }
                field(lineDiscountType; Rec."Line Discount Type")
                {
                }
                field(copyComponentsFrom; Rec."Copy Components From")
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
                field(colStatus; Rec."COL Status")
                {
                }
                field(projectNoPGS; Rec."Project No. PGS")
                {
                }
                field(projectTaskCodePGS; Rec."Project Task Code PGS")
                {
                }
                field(timeEntryResouceNoPGS; Rec."Time Entry Resouce No. PGS")
                {
                }
                field(timeEntryEntryNoPGS; Rec."Time Entry Entry No. PGS")
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
