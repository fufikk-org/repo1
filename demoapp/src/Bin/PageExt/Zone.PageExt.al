namespace Weibel.Warehouse.Structure;

using Microsoft.Warehouse.Structure;

pageextension 70261 "COL Zone" extends Zones
{
    layout
    {
        addbefore(Description)
        {
            field("COL Exclude Zone From Fil."; Rec."COL Exclude Zone From Fil.")
            {
                ApplicationArea = All;
            }
        }
    }
}
