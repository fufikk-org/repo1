namespace Weibel.Manufacturing.ProductionBOM;

using Microsoft.Manufacturing.ProductionBOM;
using Weibel.Manufacturing.BlockProduction;

page 70136 "COL Prod. BOM Line FactBox"
{
    PageType = CardPart;
    SourceTable = "Production BOM Line";
    Caption = 'BOM Line Details';
    ApplicationArea = All;
    Editable = false;

    layout
    {
        area(content)
        {
            group(LineDetails)
            {
                Caption = 'Line Details';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the variant code of the item.';
                }
                field(isProductionBlocked; BlockProductionMgt.IsProductionBOMLineBlocked(Rec))
                {
                    Caption = 'Production Blocked';
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the Production BOM line is contains a blocked item or variant.';
                }
            }
            group(ItemVariantDetails)
            {
                Caption = 'Prod. Blocked Details';
                field(isItemProductionBlocked; BlockProductionMgt.IsItemProductionBlocked(Rec))
                {
                    Caption = 'Item Production Blocked';
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the item variant is blocked for production.';
                }
                field(isItemVariantProductionBlocked; BlockProductionMgt.IsItemVariantProductionBlocked(Rec))
                {
                    Caption = 'Variant Production Blocked';
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the item variant is blocked for production.';
                }
                field(isBOMProductionBlocked; BlockProductionMgt.IsBOMProductionBlocked(Rec))
                {
                    Caption = 'BOM Production Blocked';
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the Production BOM line is blocked for production.';
                }
            }
        }
    }

    var
        BlockProductionMgt: Codeunit "COL Block Production Mgt.";
}