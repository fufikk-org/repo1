namespace Weibel.Inventory.Availability;

using Microsoft.Inventory.Availability;

enumextension 70105 "COL Item Availability Type" extends "Item Availability Type"
{
    value(70100; "COL Empty")
    {
        Caption = '', Locked = true;
    }
}