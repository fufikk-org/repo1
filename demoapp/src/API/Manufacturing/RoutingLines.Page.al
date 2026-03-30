namespace Weibel.API;

using Microsoft.Manufacturing.Routing;

page 70150 "COL Routing Lines"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'routingLine';
    EntitySetName = 'routingLines';
    PageType = API;
    SourceTable = "Routing Line";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(routingNo; Rec."Routing No.")
                {
                }
                field(versionCode; Rec."Version Code")
                {
                }
                field(operationNo; Rec."Operation No.")
                {
                }
                field(nextOperationNo; Rec."Next Operation No.")
                {
                }
                field(previousOperationNo; Rec."Previous Operation No.")
                {
                }
                field(type; Rec."Type")
                {
                }
                field(no; Rec."No.")
                {
                }
                field(workCenterNo; Rec."Work Center No.")
                {
                }
                field(workCenterGroupCode; Rec."Work Center Group Code")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(setupTime; Rec."Setup Time")
                {
                }
                field(runTime; Rec."Run Time")
                {
                }
                field(waitTime; Rec."Wait Time")
                {
                }
                field(moveTime; Rec."Move Time")
                {
                }
                field(fixedScrapQuantity; Rec."Fixed Scrap Quantity")
                {
                }
                field(lotSize; Rec."Lot Size")
                {
                }
                field(scrapFactor; Rec."Scrap Factor %")
                {
                }
                field(setupTimeUnitOfMeasCode; Rec."Setup Time Unit of Meas. Code")
                {
                }
                field(runTimeUnitOfMeasCode; Rec."Run Time Unit of Meas. Code")
                {
                }
                field(waitTimeUnitOfMeasCode; Rec."Wait Time Unit of Meas. Code")
                {
                }
                field(moveTimeUnitOfMeasCode; Rec."Move Time Unit of Meas. Code")
                {
                }
                field(minimumProcessTime; Rec."Minimum Process Time")
                {
                }
                field(maximumProcessTime; Rec."Maximum Process Time")
                {
                }
                field(concurrentCapacities; Rec."Concurrent Capacities")
                {
                }
                field(sendAheadQuantity; Rec."Send-Ahead Quantity")
                {
                }
                field(routingLinkCode; Rec."Routing Link Code")
                {
                }
                field(standardTaskCode; Rec."Standard Task Code")
                {
                }
                field(unitCostPer; Rec."Unit Cost per")
                {
                }
                field(recalculate; Rec.Recalculate)
                {
                }
                field(comment; Rec.Comment)
                {
                }
                field(sequenceNoForward; Rec."Sequence No. (Forward)")
                {
                }
                field(sequenceNoBackward; Rec."Sequence No. (Backward)")
                {
                }
                field(fixedScrapQtyAccum; Rec."Fixed Scrap Qty. (Accum.)")
                {
                }
                field(scrapFactorAccumulated; Rec."Scrap Factor % (Accumulated)")
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
