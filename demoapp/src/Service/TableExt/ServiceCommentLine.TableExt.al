namespace Weibel.Service.Comment;

using Microsoft.Service.Comment;

tableextension 70150 "COL Service Comment Line" extends "Service Comment Line"
{
    fields
    {
        field(70100; "COL Quote"; Boolean)
        {
            Caption = 'Quote';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies if the comment should be printed on Quote document.';
        }
        field(70101; "COL Order"; Boolean)
        {
            Caption = 'Order';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies if the comment should be printed on Order document.';
        }
        field(70102; "COL Shipment"; Boolean)
        {
            Caption = 'Shipment';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies if the comment should be printed on Shipment document.';
        }
        field(70103; "COL Invoice"; Boolean)
        {
            Caption = 'Invoice';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies if the comment should be printed on Invoice document.';
        }
    }
}
