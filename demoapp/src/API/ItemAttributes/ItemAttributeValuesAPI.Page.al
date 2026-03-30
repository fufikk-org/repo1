namespace Weibel.API;

using Microsoft.Inventory.Item.Attribute;

page 70239 "COL Item Attribute Values API"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'itemAttributeValue';
    EntitySetName = 'itemAttributeValues';
    PageType = API;
    SourceTable = "Item Attribute Value";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(attributeID; Rec."Attribute ID")
                {
                }
                field(id; Rec.ID)
                {
                }
                field(value; Rec."Value")
                {
                }
                field(numericValue; Rec."Numeric Value")
                {
                }
                field(dateValue; Rec."Date Value")
                {
                }
                field(blocked; Rec.Blocked)
                {
                }
                field(attributeName; Rec."Attribute Name")
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
