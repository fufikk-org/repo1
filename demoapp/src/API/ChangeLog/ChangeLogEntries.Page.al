namespace Weibel.API;

using System.Diagnostics;

page 70213 "COL Change Log Entries"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'changeLogEntry';
    EntitySetName = 'changeLogEntries';
    PageType = API;
    SourceTable = "Change Log Entry";
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
                field(dateAndTime; Rec."Date and Time")
                {
                }
                field("time"; Rec."Time")
                {
                }
                field("userID"; Rec."User ID")
                {
                }
                field(tableNo; Rec."Table No.")
                {
                }
                field(fieldNo; Rec."Field No.")
                {
                }
                field(typeOfChange; Rec."Type of Change")
                {
                }
                field(oldValue; Rec."Old Value")
                {
                }
                field(newValue; Rec."New Value")
                {
                }
                field(primaryKey; Rec."Primary Key")
                {
                }
                field(primaryKeyField1No; Rec."Primary Key Field 1 No.")
                {
                }
                field(primaryKeyField1Caption; Rec."Primary Key Field 1 Caption")
                {
                }
                field(primaryKeyField1Value; Rec."Primary Key Field 1 Value")
                {
                }
                field(primaryKeyField2No; Rec."Primary Key Field 2 No.")
                {
                }
                field(primaryKeyField2Caption; Rec."Primary Key Field 2 Caption")
                {
                }
                field(primaryKeyField2Value; Rec."Primary Key Field 2 Value")
                {
                }
                field(primaryKeyField3No; Rec."Primary Key Field 3 No.")
                {
                }
                field(primaryKeyField3Caption; Rec."Primary Key Field 3 Caption")
                {
                }
                field(primaryKeyField3Value; Rec."Primary Key Field 3 Value")
                {
                }
                field("recordID"; Rec."Record ID")
                {
                }
                field(changedRecordSystemId; Rec."Changed Record SystemId")
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
