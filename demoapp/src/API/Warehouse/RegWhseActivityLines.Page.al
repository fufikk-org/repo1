namespace Weibel.API;

using Microsoft.Warehouse.Activity.History;

page 70262 "COL Reg. Whse. Activity Lines"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'registeredWhseActivityLine';
    EntitySetName = 'registeredWhseActivityLines';
    PageType = API;
    SourceTable = "Registered Whse. Activity Line";
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
                field(activityType; Rec."Activity Type")
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
                field(sourceSublineNo; Rec."Source Subline No.")
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
                field(sortingSequenceNo; Rec."Sorting Sequence No.")
                {
                }
                field(itemNo; Rec."Item No.")
                {
                }
                field(variantCode; Rec."Variant Code")
                {
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(description2; Rec."Description 2")
                {
                }
                field(quantity; Rec.Quantity)
                {
                }
                field(qtyBase; Rec."Qty. (Base)")
                {
                }
                field(shippingAdvice; Rec."Shipping Advice")
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
                field(whseActivityNo; Rec."Whse. Activity No.")
                {
                }
                field(shippingAgentCode; Rec."Shipping Agent Code")
                {
                }
                field(shippingAgentServiceCode; Rec."Shipping Agent Service Code")
                {
                }
                field(shipmentMethodCode; Rec."Shipment Method Code")
                {
                }
                field(startingDate; Rec."Starting Date")
                {
                }
                field(serialNo; Rec."Serial No.")
                {
                }
                field(lotNo; Rec."Lot No.")
                {
                }
                field(warrantyDate; Rec."Warranty Date")
                {
                }
                field(expirationDate; Rec."Expiration Date")
                {
                }
                field(packageNo; Rec."Package No.")
                {
                }
                field(binCode; Rec."Bin Code")
                {
                }
                field(zoneCode; Rec."Zone Code")
                {
                }
                field(actionType; Rec."Action Type")
                {
                }
                field(whseDocumentType; Rec."Whse. Document Type")
                {
                }
                field(whseDocumentNo; Rec."Whse. Document No.")
                {
                }
                field(whseDocumentLineNo; Rec."Whse. Document Line No.")
                {
                }
                field(cubage; Rec.Cubage)
                {
                }
                field(weight; Rec.Weight)
                {
                }
                field(specialEquipmentCode; Rec."Special Equipment Code")
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
