namespace Weibel.Manufacturing.ProductionBOM;

using Microsoft.Manufacturing.ProductionBOM;

tableextension 70157 "COL Where-Used Line" extends "Where-Used Line"
{
    fields
    {
        field(70100; "COL No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the number of the item that the base item or production BOM is assigned to.';
        }
        field(70101; "COL Type"; enum "Production BOM Line Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the type of the item that the base item or production BOM is assigned to.';
        }
    }
}
