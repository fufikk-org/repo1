namespace Weibel.Warehouse.Activity;

using Microsoft.Warehouse.Activity;

pageextension 70225 "COL Whse. Pick Subform" extends "Whse. Pick Subform"
{
    layout
    {
        modify("Zone Code")
        {
            Visible = true;
        }
    }
}
