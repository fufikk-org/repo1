namespace Weibel.API;

using System.Threading;

page 70130 "COL Job Queue Log Entries"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'jobQueueLogEntry';
    EntitySetName = 'jobQueueLogEntries';
    PageType = API;
    SourceTable = "Job Queue Log Entry";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(entryNo; Rec."Entry No.")
                {
                }
                field(id; Rec.ID)
                {
                }
                field("userID"; Rec."User ID")
                {
                }
                field(startDateTime; Rec."Start Date/Time")
                {
                }
                field(endDateTime; Rec."End Date/Time")
                {
                }
                field(objectTypeToRun; Rec."Object Type to Run")
                {
                }
                field(objectIDToRun; Rec."Object ID to Run")
                {
                }
                field(objectCaptionToRun; Rec."Object Caption to Run")
                {
                }
                field(status; Rec.Status)
                {
                }
                field(description; Rec.Description)
                {
                }
                field(errorMessage; Rec."Error Message")
                {
                }
                field(jobQueueCategoryCode; Rec."Job Queue Category Code")
                {
                }
                field(parameterString; Rec."Parameter String")
                {
                }
                field(errorMessageRegisterId; Rec."Error Message Register Id")
                {
                }
                field(systemTaskId; Rec."System Task Id")
                {
                }
                field(userSessionID; Rec."User Session ID")
                {
                }
                field(userServiceInstanceID; Rec."User Service Instance ID")
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
