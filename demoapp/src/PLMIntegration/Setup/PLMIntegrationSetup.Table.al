namespace Weibel.Integration.PLM;
using Microsoft.Inventory.Item;

table 70101 "COL PLM Integration Setup"
{
    Caption = 'PLM Integration Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
        }
        field(2; "PLM Item Template Code"; Code[20])
        {
            Caption = 'PLM Item Template Code';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies item template that is used when items are created through PLM integration.';
            TableRelation = "Item Templ.";
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
