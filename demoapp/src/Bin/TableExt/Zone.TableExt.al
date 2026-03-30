namespace Weibel.Warehouse.Structure;

using Microsoft.Warehouse.Structure;

tableextension 70173 "COL Zone" extends Zone
{
    fields
    {
        field(70100; "COL Exclude Zone From Fil."; Boolean)
        {
            Caption = 'Exclude Zone From Pick Filtering';
            ToolTip = 'Specifies whether to exclude the zone from pick filtering.';
            DataClassification = CustomerContent;
        }
    }
}
