namespace Weibel.Inventory.Ledger;

table 70130 "COL Cable Label Template"
{
    Caption = 'Cable Label Template';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Cable Size"; Enum "COL Cable Size")
        {
            Caption = 'Cable Size';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the cable size for the label template.';
            NotBlank = true;
            BlankZero = true;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the line number for the instruction.';
            NotBlank = true;
            BlankZero = true;
        }
        field(3; Instruction; Text[100])
        {
            Caption = 'Instruction';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the instruction text for the label.';
        }
        field(4; Condition; Enum "COL Cable Label Condition")
        {
            Caption = 'Condition';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the condition when this instruction should be applied.';
        }
        field(5; LeftOffset; Integer)
        {
            Caption = 'Left Offset';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the offset value.';
            BlankZero = true;
        }
        field(6; "Space Size"; Decimal)
        {
            Caption = 'Space Size';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the space size value.';
            BlankZero = true;
        }
        field(7; RightOffset; Integer)
        {
            Caption = 'Right Offset';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the offset value.';
            BlankZero = true;
        }
    }

    keys
    {
        key(PK; "Cable Size", "Line No.")
        {
            Clustered = true;
        }
    }
}
