namespace Weibel.Inventory.Ledger;

using Microsoft.Inventory.Ledger;
using Weibel.Inventory.Item;

tableextension 70141 "COL Item Ledger Entry" extends "Item Ledger Entry"
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
