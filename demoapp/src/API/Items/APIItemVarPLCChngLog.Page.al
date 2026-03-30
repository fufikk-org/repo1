namespace Weibel.API;

using Weibel.Inventory.Item;

page 70215 "COL API Item Var. PLC Chng Log"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'itemVariantPLCChangeLog';
    EntitySetName = 'itemVariantPLCChangeLogs';
    PageType = API;
    SourceTable = "COL Item Variant PLC Chng. Log";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(itemNo; Rec."Item No.")
                {
                }
                field(variantCode; Rec."Variant Code")
                {
                }
                field(entryNo; Rec."Entry No.")
                {
                }
                field(oldPLC; Rec."Old PLC")
                {
                }
                field(newPLC; Rec."New PLC")
                {
                }
                field(changedBy; Rec."Changed By")
                {
                }
                field(dateChanged; Rec."Date Changed")
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
