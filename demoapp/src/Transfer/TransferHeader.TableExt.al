namespace Weibel.Inventory.Transfer;

using Microsoft.Inventory.Transfer;
using Weibel.Shipping;

tableextension 70115 "COL Transfer Header" extends "Transfer Header"
{
    fields
    {
        field(70100; "COL Shipping Status"; Code[20])
        {
            Caption = 'Shipping Status';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies shipping status of the document.';
            TableRelation = "COL Shipping Status";
        }
    }
}