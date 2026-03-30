namespace Weibel.API;

using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Item;
using Weibel.Inventory.Item;
using Weibel.Foundation.Navigate;
using Microsoft.Foundation.Navigate;

page 70186 "COL Prod Order Lines API"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'prodOrderLine';
    EntitySetName = 'prodOrderLines';
    PageType = API;
    SourceTable = "Prod. Order Line";
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
                field(status; Rec.Status)
                {
                    Caption = 'Status', Locked = true;
                }
                field(prodOrderNo; Rec."Prod. Order No.")
                {
                    Caption = 'Prod. Order No.', Locked = true;
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.', Locked = true;
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.', Locked = true;
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code', Locked = true;
                }
                field(plc; plcValue)
                {
                    Caption = 'PLC', Locked = true;
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description', Locked = true;
                }
                field(description2; Rec."Description 2")
                {
                    Caption = 'Description 2', Locked = true;
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
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity', Locked = true;
                }
                field(finishedQuantity; Rec."Finished Quantity")
                {
                    Caption = 'Finished Quantity', Locked = true;
                }
                field(remainingQuantity; Rec."Remaining Quantity")
                {
                    Caption = 'Remaining Quantity', Locked = true;
                }
                field(scrap; Rec."Scrap %")
                {
                    Caption = 'Scrap %', Locked = true;
                }
                field(dueDate; Rec."Due Date")
                {
                    Caption = 'Due Date', Locked = true;
                }
                field(startingDate; Rec."Starting Date")
                {
                    Caption = 'Starting Date', Locked = true;
                }
                field(startingTime; Rec."Starting Time")
                {
                    Caption = 'Starting Time', Locked = true;
                }
                field(endingDate; Rec."Ending Date")
                {
                    Caption = 'Ending Date', Locked = true;
                }
                field(endingTime; Rec."Ending Time")
                {
                    Caption = 'Ending Time', Locked = true;
                }
                field(planningLevelCode; Rec."Planning Level Code")
                {
                    Caption = 'Planning Level Code', Locked = true;
                }
                field(priority; Rec.Priority)
                {
                    Caption = 'Priority', Locked = true;
                }
                field(productionBOMNo; Rec."Production BOM No.")
                {
                    Caption = 'Production BOM No.', Locked = true;
                }
                field(routingNo; Rec."Routing No.")
                {
                    Caption = 'Routing No.', Locked = true;
                }
                field(inventoryPostingGroup; Rec."Inventory Posting Group")
                {
                    Caption = 'Inventory Posting Group', Locked = true;
                }
                field(routingReferenceNo; Rec."Routing Reference No.")
                {
                    Caption = 'Routing Reference No.', Locked = true;
                }
                field(unitCost; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost', Locked = true;
                }
                field(costAmount; Rec."Cost Amount")
                {
                    Caption = 'Cost Amount', Locked = true;
                }
                // field(reservedQuantity; Rec."Reserved Quantity")
                // {
                //     Caption = 'Reserved Quantity', Locked = true;
                // }
                field(qtyRoundingPrecision; Rec."Qty. Rounding Precision")
                {
                    Caption = 'Qty. Rounding Precision', Locked = true;
                }
                field(qtyRoundingPrecisionBase; Rec."Qty. Rounding Precision (Base)")
                {
                    Caption = 'Qty. Rounding Precision (Base)', Locked = true;
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code', Locked = true;
                }
                field(quantityBase; Rec."Quantity (Base)")
                {
                    Caption = 'Quantity (Base)', Locked = true;
                }
                field(finishedQtyBase; Rec."Finished Qty. (Base)")
                {
                    Caption = 'Finished Qty. (Base)', Locked = true;
                }
                field(remainingQtyBase; Rec."Remaining Qty. (Base)")
                {
                    Caption = 'Remaining Qty. (Base)', Locked = true;
                }
                // field(reservedQtyBase; Rec."Reserved Qty. (Base)")
                // {
                //     Caption = 'Reserved Qty. (Base)', Locked = true;
                // }
                // field(expectedOperationCostAmt; Rec."Expected Operation Cost Amt.")
                // {
                //     Caption = 'Expected Operation Cost Amt.', Locked = true;
                // }
                // field(totalExpOperOutputQty; Rec."Total Exp. Oper. Output (Qty.)")
                // {
                //     Caption = 'Total Exp. Oper. Output (Qty.)', Locked = true;
                // }
                // field(expectedComponentCostAmt; Rec."Expected Component Cost Amt.")
                // {
                //     Caption = 'Expected Component Cost Amt.', Locked = true;
                // }
                field(startingDateTime; Rec."Starting Date-Time")
                {
                    Caption = 'Starting Date-Time', Locked = true;
                }
                field(endingDateTime; Rec."Ending Date-Time")
                {
                    Caption = 'Ending Date-Time', Locked = true;
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                    Caption = 'Dimension Set ID', Locked = true;
                }
                field(costAmountACY; Rec."Cost Amount (ACY)")
                {
                    Caption = 'Cost Amount (ACY)', Locked = true;
                }
                field(unitCostACY; Rec."Unit Cost (ACY)")
                {
                    Caption = 'Unit Cost (ACY)', Locked = true;
                }
                field(productionBOMVersionCode; Rec."Production BOM Version Code")
                {
                    Caption = 'Production BOM Version Code', Locked = true;
                }
                field(routingVersionCode; Rec."Routing Version Code")
                {
                    Caption = 'Routing Version Code', Locked = true;
                }
                field(routingType; Rec."Routing Type")
                {
                    Caption = 'Routing Type', Locked = true;
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                    Caption = 'Qty. per Unit of Measure', Locked = true;
                }
                field(mpsOrder; Rec."MPS Order")
                {
                    Caption = 'MPS Order', Locked = true;
                }
                field(planningFlexibility; Rec."Planning Flexibility")
                {
                    Caption = 'Planning Flexibility', Locked = true;
                }
                field(indirectCost; Rec."Indirect Cost %")
                {
                    Caption = 'Indirect Cost %', Locked = true;
                }
                field(overheadRate; Rec."Overhead Rate")
                {
                    Caption = 'Overhead Rate', Locked = true;
                }
                field(systemCreatedAt; Rec."SystemCreatedAt") { }

                field(systemCreatedBy; Rec."SystemCreatedBy") { }

                field(systemModifiedAt; Rec."SystemModifiedAt") { }

                field(systemModifiedBy; Rec."SystemModifiedBy") { }

                part("COL_OrderTrackings"; "COL Order Tracking Entry")
                {
                    ApplicationArea = All;
                    Caption = 'OrderTrackings';
                    EntityName = 'colOrderTracking';
                    EntitySetName = 'colOrderTrackings';
                    Editable = false;
                    SubPageLink = "COL Source Line Id" = field(SystemId);
                }
            }
        }
    }

    var
        plcValue: Text;

    trigger OnAfterGetRecord()
    var
        ItemVariant: Record "Item Variant";
    begin
        plcValue := Format(ItemVariant."COL Product Life Cycle"::"Not Relevant");
        if ItemVariant.Get(Rec."Item No.", Rec."Variant Code") then
            plcValue := Format(ItemVariant."COL Product Life Cycle");


    end;
}
