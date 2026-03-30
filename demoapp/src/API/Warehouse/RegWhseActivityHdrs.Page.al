namespace Weibel.API;

using Microsoft.Warehouse.Activity.History;

page 70261 "COL Reg. Whse. Activity Hdrs."
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'registeredWhseActivityHeader';
    EntitySetName = 'registeredWhseActivityHeaders';
    PageType = API;
    SourceTable = "Registered Whse. Activity Hdr.";
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
                field(registeringDate; Rec."Registering Date")
                {
                }
                field(noSeries; Rec."No. Series")
                {
                }
                field(whseActivityNo; Rec."Whse. Activity No.")
                {
                }
                field(noPrinted; Rec."No. Printed")
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
