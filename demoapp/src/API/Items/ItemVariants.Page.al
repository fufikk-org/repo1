namespace Weibel.API;

using Microsoft.Inventory.Item;

page 70211 "COL Item Variants"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'itemVariant';
    EntitySetName = 'itemVariants';
    PageType = API;
    SourceTable = "Item Variant";
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
                field(itemNo; Rec."Item No.")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(description2; Rec."Description 2")
                {
                }
                field(itemId; Rec."Item Id")
                {
                }
                field(blocked; Rec.Blocked)
                {
                }
                field(salesBlocked; Rec."Sales Blocked")
                {
                }
                field(purchasingBlocked; Rec."Purchasing Blocked")
                {
                }
                field(serviceBlocked; Rec."Service Blocked")
                {
                }
                field(productionBlocked; Rec."COL Production Blocked")
                {
                }
                field(colProductLifeCycle; Rec."COL Product Life Cycle")
                {
                }
                field(colChangedBy; Rec."COL Changed By")
                {
                }
                field(colDateChanged; Rec."COL Date Changed")
                {
                }
                field(colProductionBlocked; Rec."COL Production Blocked")
                {
                }
                field(colProjectBlocked; Rec."COL Project Blocked")
                {
                }
                field(colPlanningBlocked; Rec."COL Planning Blocked")
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
                part(comments; "COL Record Link Comments")
                {
                    // just to pass some filtering information to subpage and get notes for specific document
                    SubPageLink = SystemId = field(SystemId), "Link ID" = const(Database::"Item Variant"), Type = filter(Note | Link);
                }
            }
        }
    }
}
