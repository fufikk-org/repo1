namespace Weibel.API;

using Microsoft.Projects.Project.Ledger;

page 70204 "COL Project Ledger Entries Cus"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    DelayedInsert = true;
    EntityName = 'projectLedgerEntryCustom';
    EntitySetName = 'projectLedgerEntriesCustom';
    PageType = API;
    SourceTable = "Job Ledger Entry";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(entryNo; Rec."Entry No.") { }

                field(jobNo; Rec."Job No.") { }

                field(postingDate; Rec."Posting Date") { }

                field(documentNo; Rec."Document No.") { }

                field(type; Rec."Type") { }

                field(no; Rec."No.") { }

                field(description; Rec."Description") { }

                field(quantity; Rec."Quantity") { }

                field(directUnitCostLCY; Rec."Direct Unit Cost (LCY)") { }

                field(unitCostLCY; Rec."Unit Cost (LCY)") { }

                field(totalCostLCY; Rec."Total Cost (LCY)") { }

                field(unitPriceLCY; Rec."Unit Price (LCY)") { }

                field(totalPriceLCY; Rec."Total Price (LCY)") { }

                field(resourceGroupNo; Rec."Resource Group No.") { }

                field(unitOfMeasureCode; Rec."Unit of Measure Code") { }

                field(locationCode; Rec."Location Code") { }

                field(jobPostingGroup; Rec."Job Posting Group") { }

                field(globalDimension1Code; Rec."Global Dimension 1 Code") { }

                field(globalDimension2Code; Rec."Global Dimension 2 Code") { }

                field(workTypeCode; Rec."Work Type Code") { }

                field(customerPriceGroup; Rec."Customer Price Group") { }

                field("userID"; Rec."User ID") { }

                field(sourceCode; Rec."Source Code") { }

                field(shptMethodCode; Rec."Shpt. Method Code") { }

                field(amtToPostToGL; Rec."Amt. to Post to G/L") { }

                field(amtPostedToGL; Rec."Amt. Posted to G/L") { }

                field(entryType; Rec."Entry Type") { }

                field(journalBatchName; Rec."Journal Batch Name") { }

                field(reasonCode; Rec."Reason Code") { }

                field(transactionType; Rec."Transaction Type") { }

                field(transportMethod; Rec."Transport Method") { }

                field(countryRegionCode; Rec."Country/Region Code") { }

                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group") { }

                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group") { }

                field(entryExitPoint; Rec."Entry/Exit Point") { }

                field(documentDate; Rec."Document Date") { }

                field(externalDocumentNo; Rec."External Document No.") { }

                field("area"; Rec."Area") { }

                field(transactionSpecification; Rec."Transaction Specification") { }

                field(noSeries; Rec."No. Series") { }

                field(additionalCurrencyTotalCost; Rec."Additional-Currency Total Cost") { }

                field(addCurrencyTotalPrice; Rec."Add.-Currency Total Price") { }

                field(addCurrencyLineAmount; Rec."Add.-Currency Line Amount") { }

                field(dimensionSetID; Rec."Dimension Set ID") { }

                field(jobTaskNo; Rec."Job Task No.") { }

                field(lineAmountLCY; Rec."Line Amount (LCY)") { }

                field(unitCost; Rec."Unit Cost") { }

                field(totalCost; Rec."Total Cost") { }

                field(unitPrice; Rec."Unit Price") { }

                field(totalPrice; Rec."Total Price") { }

                field(lineAmount; Rec."Line Amount") { }

                field(lineDiscountAmount; Rec."Line Discount Amount") { }

                field(lineDiscountAmountLCY; Rec."Line Discount Amount (LCY)") { }

                field(currencyCode; Rec."Currency Code") { }

                field(currencyFactor; Rec."Currency Factor") { }

                field(description2; Rec."Description 2") { }

                field(ledgerEntryType; Rec."Ledger Entry Type") { }

                field(ledgerEntryNo; Rec."Ledger Entry No.") { }

                field(serialNo; Rec."Serial No.") { }

                field(lotNo; Rec."Lot No.") { }

                field(lineDiscount; Rec."Line Discount %") { }

                field(lineType; Rec."Line Type") { }

                field(originalUnitCostLCY; Rec."Original Unit Cost (LCY)") { }

                field(originalTotalCostLCY; Rec."Original Total Cost (LCY)") { }

                field(originalUnitCost; Rec."Original Unit Cost") { }

                field(originalTotalCost; Rec."Original Total Cost") { }

                field(originalTotalCostACY; Rec."Original Total Cost (ACY)") { }

                field(adjusted; Rec."Adjusted") { }

                field(dateTimeAdjusted; Rec."DateTime Adjusted") { }

                field(variantCode; Rec."Variant Code") { }

                field(binCode; Rec."Bin Code") { }

                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure") { }

                field(quantityBase; Rec."Quantity (Base)") { }

                field(serviceOrderNo; Rec."Service Order No.") { }

                field(postedServiceShipmentNo; Rec."Posted Service Shipment No.") { }

                field(packageNo; Rec."Package No.") { }

                field(documentTypePGS; Rec."Document Type PGS") { }

                field(expensePGS; Rec."Expense PGS") { }

                field(paymentPGS; Rec."Payment PGS") { }

                field(prePaymentPGS; Rec."Pre Payment PGS") { }

                field(expenseCodePGS; Rec."Expense Code PGS") { }

                field(paymentCodePGS; Rec."Payment Code PGS") { }

                field(costPostedPGS; Rec."Cost Posted PGS") { }

                field(itemEntryNoPGS; Rec."Item Entry No. PGS") { }

                field(expenseResourcePGS; Rec."Expense Resource PGS") { }

                field(sourceNoPGS; Rec."Source No. PGS") { }

                field(mainProjectNoPGS; Rec."Main Project No. PGS") { }

                field(mainProjectTaskCodePGS; Rec."Main Project Task Code PGS") { }

                field(connectedToProjectPGS; Rec."Connected to Project PGS") { }

                field(sourceTypePGS; Rec."Source Type PGS") { }

                field(paymentTypePGS; Rec."Payment Type PGS") { }

                field(repeatingPGS; Rec."Repeating PGS") { }

                field(frequencyPGS; Rec."Frequency PGS") { }

                field(internalProjectPGS; Rec."Internal Project PGS") { }

                field(lineManagerPGS; Rec."Line Manager PGS") { }

                field(vatProdPostingGroupPGS; Rec."VAT Prod. Posting Group PGS") { }

                field(vatBusPostingGroupPGS; Rec."VAT Bus. Posting Group PGS") { }

                field(resourceSubGroupNoPGS; Rec."Resource Sub Group No. PGS") { }

                field(serviceContractNoPGS; Rec."Service Contract No. PGS") { }

                field(referencePGS; Rec."Reference PGS") { }

                field(applyingEntryPGS; Rec."Applying Entry PGS") { }

                field(projectTypePGS; Rec."Project Type PGS") { }

                field(newUnitPriceLCYPGS; Rec."New Unit Price (LCY) PGS") { }

                field(customerProjectPGS; Rec."Customer Project PGS") { }

                field(amountToApplyPGS; Rec."Amount to Apply PGS") { }

                field(outlookUIDPGS; Rec."Outlook UID PGS") { }

                field(statusPGS; Rec."Status PGS") { }

                field(unitCostInclVATLCYPGS; Rec."Unit Cost Incl. VAT (LCY) PGS") { }

                field(unitCostInclVATPGS; Rec."Unit Cost Incl. VAT PGS") { }

                field(postponeToDatePGS; Rec."Postpone to Date PGS") { }

                field(postponeTimePGS; Rec."Postpone Time PGS") { }

                field(positivePGS; Rec."Positive PGS") { }

                field(openPGS; Rec."Open PGS") { }

                field(appliesToIDPGS; Rec."Applies-to ID PGS") { }

                field(chargeablePGS; Rec."Chargeable PGS") { }

                field(addCurrAmtToRecogPGS; Rec."Add.-Curr. Amt. to Recog. PGS") { }

                field(addCurrAmtToPostGLPGS; Rec."Add.-Curr.Amt.to Post G/L PGS") { }

                field(addCurrAmountRecogPGS; Rec."Add.-Curr. Amount Recog. PGS") { }

                field(addCurrAmtPostedGLPGS; Rec."Add.-Curr.Amt.Posted G/L PGS") { }

                field(createdDocumentTypePGS; Rec."Created Document Type PGS") { }

                field(createdDocumentNoPGS; Rec."Created Document No. PGS") { }

                field(timeSheetEntryNoPGS; Rec."Time Sheet Entry No. PGS") { }

                field(amtToRecognizePGS; Rec."Amt. to Recognize PGS") { }

                field(hourBankNoPGS; Rec."Hour Bank No. PGS") { }

                field(amtToPostToGLTMPPGS; Rec."Amt. to Post to G/L TMP PGS") { }

                field(amtToRecognizeTMPPGS; Rec."Amt. to Recognize TMP PGS") { }

                field(mainProfileCodePGS; Rec."Main Profile Code PGS") { }

                field(unitPriceToInvoiceLCYPGS; Rec."Unit price to invoice(LCY) PGS") { }

                field(costPriceToInvoiceLCYPGS; Rec."Cost price to invoice(LCY) PGS") { }

                field(unitPriceToInvoicePGS; Rec."Unit price to invoice PGS") { }

                field(costPriceToInvoicePGS; Rec."Cost price to invoice PGS") { }

                field(approvedPGS; Rec."Approved PGS") { }

                field(approvedByPGS; Rec."Approved By PGS") { }

                field(approvedDatePGS; Rec."Approved Date PGS") { }

                field(resourceTypePGS; Rec."Resource Type PGS") { }

                field(valueToInvoiceUsedPGS; Rec."Value to invoice Used PGS") { }

                field(approvedTimePGS; Rec."Approved Time PGS") { }

                field(costTypePGS; Rec."Cost Type PGS") { }

                field(payTypeCostFactorPGS; Rec."Pay Type Cost Factor PGS") { }

                field(timePayTypePGS; Rec."Time Pay Type PGS") { }

                field(payTypePriceFactorPGS; Rec."Pay Type Price Factor PGS") { }

                field(reversedPGS; Rec."Reversed PGS") { }

                field(reversedByEntryNoPGS; Rec."Reversed by Entry No. PGS") { }

                field(reversedEntryNoPGS; Rec."Reversed Entry No. PGS") { }

                field(periodStartDatePGS; Rec."Period Start Date PGS") { }

                field(expDocumentNoPGS; Rec."Exp Document No. PGS") { }

                field(expensePaymentTypePGS; Rec."Expense Payment Type PGS") { }

                field(expensePostingPGS; Rec."Expense Posting PGS") { }

                field(qtyToInvoicePGS; Rec."Qty to Invoice PGS") { }

                field(remainingQtyPGS; Rec."Remaining Qty PGS") { }

                field(manualQtyToInvoicePGS; Rec."Manual Qty to Invoice PGS") { }

                field(contractTypePGS; Rec."Contract Type PGS") { }

                field(usageValueTypePGS; Rec."Usage Value Type PGS") { }

                field(creditCardCodePGS; Rec."Credit Card Code PGS") { }

                field(purposePGS; Rec."Purpose PGS") { }

                field(expenseDatePGS; Rec."Expense Date PGS") { }

                field(retentionPGS; Rec."Retention % PGS") { }

                field(retentionOpenEntryPGS; Rec."Retention Open Entry PGS") { }

                field(subcontractNoPGS; Rec."Subcontract No. PGS") { }

                field(paymentRequestNoPGS; Rec."Payment Request No. PGS") { }

                field(vendorNoPGS; Rec."Vendor No PGS") { }

                field(includeCostPGS; Rec."Include Cost PGS") { }

                field(includePricePGS; Rec."Include Price PGS") { }

                field(paymentReqLineNoPGS; Rec."Payment Req Line No. PGS") { }

                field(createdPurchTypePGS; Rec."Created Purch. Type PGS") { }

                field(payReqEntryNoPGS; Rec."Pay Req Entry No. PGS") { }

                field(subcontractLineNoPGS; Rec."Subcontract Line No. PGS") { }

                field(payReqLineNoPGS; Rec."Pay Req Line No. PGS") { }

                field(description2PGS; Rec."Description 2 PGS") { }

                field(percentCompletePGS; Rec."Percent Complete PGS") { }

                field(closeLinePGS; Rec."Close Line PGS") { }

                field(deferralCodePGS; Rec."Deferral Code PGS") { }

                field(documentLineNoPGS; Rec."Document Line No. PGS") { }

                field(invoiceZeroPricePGS; Rec."Invoice Zero Price PGS") { }

                field(retentionEntryPGS; Rec."Retention Entry PGS") { }

                field(registerNoPGS; Rec."Register No. PGS") { }

                field(allocationPGS; Rec."Allocation PGS") { }

                field(allocWorkingEntryNoPGS; Rec."Alloc Working Entry No. PGS") { }

                field(allocSourceEntryNoPGS; Rec."Alloc Source Entry No. PGS") { }

                field(closedDatePGS; Rec."Closed Date PGS") { }

                field(closedEntryNoPGS; Rec."Closed Entry No. PGS") { }

                field(closedDetEntryNoPGS; Rec."Closed Det. Entry No. PGS") { }

                field(pctOfSplitBillingPGS; Rec."Pct of Split Billing PGS") { }

                field(subscriptionOrderNoPGS; Rec."Subscription Order No. PGS") { }

                field(subscrOrderLineNoPGS; Rec."Subscr. Order Line No. PGS") { }

                field(hideInSpecPGS; Rec."Hide in Spec. PGS") { }

                field(subscriptionStartDatePGS; Rec."Subscription Start Date PGS") { }

                field(subscriptionEndDatePGS; Rec."Subscription End Date PGS") { }

                field(systemId; Rec.SystemId) { }

                field(systemCreatedAt; Rec."SystemCreatedAt") { }

                field(systemCreatedBy; Rec."SystemCreatedBy") { }

                field(systemModifiedAt; Rec."SystemModifiedAt") { }

                field(systemModifiedBy; Rec."SystemModifiedBy") { }

            }
        }
    }
}
