namespace Weibel.Service.Document;

using Microsoft.Service.Ledger;
using Weibel.Inventory.Item;

tableextension 70137 "COL Service Ledger Entries" extends "Service Ledger Entry"
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
