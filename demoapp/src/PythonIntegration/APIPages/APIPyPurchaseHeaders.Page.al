namespace Weibel.Integration.Python;

using Microsoft.Purchases.Document;

page 70111 "COL API Py Purchase Headers"
{
    APIGroup = 'pythonData';
    APIPublisher = 'weibel';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Editable = false;
    DataAccessIntent = ReadOnly;
    EntityName = 'purchaseHeader';
    EntitySetName = 'purchaseHeaders';
    PageType = API;
    SourceTable = "Purchase Header";
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
                field(no; Rec."No.")
                {
                    Caption = 'No.', Locked = true;
                }
                field(payToVendorNo; Rec."Pay-to Vendor No.")
                {
                    Caption = 'Pay-to Vendor No.', Locked = true;
                }
                field(payToName; Rec."Pay-to Name")
                {
                    Caption = 'Pay-to Name', Locked = true;
                }
                field(payToName2; Rec."Pay-to Name 2")
                {
                    Caption = 'Pay-to Name 2', Locked = true;
                }
                field(payToAddress; Rec."Pay-to Address")
                {
                    Caption = 'Pay-to Address', Locked = true;
                }
                field(payToAddress2; Rec."Pay-to Address 2")
                {
                    Caption = 'Pay-to Address 2', Locked = true;
                }
                field(payToCity; Rec."Pay-to City")
                {
                    Caption = 'Pay-to City', Locked = true;
                }
                field(payToContact; Rec."Pay-to Contact")
                {
                    Caption = 'Pay-to Contact', Locked = true;
                }
                field(yourReference; Rec."Your Reference")
                {
                    Caption = 'Your Reference', Locked = true;
                }
                field(shipToCode; Rec."Ship-to Code")
                {
                    Caption = 'Ship-to Code', Locked = true;
                }
                field(shipToName; Rec."Ship-to Name")
                {
                    Caption = 'Ship-to Name', Locked = true;
                }
                field(shipToName2; Rec."Ship-to Name 2")
                {
                    Caption = 'Ship-to Name 2', Locked = true;
                }
                field(shipToAddress; Rec."Ship-to Address")
                {
                    Caption = 'Ship-to Address', Locked = true;
                }
                field(shipToAddress2; Rec."Ship-to Address 2")
                {
                    Caption = 'Ship-to Address 2', Locked = true;
                }
                field(shipToCity; Rec."Ship-to City")
                {
                    Caption = 'Ship-to City', Locked = true;
                }
                field(shipToContact; Rec."Ship-to Contact")
                {
                    Caption = 'Ship-to Contact', Locked = true;
                }
                field(orderDate; Rec."Order Date")
                {
                    Caption = 'Order Date', Locked = true;
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date', Locked = true;
                }
                field(expectedReceiptDate; Rec."Expected Receipt Date")
                {
                    Caption = 'Expected Receipt Date', Locked = true;
                }
                field(postingDescription; Rec."Posting Description")
                {
                    Caption = 'Posting Description', Locked = true;
                }
                field(paymentTermsCode; Rec."Payment Terms Code")
                {
                    Caption = 'Payment Terms Code', Locked = true;
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date', Locked = true;
                }
                field(paymentDiscount; Rec."Payment Discount %")
                {
                    Caption = 'Payment Discount %', Locked = true;
                }
                field(pmtDiscountDate; Rec."Pmt. Discount Date")
                {
                    Caption = 'Pmt. Discount Date', Locked = true;
                }
                field(shipmentMethodCode; Rec."Shipment Method Code")
                {
                    Caption = 'Shipment Method Code', Locked = true;
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code', Locked = true;
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code', Locked = true;
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code', Locked = true;
                }
                field(vendorPostingGroup; Rec."Vendor Posting Group")
                {
                    Caption = 'Vendor Posting Group', Locked = true;
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code', Locked = true;
                }
                field(currencyFactor; Rec."Currency Factor")
                {
                    Caption = 'Currency Factor', Locked = true;
                }
                field(pricesIncludingVAT; Rec."Prices Including VAT")
                {
                    Caption = 'Prices Including VAT', Locked = true;
                }
                field(invoiceDiscCode; Rec."Invoice Disc. Code")
                {
                    Caption = 'Invoice Disc. Code', Locked = true;
                }
                field(languageCode; Rec."Language Code")
                {
                    Caption = 'Language Code', Locked = true;
                }
                field(formatRegion; Rec."Format Region")
                {
                    Caption = 'Format Region', Locked = true;
                }
                field(purchaserCode; Rec."Purchaser Code")
                {
                    Caption = 'Purchaser Code', Locked = true;
                }
                field(orderClass; Rec."Order Class")
                {
                    Caption = 'Order Class', Locked = true;
                }
                // field(comment; Rec.Comment)
                // {
                //     Caption = 'Comment', Locked = true;
                // }
                field(noPrinted; Rec."No. Printed")
                {
                    Caption = 'No. Printed', Locked = true;
                }
                field(onHold; Rec."On Hold")
                {
                    Caption = 'On Hold', Locked = true;
                }
                field(appliesToDocType; Rec."Applies-to Doc. Type")
                {
                    Caption = 'Applies-to Doc. Type', Locked = true;
                }
                field(appliesToDocNo; Rec."Applies-to Doc. No.")
                {
                    Caption = 'Applies-to Doc. No.', Locked = true;
                }
                field(balAccountNo; Rec."Bal. Account No.")
                {
                    Caption = 'Bal. Account No.', Locked = true;
                }
                // field(recalculateInvoiceDisc; Rec."Recalculate Invoice Disc.")
                // {
                //     Caption = 'Recalculate Invoice Disc.', Locked = true;
                // }
                field(receive; Rec.Receive)
                {
                    Caption = 'Receive', Locked = true;
                }
                field(invoice; Rec.Invoice)
                {
                    Caption = 'Invoice', Locked = true;
                }
                field(printPostedDocuments; Rec."Print Posted Documents")
                {
                    Caption = 'Print Posted Documents', Locked = true;
                }
                // field(amount; Rec.Amount)
                // {
                //     Caption = 'Amount', Locked = true;
                // }
                // field(amountIncludingVAT; Rec."Amount Including VAT")
                // {
                //     Caption = 'Amount Including VAT', Locked = true;
                // }
                field(receivingNo; Rec."Receiving No.")
                {
                    Caption = 'Receiving No.', Locked = true;
                }
                field(postingNo; Rec."Posting No.")
                {
                    Caption = 'Posting No.', Locked = true;
                }
                field(lastReceivingNo; Rec."Last Receiving No.")
                {
                    Caption = 'Last Receiving No.', Locked = true;
                }
                field(lastPostingNo; Rec."Last Posting No.")
                {
                    Caption = 'Last Posting No.', Locked = true;
                }
                field(vendorOrderNo; Rec."Vendor Order No.")
                {
                    Caption = 'Vendor Order No.', Locked = true;
                }
                field(vendorShipmentNo; Rec."Vendor Shipment No.")
                {
                    Caption = 'Vendor Shipment No.', Locked = true;
                }
                field(vendorInvoiceNo; Rec."Vendor Invoice No.")
                {
                    Caption = 'Vendor Invoice No.', Locked = true;
                }
                field(vendorCrMemoNo; Rec."Vendor Cr. Memo No.")
                {
                    Caption = 'Vendor Cr. Memo No.', Locked = true;
                }
                field(vatRegistrationNo; Rec."VAT Registration No.")
                {
                    Caption = 'VAT Registration No.', Locked = true;
                }
                field(sellToCustomerNo; Rec."Sell-to Customer No.")
                {
                    Caption = 'Sell-to Customer No.', Locked = true;
                }
                field(reasonCode; Rec."Reason Code")
                {
                    Caption = 'Reason Code', Locked = true;
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    Caption = 'Gen. Bus. Posting Group', Locked = true;
                }
                field(transactionType; Rec."Transaction Type")
                {
                    Caption = 'Transaction Type', Locked = true;
                }
                field(transportMethod; Rec."Transport Method")
                {
                    Caption = 'Transport Method', Locked = true;
                }
                field(vatCountryRegionCode; Rec."VAT Country/Region Code")
                {
                    Caption = 'VAT Country/Region Code', Locked = true;
                }
                field(buyFromVendorName; Rec."Buy-from Vendor Name")
                {
                    Caption = 'Buy-from Vendor Name', Locked = true;
                }
                field(buyFromVendorName2; Rec."Buy-from Vendor Name 2")
                {
                    Caption = 'Buy-from Vendor Name 2', Locked = true;
                }
                field(buyFromAddress; Rec."Buy-from Address")
                {
                    Caption = 'Buy-from Address', Locked = true;
                }
                field(buyFromAddress2; Rec."Buy-from Address 2")
                {
                    Caption = 'Buy-from Address 2', Locked = true;
                }
                field(buyFromCity; Rec."Buy-from City")
                {
                    Caption = 'Buy-from City', Locked = true;
                }
                field(buyFromContact; Rec."Buy-from Contact")
                {
                    Caption = 'Buy-from Contact', Locked = true;
                }
                field(payToPostCode; Rec."Pay-to Post Code")
                {
                    Caption = 'Pay-to Post Code', Locked = true;
                }
                field(payToCounty; Rec."Pay-to County")
                {
                    Caption = 'Pay-to County', Locked = true;
                }
                field(payToCountryRegionCode; Rec."Pay-to Country/Region Code")
                {
                    Caption = 'Pay-to Country/Region Code', Locked = true;
                }
                field(buyFromPostCode; Rec."Buy-from Post Code")
                {
                    Caption = 'Buy-from Post Code', Locked = true;
                }
                field(buyFromCounty; Rec."Buy-from County")
                {
                    Caption = 'Buy-from County', Locked = true;
                }
                field(buyFromCountryRegionCode; Rec."Buy-from Country/Region Code")
                {
                    Caption = 'Buy-from Country/Region Code', Locked = true;
                }
                field(shipToPostCode; Rec."Ship-to Post Code")
                {
                    Caption = 'Ship-to Post Code', Locked = true;
                }
                field(shipToCounty; Rec."Ship-to County")
                {
                    Caption = 'Ship-to County', Locked = true;
                }
                field(shipToCountryRegionCode; Rec."Ship-to Country/Region Code")
                {
                    Caption = 'Ship-to Country/Region Code', Locked = true;
                }
                field(balAccountType; Rec."Bal. Account Type")
                {
                    Caption = 'Bal. Account Type', Locked = true;
                }
                field(orderAddressCode; Rec."Order Address Code")
                {
                    Caption = 'Order Address Code', Locked = true;
                }
                field(entryPoint; Rec."Entry Point")
                {
                    Caption = 'Entry Point', Locked = true;
                }
                field(correction; Rec.Correction)
                {
                    Caption = 'Correction', Locked = true;
                }
                field(documentDate; Rec."Document Date")
                {
                    Caption = 'Document Date', Locked = true;
                }
                field("area"; Rec."Area")
                {
                    Caption = 'Area', Locked = true;
                }
                field(transactionSpecification; Rec."Transaction Specification")
                {
                    Caption = 'Transaction Specification', Locked = true;
                }
                field(paymentMethodCode; Rec."Payment Method Code")
                {
                    Caption = 'Payment Method Code', Locked = true;
                }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series', Locked = true;
                }
                field(postingNoSeries; Rec."Posting No. Series")
                {
                    Caption = 'Posting No. Series', Locked = true;
                }
                field(receivingNoSeries; Rec."Receiving No. Series")
                {
                    Caption = 'Receiving No. Series', Locked = true;
                }
                field(taxAreaCode; Rec."Tax Area Code")
                {
                    Caption = 'Tax Area Code', Locked = true;
                }
                field(taxLiable; Rec."Tax Liable")
                {
                    Caption = 'Tax Liable', Locked = true;
                }
                field(vatBusPostingGroup; Rec."VAT Bus. Posting Group")
                {
                    Caption = 'VAT Bus. Posting Group', Locked = true;
                }
                field(appliesToID; Rec."Applies-to ID")
                {
                    Caption = 'Applies-to ID', Locked = true;
                }
                field(vatBaseDiscount; Rec."VAT Base Discount %")
                {
                    Caption = 'VAT Base Discount %', Locked = true;
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status', Locked = true;
                }
                field(invoiceDiscountCalculation; Rec."Invoice Discount Calculation")
                {
                    Caption = 'Invoice Discount Calculation', Locked = true;
                }
                field(invoiceDiscountValue; Rec."Invoice Discount Value")
                {
                    Caption = 'Invoice Discount Value', Locked = true;
                }
                field(sendICDocument; Rec."Send IC Document")
                {
                    Caption = 'Send IC Document', Locked = true;
                }
                field(icStatus; Rec."IC Status")
                {
                    Caption = 'IC Status', Locked = true;
                }
                field(buyFromICPartnerCode; Rec."Buy-from IC Partner Code")
                {
                    Caption = 'Buy-from IC Partner Code', Locked = true;
                }
                field(payToICPartnerCode; Rec."Pay-to IC Partner Code")
                {
                    Caption = 'Pay-to IC Partner Code', Locked = true;
                }
                field(icReferenceDocumentNo; Rec."IC Reference Document No.")
                {
                    Caption = 'IC Reference Document No.', Locked = true;
                }
                field(icDirection; Rec."IC Direction")
                {
                    Caption = 'IC Direction', Locked = true;
                }
                field(prepaymentNo; Rec."Prepayment No.")
                {
                    Caption = 'Prepayment No.', Locked = true;
                }
                field(lastPrepaymentNo; Rec."Last Prepayment No.")
                {
                    Caption = 'Last Prepayment No.', Locked = true;
                }
                field(prepmtCrMemoNo; Rec."Prepmt. Cr. Memo No.")
                {
                    Caption = 'Prepmt. Cr. Memo No.', Locked = true;
                }
                field(lastPrepmtCrMemoNo; Rec."Last Prepmt. Cr. Memo No.")
                {
                    Caption = 'Last Prepmt. Cr. Memo No.', Locked = true;
                }
                field(prepayment; Rec."Prepayment %")
                {
                    Caption = 'Prepayment %', Locked = true;
                }
                field(prepaymentNoSeries; Rec."Prepayment No. Series")
                {
                    Caption = 'Prepayment No. Series', Locked = true;
                }
                field(compressPrepayment; Rec."Compress Prepayment")
                {
                    Caption = 'Compress Prepayment', Locked = true;
                }
                field(prepaymentDueDate; Rec."Prepayment Due Date")
                {
                    Caption = 'Prepayment Due Date', Locked = true;
                }
                field(prepmtCrMemoNoSeries; Rec."Prepmt. Cr. Memo No. Series")
                {
                    Caption = 'Prepmt. Cr. Memo No. Series', Locked = true;
                }
                field(prepmtPostingDescription; Rec."Prepmt. Posting Description")
                {
                    Caption = 'Prepmt. Posting Description', Locked = true;
                }
                field(prepmtPmtDiscountDate; Rec."Prepmt. Pmt. Discount Date")
                {
                    Caption = 'Prepmt. Pmt. Discount Date', Locked = true;
                }
                field(prepmtPaymentTermsCode; Rec."Prepmt. Payment Terms Code")
                {
                    Caption = 'Prepmt. Payment Terms Code', Locked = true;
                }
                field(prepmtPaymentDiscount; Rec."Prepmt. Payment Discount %")
                {
                    Caption = 'Prepmt. Payment Discount %', Locked = true;
                }
                field(quoteNo; Rec."Quote No.")
                {
                    Caption = 'Quote No.', Locked = true;
                }
                field(jobQueueStatus; Rec."Job Queue Status")
                {
                    Caption = 'Job Queue Status', Locked = true;
                }
                field(jobQueueEntryID; Rec."Job Queue Entry ID")
                {
                    Caption = 'Job Queue Entry ID', Locked = true;
                }
                field(incomingDocumentEntryNo; Rec."Incoming Document Entry No.")
                {
                    Caption = 'Incoming Document Entry No.', Locked = true;
                }
                field(creditorNo; Rec."Creditor No.")
                {
                    Caption = 'Creditor No.', Locked = true;
                }
                field(paymentReference; Rec."Payment Reference")
                {
                    Caption = 'Payment Reference', Locked = true;
                }
                field(invoiceReceivedDate; Rec."Invoice Received Date")
                {
                    Caption = 'Invoice Received Date', Locked = true;
                }
                field(journalTemplName; Rec."Journal Templ. Name")
                {
                    Caption = 'Journal Template Name', Locked = true;
                }
                field(vatReportingDate; Rec."VAT Reporting Date")
                {
                    Caption = 'VAT Date', Locked = true;
                }
