namespace Weibel.Inventory.Transfer;

using Microsoft.Inventory.Transfer;
using Weibel.Shipping;

tableextension 70116 "COL Transfer Shipment Header" extends "Transfer Shipment Header"
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