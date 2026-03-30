namespace Weibel.API;

using Microsoft.Inventory.Item;

page 70230 "COL Item Entry Relations"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'itemEntryRelation';
    EntitySetName = 'itemEntryRelations';
    PageType = API;
    SourceTable = "Item Entry Relation";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(itemEntryNo; Rec."Item Entry No.")
                {
                }
                field(sourceType; Rec."Source Type")
                {
                }
                field(sourceSubtype; Rec."Source Subtype")
                {
                }
                field(sourceID; Rec."Source ID")
                {
                }
                field(sourceBatchName; Rec."Source Batch Name")
                {
                }
                field(sourceProdOrderLine; Rec."Source Prod. Order Line")
                {
                }
                field(sourceRefNo; Rec."Source Ref. No.")
                {
                }
                field(serialNo; Rec."Serial No.")
                {
                }
                field(lotNo; Rec."Lot No.")
                {
                }
                field(orderNo; Rec."Order No.")
                {
                }
                field(orderLineNo; Rec."Order Line No.")
                {
                }
                field(packageNo; Rec."Package No.")
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
