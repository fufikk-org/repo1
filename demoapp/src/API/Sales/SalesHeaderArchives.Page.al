namespace Weibel.API;

using Microsoft.Sales.Archive;

page 70176 "COL Sales Header Archives"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'salesHeaderArchive';
    EntitySetName = 'salesHeaderArchives';
    PageType = API;
    SourceTable = "Sales Header Archive";
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
                field(no; Rec."No.")
                {
                }
                field(billToCustomerNo; Rec."Bill-to Customer No.")
                {
                }
                field(billToName; Rec."Bill-to Name")
                {
                }
                field(billToName2; Rec."Bill-to Name 2")
                {
                }
                field(billToAddress; Rec."Bill-to Address")
                {
                }
                field(billToAddress2; Rec."Bill-to Address 2")
                {
                }
                field(billToCity; Rec."Bill-to City")
                {
                }
                field(billToContact; Rec."Bill-to Contact")
                {
                }
                field(yourReference; Rec."Your Reference")
                {
                }
                field(shipToCode; Rec."Ship-to Code")
                {
                }
                field(shipToName; Rec."Ship-to Name")
                {
                }
                field(shipToName2; Rec."Ship-to Name 2")
                {
                }
                field(shipToAddress; Rec."Ship-to Address")
                {
                }
                field(shipToAddress2; Rec."Ship-to Address 2")
                {
                }
                field(shipToCity; Rec."Ship-to City")
                {
                }
                field(shipToContact; Rec."Ship-to Contact")
                {
                }
                field(orderDate; Rec."Order Date")
                {
                }
                field(postingDate; Rec."Posting Date")
                {
                }
                field(shipmentDate; Rec."Shipment Date")
                {
                }
                field(postingDescription; Rec."Posting Description")
                {
                }
                field(paymentTermsCode; Rec."Payment Terms Code")
                {
                }
                field(dueDate; Rec."Due Date")
                {
                }
                field(paymentDiscount; Rec."Payment Discount %")
                {
                }
                field(pmtDiscountDate; Rec."Pmt. Discount Date")
                {
                }
                field(shipmentMethodCode; Rec."Shipment Method Code")
                {
                }
                field(locationCode; Rec."Location Code")
                {
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                }
                field(customerPostingGroup; Rec."Customer Posting Group")
                {
                }
                field(currencyCode; Rec."Currency Code")
                {
                }
                field(currencyFactor; Rec."Currency Factor")
                {
                }
                field(priceGroupCode; Rec."Price Group Code")
                {
                }
                field(pricesIncludingVAT; Rec."Prices Including VAT")
                {
                }
                field(invoiceDiscCode; Rec."Invoice Disc. Code")
                {
                }
                field(custItemDiscGr; Rec."Cust./Item Disc. Gr.")
                {
                }
                field(languageCode; Rec."Language Code")
                {
                }
                field(formatRegion; Rec."Format Region")
                {
                }
                field(salespersonCode; Rec."Salesperson Code")
                {
                }
                field(orderClass; Rec."Order Class")
                {
                }
                field(comment; Rec.Comment)
                {
                }
                field(noPrinted; Rec."No. Printed")
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
                field(balAccountNo; Rec."Bal. Account No.")
                {
                }
                field(ship; Rec.Ship)
                {
                }
                field(invoice; Rec.Invoice)
                {
                }
                field(amount; Rec.Amount)
                {
                }
                field(amountIncludingVAT; Rec."Amount Including VAT")
                {
                }
                field(shippingNo; Rec."Shipping No.")
                {
                }
                field(postingNo; Rec."Posting No.")
                {
                }
                field(lastShippingNo; Rec."Last Shipping No.")
                {
                }
                field(lastPostingNo; Rec."Last Posting No.")
                {
                }
                field(prepaymentNo; Rec."Prepayment No.")
                {
                }
                field(lastPrepaymentNo; Rec."Last Prepayment No.")
                {
                }
                field(prepmtCrMemoNo; Rec."Prepmt. Cr. Memo No.")
                {
                }
                field(lastPrepmtCrMemoNo; Rec."Last Prepmt. Cr. Memo No.")
                {
                }
                field(vatRegistrationNo; Rec."VAT Registration No.")
                {
                }
                field(combineShipments; Rec."Combine Shipments")
                {
                }
                field(reasonCode; Rec."Reason Code")
                {
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                }
                field(eu3PartyTrade; Rec."EU 3-Party Trade")
                {
                }
                field(transactionType; Rec."Transaction Type")
                {
                }
                field(transportMethod; Rec."Transport Method")
                {
                }
                field(vatCountryRegionCode; Rec."VAT Country/Region Code")
                {
                }
                field(sellToCustomerName; Rec."Sell-to Customer Name")
                {
                }
                field(sellToCustomerName2; Rec."Sell-to Customer Name 2")
                {
                }
                field(sellToAddress; Rec."Sell-to Address")
                {
                }
                field(sellToAddress2; Rec."Sell-to Address 2")
                {
                }
                field(sellToCity; Rec."Sell-to City")
                {
                }
                field(sellToContact; Rec."Sell-to Contact")
                {
                }
                field(billToPostCode; Rec."Bill-to Post Code")
                {
                }
                field(billToCounty; Rec."Bill-to County")
                {
                }
                field(billToCountryRegionCode; Rec."Bill-to Country/Region Code")
                {
                }
                field(sellToPostCode; Rec."Sell-to Post Code")
                {
                }
                field(sellToCounty; Rec."Sell-to County")
                {
                }
                field(sellToCountryRegionCode; Rec."Sell-to Country/Region Code")
                {
                }
                field(shipToPostCode; Rec."Ship-to Post Code")
                {
                }
                field(shipToCounty; Rec."Ship-to County")
                {
                }
                field(shipToCountryRegionCode; Rec."Ship-to Country/Region Code")
                {
                }
                field(balAccountType; Rec."Bal. Account Type")
                {
                }
                field(exitPoint; Rec."Exit Point")
                {
                }
                field(correction; Rec.Correction)
                {
                }
                field(documentDate; Rec."Document Date")
                {
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                }
                field("area"; Rec."Area")
                {
                }
                field(transactionSpecification; Rec."Transaction Specification")
                {
                }
                field(paymentMethodCode; Rec."Payment Method Code")
                {
                }
                field(shippingAgentCode; Rec."Shipping Agent Code")
                {
                }
                field(packageTrackingNo; Rec."Package Tracking No.")
                {
                }
                field(noSeries; Rec."No. Series")
                {
                }
                field(postingNoSeries; Rec."Posting No. Series")
                {
                }
                field(shippingNoSeries; Rec."Shipping No. Series")
                {
                }
                field(taxAreaCode; Rec."Tax Area Code")
                {
                }
                field(taxLiable; Rec."Tax Liable")
                {
                }
                field(vatBusPostingGroup; Rec."VAT Bus. Posting Group")
                {
                }
                field(reserve; Rec.Reserve)
                {
                }
                field(appliesToID; Rec."Applies-to ID")
                {
                }
                field(vatBaseDiscount; Rec."VAT Base Discount %")
                {
                }
                field(status; Rec.Status)
                {
                }
                field(invoiceDiscountCalculation; Rec."Invoice Discount Calculation")
                {
                }
                field(invoiceDiscountValue; Rec."Invoice Discount Value")
                {
                }
                field(sendICDocument; Rec."Send IC Document")
                {
                }
                field(icStatus; Rec."IC Status")
                {
                }
                field(sellToICPartnerCode; Rec."Sell-to IC Partner Code")
                {
                }
                field(billToICPartnerCode; Rec."Bill-to IC Partner Code")
                {
                }
                field(icReferenceDocumentNo; Rec."IC Reference Document No.")
                {
                }
                field(icDirection; Rec."IC Direction")
                {
                }
                field(prepayment; Rec."Prepayment %")
                {
                }
                field(prepaymentNoSeries; Rec."Prepayment No. Series")
                {
                }
                field(compressPrepayment; Rec."Compress Prepayment")
                {
                }
                field(prepaymentDueDate; Rec."Prepayment Due Date")
                {
                }
                field(prepmtCrMemoNoSeries; Rec."Prepmt. Cr. Memo No. Series")
                {
                }
                field(prepmtPostingDescription; Rec."Prepmt. Posting Description")
                {
                }
                field(prepmtPmtDiscountDate; Rec."Prepmt. Pmt. Discount Date")
                {
                }
                field(prepmtPaymentTermsCode; Rec."Prepmt. Payment Terms Code")
                {
                }
                field(prepmtPaymentDiscount; Rec."Prepmt. Payment Discount %")
                {
                }
                field(noOfArchivedVersions; Rec."No. of Archived Versions")
                {
                }
                field(salesQuoteNo; Rec."Sales Quote No.")
                {
                }
                field(quoteValidUntilDate; Rec."Quote Valid Until Date")
                {
                }
                field(quoteSentToCustomer; Rec."Quote Sent to Customer")
                {
                }
                field(quoteAccepted; Rec."Quote Accepted")
                {
                }
                field(quoteAcceptedDate; Rec."Quote Accepted Date")
                {
                }
                field(companyBankAccountCode; Rec."Company Bank Account Code")
                {
                }
                field(incomingDocumentEntryNo; Rec."Incoming Document Entry No.")
                {
                }
                field(sellToPhoneNo; Rec."Sell-to Phone No.")
                {
                }
                field(sellToEMail; Rec."Sell-to E-Mail")
                {
                }
                field(vatReportingDate; Rec."VAT Reporting Date")
                {
                }
                field(rcvdFromCountRegionCode; Rec."Rcvd.-from Count./Region Code")
                {
                }
                field(workDescription; Rec."Work Description")
                {
                }
                field(shipToPhoneNo; Rec."Ship-to Phone No.")
                {
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                }
                field(sourceDocExists; Rec."Source Doc. Exists")
                {
                }
                field(lastArchivedDate; Rec."Last Archived Date")
                {
                }
                field(interactionExist; Rec."Interaction Exist")
                {
                }
                field(timeArchived; Rec."Time Archived")
                {
                }
                field(dateArchived; Rec."Date Archived")
                {
                }
                field(archivedBy; Rec."Archived By")
                {
                }
                field(versionNo; Rec."Version No.")
                {
                }
                field(docNoOccurrence; Rec."Doc. No. Occurrence")
                {
                }
                field(campaignNo; Rec."Campaign No.")
                {
                }
                field(sellToContactNo; Rec."Sell-to Contact No.")
                {
                }
                field(billToContactNo; Rec."Bill-to Contact No.")
                {
                }
                field(opportunityNo; Rec."Opportunity No.")
                {
                }
                field(sellToCustomerTemplCode; Rec."Sell-to Customer Templ. Code")
                {
                }
                field(billToCustomerTemplCode; Rec."Bill-to Customer Templ. Code")
                {
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                }
                field(shippingAdvice; Rec."Shipping Advice")
                {
                }
                field(completelyShipped; Rec."Completely Shipped")
                {
                }
                field(postingFromWhseRef; Rec."Posting from Whse. Ref.")
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
                field(shippingAgentServiceCode; Rec."Shipping Agent Service Code")
                {
                }
                field(lateOrderShipping; Rec."Late Order Shipping")
                {
                }
                field(receive; Rec.Receive)
                {
                }
                field(returnReceiptNo; Rec."Return Receipt No.")
                {
                }
                field(returnReceiptNoSeries; Rec."Return Receipt No. Series")
                {
                }
                field(lastReturnReceiptNo; Rec."Last Return Receipt No.")
                {
                }
                field(priceCalculationMethod; Rec."Price Calculation Method")
                {
                }
                field(allowLineDisc; Rec."Allow Line Disc.")
                {
                }
                field(getShipmentUsed; Rec."Get Shipment Used")
                {
                }
                field(assignedUserID; Rec."Assigned User ID")
                {
                }
                field(colSalesFinanceCategory; Rec."COL Sales Finance Category")
                {
                }
                field(colSalesOrderCategory; Rec."COL Sales Order Category")
                {
                }
                field(projectNoPGS; Rec."Project No. PGS")
                {
                }
                field(projectManagerCodePGS; Rec."Project Manager Code PGS")
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
