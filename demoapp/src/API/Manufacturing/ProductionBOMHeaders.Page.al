namespace Weibel.API;

using Microsoft.Manufacturing.ProductionBOM;

page 70149 "COL Production BOM Headers"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'productionBomHeader';
    EntitySetName = 'productionBomHeaders';
    PageType = API;
    SourceTable = "Production BOM Header";
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
                field(searchName; Rec."Search Name")
                {
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                }
                field(lowLevelCode; Rec."Low-Level Code")
                {
                }
                field(comment; Rec.Comment)
                {
                }
                field(creationDate; Rec."Creation Date")
                {
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                }
                field(status; Rec.Status)
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
