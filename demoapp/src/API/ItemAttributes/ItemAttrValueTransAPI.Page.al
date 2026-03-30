namespace Weibel.API;

using Microsoft.Inventory.Item.Attribute;

page 70251 "COL Item Attr. Value Trans.API"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'itemAttrValueTranslation';
    EntitySetName = 'itemAttrValueTranslations';
    PageType = API;
    SourceTable = "Item Attr. Value Translation";
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
                field(languageCode; Rec."Language Code")
                {
                }
                field(name; Rec.Name)
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
