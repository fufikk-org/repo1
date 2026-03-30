namespace Weibel.Inventory.Item;

using Microsoft.Inventory.Item;
using Microsoft.Foundation.NoSeries;
table 70116 "COL Item Variant PLC Chng. Log"
{
    DataClassification = CustomerContent;
    Caption = 'Item Variant PLC Change Log';

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
        field(3; "Entry No."; Integer)
        {
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the entry number.';
        }
        field(4; "Old PLC"; Enum "COL Product Life Cycle")
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the old product life cycle.';
        }
        field(5; "New PLC"; Enum "COL Product Life Cycle")
        {
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the new product life cycle.';
        }
        field(6; "Changed By"; Code[50])
        {
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the user who changed the product life cycle.';
        }
        field(7; "Date Changed"; DateTime)
        {
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the date and time when the product life cycle was changed.';
        }
    }

    keys
    {
        key(PK; "Item No.", "Variant Code", "Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        SequenceNoMgt: Codeunit "Sequence No. Mgt.";
    begin
        Rec."Entry No." := SequenceNoMgt.GetNextSeqNo(Database::"COL Item Variant PLC Chng. Log");
    end;
}