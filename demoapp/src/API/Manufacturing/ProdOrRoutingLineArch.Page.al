namespace Weibel.API;

using Weibel.Manufacturing.Archive;

page 70169 "COL Prod.Or. Routing Line Arch"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'prodOrderRoutingLineArchive';
    EntitySetName = 'prodOrderRoutingLineArchives';
    PageType = API;
    SourceTable = "COL Prod.Or. Routing Line Arch";
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
                field(routingReferenceNo; Rec."Routing Reference No.")
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
                field(sequenceNoActual; Rec."Sequence No. (Actual)")
                {
                }
                field(directUnitCost; Rec."Direct Unit Cost")
                {
                }
                field(indirectCost; Rec."Indirect Cost %")
                {
                }
                field(overheadRate; Rec."Overhead Rate")
                {
                }
                field(startingTime; Rec."Starting Time")
                {
                }
                field(startingDate; Rec."Starting Date")
                {
                }
                field(endingTime; Rec."Ending Time")
                {
                }
                field(endingDate; Rec."Ending Date")
                {
                }
                field(status; Rec.Status)
                {
                }
                field(prodOrderNo; Rec."Prod. Order No.")
                {
                }
                field(unitCostCalculation; Rec."Unit Cost Calculation")
                {
                }
                field(inputQuantity; Rec."Input Quantity")
                {
                }
                field(criticalPath; Rec."Critical Path")
                {
                }
                field(routingStatus; Rec."Routing Status")
                {
                }
                field(flushingMethod; Rec."Flushing Method")
                {
                }
                field(expectedOperationCostAmt; Rec."Expected Operation Cost Amt.")
                {
                }
                field(expectedCapacityNeed; Rec."Expected Capacity Need")
                {
                }
                field(expectedCapacityOvhdCost; Rec."Expected Capacity Ovhd. Cost")
                {
                }
                field(startingDateTime; Rec."Starting Date-Time")
                {
                }
                field(endingDateTime; Rec."Ending Date-Time")
                {
                }
                field(scheduleManually; Rec."Schedule Manually")
                {
                }
                field(locationCode; Rec."Location Code")
                {
                }
                field(versionNo; Rec."Version No.")
                {
                }
                field(docNoOccurrence; Rec."Doc. No. Occurrence")
                {
                }
                field(openShopFloorBinCode; Rec."Open Shop Floor Bin Code")
                {
                }
                field(toProductionBinCode; Rec."To-Production Bin Code")
                {
                }
                field(fromProductionBinCode; Rec."From-Production Bin Code")
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
                field(prodOrderItemNo; ProdOrderItemNo)
                { }
                field(prodOrderItemVariantCode; ProdOrderItemVariantNo)
                { }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        GetAdditionalLineData();
    end;

    var
        ProdOrderLineArchive: Record "COL Prod. Order Line Archive";
        ProdOrderItemNo: Code[20];
        ProdOrderItemVariantNo: Code[20];

    local procedure GetAdditionalLineData()
    begin
        Clear(ProdOrderItemNo);
        Clear(ProdOrderItemVariantNo);

        ProdOrderLineArchive.ReadIsolation := IsolationLevel::ReadCommitted;
        ProdOrderLineArchive.SetLoadFields("Item No.", "Variant Code");

        ProdOrderLineArchive.SetCurrentKey(Status, "Prod. Order No.", "Routing No.", "Routing Reference No.", "Doc. No. Occurrence", "Version No.");
        ProdOrderLineArchive.SetRange(Status, Rec.Status);
        ProdOrderLineArchive.SetRange("Prod. Order No.", Rec."Prod. Order No.");
        ProdOrderLineArchive.SetRange("Routing No.", Rec."Routing No.");
        ProdOrderLineArchive.SetRange("Routing Reference No.", Rec."Routing Reference No.");
        ProdOrderLineArchive.SetRange("Doc. No. Occurrence", Rec."Doc. No. Occurrence");
        ProdOrderLineArchive.SetRange("Version No.", Rec."Version No.");

        if ProdOrderLineArchive.FindFirst() then begin
            ProdOrderItemNo := ProdOrderLineArchive."Item No.";
            ProdOrderItemVariantNo := ProdOrderLineArchive."Variant Code";
        end;
    end;
}
