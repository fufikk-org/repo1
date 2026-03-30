namespace Weibel.API;

using Microsoft.Warehouse.History;

page 70271 "COL Posted Whse. Shpt. Hdrs."
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'postedWhseShipmentHeader';
    EntitySetName = 'postedWhseShipmentHeaders';
    PageType = API;
    SourceTable = "Posted Whse. Shipment Header";
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
                field(locationCode; Rec."Location Code")
                {
                }
                field(assignedUserID; Rec."Assigned User ID")
                {
                }
                field(assignmentDate; Rec."Assignment Date")
                {
                }
                field(assignmentTime; Rec."Assignment Time")
                {
                }
                field(noSeries; Rec."No. Series")
                {
                }
                field(zoneCode; Rec."Zone Code")
                {
                }
                field(binCode; Rec."Bin Code")
                {
                }
                field(postingDate; Rec."Posting Date")
                {
                }
                field(shipmentDate; Rec."Shipment Date")
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
                field(whseShipmentNo; Rec."Whse. Shipment No.")
                {
                }
                field(externalDocumentNo; Rec."External Document No.")
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
