namespace Weibel.Purchases.Setup;

using Microsoft.Purchases.Setup;

tableextension 70149 "COL Purchases Setup" extends "Purchases & Payables Setup"
{
    fields
    {
        field(70100; "COL Force Default Report"; Boolean)
        {
            Caption = 'Force Default Report';
            ToolTip = 'The default report ID to use for purchase documents.';
            DataClassification = CustomerContent;
        }
        field(70101; "COL Use User Purchaser Code"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Use User Purchaser Code';
            ToolTip = 'Specifies if the user''s purchaser code should be used for purchase orders, instead of the one from the vendor card.';
        }
        field(70102; "COL Keep Vendor Lead Time I/S"; Boolean)
        {
            Caption = 'Keep Vendor Lead Time Item/SKU';
            ToolTip = 'Specifies whether to keep the vendor lead time when updating items and stockkeeping units.';
            DataClassification = CustomerContent;
        }
        field(70103; "COL Skip PO Re-Approval"; Boolean)
        {
            Caption = 'Skip Re-Approval of Purchase Orders';
            ToolTip = 'Specifies whether purchase orders can skip re-approval when they are modified.';
            DataClassification = CustomerContent;
        }
    }
}
