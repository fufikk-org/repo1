namespace Weibel.API;

using Weibel.Inventory.LegacyItems;

page 70194 "COL API Legacy Items"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'legacyItem';
    EntitySetName = 'legacyItems';
    PageType = API;
    SourceTable = "COL Legacy Item";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(navItemNo; Rec."NAV Item No.")
                {
                }

                field(navItemDescription; Rec."NAV Item Description")
                {
                }
                field(navItemDescription2; Rec."NAV Item Description 2")
                {
                }
                field(itemNo; Rec."Item No.")
                {
                }
                field(variantCode; Rec."Variant Code")
                {
                }
                field(itemDescription; Rec."Item Description")
                {
                }
                field(itemDescription2; Rec."Item Description 2")
                {
                }
                field(variantDescription; Rec."Variant Description")
                {
                }
                field(variantDescription2; Rec."Variant Description 2")
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
