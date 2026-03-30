namespace Weibel.Manufacturing.ProductionBOM;

using Microsoft.Manufacturing.ProductionBOM;
using Weibel.Inventory.Item;

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
        field(70102; "COL Related SKU Item No."; Code[20])
        {
            Caption = 'Related SKU Item No.';
            ToolTip = 'Specifies the item number of the related stockkeeping unit.';
            DataClassification = CustomerContent;
        }
        field(70103; "COL Related SKU Variant Code"; Code[10])
        {
            Caption = 'Related SKU Variant Code';
            ToolTip = 'Specifies the variant code of the related stockkeeping unit.';
            DataClassification = CustomerContent;
        }
        field(70104; "COL Related SKU Location Code"; Code[10])
        {
            Caption = 'Related SKU Location Code';
            ToolTip = 'Specifies the location code of the related stockkeeping unit.';
            DataClassification = CustomerContent;
        }
        field(70105; "COL Product Life Cycle"; Enum "COL Product Life Cycle")
        {
            Caption = 'Product Life Cycle';
            ToolTip = 'Specifies the product life cycle from the item variant.';
            DataClassification = CustomerContent;
        }
    }
}
