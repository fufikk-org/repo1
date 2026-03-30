namespace Weibel.API;

using Microsoft.Purchases.Vendor;

page 70200 "COL Vendors Custom"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'colVendors';
    EntityName = 'vendorCustom';
    EntitySetName = 'vendorsCustom';
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
                field(no; Rec."No.") { }

                field(name; Rec."Name") { }

                field(searchName; Rec."Search Name") { }

                field(name2; Rec."Name 2") { }

                field(address; Rec."Address") { }

                field(address2; Rec."Address 2") { }

                field(city; Rec."City") { }

                field(contact; Rec."Contact") { }

                field(phoneNo; Rec."Phone No.") { }

                field(telexNo; Rec."Telex No.") { }

                field(ourAccountNo; Rec."Our Account No.") { }

                field(territoryCode; Rec."Territory Code") { }

                field(globalDimension1Code; Rec."Global Dimension 1 Code") { }

                field(globalDimension2Code; Rec."Global Dimension 2 Code") { }

                field(budgetedAmount; Rec."Budgeted Amount") { }

                field(vendorPostingGroup; Rec."Vendor Posting Group") { }

                field(currencyCode; Rec."Currency Code") { }

                field(languageCode; Rec."Language Code") { }

                field(registrationNumber; Rec."Registration Number") { }

                field(statisticsGroup; Rec."Statistics Group") { }

                field(paymentTermsCode; Rec."Payment Terms Code") { }

                field(finChargeTermsCode; Rec."Fin. Charge Terms Code") { }

                field(purchaserCode; Rec."Purchaser Code") { }

                field(shipmentMethodCode; Rec."Shipment Method Code") { }

                field(shippingAgentCode; Rec."Shipping Agent Code") { }

                field(invoiceDiscCode; Rec."Invoice Disc. Code") { }

                field(countryRegionCode; Rec."Country/Region Code") { }

                field(blocked; Rec."Blocked") { }

                field(payToVendorNo; Rec."Pay-to Vendor No.") { }

                field(priority; Rec."Priority") { }

                field(paymentMethodCode; Rec."Payment Method Code") { }

                field(formatRegion; Rec."Format Region") { }

                field(lastModifiedDateTime; Rec."Last Modified Date Time") { }

                field(lastDateModified; Rec."Last Date Modified") { }

                field(applicationMethod; Rec."Application Method") { }

                field(pricesIncludingVAT; Rec."Prices Including VAT") { }

                field(faxNo; Rec."Fax No.") { }

                field(telexAnswerBack; Rec."Telex Answer Back") { }

                field(vatRegistrationNo; Rec."VAT Registration No.") { }

                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group") { }

                field(gln; Rec."GLN") { }

                field(postCode; Rec."Post Code") { }

                field(county; Rec."County") { }

                field(eoriNumber; Rec."EORI Number") { }

                field(eMail; Rec."E-Mail") { }

                field(homePage; Rec."Home Page") { }
#pragma warning restore AL0432

                field(noSeries; Rec."No. Series") { }

                field(taxAreaCode; Rec."Tax Area Code") { }

                field(taxLiable; Rec."Tax Liable") { }

                field(vatBusPostingGroup; Rec."VAT Bus. Posting Group") { }

                field(blockPaymentTolerance; Rec."Block Payment Tolerance") { }

                field(icPartnerCode; Rec."IC Partner Code") { }

                field(prepayment; Rec."Prepayment %") { }

                field(partnerType; Rec."Partner Type") { }

                field(intrastatPartnerType; Rec."Intrastat Partner Type") { }

                field(excludeFromPmtPractices; Rec."Exclude from Pmt. Practices") { }

                field(companySizeCode; Rec."Company Size Code") { }

                field(image; Rec."Image") { }

                field(privacyBlocked; Rec."Privacy Blocked") { }

                field(disableSearchByName; Rec."Disable Search by Name") { }

                field(creditorNo; Rec."Creditor No.") { }

                field(allowMultiplePostingGroups; Rec."Allow Multiple Posting Groups") { }

                field(preferredBankAccountCode; Rec."Preferred Bank Account Code") { }

                field(cashFlowPaymentTermsCode; Rec."Cash Flow Payment Terms Code") { }

                field(primaryContactNo; Rec."Primary Contact No.") { }

                field(mobilePhoneNo; Rec."Mobile Phone No.") { }

                field(responsibilityCenter; Rec."Responsibility Center") { }

                field(locationCode; Rec."Location Code") { }

                field(leadTimeCalculation; Rec."Lead Time Calculation") { }

                field(priceCalculationMethod; Rec."Price Calculation Method") { }

                field(baseCalendarCode; Rec."Base Calendar Code") { }

                field(documentSendingProfile; Rec."Document Sending Profile") { }

                field(validateEUVatRegNo; Rec."Validate EU Vat Reg. No.") { }

                field(currencyId; Rec."Currency Id") { }

                field(paymentTermsId; Rec."Payment Terms Id") { }

                field(paymentMethodId; Rec."Payment Method Id") { }

                field(overReceiptCode; Rec."Over-Receipt Code") { }

                field(fplLasernetEMail; Rec."FPL Lasernet E-Mail") { }

                field(fplLasernetFax; Rec."FPL Lasernet Fax") { }

                field(fplGLNCode; Rec."FPL GLN Code") { }

                field(fplShowPriceOnReceipt; Rec."FPL Show Price on Receipt") { }

                field(fplDefaultPrintMethod; Rec."FPL Default Print Method") { }

                field(statusPGS; Rec."Status PGS") { }

                field(specialtyPGS; Rec."Specialty PGS") { }

                field(eeoPGS; Rec."EEO PGS") { }

                field(minorityOwnedPGS; Rec."Minority Owned PGS") { }

                field(femaleOwnedPGS; Rec."Female Owned PGS") { }

                field(disabledOwnerPGS; Rec."Disabled Owner PGS") { }

                field(preferredVendorPGS; Rec."Preferred Vendor PGS") { }

                field(separateCheckPGS; Rec."Separate Check PGS") { }

                field(subcontractorPGS; Rec."Subcontractor PGS") { }

                field(systemId; Rec.SystemId) { }

                field(systemCreatedAt; Rec."SystemCreatedAt") { }

                field(systemCreatedBy; Rec."SystemCreatedBy") { }

                field(systemModifiedAt; Rec."SystemModifiedAt") { }

                field(systemModifiedBy; Rec."SystemModifiedBy") { }
            }
        }
    }
}
