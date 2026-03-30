namespace Weibel.API;

using Microsoft.Inventory.Item.Attribute;

page 70252 "COL Item AttributeValueMap.API"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'itemAttributeValueMapping';
    EntitySetName = 'itemAttributeValueMappings';
    PageType = API;
    SourceTable = "Item Attribute Value Mapping";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(tableID; Rec."Table ID")
                {
                }
                field(no; Rec."No.")
                {
                }
                field(itemAttributeID; Rec."Item Attribute ID")
                {
                }
                field(itemAttributeValueID; Rec."Item Attribute Value ID")
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
