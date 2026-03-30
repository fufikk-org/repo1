namespace Weibel.API;

using Microsoft.Sales.Document;

page 70190 "COL Sales Headers API"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'salesHeader';
    EntitySetName = 'salesHeaders';
    PageType = API;
    SourceTable = "Sales Header";
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
                field(no; Rec."No.")
                {
                    Caption = 'No.', Locked = true;
                }
                field(billToCustomerNo; Rec."Bill-to Customer No.")
                {
                    Caption = 'Bill-to Customer No.', Locked = true;
                }
                field(billToName; Rec."Bill-to Name")
                {
                    Caption = 'Bill-to Name', Locked = true;
                }
                field(billToName2; Rec."Bill-to Name 2")
                {
                    Caption = 'Bill-to Name 2', Locked = true;
                }
                field(billToAddress; Rec."Bill-to Address")
                {
                    Caption = 'Bill-to Address', Locked = true;
                }
                field(billToAddress2; Rec."Bill-to Address 2")
                {
                    Caption = 'Bill-to Address 2', Locked = true;
                }
                field(billToCity; Rec."Bill-to City")
                {
                    Caption = 'Bill-to City', Locked = true;
                }
                field(billToContact; Rec."Bill-to Contact")
                {
                    Caption = 'Bill-to Contact', Locked = true;
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
                field(shipmentDate; Rec."Shipment Date")
                {
                    Caption = 'Shipment Date', Locked = true;
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
                field(customerPostingGroup; Rec."Customer Posting Group")
                {
                    Caption = 'Customer Posting Group', Locked = true;
                }
                field(currencyCode; Rec."Currency Code")
                {
                    Caption = 'Currency Code', Locked = true;
                }
                field(currencyFactor; Rec."Currency Factor")
                {
                    Caption = 'Currency Factor', Locked = true;
                }
                field(customerPriceGroup; Rec."Customer Price Group")
                {
                    Caption = 'Customer Price Group', Locked = true;
                }
                field(pricesIncludingVAT; Rec."Prices Including VAT")
                {
                    Caption = 'Prices Including VAT', Locked = true;
                }
                field(invoiceDiscCode; Rec."Invoice Disc. Code")
                {
                    Caption = 'Invoice Disc. Code', Locked = true;
                }
                field(customerDiscGroup; Rec."Customer Disc. Group")
                {
                    Caption = 'Customer Disc. Group', Locked = true;
                }
                field(languageCode; Rec."Language Code")
                {
                    Caption = 'Language Code', Locked = true;
                }
                field(formatRegion; Rec."Format Region")
                {
                    Caption = 'Format Region', Locked = true;
                }
                field(salespersonCode; Rec."Salesperson Code")
                {
                    Caption = 'Salesperson Code', Locked = true;
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
                field(ship; Rec.Ship)
                {
                    Caption = 'Ship', Locked = true;
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
                field(shippingNo; Rec."Shipping No.")
                {
                    Caption = 'Shipping No.', Locked = true;
                }
                field(postingNo; Rec."Posting No.")
                {
                    Caption = 'Posting No.', Locked = true;
                }
                field(lastShippingNo; Rec."Last Shipping No.")
                {
                    Caption = 'Last Shipping No.', Locked = true;
                }
                field(lastPostingNo; Rec."Last Posting No.")
                {
                    Caption = 'Last Posting No.', Locked = true;
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
                field(vatRegistrationNo; Rec."VAT Registration No.")
                {
                    Caption = 'VAT Registration No.', Locked = true;
                }
                field(combineShipments; Rec."Combine Shipments")
                {
                    Caption = 'Combine Shipments', Locked = true;
                }
                field(registrationNumber; Rec."Registration Number")
                {
                    Caption = 'Registration No.', Locked = true;
                }
                field(reasonCode; Rec."Reason Code")
                {
                    Caption = 'Reason Code', Locked = true;
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                    Caption = 'Gen. Bus. Posting Group', Locked = true;
                }
                field(eu3PartyTrade; Rec."EU 3-Party Trade")
                {
                    Caption = 'EU 3-Party Trade', Locked = true;
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
                field(sellToCustomerName; Rec."Sell-to Customer Name")
                {
                    Caption = 'Sell-to Customer Name', Locked = true;
                }
                field(sellToCustomerName2; Rec."Sell-to Customer Name 2")
                {
                    Caption = 'Sell-to Customer Name 2', Locked = true;
                }
                field(sellToAddress; Rec."Sell-to Address")
                {
                    Caption = 'Sell-to Address', Locked = true;
                }
                field(sellToAddress2; Rec."Sell-to Address 2")
                {
                    Caption = 'Sell-to Address 2', Locked = true;
                }
                field(sellToCity; Rec."Sell-to City")
                {
                    Caption = 'Sell-to City', Locked = true;
                }
                field(sellToContact; Rec."Sell-to Contact")
                {
                    Caption = 'Sell-to Contact', Locked = true;
                }
                field(billToPostCode; Rec."Bill-to Post Code")
                {
                    Caption = 'Bill-to Post Code', Locked = true;
                }
                field(billToCounty; Rec."Bill-to County")
                {
                    Caption = 'Bill-to County', Locked = true;
                }
                field(billToCountryRegionCode; Rec."Bill-to Country/Region Code")
                {
                    Caption = 'Bill-to Country/Region Code', Locked = true;
                }
                field(sellToPostCode; Rec."Sell-to Post Code")
                {
                    Caption = 'Sell-to Post Code', Locked = true;
                }
                field(sellToCounty; Rec."Sell-to County")
                {
                    Caption = 'Sell-to County', Locked = true;
                }
                field(sellToCountryRegionCode; Rec."Sell-to Country/Region Code")
                {
                    Caption = 'Sell-to Country/Region Code', Locked = true;
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
                field(exitPoint; Rec."Exit Point")
                {
                    Caption = 'Exit Point', Locked = true;
                }
                field(correction; Rec.Correction)
                {
                    Caption = 'Correction', Locked = true;
                }
                field(documentDate; Rec."Document Date")
                {
                    Caption = 'Document Date', Locked = true;
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                    Caption = 'External Document No.', Locked = true;
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
                field(shippingAgentCode; Rec."Shipping Agent Code")
                {
                    Caption = 'Shipping Agent Code', Locked = true;
                }
                // field(packageTrackingNo; Rec."Package Tracking No.")
                // {
                //     Caption = 'Package Tracking No.', Locked = true;
                // }
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series', Locked = true;
                }
                field(postingNoSeries; Rec."Posting No. Series")
                {
                    Caption = 'Posting No. Series', Locked = true;
                }
                field(shippingNoSeries; Rec."Shipping No. Series")
                {
                    Caption = 'Shipping No. Series', Locked = true;
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
                field(reserve; Rec.Reserve)
                {
                    Caption = 'Reserve', Locked = true;
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
                field(sellToICPartnerCode; Rec."Sell-to IC Partner Code")
                {
                    Caption = 'Sell-to IC Partner Code', Locked = true;
                }
                field(billToICPartnerCode; Rec."Bill-to IC Partner Code")
                {
                    Caption = 'Bill-to IC Partner Code', Locked = true;
                }
                field(icReferenceDocumentNo; Rec."IC Reference Document No.")
                {
                    Caption = 'IC Reference Document No.', Locked = true;
                }
                field(icDirection; Rec."IC Direction")
                {
                    Caption = 'IC Direction', Locked = true;
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
                field(quoteValidUntilDate; Rec."Quote Valid Until Date")
                {
                    Caption = 'Quote Valid To Date', Locked = true;
                }
                field(quoteSentToCustomer; Rec."Quote Sent to Customer")
                {
                    Caption = 'Quote Sent to Customer', Locked = true;
                }
                field(quoteAccepted; Rec."Quote Accepted")
                {
                    Caption = 'Quote Accepted', Locked = true;
                }
                field(quoteAcceptedDate; Rec."Quote Accepted Date")
                {
                    Caption = 'Quote Accepted Date', Locked = true;
                }
                field(jobQueueStatus; Rec."Job Queue Status")
                {
                    Caption = 'Job Queue Status', Locked = true;
                }
                field(jobQueueEntryID; Rec."Job Queue Entry ID")
                {
                    Caption = 'Job Queue Entry ID', Locked = true;
                }
                field(companyBankAccountCode; Rec."Company Bank Account Code")
                {
                    Caption = 'Company Bank Account Code', Locked = true;
                }
                field(incomingDocumentEntryNo; Rec."Incoming Document Entry No.")
                {
                    Caption = 'Incoming Document Entry No.', Locked = true;
                }
#if not BC24
                field(altVATRegistrationNo; Rec."Alt. VAT Registration No.")
                {
                    Caption = 'Alternative VAT Registration No.', Locked = true;
                }
                field(altGenBusPostingGroup; Rec."Alt. Gen. Bus Posting Group")
                {
                    Caption = 'Alternative Gen. Bus. Posting Group', Locked = true;
                }
                field(altVATBusPostingGroup; Rec."Alt. VAT Bus Posting Group")
                {
                    Caption = 'Alternative VAT Bus. Posting Group', Locked = true;
                }
#endif
                field(isTest; Rec.IsTest)
                {
                    Caption = 'IsTest', Locked = true;
                }
                field(sellToPhoneNo; Rec."Sell-to Phone No.")
                {
                    Caption = 'Sell-to Phone No.', Locked = true;
                }
                field(sellToEMail; Rec."Sell-to E-Mail")
                {
                    Caption = 'Email', Locked = true;
                }
                field(journalTemplName; Rec."Journal Templ. Name")
                {
                    Caption = 'Journal Template Name', Locked = true;
                }
                field(vatReportingDate; Rec."VAT Reporting Date")
                {
                    Caption = 'VAT Date', Locked = true;
                }
                field(rcvdFromCountRegionCode; Rec."Rcvd.-from Count./Region Code")
                {
                    Caption = 'Received-from Country/Region Code', Locked = true;
                }
#if not BC24
                field(lastEmailSentTime; Rec."Last Email Sent Time")
                {
                    Caption = 'Last Email Sent Time', Locked = true;
                }
                field(lastEmailSentMessageId; Rec."Last Email Sent Message Id")
                {
                    Caption = 'Last Email Sent Message Id', Locked = true;
                }
#endif
                field(workDescription; Rec."Work Description")
                {
                    Caption = 'Work Description', Locked = true;
                }
#if not BC24
                field(shipToPhoneNo; Rec."Ship-to Phone No.")
                {
                    Caption = 'Ship-to Phone No.', Locked = true;
                }
#endif
                // field(amtShipNotInvLCY; Rec."Amt. Ship. Not Inv. (LCY)")
                // {
                //     Caption = 'Amount Shipped Not Invoiced (LCY) Incl. VAT', Locked = true;
                // }
                // field(amtShipNotInvLCYBase; Rec."Amt. Ship. Not Inv. (LCY) Base")
                // {
                //     Caption = 'Amount Shipped Not Invoiced (LCY)', Locked = true;
                // }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID', Locked = true;
                }
                field(paymentServiceSetID; Rec."Payment Service Set ID")
                {
                    Caption = 'Payment Service Set ID', Locked = true;
                }
                // field(coupledToDataverse; Rec."Coupled to Dataverse")
                // {
                //     Caption = 'Coupled to Dynamics 365 Sales', Locked = true;
                // }
                field(directDebitMandateID; Rec."Direct Debit Mandate ID")
                {
                    Caption = 'Direct Debit Mandate ID', Locked = true;
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
                field(sellToContactNo; Rec."Sell-to Contact No.")
                {
                    Caption = 'Sell-to Contact No.', Locked = true;
                }
                field(billToContactNo; Rec."Bill-to Contact No.")
                {
                    Caption = 'Bill-to Contact No.', Locked = true;
                }
                field(opportunityNo; Rec."Opportunity No.")
                {
                    Caption = 'Opportunity No.', Locked = true;
                }
                field(sellToCustomerTemplCode; Rec."Sell-to Customer Templ. Code")
                {
                    Caption = 'Sell-to Customer Template Code', Locked = true;
                }
                field(billToCustomerTemplCode; Rec."Bill-to Customer Templ. Code")
                {
                    Caption = 'Bill-to Customer Template Code', Locked = true;
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center', Locked = true;
                }
                field(shippingAdvice; Rec."Shipping Advice")
                {
                    Caption = 'Shipping Advice', Locked = true;
                }
                // field(shippedNotInvoiced; Rec."Shipped Not Invoiced")
                // {
                //     Caption = 'Shipped Not Invoiced', Locked = true;
                // }
                // field(completelyShipped; Rec."Completely Shipped")
                // {
                //     Caption = 'Completely Shipped', Locked = true;
                // }
                field(postingFromWhseRef; Rec."Posting from Whse. Ref.")
                {
                    Caption = 'Posting from Whse. Ref.', Locked = true;
                }
                // field(shipped; Rec.Shipped)
                // {
                //     Caption = 'Shipped', Locked = true;
                // }
                // field(lastShipmentDate; Rec."Last Shipment Date")
                // {
                //     Caption = 'Last Shipment Date', Locked = true;
                // }
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
                field(shippingAgentServiceCode; Rec."Shipping Agent Service Code")
                {
                    Caption = 'Shipping Agent Service Code', Locked = true;
                }
                // field(lateOrderShipping; Rec."Late Order Shipping")
                // {
                //     Caption = 'Late Order Shipping', Locked = true;
                // }
                field(receive; Rec.Receive)
                {
                    Caption = 'Receive', Locked = true;
                }
                field(returnReceiptNo; Rec."Return Receipt No.")
                {
                    Caption = 'Return Receipt No.', Locked = true;
                }
                field(returnReceiptNoSeries; Rec."Return Receipt No. Series")
                {
                    Caption = 'Return Receipt No. Series', Locked = true;
                }
                field(lastReturnReceiptNo; Rec."Last Return Receipt No.")
                {
                    Caption = 'Last Return Receipt No.', Locked = true;
                }
                field(priceCalculationMethod; Rec."Price Calculation Method")
                {
                    Caption = 'Price Calculation Method', Locked = true;
                }
                field(allowLineDisc; Rec."Allow Line Disc.")
                {
                    Caption = 'Allow Line Disc.', Locked = true;
                }
                field(getShipmentUsed; Rec."Get Shipment Used")
                {
                    Caption = 'Get Shipment Used', Locked = true;
                }
                field(assignedUserID; Rec."Assigned User ID")
                {
                    Caption = 'Assigned User ID', Locked = true;
                }
                field(colShippingStatus; Rec."COL Shipping Status")
                {
                    Caption = 'Shipping Status', Locked = true;
                }
                field(colOriginalContractualDate; Rec."COL Original Contractual Date")
                {
                    Caption = 'Original Contractual Date', Locked = true;
                }
                field(colEndUserType; Rec."COL End User Type")
                {
                    Caption = 'End User Type', Locked = true;
                }
                field(colExistingEndUserNo; Rec."COL Existing End User No.")
                {
                    Caption = 'Existing End User No.', Locked = true;
                }
                field(colEndUserName; Rec."COL End User Name")
                {
                    Caption = 'End User Name', Locked = true;
                }
                field(colEndUserName2; Rec."COL End User Name 2")
                {
                    Caption = 'End User Name 2', Locked = true;
                }
                field(colEndUserAddress; Rec."COL End User Address")
                {
                    Caption = 'End User Address', Locked = true;
                }
                field(colEndUserAddress2; Rec."COL End User Address 2")
                {
                    Caption = 'End User Address 2', Locked = true;
                }
                field(colEndUserCity; Rec."COL End User City")
                {
                    Caption = 'End User City', Locked = true;
                }
                field(colEndUserPostCode; Rec."COL End User Post Code")
                {
                    Caption = 'End User Post Code', Locked = true;
                }
                field(colEndUserCounty; Rec."COL End User County")
                {
                    Caption = 'End User County', Locked = true;
                }
                field(colEndUserCountryRegion; Rec."COL End User Country/Region")
                {
                    Caption = 'End User Country/Region Code', Locked = true;
                }
                field(colEndUserEMail; Rec."COL End User E-Mail")
                {
                    Caption = 'End User Email', Locked = true;
                }
                field(colOldProjectCode; Rec."COL Old Project Code")
                {
                    Caption = 'Old Project Code', Locked = true;
                }
                field(projectNoPGS; Rec."Project No. PGS")
                {
                    Caption = 'Project No.', Locked = true;
                }
                field(mainProjectNoPGS; Rec."Main Project No. PGS")
                {
                    Caption = 'Contract No.', Locked = true;
                }
                field(projectManagerCodePGS; Rec."Project Manager Code PGS")
                {
                    Caption = 'Project Manager Code', Locked = true;
                }
                field(percentCompleteBillingPGS; Rec."Percent Complete Billing PGS")
                {
                    Caption = '% Complete Billing', Locked = true;
                }
                field(externalProjectNoPGS; Rec."External Project No. PGS")
                {
                    Caption = 'External Project No.', Locked = true;
                }
                field(documentSourcePGS; Rec."Document Source PGS")
                {
                    Caption = 'Document Source', Locked = true;
                }
                field(colSalesOrderCategory; Rec."COL Sales Order Category")
                {
                    Caption = 'Sales Order Category', Locked = true;
                }
                field(colDescription; Rec."COL Description")
                {
                    Caption = 'Description', Locked = true;
                }
                field(colProjectName; Rec."COL Project Name")
                {
                    Caption = 'Project Name', Locked = true;
                }
                field(colNoOfPackagesManual; Rec."COL No. of Packages Manual")
                {
                }
                field(colTotalGrossWeightManual; Rec."COL Total Gross Weight Manual")
                {
                }
                field(colExportClassificationCode; Rec."COL Export Classification Code")
                {
                }
                field(colExportPermitNo; Rec."COL Export Permit No.")
                {
                }
                field(colWarrantyCode; Rec."COL Warranty Code")
                {
                }
                field(systemCreatedAt; Rec."SystemCreatedAt") { }

                field(systemCreatedBy; Rec."SystemCreatedBy") { }

                field(systemModifiedAt; Rec."SystemModifiedAt") { }

                field(systemModifiedBy; Rec."SystemModifiedBy") { }
            }
        }
    }
}
