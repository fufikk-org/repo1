namespace Weibel.API;

using Microsoft.Inventory.Tracking;

page 70255 "COL Reservation Entries"
{
    APIGroup = 'reservationdata2';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'reservationEntry';
    EntitySetName = 'reservationEntries';
    PageType = API;
    SourceTable = "Reservation Entry";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                }
                field(entryNo; Rec."Entry No.")
                {
                }
                field(positive; Rec.Positive)
                {
                }
                field(itemNo; Rec."Item No.")
                {
                }
                field(locationCode; Rec."Location Code")
                {
                }
                field(quantityBase; Rec."Quantity (Base)")
                {
                }
                field(reservationStatus; Rec."Reservation Status")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(creationDate; Rec."Creation Date")
                {
                }
                field(transferredFromEntryNo; Rec."Transferred from Entry No.")
                {
                }
                field(sourceType; Rec."Source Type")
                {
                }
                field(sourceSubtype; Rec."Source Subtype")
                {
                }
                field(sourceId; Rec."Source ID")
                {
                }
                field(sourceBatchName; Rec."Source Batch Name")
                {
                }
                field(sourceProdOrderLine; Rec."Source Prod. Order Line")
                {
                }
                field(sourceRefNo; Rec."Source Ref. No.")
                {
                }
                field(itemLedgerEntryNo; Rec."Item Ledger Entry No.")
                {
                }
                field(expectedReceiptDate; Rec."Expected Receipt Date")
                {
                }
                field(shipmentDate; Rec."Shipment Date")
                {
                }
                field(serialNo; Rec."Serial No.")
                {
                }
                field(createdBy; Rec."Created By")
                {
                }
                field(changedBy; Rec."Changed By")
                {
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                }
                field(quantity; Rec.Quantity)
                {
                }
                field(actionMessageAdjustment; Rec."Action Message Adjustment")
                {
                }
                // field(binding; Rec.Binding)
                // {
                // }
                field(suppressedActionMsg; Rec."Suppressed Action Msg.")
                {
                }
                field(planningFlexibility; Rec."Planning Flexibility")
                {
                }
                field(applToItemEntry; Rec."Appl.-to Item Entry")
                {
                }
                field(warrantyDate; Rec."Warranty Date")
                {
                }
                field(expirationDate; Rec."Expiration Date")
                {
                }
                field(qtyToHandleBase; Rec."Qty. to Handle (Base)")
                {
                }
                field(qtyToInvoiceBase; Rec."Qty. to Invoice (Base)")
                {
                }
                field(quantityInvoicedBase; Rec."Quantity Invoiced (Base)")
                {
                }
                field(newSerialNo; Rec."New Serial No.")
                {
                }
                field(newLotNo; Rec."New Lot No.")
                {
                }
                field(disallowCancellation; Rec."Disallow Cancellation")
                {
                }
                field(lotNo; Rec."Lot No.")
                {
                }
                field(variantCode; Rec."Variant Code")
                {
                }
                field(applFromItemEntry; Rec."Appl.-from Item Entry")
                {
                }
                field(correction; Rec.Correction)
                {
                }
                field(newExpirationDate; Rec."New Expiration Date")
                {
                }
                field(itemTracking; Rec."Item Tracking")
                {
                }
                field(untrackedSurplus; Rec."Untracked Surplus")
                {
                }
                field(packageNo; Rec."Package No.")
                {
                }
                field(newPackageNo; Rec."New Package No.")
                {
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
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
