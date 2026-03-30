namespace Weibel.API;

using Microsoft.Manufacturing.Capacity;

page 70154 "COL Capacity Ledger Entries"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'capacityLedgerEntry';
    EntitySetName = 'capacityLedgerEntries';
    PageType = API;
    SourceTable = "Capacity Ledger Entry";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(entryNo; Rec."Entry No.")
                {
                }
                field(no; Rec."No.")
                {
                }
                field(postingDate; Rec."Posting Date")
                {
                }
                field(type; Rec."Type")
                {
                }
                field(documentNo; Rec."Document No.")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(operationNo; Rec."Operation No.")
                {
                }
                field(workCenterNo; Rec."Work Center No.")
                {
                }
                field(quantity; Rec.Quantity)
                {
                }
                field(setupTime; Rec."Setup Time")
                {
                }
                field(runTime; Rec."Run Time")
                {
                }
                field(stopTime; Rec."Stop Time")
                {
                }
                field(invoicedQuantity; Rec."Invoiced Quantity")
                {
                }
                field(outputQuantity; Rec."Output Quantity")
                {
                }
                field(scrapQuantity; Rec."Scrap Quantity")
                {
                }
                field(concurrentCapacity; Rec."Concurrent Capacity")
                {
                }
                field(capUnitOfMeasureCode; Rec."Cap. Unit of Measure Code")
                {
                }
                field(qtyPerCapUnitOfMeasure; Rec."Qty. per Cap. Unit of Measure")
                {
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                }
                field(lastOutputLine; Rec."Last Output Line")
                {
                }
                field(completelyInvoiced; Rec."Completely Invoiced")
                {
                }
                field(startingTime; Rec."Starting Time")
                {
                }
                field(endingTime; Rec."Ending Time")
                {
                }
                field(routingNo; Rec."Routing No.")
                {
                }
                field(routingReferenceNo; Rec."Routing Reference No.")
                {
                }
                field(itemNo; Rec."Item No.")
                {
                }
                field(variantCode; Rec."Variant Code")
                {
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                }
                field(documentDate; Rec."Document Date")
                {
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                }
                field(stopCode; Rec."Stop Code")
                {
                }
                field(scrapCode; Rec."Scrap Code")
                {
                }
                field(workCenterGroupCode; Rec."Work Center Group Code")
                {
                }
                field(workShiftCode; Rec."Work Shift Code")
                {
                }
                field(directCost; Rec."Direct Cost")
                {
                }
                field(overheadCost; Rec."Overhead Cost")
                {
                }
                field(directCostACY; Rec."Direct Cost (ACY)")
                {
                }
                field(overheadCostACY; Rec."Overhead Cost (ACY)")
                {
                }
                field(subcontracting; Rec.Subcontracting)
                {
                }
                field(orderType; Rec."Order Type")
                {
                }
                field(orderNo; Rec."Order No.")
                {
                }
                field(orderLineNo; Rec."Order Line No.")
                {
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                }
                field(shortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                {
                }
                field(shortcutDimension4Code; Rec."Shortcut Dimension 4 Code")
                {
                }
                field(shortcutDimension5Code; Rec."Shortcut Dimension 5 Code")
                {
                }
                field(shortcutDimension6Code; Rec."Shortcut Dimension 6 Code")
                {
                }
                field(shortcutDimension7Code; Rec."Shortcut Dimension 7 Code")
                {
                }
                field(shortcutDimension8Code; Rec."Shortcut Dimension 8 Code")
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
