namespace Weibel.Purchases.Setup;

using Microsoft.Purchases.Setup;

pageextension 70201 "COL Purchases Setup" extends "Purchases & Payables Setup"
{
    layout
    {
        addlast(General)
        {
            field("COL Force Default Report"; Rec."COL Force Default Report")
            {
                ApplicationArea = All;
            }
            field("COL Use User Purchaser Code"; Rec."COL Use User Purchaser Code")
            {
                ApplicationArea = All;
            }
            field("COL Keep Vendor Lead Time I/S"; Rec."COL Keep Vendor Lead Time I/S")
            {
                ApplicationArea = All;
            }
            field("COL Skip PO Re-Approval"; Rec."COL Skip PO Re-Approval")
            {
                ApplicationArea = All;
            }
        }
    }
}
