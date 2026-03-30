namespace Weibel.API;

using Weibel.Inventory.Item;

page 70217 "COL API Manufacturers"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'manufacturer';
    EntitySetName = 'manufacturers';
    PageType = API;
    SourceTable = "COL Manufacturer";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("code"; Rec."Code")
                {
                }
                field(name; Rec.Name)
                {
                }
                field(vendorNo; Rec."Vendor No.")
                {
                }
                field(website; Rec.Website)
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
