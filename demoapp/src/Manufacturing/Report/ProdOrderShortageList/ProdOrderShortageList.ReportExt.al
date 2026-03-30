namespace Weibel.Manufacturing.Reports;

using Microsoft.Manufacturing.Reports;

reportextension 70113 "COL Prod.Order - Shortage List" extends "Prod. Order - Shortage List"
{
    dataset
    {
        add("Production Order")
        {
            column(COLCompItemVariantCodeCaption; VariantCaptionLbl)
            {
            }
            column(COLProdOrderVariantCode; "Variant Code")
            {
            }
            column(COLSourceNo; "Source No.")
            {
            }
        }
        add("Prod. Order Component")
        {
            column(COLCompItemVariantCode; "Variant Code")
            {
            }
        }
    }
    rendering
    {
        layout(COLReportLayout)
        {
            Caption = 'Weibel - Prod. Order - Shortage List';
            Summary = 'Weibel adjusted layout';
            Type = RDLC;
            LayoutFile = './src/Manufacturing/Report/ProdOrderShortageList/COLProdOrderShortageList.rdl';
        }
    }

    var
        VariantCaptionLbl: Label 'Variant';
}