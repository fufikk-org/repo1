namespace Weibel.Inventory.Planning;

using Microsoft.Inventory.Planning;

tableextension 70147 "COL Planning Component" extends "Planning Component"
{
    fields
    {
        field(70148; "COL Position"; Code[2048])
        {
            Caption = 'Position (Weibel)';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the position of the component on the bill of material.';
        }
        field(70149; "COL Position 3"; Code[20])
        {
            Caption = 'Position 3 (Weibel)';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the third reference number for the component position on a bill of material, such as the alternate position number of a component on a print card.';
        }
    }
}