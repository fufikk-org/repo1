namespace Weibel.Sales.History;

using Microsoft.Sales.History;
using Weibel.Inventory.Item;

tableextension 70139 "COL Sales Invoice Line" extends "Sales Invoice Line"
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
