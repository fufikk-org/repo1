namespace Weibel.API;

page 70161 "COL JobManEmployeeGroup"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'jobManEmployeeGroup';
    EntitySetName = 'jobManEmployeeGroups';
    PageType = API;
    SourceTable = JobManEmployeeGroup;
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(groupNo; Rec.GroupNo)
                {
                }
                field(type; Rec."Type")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(responsibleUserID; Rec.ResponsibleUserID)
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
