namespace Weibel.Kardex;

table 70136 "COL Kardex Msg. Line"
{
    Caption = 'Kardex Msg. Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            ToolTip = 'Specifies the value of the Entry No. field.';
            TableRelation = "COL Kardex Msg. Header"."Entry No.";
        }
        field(2; "Related Log Line"; Integer)
        {
            Caption = 'Related Log Line';
            ToolTip = 'Specifies the value of the Related Log Line field.';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            ToolTip = 'Specifies the value of the Line No. field.';
        }
        field(4; "Item ID"; Code[50])
        {
            Caption = 'Item ID';
            ToolTip = 'Specifies the value of the Item ID field.';
        }
        field(5; "Item Text"; Text[40])
        {
            Caption = 'Item Text';
            ToolTip = 'Specifies the value of the Item Text field.';
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
            ToolTip = 'Specifies the value of the Quantity field.';
        }
        field(7; "Serial Number Mode"; Code[10])
        {
            Caption = 'Serial Number Mode';
            ToolTip = 'Specifies the value of the Serial Number Mode field.';
        }
        field(8; "Serial Number"; Code[50])
        {
            Caption = 'Serial Number';
            ToolTip = 'Specifies the value of the Serial Number field.';
        }
        field(9; "Position Number"; Code[50])
        {
            Caption = 'Position Number';
            ToolTip = 'Specifies the value of the Position Number field.';
        }
        field(10; "Jrn. Line No."; Integer)
        {
            Caption = 'Related Line No.';
            ToolTip = 'Specifies the value of the Line No. field.';
        }
        field(11; "User Id"; Text[50])
        {
            Caption = 'User Id';
            ToolTip = 'Specifies the value of the User Id field.';
        }
        field(12; "New Quantity"; Decimal)
        {
            Caption = 'New Quantity';
            ToolTip = 'Specifies the value of the New Quantity field.';
        }
        field(13; "Item Variant"; Code[20])
        {
            Caption = 'Item Variant';
            ToolTip = 'Specifies the value of the Item Variant field.';
        }
    }
    keys
    {
        key(PK; "Entry No.", "Related Log Line", "Line No.")
        {
            Clustered = true;
        }
    }
}
