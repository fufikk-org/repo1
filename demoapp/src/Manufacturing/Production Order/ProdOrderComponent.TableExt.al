namespace Weibel.Manufacturing.Document;

using Microsoft.Manufacturing.Document;
using Weibel.Manufacturing.BlockProduction;
using Microsoft.Warehouse.Structure;

tableextension 70129 "COL Prod. Order Component" extends "Prod. Order Component"
{
    fields
    {
        field(70103; "COL Position"; Code[2048])
        {
            Caption = 'Position (Weibel)';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the position of the component on the bill of material.';
        }
        field(70104; "COL Position 3"; Code[20])
        {
            Caption = 'Position 3 (Weibel)';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the third reference number for the component position on a bill of material, such as the alternate position number of a component on a print card.';
        }
        field(70111; "COL Default Bin Code"; Code[20])
        {
            Caption = 'Default Bin Code';
            Editable = false;
            ToolTip = 'Specifies Default Bin Code from item''s variant.';
            FieldClass = FlowField;
            CalcFormula = lookup("Bin Content"."Bin Code" where("Default" = const(true), "Item No." = field("Item No."), "Variant Code" = field("Variant Code")));
        }
        field(70112; "COL Fixed Bin Code"; Code[20])
        {
            Caption = 'Fixed Bin Code';
            Editable = false;
            ToolTip = 'Specifies Fixed Bin Code from item''s variant.';
            FieldClass = FlowField;
            CalcFormula = lookup("Bin Content"."Bin Code" where("Fixed" = const(true), "Item No." = field("Item No."), "Variant Code" = field("Variant Code")));
        }
        modify("Item No.")
        {
            trigger OnAfterValidate()
            begin
                BlockProductionMgt.VerifyProductionOrderComponentLine(Rec);
            end;
        }
        modify("Variant Code")
        {
            trigger OnAfterValidate()
            begin
                BlockProductionMgt.VerifyProductionOrderComponentLine(Rec);
            end;
        }
    }


    var
        BlockProductionMgt: Codeunit "COL Block Production Mgt.";
}
