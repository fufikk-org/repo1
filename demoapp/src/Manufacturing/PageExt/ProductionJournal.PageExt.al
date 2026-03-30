namespace Weibel.Manufacturing.Journal;

using Microsoft.Manufacturing.Journal;

pageextension 70272 "COL Production Journal" extends "Production Journal"
{
    layout
    {

        addafter("Quantity")
        {
            field("COL Qty. Picked"; Rec."COL Qty. Picked")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("COL Remaining Quantity"; Rec."COL Remaining Quantity")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
