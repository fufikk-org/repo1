namespace Weibel.Service.Document;

using Weibel.Inventory.Item;
using Microsoft.Service.History;

tableextension 70136 "COL Service Shipment Item Line" extends "Service Shipment Item Line"
{
    fields
    {
        field(70100; "COL Export Classification Code"; Enum "COL Item Export Classification")
        {
            Caption = 'Export Classification Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies export classification.';
        }
    }
}