#if not BC24
                field(shipToPhoneNo; Rec."Ship-to Phone No.")
                {
                    Caption = 'Ship-to Phone No.', Locked = true;
                }
#endif
                // field(aRcdNotInvExVATLCY; Rec."A. Rcd. Not Inv. Ex. VAT (LCY)")
                // {
                //     Caption = 'Amount Received Not Invoiced (LCY)', Locked = true;
                // }
                // field(amtRcdNotInvoicedLCY; Rec."Amt. Rcd. Not Invoiced (LCY)")
                // {
                //     Caption = 'Amount Received Not Invoiced (LCY) Incl. VAT', Locked = true;
                // }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID', Locked = true;
                }
                field(remitToCode; Rec."Remit-to Code")
                {
                    Caption = 'Remit-to Code', Locked = true;
                }
                // field(invoiceDiscountAmount; Rec."Invoice Discount Amount")
                // {
                //     Caption = 'Invoice Discount Amount', Locked = true;
                // }
                // field(noOfArchivedVersions; Rec."No. of Archived Versions")
                // {
                //     Caption = 'No. of Archived Versions', Locked = true;
                // }
                field(docNoOccurrence; Rec."Doc. No. Occurrence")
                {
                    Caption = 'Doc. No. Occurrence', Locked = true;
                }
                field(campaignNo; Rec."Campaign No.")
                {
                    Caption = 'Campaign No.', Locked = true;
                }
                field(buyFromContactNo; Rec."Buy-from Contact No.")
                {
                    Caption = 'Buy-from Contact No.', Locked = true;
                }
                field(payToContactNo; Rec."Pay-to Contact No.")
                {
                    Caption = 'Pay-to Contact No.', Locked = true;
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center', Locked = true;
                }
                // field(partiallyInvoiced; Rec."Partially Invoiced")
                // {
                //     Caption = 'Partially Invoiced', Locked = true;
                // }
                // field(completelyReceived; Rec."Completely Received")
                // {
                //     Caption = 'Completely Received', Locked = true;
                // }
                field(postingFromWhseRef; Rec."Posting from Whse. Ref.")
                {
                    Caption = 'Posting from Whse. Ref.', Locked = true;
                }
                // field(receivedNotInvoiced; Rec."Received Not Invoiced")
                // {
                //     Caption = 'Received Not Invoiced', Locked = true;
                // }
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
                field(vendorAuthorizationNo; Rec."Vendor Authorization No.")
                {
                    Caption = 'Vendor Authorization No.', Locked = true;
                }
                field(returnShipmentNo; Rec."Return Shipment No.")
                {
                    Caption = 'Return Shipment No.', Locked = true;
                }
                field(returnShipmentNoSeries; Rec."Return Shipment No. Series")
                {
                    Caption = 'Return Shipment No. Series', Locked = true;
                }
                field(ship; Rec.Ship)
                {
                    Caption = 'Ship', Locked = true;
                }
                field(lastReturnShipmentNo; Rec."Last Return Shipment No.")
                {
                    Caption = 'Last Return Shipment No.', Locked = true;
                }
                field(priceCalculationMethod; Rec."Price Calculation Method")
                {
                    Caption = 'Price Calculation Method', Locked = true;
                }
                field(assignedUserID; Rec."Assigned User ID")
                {
                    Caption = 'Assigned User ID', Locked = true;
                }
                // field(pendingApprovals; Rec."Pending Approvals")
                // {
                //     Caption = 'Pending Approvals', Locked = true;
                // }
                field(projectNoPGS; Rec."Project No. PGS")
                {
                    Caption = 'Project No.', Locked = true;
                }
                field(expDocumentNoPGS; Rec."Exp Document No. PGS")
                {
                    Caption = 'Exp Document No.', Locked = true;
                }
                field(subcontractPGS; Rec."Subcontract PGS")
                {
                    Caption = 'Subcontract', Locked = true;
                }
                field(payReqNoPGS; Rec."Pay Req No. PGS")
                {
                    Caption = 'Pay Req No.', Locked = true;
                }
                field(jobLedEntryNoPGS; Rec."Job Led. Entry No. PGS")
                {
                    Caption = 'Job Ledger Entry No.', Locked = true;
                }
                field(purchaseReceiptPostingPGS; Rec."Purchase Receipt Posting PGS")
                {
                    Caption = 'Purchase Receipt Posting', Locked = true;
                }
            }
        }
    }
}
