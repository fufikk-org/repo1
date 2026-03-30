namespace Weibel.Manufacturing.Document;

using Microsoft.Manufacturing.Document;
using Weibel.Manufacturing.BlockProduction;
using Microsoft.Inventory.Item;
using Weibel.Inventory.Item;

tableextension 70128 "COL Prod. Order Line" extends "Prod. Order Line"
{
    fields
    {
        field(70111; "COL Product Life Cycle"; enum "COL Product Life Cycle")
        {
            Caption = 'Source Product Life Cycle';
            ToolTip = 'Specifies the Product Life Cycle of the source item variant.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Item Variant"."COL Product Life Cycle" where("Item No." = field("Item No."), "Code" = field("Variant Code")));
        }

        modify("Item No.")
        {
            trigger OnAfterValidate()
            begin
                BlockProductionMgt.VerifyProductionOrderLine(Rec);
            end;
        }
        modify("Variant Code")
        {
            trigger OnAfterValidate()
            begin
                BlockProductionMgt.VerifyProductionOrderLine(Rec);
            end;
        }
    }


    var
        BlockProductionMgt: Codeunit "COL Block Production Mgt.";
}
