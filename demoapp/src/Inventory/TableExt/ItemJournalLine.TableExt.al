namespace Weibel.Inventory.Journal;

using Microsoft.Inventory.Journal;
using Weibel.Inventory.Item;
using Weibel.Kardex;
using Microsoft.Manufacturing.Document;

tableextension 70142 "COL Item Journal Line" extends "Item Journal Line"
{
    fields
    {
        field(70100; "COL Export Classification Code"; Enum "COL Item Export Classification")
        {
            Caption = 'Export Classification Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies export classification.';
        }
        field(70101; "COL Kardex Log No."; Integer)
        {
            Caption = 'Kardex Log No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies Kardex Log No.';
        }
        field(70102; "COL Kardex Quantity"; Decimal)
        {
            Caption = 'Kardex Quantity';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies Kardex Quantity';
        }
        field(70103; "COL Logia User ID"; Code[50])
        {
            Caption = 'Logia User ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies Logia User ID';
        }
        field(70104; "COL Kardex Quantity To Confirm"; Decimal)
        {
            Caption = 'Kardex Quantity To Confirm';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies Kardex Quantity';
        }
        field(70105; "COL Qty. Picked"; Decimal)
        {
            Caption = 'Qty. Picked';
            ToolTip = 'Specifies Quantity Picked on Production Order Component.';
            FieldClass = FlowField;
            DecimalPlaces = 0 : 5;
            CalcFormula = Sum("Prod. Order Component"."Qty. Picked" where("Status" = const(Released), "Prod. Order No." = field("Order No."), "Prod. Order Line No." = field("Order Line No."), "Line No." = field("Prod. Order Comp. Line No.")));
        }
        field(70106; "COL Remaining Quantity"; Decimal)
        {
            Caption = 'Remaining Quantity';
            ToolTip = 'Specifies Remaining Quantity on Production Order Component.';
            FieldClass = FlowField;
            DecimalPlaces = 0 : 5;
            CalcFormula = Sum("Prod. Order Component"."Remaining Quantity" where("Status" = const(Released), "Prod. Order No." = field("Order No."), "Prod. Order Line No." = field("Order Line No."), "Line No." = field("Prod. Order Comp. Line No.")));
        }

        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                "COL Kardex Quantity To Confirm" := Quantity;
            end;
        }

        modify("Quantity (Base)")
        {
            trigger OnAfterValidate()
            begin
                "COL Kardex Quantity To Confirm" := "Quantity"; // must be aligned with Quantity field
            end;
        }
    }

    trigger OnBeforeDelete()
    var
        KardexMgt: Codeunit "COL Kardex Mgt.";
    begin
        KardexMgt.DeleteJrnLineCheck(Rec);
    end;
}
