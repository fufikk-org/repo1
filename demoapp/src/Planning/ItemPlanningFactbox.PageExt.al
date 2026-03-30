namespace Weibel.Inventory.Planning;

using Microsoft.Inventory.Item;

pageextension 70106 "COL Item Planning Factbox" extends "Item Planning FactBox"
{
    layout
    {
        addafter("Reorder Quantity")
        {
            field("COL Qty. in Planning"; Rec.COLGetQtyInPlanningWorksheet())
            {
                ApplicationArea = All;
                Caption = 'Qty. in Planning';
                ToolTip = 'Specifies the quantity of an item in planning worksheet lines.';
                DecimalPlaces = 0 : 5;
                Editable = false;

                trigger OnDrillDown()
                begin
                    Rec.COLDrillDownQtyInPlanningWorksheet();
                end;
            }
        }
    }
}
