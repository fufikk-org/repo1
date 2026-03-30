namespace Weibel.API;

using Microsoft.Manufacturing.Document;

page 70187 "COL ProdOrderRoutLines API"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'prodOrderRoutingLine';
    EntitySetName = 'prodOrderRoutingLines';
    PageType = API;
    SourceTable = "Prod. Order Routing Line";
    Editable = false;
    ODataKeyFields = SystemId;
    DataAccessIntent = ReadOnly;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'SystemId', Locked = true;
                }
                field(routingNo; Rec."Routing No.")
                {
                    Caption = 'Routing No.', Locked = true;
                }
                field(routingReferenceNo; Rec."Routing Reference No.")
                {
                    Caption = 'Routing Reference No.', Locked = true;
                }
                field(operationNo; Rec."Operation No.")
                {
                    Caption = 'Operation No.', Locked = true;
                }
                field(nextOperationNo; Rec."Next Operation No.")
                {
                    Caption = 'Next Operation No.', Locked = true;
                }
                field(previousOperationNo; Rec."Previous Operation No.")
                {
                    Caption = 'Previous Operation No.', Locked = true;
                }
                field(type; Rec."Type")
                {
                    Caption = 'Type', Locked = true;
                }
                field(no; Rec."No.")
                {
                    Caption = 'No.', Locked = true;
                }
                field(workCenterNo; Rec."Work Center No.")
                {
                    Caption = 'Work Center No.', Locked = true;
                }
                field(workCenterGroupCode; Rec."Work Center Group Code")
                {
                    Caption = 'Work Center Group Code', Locked = true;
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description', Locked = true;
                }
                field(setupTime; Rec."Setup Time")
                {
                    Caption = 'Setup Time', Locked = true;
                }
                field(runTime; Rec."Run Time")
                {
                    Caption = 'Run Time', Locked = true;
                }
                field(waitTime; Rec."Wait Time")
                {
                    Caption = 'Wait Time', Locked = true;
                }
                field(moveTime; Rec."Move Time")
                {
                    Caption = 'Move Time', Locked = true;
                }
                field(fixedScrapQuantity; Rec."Fixed Scrap Quantity")
                {
                    Caption = 'Fixed Scrap Quantity', Locked = true;
                }
                field(lotSize; Rec."Lot Size")
                {
                    Caption = 'Lot Size', Locked = true;
                }
                field(scrapFactor; Rec."Scrap Factor %")
                {
                    Caption = 'Scrap Factor %', Locked = true;
                }
                field(setupTimeUnitOfMeasCode; Rec."Setup Time Unit of Meas. Code")
                {
                    Caption = 'Setup Time Unit of Meas. Code', Locked = true;
                }
                field(runTimeUnitOfMeasCode; Rec."Run Time Unit of Meas. Code")
                {
                    Caption = 'Run Time Unit of Meas. Code', Locked = true;
                }
                field(waitTimeUnitOfMeasCode; Rec."Wait Time Unit of Meas. Code")
                {
                    Caption = 'Wait Time Unit of Meas. Code', Locked = true;
                }
                field(moveTimeUnitOfMeasCode; Rec."Move Time Unit of Meas. Code")
                {
                    Caption = 'Move Time Unit of Meas. Code', Locked = true;
                }
                field(minimumProcessTime; Rec."Minimum Process Time")
                {
                    Caption = 'Minimum Process Time', Locked = true;
                }
                field(maximumProcessTime; Rec."Maximum Process Time")
                {
                    Caption = 'Maximum Process Time', Locked = true;
                }
                field(concurrentCapacities; Rec."Concurrent Capacities")
                {
                    Caption = 'Concurrent Capacities', Locked = true;
                }
                field(sendAheadQuantity; Rec."Send-Ahead Quantity")
                {
                    Caption = 'Send-Ahead Quantity', Locked = true;
                }
                field(routingLinkCode; Rec."Routing Link Code")
                {
                    Caption = 'Routing Link Code', Locked = true;
                }
                field(standardTaskCode; Rec."Standard Task Code")
                {
                    Caption = 'Standard Task Code', Locked = true;
                }
                field(unitCostPer; Rec."Unit Cost per")
                {
                    Caption = 'Unit Cost per', Locked = true;
                }
                field(recalculate; Rec.Recalculate)
                {
                    Caption = 'Recalculate', Locked = true;
                }
                field(sequenceNoForward; Rec."Sequence No. (Forward)")
                {
                    Caption = 'Sequence No. (Forward)', Locked = true;
                }
                field(sequenceNoBackward; Rec."Sequence No. (Backward)")
                {
                    Caption = 'Sequence No. (Backward)', Locked = true;
                }
                field(fixedScrapQtyAccum; Rec."Fixed Scrap Qty. (Accum.)")
                {
                    Caption = 'Fixed Scrap Qty. (Accum.)', Locked = true;
                }
                field(scrapFactorAccumulated; Rec."Scrap Factor % (Accumulated)")
                {
                    Caption = 'Scrap Factor % (Accumulated)', Locked = true;
                }
                field(sequenceNoActual; Rec."Sequence No. (Actual)")
                {
                    Caption = 'Sequence No. (Actual)', Locked = true;
                }
                field(directUnitCost; Rec."Direct Unit Cost")
                {
                    Caption = 'Direct Unit Cost', Locked = true;
                }
                field(indirectCost; Rec."Indirect Cost %")
                {
                    Caption = 'Indirect Cost %', Locked = true;
                }
                field(overheadRate; Rec."Overhead Rate")
                {
                    Caption = 'Overhead Rate', Locked = true;
                }
                field(startingTime; Rec."Starting Time")
                {
                    Caption = 'Starting Time', Locked = true;
                }
                field(startingDate; Rec."Starting Date")
                {
                    Caption = 'Starting Date', Locked = true;
                }
                field(endingTime; Rec."Ending Time")
                {
                    Caption = 'Ending Time', Locked = true;
                }
                field(endingDate; Rec."Ending Date")
                {
                    Caption = 'Ending Date', Locked = true;
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status', Locked = true;
                }
                field(prodOrderNo; Rec."Prod. Order No.")
                {
                    Caption = 'Prod. Order No.', Locked = true;
                }
                field(unitCostCalculation; Rec."Unit Cost Calculation")
                {
                    Caption = 'Unit Cost Calculation', Locked = true;
                }
                field(inputQuantity; Rec."Input Quantity")
                {
                    Caption = 'Input Quantity', Locked = true;
                }
                field(criticalPath; Rec."Critical Path")
                {
                    Caption = 'Critical Path', Locked = true;
                }
                field(routingStatus; Rec."Routing Status")
                {
                    Caption = 'Routing Status', Locked = true;
                }
                field(flushingMethod; Rec."Flushing Method")
                {
                    Caption = 'Flushing Method', Locked = true;
                }
                field(expectedOperationCostAmt; Rec."Expected Operation Cost Amt.")
                {
                    Caption = 'Expected Operation Cost Amt.', Locked = true;
                }
                field(expectedCapacityNeed; Rec."Expected Capacity Need")
                {
                    Caption = 'Expected Capacity Need', Locked = true;
                }
                field(expectedCapacityOvhdCost; Rec."Expected Capacity Ovhd. Cost")
                {
                    Caption = 'Expected Capacity Ovhd. Cost', Locked = true;
                }
                field(startingDateTime; Rec."Starting Date-Time")
                {
                    Caption = 'Starting Date-Time', Locked = true;
                }
                field(endingDateTime; Rec."Ending Date-Time")
                {
                    Caption = 'Ending Date-Time', Locked = true;
                }
                field(scheduleManually; Rec."Schedule Manually")
                {
                    Caption = 'Schedule Manually', Locked = true;
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code', Locked = true;
                }
                field(openShopFloorBinCode; Rec."Open Shop Floor Bin Code")
                {
                    Caption = 'Open Shop Floor Bin Code', Locked = true;
                }
                field(toProductionBinCode; Rec."To-Production Bin Code")
                {
                    Caption = 'To-Production Bin Code', Locked = true;
                }
                field(fromProductionBinCode; Rec."From-Production Bin Code")
                {
                    Caption = 'From-Production Bin Code', Locked = true;
                }
                // field(colSkipRoutingLine; Rec."COL Skip Routing Line")
                // {
                //     Caption = 'Skip Routing Line', Locked = true;
                // }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId', Locked = true;
                }
