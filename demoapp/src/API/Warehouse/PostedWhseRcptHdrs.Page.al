namespace Weibel.API;

using Microsoft.Warehouse.History;

page 70268 "COL Posted Whse. Rcpt. Hdrs."
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'postedWhseReceiptHeader';
    EntitySetName = 'postedWhseReceiptHeaders';
    PageType = API;
    SourceTable = "Posted Whse. Receipt Header";
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
                field(documentStatus; Rec."Document Status")
                {
                }
                field(postingDate; Rec."Posting Date")
                {
                }
                field(vendorShipmentNo; Rec."Vendor Shipment No.")
                {
                }
                field(whseReceiptNo; Rec."Whse. Receipt No.")
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
