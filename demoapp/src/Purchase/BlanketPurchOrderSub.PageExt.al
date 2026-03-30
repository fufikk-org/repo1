namespace Weibel.Purchase.Document;

using Microsoft.Purchases.Document;

pageextension 70102 "COL Blanket Purch.Order Sub." extends "Blanket Purchase Order Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("COL Outstanding Qty. (Base)"; OutQtyBase)
            {
                ApplicationArea = All;
                Editable = false;
                DecimalPlaces = 0 : 5;
                Caption = 'Outstanding Qty. (Base)';
                ToolTip = 'Specifies the outstanding quantity expressed in based unit of measure of the blanket purchase order line.';
            }
            field("COL Outstanding Quantity"; OutQty)
            {
                ApplicationArea = All;
                Editable = false;
                DecimalPlaces = 0 : 5;
                Caption = 'Outstanding Quantity';
                ToolTip = 'Specifies the outstanding quantity of the blanket purchase order line.';
            }
            field("COL Purchaser Code"; Rec."COL Purchaser Code")
            {
                Visible = false;
                Editable = false;
                ApplicationArea = All;
            }
        }
    }

    var
        OutQtyBase: Decimal;
        OutQty: Decimal;

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("COLG Out. Qty. on Lines", "COLG Out. Qty. on Lines (Base)");
        OutQty := Rec.Quantity - Rec."COLG Out. Qty. on Lines";
        OutQtyBase := Rec."Quantity (Base)" - Rec."COLG Out. Qty. on Lines (Base)";
    end;
}