#if not BLOCK_DYNAMIC_PRODITEMNO
                field(prodOrderItemNo; ProdOrderItemNo)
                { }
                field(prodOrderItemVariantCode; ProdOrderItemVariantNo)
                { }
#else
                field(prodOrderItemNo; Rec."COL Prod. Order Item No.")
                {
                }
                field(prodOrderItemVariantCode; Rec."COL Prod. Order Variant Code")
                {
                }
#endif
                field(colLock; Rec."COL Lock")
                {
                }
                field(colFinishedByUser; Rec."COL Finished By User")
                {
                }
                field(colFinishedDateTime; Rec."COL Finished Date-Time")
                {
                }
                field(colInProgressDateTime; Rec."COL In Progress Date-Time")
                {
                }
                field(colInProgressSetByUser; Rec."COL In Progress Set By User")
                {
                }
                field(systemCreatedAt; Rec."SystemCreatedAt") { }

                field(systemCreatedBy; Rec."SystemCreatedBy") { }

                field(systemModifiedAt; Rec."SystemModifiedAt") { }

                field(systemModifiedBy; Rec."SystemModifiedBy") { }
            }
        }
    }

#if not BLOCK_DYNAMIC_PRODITEMNO
    trigger OnAfterGetRecord()
    begin
        GetAdditionalLineData();
    end;


    var
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderItemNo: Code[20];
        ProdOrderItemVariantNo: Code[20];

    local procedure GetAdditionalLineData()
    begin
        Clear(ProdOrderItemNo);
        Clear(ProdOrderItemVariantNo);

        ProdOrderLine.ReadIsolation := IsolationLevel::ReadCommitted;
        ProdOrderLine.SetLoadFields("Item No.", "Variant Code");

        ProdOrderLine.SetCurrentKey(Status, "Prod. Order No.", "Routing No.", "Routing Reference No.");
        ProdOrderLine.SetRange(Status, Rec.Status);
        ProdOrderLine.SetRange("Prod. Order No.", Rec."Prod. Order No.");
        ProdOrderLine.SetRange("Routing No.", Rec."Routing No.");
        ProdOrderLine.SetRange("Routing Reference No.", Rec."Routing Reference No.");
        if ProdOrderLine.FindFirst() then begin
            ProdOrderItemNo := ProdOrderLine."Item No.";
            ProdOrderItemVariantNo := ProdOrderLine."Variant Code";
        end;
    end;
#endif
}
