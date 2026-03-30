namespace Weibel.API;

using Microsoft.Inventory.Item.Attribute;

page 70238 "COL Item Attributes API"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'itemAttribute';
    EntitySetName = 'itemAttributes';
    PageType = API;
    SourceTable = "Item Attribute";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(id; Rec.ID)
                {
                }
                field(name; Rec.Name)
                {
                }
                field(blocked; Rec.Blocked)
                {
                }
                field(type; Rec."Type")
                {
                }
                field(unitOfMeasure; Rec."Unit of Measure")
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
