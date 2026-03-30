namespace Weibel.API;

using Microsoft.Warehouse.History;

page 70270 "COL Posted Whse. Rcpt. Lines"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'postedWhseReceiptLine';
    EntitySetName = 'postedWhseReceiptLines';
    PageType = API;
    SourceTable = "Posted Whse. Receipt Line";
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
                field(no; Rec."No.")
                {
                }
                field(lineNo; Rec."Line No.")
                {
                }
                field(sourceType; Rec."Source Type")
                {
                }
                field(sourceSubtype; Rec."Source Subtype")
                {
                }
                field(sourceNo; Rec."Source No.")
                {
                }
                field(sourceLineNo; Rec."Source Line No.")
                {
                }
                field(sourceDocument; Rec."Source Document")
                {
                }
                field(locationCode; Rec."Location Code")
                {
                }
                field(shelfNo; Rec."Shelf No.")
                {
                }
                field(binCode; Rec."Bin Code")
                {
                }
                field(zoneCode; Rec."Zone Code")
                {
                }
                field(itemNo; Rec."Item No.")
                {
                }
                field(quantity; Rec.Quantity)
                {
                }
                field(qtyBase; Rec."Qty. (Base)")
                {
                }
                field(qtyCrossDocked; Rec."Qty. Cross-Docked")
                {
                }
                field(qtyCrossDockedBase; Rec."Qty. Cross-Docked (Base)")
                {
                }
                field(qtyPutAway; Rec."Qty. Put Away")
                {
                }
                field(qtyPutAwayBase; Rec."Qty. Put Away (Base)")
                {
                }
                field(putAwayQty; Rec."Put-away Qty.")
                {
                }
                field(putAwayQtyBase; Rec."Put-away Qty. (Base)")
                {
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                }
                field(variantCode; Rec."Variant Code")
                {
                }
                field(serialNo; Rec."Serial No.")
                {
                }
                field(lotNo; Rec."Lot No.")
                {
                }
                field(packageNo; Rec."Package No.")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(description2; Rec."Description 2")
                {
                }
                field(status; Rec.Status)
                {
                }
                field(dueDate; Rec."Due Date")
                {
                }
                field(startingDate; Rec."Starting Date")
                {
                }
                field(crossDockBinCode; Rec."Cross-Dock Bin Code")
                {
                }
                field(crossDockZoneCode; Rec."Cross-Dock Zone Code")
                {
                }
                field(postedSourceDocument; Rec."Posted Source Document")
                {
                }
                field(postedSourceNo; Rec."Posted Source No.")
                {
                }
                field(whseReceiptNo; Rec."Whse. Receipt No.")
                {
                }
                field(whseReceiptLineNo; Rec."Whse Receipt Line No.")
                {
                }
                field(postingDate; Rec."Posting Date")
                {
                }
                field(vendorShipmentNo; Rec."Vendor Shipment No.")
                {
                }
                field(warrantyDate; Rec."Warranty Date")
                {
                }
                field(expirationDate; Rec."Expiration Date")
                {
                }
                field(qtyRoundingPrecision; Rec."Qty. Rounding Precision")
                {
                }
                field(qtyRoundingPrecisionBase; Rec."Qty. Rounding Precision (Base)")
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
