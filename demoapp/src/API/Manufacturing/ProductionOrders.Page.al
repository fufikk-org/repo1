namespace Weibel.API;

using Microsoft.Manufacturing.Document;

page 70171 "COL Production Orders"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'productionOrder';
    EntitySetName = 'productionOrders';
    PageType = API;
    SourceTable = "Production Order";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(status; Rec.Status)
                {
                }
                field(no; Rec."No.")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(searchDescription; Rec."Search Description")
                {
                }
                field(description2; Rec."Description 2")
                {
                }
                field(creationDate; Rec."Creation Date")
                {
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                }
                field(sourceType; Rec."Source Type")
                {
                }
                field(sourceNo; Rec."Source No.")
                {
                }
                field(routingNo; Rec."Routing No.")
                {
                }
                field(variantCode; Rec."Variant Code")
                {
                }
                field(inventoryPostingGroup; Rec."Inventory Posting Group")
                {
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                }
                field(comment; Rec.Comment)
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
                field(dueDate; Rec."Due Date")
                {
                }
                field(finishedDate; Rec."Finished Date")
                {
                }
                field(blocked; Rec.Blocked)
                {
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                }
                field(locationCode; Rec."Location Code")
                {
                }
                field(binCode; Rec."Bin Code")
                {
                }
                field(replanRefNo; Rec."Replan Ref. No.")
                {
                }
                field(replanRefStatus; Rec."Replan Ref. Status")
                {
                }
                field(lowLevelCode; Rec."Low-Level Code")
                {
                }
                field(quantity; Rec.Quantity)
                {
                }
                field(unitCost; Rec."Unit Cost")
                {
                }
                field(costAmount; Rec."Cost Amount")
                {
                }
                field(expectedOperationCostAmt; Rec."Expected Operation Cost Amt.")
                {
                }
                field(expectedComponentCostAmt; Rec."Expected Component Cost Amt.")
                {
                }
                field(actualTimeUsed; Rec."Actual Time Used")
                {
                }
                field(allocatedCapacityNeed; Rec."Allocated Capacity Need")
                {
                }
                field(expectedCapacityNeed; Rec."Expected Capacity Need")
                {
                }
                field(noSeries; Rec."No. Series")
                {
                }
                field(plannedOrderNo; Rec."Planned Order No.")
                {
                }
                field(firmPlannedOrderNo; Rec."Firm Planned Order No.")
                {
                }
                field(simulatedOrderNo; Rec."Simulated Order No.")
                {
                }
                field(expectedMaterialOvhdCost; Rec."Expected Material Ovhd. Cost")
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
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                }
                field(completelyPicked; Rec."Completely Picked")
                {
                }
                field(assignedUserID; Rec."Assigned User ID")
                {
                }
                field(colRemainingQuantity; Rec."COL Remaining Quantity")
                {
                }
                field(colCapacityLedgerEntries; Rec."COL Capacity Ledger Entries")
                {
                }
                field(colNoOfArchivedVersions; Rec."COL No. of Archived Versions")
                {
                }
                field(colInternalStatus; Rec."COL Internal Status")
                {
                }
                field(colReasonCode; Rec."COL Reason Code")
                {
                }
                field(colRemainingOutput; Rec."COL Remaining Output")
                {
                }
                field(colDocNoOccurrence; Rec."COL Doc. No. Occurrence")
                {
                }
                field(jobNoPGS; Rec."Job No. PGS")
                {
                }
                field(taskNoPGS; Rec."Task No. PGS")
                {
                }
                field(jobContractEntryNoPGS; Rec."Job Contract Entry No. PGS")
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
