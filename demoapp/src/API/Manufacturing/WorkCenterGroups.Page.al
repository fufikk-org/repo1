namespace Weibel.API;

using Microsoft.Manufacturing.WorkCenter;

page 70183 "COL Work Center Groups"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'workCenterGroup';
    EntitySetName = 'workCenterGroups';
    PageType = API;
    SourceTable = "Work Center Group";
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
                field(capacityTotal; Rec."Capacity (Total)")
                {
                }
                field(capacityEffective; Rec."Capacity (Effective)")
                {
                }
                field(prodOrderNeedQty; Rec."Prod. Order Need (Qty.)")
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
