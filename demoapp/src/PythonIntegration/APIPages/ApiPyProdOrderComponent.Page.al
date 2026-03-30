namespace Weibel.Integration.Python;

using Microsoft.Manufacturing.Document;

page 70106 "COL API Py ProdOrderComponent"
{
    APIGroup = 'pythonData';
    APIPublisher = 'weibel';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Editable = false;
    DataAccessIntent = ReadOnly;
    EntityName = 'prodOrderComponent';
    EntitySetName = 'prodOrderComponents';
    PageType = API;
    SourceTable = "Prod. Order Component";
    ODataKeyFields = SystemId;

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
                field(status; Rec.Status)
                {
                    Caption = 'Status', Locked = true;
                }
                field(prodOrderNo; Rec."Prod. Order No.")
                {
                    Caption = 'Prod. Order No.', Locked = true;
                }
                field(prodOrderLineNo; Rec."Prod. Order Line No.")
                {
                    Caption = 'Prod. Order Line No.', Locked = true;
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.', Locked = true;
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.', Locked = true;
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description', Locked = true;
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code', Locked = true;
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity', Locked = true;
                }
                field(position; Rec.Position)
                {
                    Caption = 'Position', Locked = true;
                }
                field(position2; Rec."Position 2")
                {
                    Caption = 'Position 2', Locked = true;
                }
                field(position3; Rec."Position 3")
                {
                    Caption = 'Position 3', Locked = true;
                }
                field(leadTimeOffset; Rec."Lead-Time Offset")
                {
                    Caption = 'Lead-Time Offset', Locked = true;
                }
                field(routingLinkCode; Rec."Routing Link Code")
                {
                    Caption = 'Routing Link Code', Locked = true;
                }
                field(scrap; Rec."Scrap %")
                {
                    Caption = 'Scrap %', Locked = true;
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code', Locked = true;
                }
                field(qtyRoundingPrecision; Rec."Qty. Rounding Precision")
                {
                    Caption = 'Qty. Rounding Precision', Locked = true;
                }
                field(qtyRoundingPrecisionBase; Rec."Qty. Rounding Precision (Base)")
                {
                    Caption = 'Qty. Rounding Precision (Base)', Locked = true;
                }
                field(expectedQuantity; Rec."Expected Quantity")
                {
                    Caption = 'Expected Quantity', Locked = true;
                }
                field(remainingQuantity; Rec."Remaining Quantity")
                {
                    Caption = 'Remaining Quantity', Locked = true;
                }
                // field(actConsumptionQty; Rec."Act. Consumption (Qty)")
                // {
                //     Caption = 'Act. Consumption (Qty)', Locked = true;
                // }
                field(flushingMethod; Rec."Flushing Method")
                {
                    Caption = 'Flushing Method', Locked = true;
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code', Locked = true;
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code', Locked = true;
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code', Locked = true;
                }
                field(binCode; Rec."Bin Code")
                {
                    Caption = 'Bin Code', Locked = true;
                }
                field(suppliedByLineNo; Rec."Supplied-by Line No.")
                {
                    Caption = 'Supplied-by Line No.', Locked = true;
                }
                field(planningLevelCode; Rec."Planning Level Code")
                {
                    Caption = 'Planning Level Code', Locked = true;
                }
                field(itemLowLevelCode; Rec."Item Low-Level Code")
                {
                    Caption = 'Item Low-Level Code', Locked = true;
                }
                field(length; Rec.Length)
                {
                    Caption = 'Length', Locked = true;
                }
                field(width; Rec.Width)
                {
                    Caption = 'Width', Locked = true;
                }
                field(weight; Rec.Weight)
                {
                    Caption = 'Weight', Locked = true;
                }
                field(depth; Rec.Depth)
                {
                    Caption = 'Depth', Locked = true;
                }
                field(calculationFormula; Rec."Calculation Formula")
                {
                    Caption = 'Calculation Formula', Locked = true;
                }
                field(quantityPer; Rec."Quantity per")
                {
                    Caption = 'Quantity per', Locked = true;
                }
                field(unitCost; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost', Locked = true;
                }
                field(costAmount; Rec."Cost Amount")
                {
                    Caption = 'Cost Amount', Locked = true;
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date', Locked = true;
                }
                field(dueTime; Rec."Due Time")
                {
                    Caption = 'Due Time', Locked = true;
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                    Caption = 'Qty. per Unit of Measure', Locked = true;
                }
                field(remainingQtyBase; Rec."Remaining Qty. (Base)")
                {
                    Caption = 'Remaining Qty. (Base)', Locked = true;
                }
                field(quantityBase; Rec."Quantity (Base)")
                {
                    Caption = 'Quantity (Base)', Locked = true;
                }
                // field(reservedQtyBase; Rec."Reserved Qty. (Base)")
                // {
                //     Caption = 'Reserved Qty. (Base)', Locked = true;
                // }
                // field(reservedQuantity; Rec."Reserved Quantity")
                // {
                //     Caption = 'Reserved Quantity', Locked = true;
                // }
                field(expectedQtyBase; Rec."Expected Qty. (Base)")
                {
                    Caption = 'Expected Qty. (Base)', Locked = true;
                }
                field(dueDateTime; Rec."Due Date-Time")
                {
                    Caption = 'Due Date-Time', Locked = true;
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID', Locked = true;
                }
                // field(substitutionAvailable; Rec."Substitution Available")
                // {
                //     Caption = 'Substitution Available', Locked = true;
                // }
                field(originalItemNo; Rec."Original Item No.")
                {
                    Caption = 'Original Item No.', Locked = true;
                }
                field(originalVariantCode; Rec."Original Variant Code")
                {
                    Caption = 'Original Variant Code', Locked = true;
                }
                // field(pickQty; Rec."Pick Qty.")
                // {
                //     Caption = 'Pick Qty.', Locked = true;
                // }
                field(qtyPicked; Rec."Qty. Picked")
                {
                    Caption = 'Qty. Picked', Locked = true;
                }
                field(qtyPickedBase; Rec."Qty. Picked (Base)")
                {
                    Caption = 'Qty. Picked (Base)', Locked = true;
                }
                field(completelyPicked; Rec."Completely Picked")
                {
                    Caption = 'Completely Picked', Locked = true;
                }
                // field(pickQtyBase; Rec."Pick Qty. (Base)")
                // {
                //     Caption = 'Pick Qty. (Base)', Locked = true;
                // }
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
                field(directCostAmount; Rec."Direct Cost Amount")
                {
                    Caption = 'Direct Cost Amount', Locked = true;
                }
                field(overheadAmount; Rec."Overhead Amount")
                {
                    Caption = 'Overhead Amount', Locked = true;
                }
            }
        }
    }
}
