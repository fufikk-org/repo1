namespace Weibel.API;

using Microsoft.Finance.Dimension;

page 70155 "COL Dimension Values"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'dimensionValue';
    EntitySetName = 'dimensionValues';
    PageType = API;
    SourceTable = "Dimension Value";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(dimensionCode; Rec."Dimension Code")
                {
                }
                field("code"; Rec."Code")
                {
                }
                field(name; Rec.Name)
                {
                }
                field(dimensionValueType; Rec."Dimension Value Type")
                {
                }
                field(totaling; Rec.Totaling)
                {
                }
                field(blocked; Rec.Blocked)
                {
                }
                field(consolidationCode; Rec."Consolidation Code")
                {
                }
                field(indentation; Rec.Indentation)
                {
                }
                field(globalDimensionNo; Rec."Global Dimension No.")
                {
                }
                field(mapToICDimensionCode; Rec."Map-to IC Dimension Code")
                {
                }
                field(mapToICDimensionValueCode; Rec."Map-to IC Dimension Value Code")
                {
                }
                field(dimensionValueID; Rec."Dimension Value ID")
                {
                }
                field(lastModifiedDateTime; Rec."Last Modified Date Time")
                {
                }
                field(dimensionId; Rec."Dimension Id")
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
