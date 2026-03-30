namespace Weibel.API;

using Microsoft.Warehouse.Document;

page 70182 "COL Warehouse Shipment Lines"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'warehouseShipmentLine';
    EntitySetName = 'warehouseShipmentLines';
    PageType = API;
    SourceTable = "Warehouse Shipment Line";
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
                field(qtyOutstanding; Rec."Qty. Outstanding")
                {
                }
                field(qtyOutstandingBase; Rec."Qty. Outstanding (Base)")
                {
                }
                field(qtyToShip; Rec."Qty. to Ship")
                {
                }
                field(qtyToShipBase; Rec."Qty. to Ship (Base)")
                {
                }
                field(qtyPicked; Rec."Qty. Picked")
                {
                }
                field(qtyPickedBase; Rec."Qty. Picked (Base)")
                {
                }
                field(qtyShipped; Rec."Qty. Shipped")
                {
                }
                field(qtyShippedBase; Rec."Qty. Shipped (Base)")
                {
                }
                field(pickQty; Rec."Pick Qty.")
                {
                }
                field(pickQtyBase; Rec."Pick Qty. (Base)")
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
                field(description; Rec.Description)
                {
                }
                field(description2; Rec."Description 2")
                {
                }
                field(status; Rec.Status)
                {
                }
                field(sortingSequenceNo; Rec."Sorting Sequence No.")
                {
                }
                field(dueDate; Rec."Due Date")
                {
                }
                field(destinationType; Rec."Destination Type")
                {
                }
                field(destinationNo; Rec."Destination No.")
                {
                }
                field(cubage; Rec.Cubage)
                {
                }
                field(weight; Rec.Weight)
                {
                }
                field(shippingAdvice; Rec."Shipping Advice")
                {
                }
                field(shipmentDate; Rec."Shipment Date")
                {
                }
                field(completelyPicked; Rec."Completely Picked")
                {
                }
                field(notUpdBySrcDocPost; Rec."Not upd. by Src. Doc. Post.")
                {
                }
                field(postingFromWhseRef; Rec."Posting from Whse. Ref.")
                {
                }
                field(qtyRoundingPrecision; Rec."Qty. Rounding Precision")
                {
                }
                field(qtyRoundingPrecisionBase; Rec."Qty. Rounding Precision (Base)")
                {
                }
                field(assembleToOrder; Rec."Assemble to Order")
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
