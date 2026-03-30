namespace Weibel.API;

using Microsoft.Manufacturing.WorkCenter;

page 70184 "COL Work Centers"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'workCenter';
    EntitySetName = 'workCenters';
    PageType = API;
    SourceTable = "Work Center";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                }
                field(name; Rec.Name)
                {
                }
                field(searchName; Rec."Search Name")
                {
                }
                field(name2; Rec."Name 2")
                {
                }
                field(address; Rec.Address)
                {
                }
                field(address2; Rec."Address 2")
                {
                }
                field(city; Rec.City)
                {
                }
                field(postCode; Rec."Post Code")
                {
                }
                field(alternateWorkCenter; Rec."Alternate Work Center")
                {
                }
                field(workCenterGroupCode; Rec."Work Center Group Code")
                {
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                }
                field(subcontractorNo; Rec."Subcontractor No.")
                {
                }
                field(directUnitCost; Rec."Direct Unit Cost")
                {
                }
                field(indirectCost; Rec."Indirect Cost %")
                {
                }
                field(unitCost; Rec."Unit Cost")
                {
                }
                field(queueTime; Rec."Queue Time")
                {
                }
                field(queueTimeUnitOfMeasCode; Rec."Queue Time Unit of Meas. Code")
                {
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                }
                field(comment; Rec.Comment)
                {
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                }
                field(capacity; Rec.Capacity)
                {
                }
                field(efficiency; Rec.Efficiency)
                {
                }
                field(maximumEfficiency; Rec."Maximum Efficiency")
                {
                }
                field(minimumEfficiency; Rec."Minimum Efficiency")
                {
                }
                field(calendarRoundingPrecision; Rec."Calendar Rounding Precision")
                {
                }
                field(simulationType; Rec."Simulation Type")
                {
                }
                field(shopCalendarCode; Rec."Shop Calendar Code")
                {
                }
                field(blocked; Rec.Blocked)
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
                field(prodOrderNeedAmount; Rec."Prod. Order Need Amount")
                {
                }
                field(unitCostCalculation; Rec."Unit Cost Calculation")
                {
                }
                field(specificUnitCost; Rec."Specific Unit Cost")
                {
                }
                field(consolidatedCalendar; Rec."Consolidated Calendar")
                {
                }
                field(flushingMethod; Rec."Flushing Method")
                {
                }
                field(noSeries; Rec."No. Series")
                {
                }
                field(overheadRate; Rec."Overhead Rate")
                {
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                }
                field(county; Rec.County)
                {
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                }
                field(locationCode; Rec."Location Code")
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
            }
        }
    }
}
