namespace Weibel.API;

using Microsoft.Inventory.Ledger;

page 70178 "COL Value Entries"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'valueEntry';
    EntitySetName = 'valueEntries';
    PageType = API;
    SourceTable = "Value Entry";
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
                field(itemNo; Rec."Item No.")
                {
                }
                field(postingDate; Rec."Posting Date")
                {
                }
                field(itemLedgerEntryType; Rec."Item Ledger Entry Type")
                {
                }
                field(sourceNo; Rec."Source No.")
                {
                }
                field(documentNo; Rec."Document No.")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(locationCode; Rec."Location Code")
                {
                }
                field(inventoryPostingGroup; Rec."Inventory Posting Group")
                {
                }
                field(sourcePostingGroup; Rec."Source Posting Group")
                {
                }
                field(itemLedgerEntryNo; Rec."Item Ledger Entry No.")
                {
                }
                field(valuedQuantity; Rec."Valued Quantity")
                {
                }
                field(itemLedgerEntryQuantity; Rec."Item Ledger Entry Quantity")
                {
                }
                field(invoicedQuantity; Rec."Invoiced Quantity")
                {
                }
                field(costPerUnit; Rec."Cost per Unit")
                {
                }
                field(salesAmountActual; Rec."Sales Amount (Actual)")
                {
                }
                field(salespersPurchCode; Rec."Salespers./Purch. Code")
                {
                }
                field(discountAmount; Rec."Discount Amount")
                {
                }
                field("userID"; Rec."User ID")
                {
                }
                field(sourceCode; Rec."Source Code")
                {
                }
                field(appliesToEntry; Rec."Applies-to Entry")
                {
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                }
                field(sourceType; Rec."Source Type")
                {
                }
                field(costAmountActual; Rec."Cost Amount (Actual)")
                {
                }
                field(costPostedToGL; Rec."Cost Posted to G/L")
                {
                }
                field(reasonCode; Rec."Reason Code")
                {
                }
                field(dropShipment; Rec."Drop Shipment")
                {
                }
                field(journalBatchName; Rec."Journal Batch Name")
                {
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                }
                field(documentDate; Rec."Document Date")
                {
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                }
                field(costAmountActualACY; Rec."Cost Amount (Actual) (ACY)")
                {
                }
                field(costPostedToGLACY; Rec."Cost Posted to G/L (ACY)")
                {
                }
                field(costPerUnitACY; Rec."Cost per Unit (ACY)")
                {
                }
                field(documentType; Rec."Document Type")
                {
                }
                field(documentLineNo; Rec."Document Line No.")
                {
                }
                field(vatReportingDate; Rec."VAT Reporting Date")
                {
                }
                field(orderType; Rec."Order Type")
                {
                }
                field(orderNo; Rec."Order No.")
                {
                }
                field(orderLineNo; Rec."Order Line No.")
                {
                }
                field(expectedCost; Rec."Expected Cost")
                {
                }
                field(itemChargeNo; Rec."Item Charge No.")
                {
                }
                field(valuedByAverageCost; Rec."Valued By Average Cost")
                {
                }
                field(partialRevaluation; Rec."Partial Revaluation")
                {
                }
                field(inventoriable; Rec.Inventoriable)
                {
                }
                field(valuationDate; Rec."Valuation Date")
                {
                }
                field(entryType; Rec."Entry Type")
                {
                }
                field(varianceType; Rec."Variance Type")
                {
                }
                field(purchaseAmountActual; Rec."Purchase Amount (Actual)")
                {
                }
                field(purchaseAmountExpected; Rec."Purchase Amount (Expected)")
                {
                }
                field(salesAmountExpected; Rec."Sales Amount (Expected)")
                {
                }
                field(costAmountExpected; Rec."Cost Amount (Expected)")
                {
                }
                field(costAmountNonInvtbl; Rec."Cost Amount (Non-Invtbl.)")
                {
                }
                field(costAmountExpectedACY; Rec."Cost Amount (Expected) (ACY)")
                {
                }
                field(costAmountNonInvtblACY; Rec."Cost Amount (Non-Invtbl.)(ACY)")
                {
                }
                field(expectedCostPostedToGL; Rec."Expected Cost Posted to G/L")
                {
                }
                field(expCostPostedToGLACY; Rec."Exp. Cost Posted to G/L (ACY)")
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
                field(jobNo; Rec."Job No.")
                {
                }
                field(jobTaskNo; Rec."Job Task No.")
                {
                }
                field(jobLedgerEntryNo; Rec."Job Ledger Entry No.")
                {
                }
                field(variantCode; Rec."Variant Code")
                {
                }
                field(adjustment; Rec.Adjustment)
                {
                }
                field(averageCostException; Rec."Average Cost Exception")
                {
                }
                field(capacityLedgerEntryNo; Rec."Capacity Ledger Entry No.")
                {
                }
                field(type; Rec."Type")
                {
                }
                field(no; Rec."No.")
                {
                }
                field(returnReasonCode; Rec."Return Reason Code")
                {
                }
                field(pgsCreatedEntryPGS; Rec."PGS-Created Entry PGS")
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
