namespace Weibel.Inventory.Item;

using Microsoft.Inventory.Item;
using System.IO;

tableextension 70145 "COL Copy Item Buffer" extends "Copy Item Buffer"
{
    fields
    {
        field(70100; "COL New Process"; Boolean)
        {
            Caption = 'New Process';
            ToolTip = 'Specifies if the item is part of the new process.';
            DataClassification = CustomerContent;
        }
        field(70101; "COL Item Template Code"; Code[10])
        {
            Caption = 'Item Template Code';
            ToolTip = 'Specifies if the item is a template.';
            DataClassification = CustomerContent;
            TableRelation = "Config. Template Header" where("Table ID" = filter(Database::Item));
        }
        field(70102; "COL Production BOM"; Boolean)
        {
            Caption = 'Production BOM';
            ToolTip = 'Specifies if the item is part of the production BOM.';
            DataClassification = CustomerContent;
        }
        field(70103; "COL Routing"; Boolean)
        {
            Caption = 'Routing';
            ToolTip = 'Specifies if the item is part of the Routing.';
            DataClassification = CustomerContent;
        }
        field(70104; "COL Links"; Boolean)
        {
            Caption = 'Links';
            ToolTip = 'Specifies if the item is part of the Links.';
            DataClassification = CustomerContent;
        }
        field(70105; "COL Notes"; Boolean)
        {
            Caption = 'Notes';
            ToolTip = 'Specifies if the item is part of the Notes.';
            DataClassification = CustomerContent;
        }
        field(70106; "COL Variant Links"; Boolean)
        {
            Caption = 'Variant Links';
            ToolTip = 'Specifies if the links for variants should be copied.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Rec.TestField("Item Variants", true);
            end;
        }
    }
}
