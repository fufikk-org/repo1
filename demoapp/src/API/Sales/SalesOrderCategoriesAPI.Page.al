namespace Weibel.API;

using Weibel.Foundation.SalesOrderCategory;

page 70209 "COL Sales Order Categories API"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'salesOrderCategory';
    EntitySetName = 'salesOrderCategories';
    PageType = API;
    SourceTable = "COL Sales Order Category";
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
                field(description; Rec.Description)
                {
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                }
                field(systemId; Rec.SystemId)
                {
                }
            }
        }
    }
}
