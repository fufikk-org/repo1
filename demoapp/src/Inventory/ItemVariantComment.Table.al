namespace Weibel.Inventory.Item;

using Microsoft.Inventory.Item;

table 70147 "COL Item Variant Comment"
{
    DataClassification = CustomerContent;
    Caption = 'Item Variant Comment';

    fields
    {
        field(1; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item No.';
            TableRelation = "Item Variant"."Item No.";
            ToolTip = 'Specifies the item number.';
        }
        field(2; "Variant Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Variant Code';
            TableRelation = "Item Variant"."Code" where("Item No." = field("Item No."));
            ToolTip = 'Specifies the variant code.';
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the line number.';
        }
        field(4; "Date"; Date)
        {
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the date of the comment.';
        }
        field(5; Comment; Text[250])
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the comment text.';
        }
        field(6; "Changed By"; Code[50])
        {
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the user who added the comment.';
        }
        field(7; "Field Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Field Name';
            ToolTip = 'Specifies the name of the field that was changed.';
        }
        field(8; "New Value"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'New Value';
            ToolTip = 'Specifies the new value of the blocking field.';
        }
    }

    keys
    {
        key(PK; "Item No.", "Variant Code", "Line No.")
        {
            Clustered = true;
        }
    }
}
