namespace Weibel.API;

using Microsoft.Purchases.Payables;

page 70179 "COL Vendor Ledger Entries"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'vendorLedgerEntry';
    EntitySetName = 'vendorLedgerEntries';
    PageType = API;
    SourceTable = "Vendor Ledger Entry";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(entryNo; Rec."Entry No.")
                {
                }
                field(vendorNo; Rec."Vendor No.")
                {
                }
                field(postingDate; Rec."Posting Date")
                {
                }
                field(documentType; Rec."Document Type")
                {
                }
                field(documentNo; Rec."Document No.")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(vendorName; Rec."Vendor Name")
                {
                }
                field(currencyCode; Rec."Currency Code")
                {
                }
                field(amount; Rec.Amount)
                {
                }
                field(remainingAmount; Rec."Remaining Amount")
                {
                }
                field(originalAmtLCY; Rec."Original Amt. (LCY)")
                {
                }
                field(remainingAmtLCY; Rec."Remaining Amt. (LCY)")
                {
                }
                field(amountLCY; Rec."Amount (LCY)")
                {
                }
                field(purchaseLCY; Rec."Purchase (LCY)")
                {
                }
                field(invDiscountLCY; Rec."Inv. Discount (LCY)")
                {
                }
                field(buyFromVendorNo; Rec."Buy-from Vendor No.")
                {
                }
                field(vendorPostingGroup; Rec."Vendor Posting Group")
                {
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                }
                field(purchaserCode; Rec."Purchaser Code")
                {
                }
                field("userID"; Rec."User ID")
                {
                }
                field(sourceCode; Rec."Source Code")
                {
                }
                field(onHold; Rec."On Hold")
                {
                }
                field(appliesToDocType; Rec."Applies-to Doc. Type")
                {
                }
                field(appliesToDocNo; Rec."Applies-to Doc. No.")
                {
                }
                field(open; Rec.Open)
                {
                }
                field(dueDate; Rec."Due Date")
                {
                }
                field(pmtDiscountDate; Rec."Pmt. Discount Date")
                {
                }
                field(originalPmtDiscPossible; Rec."Original Pmt. Disc. Possible")
                {
                }
                field(pmtDiscRcdLCY; Rec."Pmt. Disc. Rcd.(LCY)")
                {
                }
                field(origPmtDiscPossibleLCY; Rec."Orig. Pmt. Disc. Possible(LCY)")
                {
                }
                field(positive; Rec.Positive)
                {
                }
                field(closedByEntryNo; Rec."Closed by Entry No.")
                {
                }
                field(closedAtDate; Rec."Closed at Date")
                {
                }
                field(closedByAmount; Rec."Closed by Amount")
                {
                }
                field(appliesToID; Rec."Applies-to ID")
                {
                }
                field(journalTemplName; Rec."Journal Templ. Name")
                {
                }
                field(journalBatchName; Rec."Journal Batch Name")
                {
                }
                field(reasonCode; Rec."Reason Code")
                {
                }
                field(balAccountType; Rec."Bal. Account Type")
                {
                }
                field(balAccountNo; Rec."Bal. Account No.")
                {
                }
                field(transactionNo; Rec."Transaction No.")
                {
                }
                field(closedByAmountLCY; Rec."Closed by Amount (LCY)")
                {
                }
                field(debitAmount; Rec."Debit Amount")
                {
                }
                field(creditAmount; Rec."Credit Amount")
                {
                }
                field(debitAmountLCY; Rec."Debit Amount (LCY)")
                {
                }
                field(creditAmountLCY; Rec."Credit Amount (LCY)")
                {
                }
                field(documentDate; Rec."Document Date")
                {
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                }
                field(noSeries; Rec."No. Series")
                {
                }
                field(closedByCurrencyCode; Rec."Closed by Currency Code")
                {
                }
                field(closedByCurrencyAmount; Rec."Closed by Currency Amount")
                {
                }
                field(adjustedCurrencyFactor; Rec."Adjusted Currency Factor")
                {
                }
                field(originalCurrencyFactor; Rec."Original Currency Factor")
                {
                }
                field(originalAmount; Rec."Original Amount")
                {
                }
                field(remainingPmtDiscPossible; Rec."Remaining Pmt. Disc. Possible")
                {
                }
                field(pmtDiscToleranceDate; Rec."Pmt. Disc. Tolerance Date")
                {
                }
                field(maxPaymentTolerance; Rec."Max. Payment Tolerance")
                {
                }
                field(acceptedPaymentTolerance; Rec."Accepted Payment Tolerance")
                {
                }
                field(acceptedPmtDiscTolerance; Rec."Accepted Pmt. Disc. Tolerance")
                {
                }
                field(pmtToleranceLCY; Rec."Pmt. Tolerance (LCY)")
                {
                }
                field(amountToApply; Rec."Amount to Apply")
                {
                }
                field(icPartnerCode; Rec."IC Partner Code")
                {
                }
                field(applyingEntry; Rec."Applying Entry")
                {
                }
                field(reversed; Rec.Reversed)
                {
                }
                field(reversedByEntryNo; Rec."Reversed by Entry No.")
                {
                }
                field(reversedEntryNo; Rec."Reversed Entry No.")
                {
                }
                field(prepayment; Rec.Prepayment)
                {
                }
                field(creditorNo; Rec."Creditor No.")
                {
                }
                field(paymentReference; Rec."Payment Reference")
                {
                }
                field(paymentMethodCode; Rec."Payment Method Code")
                {
                }
                field(appliesToExtDocNo; Rec."Applies-to Ext. Doc. No.")
                {
                }
                field(invoiceReceivedDate; Rec."Invoice Received Date")
                {
                }
                field(recipientBankAccount; Rec."Recipient Bank Account")
                {
                }
                field(messageToRecipient; Rec."Message to Recipient")
                {
                }
                field(exportedToPaymentFile; Rec."Exported to Payment File")
                {
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                }
                field(shortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                {
                }
                field(shortcutDimension4Code; Rec."Shortcut Dimension 4 Code")
                {
                }
                field(shortcutDimension5Code; Rec."Shortcut Dimension 5 Code")
                {
                }
                field(shortcutDimension6Code; Rec."Shortcut Dimension 6 Code")
                {
                }
                field(shortcutDimension7Code; Rec."Shortcut Dimension 7 Code")
                {
                }
                field(shortcutDimension8Code; Rec."Shortcut Dimension 8 Code")
                {
                }
                field(remitToCode; Rec."Remit-to Code")
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
