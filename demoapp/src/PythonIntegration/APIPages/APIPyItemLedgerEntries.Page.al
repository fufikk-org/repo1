namespace Weibel.Integration.Python;

using Microsoft.Inventory.Ledger;

page 70112 "COL API Py Item Ledger Entries"
{
    APIGroup = 'pythonData';
    APIPublisher = 'weibel';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Editable = false;
    DataAccessIntent = ReadOnly;
    EntityName = 'itemLedgerEntry';
    EntitySetName = 'itemLedgerEntries';
    PageType = API;
    SourceTable = "Item Ledger Entry";
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
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.', Locked = true;
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.', Locked = true;
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date', Locked = true;
                }
                field(entryType; Rec."Entry Type")
                {
                    Caption = 'Entry Type', Locked = true;
                }
                field(sourceNo; Rec."Source No.")
                {
                    Caption = 'Source No.', Locked = true;
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.', Locked = true;
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description', Locked = true;
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code', Locked = true;
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity', Locked = true;
                }
                field(remainingQuantity; Rec."Remaining Quantity")
                {
                    Caption = 'Remaining Quantity', Locked = true;
                }
                field(invoicedQuantity; Rec."Invoiced Quantity")
                {
                    Caption = 'Invoiced Quantity', Locked = true;
                }
                field(appliesToEntry; Rec."Applies-to Entry")
                {
                    Caption = 'Applies-to Entry', Locked = true;
                }
                field(open; Rec.Open)
                {
                    Caption = 'Open', Locked = true;
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code', Locked = true;
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                    Caption = 'Global Dimension 2 Code', Locked = true;
                }
                field(positive; Rec.Positive)
                {
                    Caption = 'Positive', Locked = true;
                }
                field(shptMethodCode; Rec."Shpt. Method Code")
                {
                    Caption = 'Shpt. Method Code', Locked = true;
                }
                field(sourceType; Rec."Source Type")
                {
                    Caption = 'Source Type', Locked = true;
                }
                field(dropShipment; Rec."Drop Shipment")
                {
                    Caption = 'Drop Shipment', Locked = true;
                }
                field(transactionType; Rec."Transaction Type")
                {
                    Caption = 'Transaction Type', Locked = true;
                }
                field(transportMethod; Rec."Transport Method")
                {
                    Caption = 'Transport Method', Locked = true;
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                    Caption = 'Country/Region Code', Locked = true;
                }
                field(entryExitPoint; Rec."Entry/Exit Point")
                {
                    Caption = 'Entry/Exit Point', Locked = true;
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
                field(noSeries; Rec."No. Series")
                {
                    Caption = 'No. Series', Locked = true;
                }
                // field(reservedQuantity; Rec."Reserved Quantity")
                // {
                //     Caption = 'Reserved Quantity', Locked = true;
                // }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type', Locked = true;
                }
                field(documentLineNo; Rec."Document Line No.")
                {
                    Caption = 'Document Line No.', Locked = true;
                }
                field(orderType; Rec."Order Type")
                {
                    Caption = 'Order Type', Locked = true;
                }
                field(orderNo; Rec."Order No.")
                {
                    Caption = 'Order No.', Locked = true;
                }
                field(orderLineNo; Rec."Order Line No.")
                {
                    Caption = 'Order Line No.', Locked = true;
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID', Locked = true;
                }
                // field(shortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                // {
                //     Caption = 'Shortcut Dimension 3 Code', Locked = true;
                // }
                // field(shortcutDimension4Code; Rec."Shortcut Dimension 4 Code")
                // {
                //     Caption = 'Shortcut Dimension 4 Code', Locked = true;
                // }
                // field(shortcutDimension5Code; Rec."Shortcut Dimension 5 Code")
                // {
                //     Caption = 'Shortcut Dimension 5 Code', Locked = true;
                // }
                // field(shortcutDimension6Code; Rec."Shortcut Dimension 6 Code")
                // {
                //     Caption = 'Shortcut Dimension 6 Code', Locked = true;
                // }
                // field(shortcutDimension7Code; Rec."Shortcut Dimension 7 Code")
                // {
                //     Caption = 'Shortcut Dimension 7 Code', Locked = true;
                // }
                // field(shortcutDimension8Code; Rec."Shortcut Dimension 8 Code")
                // {
                //     Caption = 'Shortcut Dimension 8 Code', Locked = true;
                // }
                field(assembleToOrder; Rec."Assemble to Order")
                {
                    Caption = 'Assemble to Order', Locked = true;
                }
                field(jobNo; Rec."Job No.")
                {
                    Caption = 'Project No.', Locked = true;
                }
                field(jobTaskNo; Rec."Job Task No.")
                {
                    Caption = 'Project Task No.', Locked = true;
                }
                field(jobPurchase; Rec."Job Purchase")
                {
                    Caption = 'Project Purchase', Locked = true;
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code', Locked = true;
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                    Caption = 'Qty. per Unit of Measure', Locked = true;
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code', Locked = true;
                }
                field(derivedFromBlanketOrder; Rec."Derived from Blanket Order")
                {
                    Caption = 'Derived from Blanket Order', Locked = true;
                }
                field(originallyOrderedNo; Rec."Originally Ordered No.")
                {
                    Caption = 'Originally Ordered No.', Locked = true;
                }
                field(originallyOrderedVarCode; Rec."Originally Ordered Var. Code")
                {
                    Caption = 'Originally Ordered Var. Code', Locked = true;
                }
                field(outOfStockSubstitution; Rec."Out-of-Stock Substitution")
                {
                    Caption = 'Out-of-Stock Substitution', Locked = true;
                }
                field(itemCategoryCode; Rec."Item Category Code")
                {
                    Caption = 'Item Category Code', Locked = true;
                }
                field(nonstock; Rec.Nonstock)
                {
                    Caption = 'Catalog', Locked = true;
                }
                field(purchasingCode; Rec."Purchasing Code")
                {
                    Caption = 'Purchasing Code', Locked = true;
                }
                field(itemReferenceNo; Rec."Item Reference No.")
                {
                    Caption = 'Item Reference No.', Locked = true;
                }
                field(completelyInvoiced; Rec."Completely Invoiced")
                {
                    Caption = 'Completely Invoiced', Locked = true;
                }
                field(lastInvoiceDate; Rec."Last Invoice Date")
                {
                    Caption = 'Last Invoice Date', Locked = true;
                }
                field(appliedEntryToAdjust; Rec."Applied Entry to Adjust")
                {
                    Caption = 'Applied Entry to Adjust', Locked = true;
                }
                // field(costAmountExpected; Rec."Cost Amount (Expected)")
                // {
                //     Caption = 'Cost Amount (Expected)', Locked = true;
                // }
                // field(costAmountActual; Rec."Cost Amount (Actual)")
                // {
                //     Caption = 'Cost Amount (Actual)', Locked = true;
                // }
                // field(costAmountNonInvtbl; Rec."Cost Amount (Non-Invtbl.)")
                // {
                //     Caption = 'Cost Amount (Non-Invtbl.)', Locked = true;
                // }
                // field(costAmountExpectedACY; Rec."Cost Amount (Expected) (ACY)")
                // {
                //     Caption = 'Cost Amount (Expected) (ACY)', Locked = true;
                // }
                // field(costAmountActualACY; Rec."Cost Amount (Actual) (ACY)")
                // {
                //     Caption = 'Cost Amount (Actual) (ACY)', Locked = true;
                // }
                // field(costAmountNonInvtblACY; Rec."Cost Amount (Non-Invtbl.)(ACY)")
                // {
                //     Caption = 'Cost Amount (Non-Invtbl.)(ACY)', Locked = true;
                // }
                // field(purchaseAmountExpected; Rec."Purchase Amount (Expected)")
                // {
                //     Caption = 'Purchase Amount (Expected)', Locked = true;
                // }
                // field(purchaseAmountActual; Rec."Purchase Amount (Actual)")
                // {
                //     Caption = 'Purchase Amount (Actual)', Locked = true;
                // }
                // field(salesAmountExpected; Rec."Sales Amount (Expected)")
                // {
                //     Caption = 'Sales Amount (Expected)', Locked = true;
                // }
                // field(salesAmountActual; Rec."Sales Amount (Actual)")
                // {
                //     Caption = 'Sales Amount (Actual)', Locked = true;
                // }
                field(correction; Rec.Correction)
                {
                    Caption = 'Correction', Locked = true;
                }
                field(shippedQtyNotReturned; Rec."Shipped Qty. Not Returned")
                {
                    Caption = 'Shipped Qty. Not Returned', Locked = true;
                }
                field(prodOrderCompLineNo; Rec."Prod. Order Comp. Line No.")
                {
                    Caption = 'Prod. Order Comp. Line No.', Locked = true;
                }
                field(serialNo; Rec."Serial No.")
                {
                    Caption = 'Serial No.', Locked = true;
                }
                field(lotNo; Rec."Lot No.")
                {
                    Caption = 'Lot No.', Locked = true;
                }
                field(warrantyDate; Rec."Warranty Date")
                {
                    Caption = 'Warranty Date', Locked = true;
                }
                field(expirationDate; Rec."Expiration Date")
                {
                    Caption = 'Expiration Date', Locked = true;
                }
                field(itemTracking; Rec."Item Tracking")
                {
                    Caption = 'Item Tracking', Locked = true;
                }
                field(packageNo; Rec."Package No.")
                {
                    Caption = 'Package No.', Locked = true;
                }
                field(returnReasonCode; Rec."Return Reason Code")
                {
                    Caption = 'Return Reason Code', Locked = true;
                }
                field(outstandingQtyPGS; Rec."Outstanding Qty. PGS")
                {
                    Caption = 'Outstanding Qty.', Locked = true;
                }
            }
        }
    }
}
