namespace Weibel.API;

using Microsoft.Manufacturing.Routing;

page 70175 "COL Routing Headers"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'routingHeader';
    EntitySetName = 'routingHeaders';
    PageType = API;
    SourceTable = "Routing Header";
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
                field(description; Rec.Description)
                {
                }
                field(description2; Rec."Description 2")
                {
                }
                field(searchDescription; Rec."Search Description")
                {
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                }
                field(comment; Rec.Comment)
                {
                }
                field(status; Rec.Status)
                {
                }
                field(type; Rec."Type")
                {
                }
                field(versionNos; Rec."Version Nos.")
                {
                }
                field(noSeries; Rec."No. Series")
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
