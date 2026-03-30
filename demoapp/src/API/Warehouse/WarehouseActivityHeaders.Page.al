namespace Weibel.API;

using Microsoft.Warehouse.Activity;

page 70180 "COL Warehouse Activity Headers"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'warehouseActivityHeader';
    EntitySetName = 'warehouseActivityHeaders';
    PageType = API;
    SourceTable = "Warehouse Activity Header";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(type; Rec."Type")
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
                field(sortingMethod; Rec."Sorting Method")
                {
                }
                field(noSeries; Rec."No. Series")
                {
                }
                field(comment; Rec.Comment)
                {
                }
                field(noPrinted; Rec."No. Printed")
                {
                }
                field(noOfLines; Rec."No. of Lines")
                {
                }
                field(postingDate; Rec."Posting Date")
                {
                }
                field(registeringNo; Rec."Registering No.")
                {
                }
                field(lastRegisteringNo; Rec."Last Registering No.")
                {
                }
                field(registeringNoSeries; Rec."Registering No. Series")
                {
                }
                field(dateOfLastPrinting; Rec."Date of Last Printing")
                {
                }
                field(timeOfLastPrinting; Rec."Time of Last Printing")
                {
                }
                field(breakbulkFilter; Rec."Breakbulk Filter")
                {
                }
                field(sourceNo; Rec."Source No.")
                {
                }
                field(sourceDocument; Rec."Source Document")
                {
                }
                field(sourceType; Rec."Source Type")
                {
                }
                field(sourceSubtype; Rec."Source Subtype")
                {
                }
                field(destinationType; Rec."Destination Type")
                {
                }
                field(destinationNo; Rec."Destination No.")
                {
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                }
                field(expectedReceiptDate; Rec."Expected Receipt Date")
                {
                }
                field(shipmentDate; Rec."Shipment Date")
                {
                }
                field(externalDocumentNo2; Rec."External Document No.2")
                {
                }
                field(doNotFillQtyToHandle; Rec."Do Not Fill Qty. to Handle")
                {
                }
                field(colRoutingLinkCode; Rec."COL Routing Link Code")
                {
                }
                field(colWorkCenterCode; Rec."COL Work Center Code")
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
