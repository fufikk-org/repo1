namespace Weibel.API;

using Microsoft.Purchases.Vendor;

page 70146 "COL Vendors"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'colVendors';
    EntityName = 'vendor';
    EntitySetName = 'vendors';
    PageType = API;
    SourceTable = Vendor;
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                }
                field(name; Rec.Name)
                {
                }
                field(searchName; Rec."Search Name")
                {
                }
                field(name2; Rec."Name 2")
                {
                }
                field(address; Rec.Address)
                {
                }
                field(address2; Rec."Address 2")
                {
                }
                field(city; Rec.City)
                {
                }
                field(contact; Rec.Contact)
                {
                }
                field(phoneNo; Rec."Phone No.")
                {
                }
                field(telexNo; Rec."Telex No.")
                {
                }
                field(ourAccountNo; Rec."Our Account No.")
                {
                }
                field(territoryCode; Rec."Territory Code")
                {
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                }
                field(budgetedAmount; Rec."Budgeted Amount")
                {
                }
                field(vendorPostingGroup; Rec."Vendor Posting Group")
                {
                }
                field(currencyCode; Rec."Currency Code")
                {
                }
                field(languageCode; Rec."Language Code")
                {
                }
                field(registrationNumber; Rec."Registration Number")
                {
                }
                field(statisticsGroup; Rec."Statistics Group")
                {
                }
                field(paymentTermsCode; Rec."Payment Terms Code")
                {
                }
                field(finChargeTermsCode; Rec."Fin. Charge Terms Code")
                {
                }
                field(purchaserCode; Rec."Purchaser Code")
                {
                }
                field(shipmentMethodCode; Rec."Shipment Method Code")
                {
                }
                field(shippingAgentCode; Rec."Shipping Agent Code")
                {
                }
                field(invoiceDiscCode; Rec."Invoice Disc. Code")
                {
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                }
                field(comment; Rec.Comment)
                {
                }
                field(blocked; Rec.Blocked)
                {
                }
                field(payToVendorNo; Rec."Pay-to Vendor No.")
                {
                }
                field(priority; Rec.Priority)
                {
                }
                field(paymentMethodCode; Rec."Payment Method Code")
                {
                }
                field(formatRegion; Rec."Format Region")
                {
                }
                field(lastModifiedDateTime; Rec."Last Modified Date Time")
                {
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                }
                field(balance; Rec.Balance)
                {
                }
                field(balanceLCY; Rec."Balance (LCY)")
                {
                }
                field(netChange; Rec."Net Change")
                {
                }
                field(netChangeLCY; Rec."Net Change (LCY)")
                {
                }
                field(purchasesLCY; Rec."Purchases (LCY)")
                {
                }
                field(invDiscountsLCY; Rec."Inv. Discounts (LCY)")
                {
                }
                field(pmtDiscountsLCY; Rec."Pmt. Discounts (LCY)")
                {
                }
                field(balanceDue; Rec."Balance Due")
                {
                }
                field(balanceDueLCY; Rec."Balance Due (LCY)")
                {
                }
                field(payments; Rec.Payments)
                {
                }
                field(invoiceAmounts; Rec."Invoice Amounts")
                {
                }
                field(crMemoAmounts; Rec."Cr. Memo Amounts")
                {
                }
                field(financeChargeMemoAmounts; Rec."Finance Charge Memo Amounts")
                {
                }
                field(paymentsLCY; Rec."Payments (LCY)")
                {
                }
                field(invAmountsLCY; Rec."Inv. Amounts (LCY)")
                {
                }
                field(crMemoAmountsLCY; Rec."Cr. Memo Amounts (LCY)")
                {
                }
                field(finChargeMemoAmountsLCY; Rec."Fin. Charge Memo Amounts (LCY)")
                {
                }
                field(outstandingOrders; Rec."Outstanding Orders")
                {
                }
                field(amtRcdNotInvoiced; Rec."Amt. Rcd. Not Invoiced")
                {
                }
                field(applicationMethod; Rec."Application Method")
                {
                }
                field(pricesIncludingVAT; Rec."Prices Including VAT")
                {
                }
                field(faxNo; Rec."Fax No.")
                {
                }
                field(telexAnswerBack; Rec."Telex Answer Back")
                {
                }
                field(vatRegistrationNo; Rec."VAT Registration No.")
                {
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                }
                field(gln; Rec.GLN)
                {
                }
                field(postCode; Rec."Post Code")
                {
                }
                field(county; Rec.County)
                {
                }
                field(eoriNumber; Rec."EORI Number")
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
                field(eMail; Rec."E-Mail")
                {
                }
                field(homePage; Rec."Home Page")
                {
                }
                field(reminderAmounts; Rec."Reminder Amounts")
                {
                }
                field(reminderAmountsLCY; Rec."Reminder Amounts (LCY)")
                {
                }
                field(noSeries; Rec."No. Series")
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
                field(outstandingOrdersLCY; Rec."Outstanding Orders (LCY)")
                {
                }
                field(amtRcdNotInvoicedLCY; Rec."Amt. Rcd. Not Invoiced (LCY)")
                {
                }
                field(blockPaymentTolerance; Rec."Block Payment Tolerance")
                {
                }
                field(pmtDiscToleranceLCY; Rec."Pmt. Disc. Tolerance (LCY)")
                {
                }
                field(pmtToleranceLCY; Rec."Pmt. Tolerance (LCY)")
                {
                }
                field(icPartnerCode; Rec."IC Partner Code")
                {
                }
                field(refunds; Rec.Refunds)
                {
                }
                field(refundsLCY; Rec."Refunds (LCY)")
                {
                }
                field(otherAmounts; Rec."Other Amounts")
                {
                }
                field(otherAmountsLCY; Rec."Other Amounts (LCY)")
                {
                }
                field(prepayment; Rec."Prepayment %")
                {
                }
                field(outstandingInvoices; Rec."Outstanding Invoices")
                {
                }
                field(outstandingInvoicesLCY; Rec."Outstanding Invoices (LCY)")
                {
                }
                field(payToNoOfArchivedDoc; Rec."Pay-to No. Of Archived Doc.")
                {
                }
                field(buyFromNoOfArchivedDoc; Rec."Buy-from No. Of Archived Doc.")
                {
                }
                field(partnerType; Rec."Partner Type")
                {
                }
                field(intrastatPartnerType; Rec."Intrastat Partner Type")
                {
                }
                field(excludeFromPmtPractices; Rec."Exclude from Pmt. Practices")
                {
                }
                field(companySizeCode; Rec."Company Size Code")
                {
                }
                field(image; Rec.Image)
                {
                }
                field(privacyBlocked; Rec."Privacy Blocked")
                {
                }
                field(disableSearchByName; Rec."Disable Search by Name")
                {
                }
                field(creditorNo; Rec."Creditor No.")
                {
                }
                field(allowMultiplePostingGroups; Rec."Allow Multiple Posting Groups")
                {
                }
                field(preferredBankAccountCode; Rec."Preferred Bank Account Code")
                {
                }
                field(coupledToDataverse; Rec."Coupled to Dataverse")
                {
                }
                field(cashFlowPaymentTermsCode; Rec."Cash Flow Payment Terms Code")
                {
                }
                field(primaryContactNo; Rec."Primary Contact No.")
                {
                }
                field(mobilePhoneNo; Rec."Mobile Phone No.")
                {
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                }
                field(locationCode; Rec."Location Code")
                {
                }
                field(leadTimeCalculation; Rec."Lead Time Calculation")
                {
                }
                field(priceCalculationMethod; Rec."Price Calculation Method")
                {
                }
                field(noOfPstdReceipts; Rec."No. of Pstd. Receipts")
                {
                }
                field(noOfPstdInvoices; Rec."No. of Pstd. Invoices")
                {
                }
                field(noOfPstdReturnShipments; Rec."No. of Pstd. Return Shipments")
                {
                }
                field(noOfPstdCreditMemos; Rec."No. of Pstd. Credit Memos")
                {
                }
                field(payToNoOfOrders; Rec."Pay-to No. of Orders")
                {
                }
                field(payToNoOfInvoices; Rec."Pay-to No. of Invoices")
                {
                }
                field(payToNoOfReturnOrders; Rec."Pay-to No. of Return Orders")
                {
                }
                field(payToNoOfCreditMemos; Rec."Pay-to No. of Credit Memos")
                {
                }
                field(payToNoOfPstdReceipts; Rec."Pay-to No. of Pstd. Receipts")
                {
                }
                field(payToNoOfPstdInvoices; Rec."Pay-to No. of Pstd. Invoices")
                {
                }
                field(payToNoOfPstdReturnS; Rec."Pay-to No. of Pstd. Return S.")
                {
                }
                field(payToNoOfPstdCrMemos; Rec."Pay-to No. of Pstd. Cr. Memos")
                {
                }
                field(noOfQuotes; Rec."No. of Quotes")
                {
                }
                field(noOfBlanketOrders; Rec."No. of Blanket Orders")
                {
                }
                field(noOfOrders; Rec."No. of Orders")
                {
                }
                field(noOfInvoices; Rec."No. of Invoices")
                {
                }
                field(noOfReturnOrders; Rec."No. of Return Orders")
                {
                }
                field(noOfCreditMemos; Rec."No. of Credit Memos")
                {
                }
                field(noOfOrderAddresses; Rec."No. of Order Addresses")
                {
                }
                field(payToNoOfQuotes; Rec."Pay-to No. of Quotes")
                {
                }
                field(payToNoOfBlanketOrders; Rec."Pay-to No. of Blanket Orders")
                {
                }
                field(noOfIncomingDocuments; Rec."No. of Incoming Documents")
                {
                }
                field(baseCalendarCode; Rec."Base Calendar Code")
                {
                }
                field(documentSendingProfile; Rec."Document Sending Profile")
                {
                }
                field(validateEUVatRegNo; Rec."Validate EU Vat Reg. No.")
                {
                }
                field(currencyId; Rec."Currency Id")
                {
                }
                field(paymentTermsId; Rec."Payment Terms Id")
                {
                }
                field(paymentMethodId; Rec."Payment Method Id")
                {
                }
                field(overReceiptCode; Rec."Over-Receipt Code")
                {
                }
                field(fplLasernetEMail; Rec."FPL Lasernet E-Mail")
                {
                }
                field(fplLasernetFax; Rec."FPL Lasernet Fax")
                {
                }
                field(fplGLNCode; Rec."FPL GLN Code")
                {
                }
                field(fplShowPriceOnReceipt; Rec."FPL Show Price on Receipt")
                {
                }
                field(fplDefaultPrintMethod; Rec."FPL Default Print Method")
                {
                }
                field(statusPGS; Rec."Status PGS")
                {
                }
                field(specialtyPGS; Rec."Specialty PGS")
                {
                }
                field(eeoPGS; Rec."EEO PGS")
                {
                }
                field(minorityOwnedPGS; Rec."Minority Owned PGS")
                {
                }
                field(femaleOwnedPGS; Rec."Female Owned PGS")
                {
                }
                field(disabledOwnerPGS; Rec."Disabled Owner PGS")
                {
                }
                field(preferredVendorPGS; Rec."Preferred Vendor PGS")
                {
                }
                field(separateCheckPGS; Rec."Separate Check PGS")
                {
                }
                field(subcontractorPGS; Rec."Subcontractor PGS")
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
