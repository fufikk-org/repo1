namespace Weibel.Service.Document;

using Weibel.Inventory.Item;
using Microsoft.Service.History;

tableextension 70135 "COL Service Invoice Line" extends "Service Invoice Line"
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
