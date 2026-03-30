namespace Weibel.API;

using Microsoft.Inventory.Ledger;

page 70202 "COL Item Ledger Entries Custom"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'itemLedgerEntryCustom';
    EntitySetName = 'itemLedgerEntriesCustom';
    PageType = API;
    SourceTable = "Item Ledger Entry";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(entryNo; Rec."Entry No.") { }

                field(itemNo; Rec."Item No.") { }

                field(postingDate; Rec."Posting Date") { }

                field(entryType; Rec."Entry Type") { }

                field(sourceNo; Rec."Source No.") { }

                field(documentNo; Rec."Document No.") { }

                field(description; Rec."Description") { }

                field(locationCode; Rec."Location Code") { }

                field(quantity; Rec."Quantity") { }

                field(remainingQuantity; Rec."Remaining Quantity") { }

                field(invoicedQuantity; Rec."Invoiced Quantity") { }

                field(appliesToEntry; Rec."Applies-to Entry") { }

                field(open; Rec."Open") { }

                field(globalDimension1Code; Rec."Global Dimension 1 Code") { }

                field(globalDimension2Code; Rec."Global Dimension 2 Code") { }

                field(positive; Rec."Positive") { }

                field(shptMethodCode; Rec."Shpt. Method Code") { }

                field(sourceType; Rec."Source Type") { }

                field(dropShipment; Rec."Drop Shipment") { }

                field(transactionType; Rec."Transaction Type") { }

                field(transportMethod; Rec."Transport Method") { }

                field(countryRegionCode; Rec."Country/Region Code") { }

                field(entryExitPoint; Rec."Entry/Exit Point") { }

                field(documentDate; Rec."Document Date") { }

                field(externalDocumentNo; Rec."External Document No.") { }

                field("area"; Rec."Area") { }

                field(transactionSpecification; Rec."Transaction Specification") { }

                field(noSeries; Rec."No. Series") { }

                field(documentType; Rec."Document Type") { }

                field(documentLineNo; Rec."Document Line No.") { }

                field(orderType; Rec."Order Type") { }

                field(orderNo; Rec."Order No.") { }

                field(orderLineNo; Rec."Order Line No.") { }

                field(dimensionSetID; Rec."Dimension Set ID") { }

                field(assembleToOrder; Rec."Assemble to Order") { }

                field(jobNo; Rec."Job No.") { }

                field(jobTaskNo; Rec."Job Task No.") { }

                field(jobPurchase; Rec."Job Purchase") { }

                field(variantCode; Rec."Variant Code") { }

                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure") { }

                field(unitOfMeasureCode; Rec."Unit of Measure Code") { }

                field(derivedFromBlanketOrder; Rec."Derived from Blanket Order") { }

                field(originallyOrderedNo; Rec."Originally Ordered No.") { }

                field(originallyOrderedVarCode; Rec."Originally Ordered Var. Code") { }

                field(outOfStockSubstitution; Rec."Out-of-Stock Substitution") { }

                field(itemCategoryCode; Rec."Item Category Code") { }

                field(nonstock; Rec."Nonstock") { }

                field(purchasingCode; Rec."Purchasing Code") { }

                field(itemReferenceNo; Rec."Item Reference No.") { }

                field(completelyInvoiced; Rec."Completely Invoiced") { }

                field(lastInvoiceDate; Rec."Last Invoice Date") { }

                field(appliedEntryToAdjust; Rec."Applied Entry to Adjust") { }

                field(correction; Rec."Correction") { }

                field(shippedQtyNotReturned; Rec."Shipped Qty. Not Returned") { }

                field(prodOrderCompLineNo; Rec."Prod. Order Comp. Line No.") { }

                field(serialNo; Rec."Serial No.") { }

                field(lotNo; Rec."Lot No.") { }

                field(warrantyDate; Rec."Warranty Date") { }

                field(expirationDate; Rec."Expiration Date") { }

                field(itemTracking; Rec."Item Tracking") { }

                field(packageNo; Rec."Package No.") { }

                field(returnReasonCode; Rec."Return Reason Code") { }

                field(colExportClassificationCode; Rec."COL Export Classification Code") { }

                field(outstandingQtyPGS; Rec."Outstanding Qty. PGS") { }

                field(jobContractEntryNoPGS; Rec."Job Contract Entry No. PGS") { }

                field(systemId; Rec.SystemId) { }

                field(systemCreatedAt; Rec."SystemCreatedAt") { }

                field(systemCreatedBy; Rec."SystemCreatedBy") { }

                field(systemModifiedAt; Rec."SystemModifiedAt") { }

                field(systemModifiedBy; Rec."SystemModifiedBy") { }
            }
        }
    }
}
