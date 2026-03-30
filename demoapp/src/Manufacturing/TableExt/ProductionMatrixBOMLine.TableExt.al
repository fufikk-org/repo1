namespace Weibel.Manufacturing.ProductionBOM;

using Microsoft.Manufacturing.ProductionBOM;

tableextension 70171 "COL Production Matrix BOM Line" extends "Production Matrix BOM Line"
{
    fields
    {
        field(70100; "COL Exploded Quantity 1"; Decimal)
        {
            Caption = 'Exploded Quantity';
            ToolTip = 'Specifies the exploded quantity for SKU 1.';
            DataClassification = CustomerContent;
        }
        field(70101; "COL Exploded Quantity 2"; Decimal)
        {
            Caption = 'Exploded Quantity';
            ToolTip = 'Specifies the exploded quantity for SKU 2.';
            DataClassification = CustomerContent;
        }
        field(70102; "COL Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            ToolTip = 'Specifies the unit cost of the item.';
            DataClassification = CustomerContent;
        }
        field(70103; "COL Cost Share 1"; Decimal)
        {
            Caption = 'Cost Share';
            ToolTip = 'Specifies the cost share for SKU 1.';
            DataClassification = CustomerContent;
        }
        field(70104; "COL Cost Share 2"; Decimal)
        {
            Caption = 'Cost Share';
            ToolTip = 'Specifies the cost share for SKU 2.';
            DataClassification = CustomerContent;
        }
        field(70105; "COL Difference Cost"; Decimal)
        {
            Caption = 'Difference Cost';
            ToolTip = 'Specifies the difference in cost between SKU 1 and SKU 2.';
            DataClassification = CustomerContent;
        }
    }
}
