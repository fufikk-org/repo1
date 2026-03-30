namespace Weibel.API;

using Microsoft.Warehouse.History;

page 70267 "COL Posted Whse. Shpt. Lines"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'postedWhseShipmentLine';
    EntitySetName = 'postedWhseShipmentLines';
    PageType = API;
    SourceTable = "Posted Whse. Shipment Line";
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
                field(dueDate; Rec."Due Date")
                {
                }
                field(shippingAdvice; Rec."Shipping Advice")
                {
                }
                field(destinationType; Rec."Destination Type")
                {
                }
                field(destinationNo; Rec."Destination No.")
                {
                }
                field(shipmentDate; Rec."Shipment Date")
                {
                }
                field(postedSourceDocument; Rec."Posted Source Document")
                {
                }
                field(postedSourceNo; Rec."Posted Source No.")
                {
                }
                field(whseShipmentNo; Rec."Whse. Shipment No.")
                {
                }
                field(whseShipmentLineNo; Rec."Whse Shipment Line No.")
                {
                }
                field(postingDate; Rec."Posting Date")
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
