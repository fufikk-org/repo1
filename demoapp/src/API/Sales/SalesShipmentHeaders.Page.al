namespace Weibel.API;

using Microsoft.Sales.History;

page 70177 "COL Sales Shipment Headers"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'salesShipmentHeader';
    EntitySetName = 'salesShipmentHeaders';
    PageType = API;
    SourceTable = "Sales Shipment Header";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
                field(customerPriceGroup; Rec."Customer Price Group")
                {
                }
                field(pricesIncludingVAT; Rec."Prices Including VAT")
                {
                }
                field(invoiceDiscCode; Rec."Invoice Disc. Code")
                {
                }
                field(customerDiscGroup; Rec."Customer Disc. Group")
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
                field(orderNo; Rec."Order No.")
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
                field(vatRegistrationNo; Rec."VAT Registration No.")
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
                field(orderNoSeries; Rec."Order No. Series")
                {
                }
                field("userID"; Rec."User ID")
                {
                }
                field(sourceCode; Rec."Source Code")
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
                field(vatBaseDiscount; Rec."VAT Base Discount %")
                {
                }
                field(quoteNo; Rec."Quote No.")
                {
                }
                field(companyBankAccountCode; Rec."Company Bank Account Code")
                {
                }
                field(sellToPhoneNo; Rec."Sell-to Phone No.")
                {
                }
                field(sellToEMail; Rec."Sell-to E-Mail")
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
                field(responsibilityCenter; Rec."Responsibility Center")
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
                field(priceCalculationMethod; Rec."Price Calculation Method")
                {
                }
                field(allowLineDisc; Rec."Allow Line Disc.")
                {
                }
                field(customerId; Rec."Customer Id")
                {
                }
                field(billToCustomerId; Rec."Bill-to Customer Id")
                {
                }
                field(colShippingStatus; Rec."COL Shipping Status")
                {
                }
                field(colEndUserType; Rec."COL End User Type")
                {
                }
                field(colExistingEndUserNo; Rec."COL Existing End User No.")
                {
                }
                field(colEndUserName; Rec."COL End User Name")
                {
                }
                field(colEndUserName2; Rec."COL End User Name 2")
                {
                }
                field(colEndUserAddress; Rec."COL End User Address")
                {
                }
                field(colEndUserAddress2; Rec."COL End User Address 2")
                {
                }
                field(colEndUserCity; Rec."COL End User City")
                {
                }
                field(colEndUserPostCode; Rec."COL End User Post Code")
                {
                }
                field(colEndUserCounty; Rec."COL End User County")
                {
                }
                field(colEndUserCountryRegion; Rec."COL End User Country/Region")
                {
                }
                field(colEndUserEMail; Rec."COL End User E-Mail")
                {
                }
                field(colNoOfPackages; Rec."COL No. of Packages")
                {
                }
                field(colTotalGrossWeight; Rec."COL Total Gross Weight")
                {
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
                field(colGSName; Rec."COL GS. Name")
                {
                }
                field(colGSName2; Rec."COL GS. Name 2")
                {
                }
                field(colGSAddress; Rec."COL GS. Address")
                {
                }
                field(colGSAddress2; Rec."COL GS. Address 2")
                {
                }
                field(colGSCity; Rec."COL GS. City")
                {
                }
                field(colGSPostCode; Rec."COL GS. Post Code")
                {
                }
                field(colGSCounty; Rec."COL GS. County")
                {
                }
                field(colGSCountryRegion; Rec."COL GS. Country/Region")
                {
                }
                field(colGSEMail; Rec."COL GS. E-Mail")
                {
                }
                field(colGSCompany; Rec."COL GS. Company")
                {
                }
                field(colGSCustomerNo; Rec."COL GS. Customer No.")
                {
                }
                field(colGSSalespersonCode; Rec."COL GS. Salesperson Code")
                {
                }
                field(colOriginalPromisedDate; Rec."COL Original Promised Date")
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
