namespace Weibel.API;

using Microsoft.Warehouse.Structure;

page 70153 "COL Bins"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'bin';
    EntitySetName = 'bins';
    PageType = API;
    SourceTable = Bin;
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(locationCode; Rec."Location Code")
                {
                }
                field("code"; Rec."Code")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(zoneCode; Rec."Zone Code")
                {
                }
                field(adjustmentBin; Rec."Adjustment Bin")
                {
                }
                field(binTypeCode; Rec."Bin Type Code")
                {
                }
                field(warehouseClassCode; Rec."Warehouse Class Code")
                {
                }
                field(blockMovement; Rec."Block Movement")
                {
                }
                field(specialEquipmentCode; Rec."Special Equipment Code")
                {
                }
                field(binRanking; Rec."Bin Ranking")
                {
                }
                field(maximumCubage; Rec."Maximum Cubage")
                {
                }
                field(maximumWeight; Rec."Maximum Weight")
                {
                }
                field(empty; Rec.Empty)
                {
                }
                field(default; Rec.Default)
                {
                }
                field(crossDockBin; Rec."Cross-Dock Bin")
                {
                }
                field(dedicated; Rec.Dedicated)
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
