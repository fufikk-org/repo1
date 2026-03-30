namespace Weibel.Manufacturing.Archive;

using Microsoft.Manufacturing.Document;
using Microsoft.Foundation.Enums;
using Microsoft.Inventory.Item.Substitution;
using Microsoft.Manufacturing.Setup;
using Microsoft.Finance.Dimension;

#pragma warning disable AS0099
table 70110 "COL Prod. Order Component Arch"
{
    Caption = 'Prod. Order Component Archive';
    DataCaptionFields = Status, "Prod. Order No.";
    DataClassification = CustomerContent;

    fields
    {
        field(1; Status; Enum "Production Order Status")
        {
            Caption = 'Status';
            ToolTip = 'Specifies the Status';
        }
        field(2; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            ToolTip = 'Specifies the Prod. Order No.';
        }
        field(3; "Prod. Order Line No."; Integer)
        {
            Caption = 'Prod. Order Line No.';
            ToolTip = 'Specifies the Prod. Order Line No.';
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
            ToolTip = 'Specifies the Line No.';
        }
        field(11; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            ToolTip = 'Specifies the Item No.';
        }
        field(12; Description; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the Description';
        }
        field(13; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            ToolTip = 'Specifies the Unit of Measure Code';
        }
        field(14; Quantity; Decimal)
        {
            Caption = 'Quantity';
            ToolTip = 'Specifies the Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(15; Position; Code[10])
        {
            Caption = 'Position';
            ToolTip = 'Specifies the Position';
        }
        field(16; "Position 2"; Code[10])
        {
            Caption = 'Position 2';
            ToolTip = 'Specifies the Position 2';
        }
        field(17; "Position 3"; Code[10])
        {
            Caption = 'Position 3';
            ToolTip = 'Specifies the Position 3';
        }
        field(18; "Lead-Time Offset"; DateFormula)
        {
            Caption = 'Lead-Time Offset';
            ToolTip = 'Specifies the Lead-Time Offset';
        }
        field(19; "Routing Link Code"; Code[10])
        {
            Caption = 'Routing Link Code';
            ToolTip = 'Specifies the Routing Link Code';
        }
        field(20; "Scrap %"; Decimal)
        {
            Caption = 'Scrap %';
            ToolTip = 'Specifies the Scrap %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(21; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            ToolTip = 'Specifies the Variant Code';
        }
        field(22; "Qty. Rounding Precision"; Decimal)
        {
            Caption = 'Qty. Rounding Precision';
            ToolTip = 'Specifies the Qty. Rounding Precision';
            InitValue = 0;
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 1;
            Editable = false;
        }
        field(23; "Qty. Rounding Precision (Base)"; Decimal)
        {
            Caption = 'Qty. Rounding Precision (Base)';
            ToolTip = 'Specifies the Qty. Rounding Precision (Base)';
            InitValue = 0;
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 1;
            Editable = false;
        }
        field(25; "Expected Quantity"; Decimal)
        {
            Caption = 'Expected Quantity';
            ToolTip = 'Specifies the Expected Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(26; "Remaining Quantity"; Decimal)
        {
            Caption = 'Remaining Quantity';
            ToolTip = 'Specifies the Remaining Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(27; "Act. Consumption (Qty)"; Decimal)
        {
            Caption = 'Act. Consumption (Qty)';
            ToolTip = 'Specifies the Act. Consumption (Qty)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(28; "Flushing Method"; Enum "Flushing Method")
        {
            Caption = 'Flushing Method';
            ToolTip = 'Specifies the Flushing Method';
        }
        field(30; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            ToolTip = 'Specifies the Location Code';
        }
        field(31; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            ToolTip = 'Specifies the Shortcut Dimension 1 Code';
        }
        field(32; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            ToolTip = 'Specifies the Shortcut Dimension 2 Code';
        }
        field(33; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            ToolTip = 'Specifies the Bin Code';
        }
        field(35; "Supplied-by Line No."; Integer)
        {
            Caption = 'Supplied-by Line No.';
            ToolTip = 'Specifies the Supplied-by Line No.';
        }
        field(36; "Planning Level Code"; Integer)
        {
            Caption = 'Planning Level Code';
            ToolTip = 'Specifies the Planning Level Code';
            Editable = false;
        }
        field(37; "Item Low-Level Code"; Integer)
        {
            Caption = 'Item Low-Level Code';
            ToolTip = 'Specifies the Item Low-Level Code';
        }
        field(40; Length; Decimal)
        {
            Caption = 'Length';
            ToolTip = 'Specifies the Length';
            DecimalPlaces = 0 : 5;

        }
        field(41; Width; Decimal)
        {
            Caption = 'Width';
            ToolTip = 'Specifies the Width';
            DecimalPlaces = 0 : 5;

        }
        field(42; Weight; Decimal)
        {
            Caption = 'Weight';
            ToolTip = 'Specifies the Weight';
            DecimalPlaces = 0 : 5;

        }
        field(43; Depth; Decimal)
        {
            Caption = 'Depth';
            ToolTip = 'Specifies the Depth';
            DecimalPlaces = 0 : 5;
        }
        field(44; "Calculation Formula"; Enum "Quantity Calculation Formula")
        {
            Caption = 'Calculation Formula';
            ToolTip = 'Specifies the Calculation Formula';
        }
        field(45; "Quantity per"; Decimal)
        {
            Caption = 'Quantity per';
            ToolTip = 'Specifies the Quantity per';
            DecimalPlaces = 0 : 5;

        }
        field(50; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            ToolTip = 'Specifies the Unit Cost';
            DecimalPlaces = 2 : 5;
        }
        field(51; "Cost Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount';
            ToolTip = 'Specifies the Cost Amount';
            Editable = false;
        }
        field(52; "Due Date"; Date)
        {
            Caption = 'Due Date';
            ToolTip = 'Specifies the Due Date';
        }
        field(53; "Due Time"; Time)
        {
            Caption = 'Due Time';
            ToolTip = 'Specifies the Due Time';
        }
        field(60; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            ToolTip = 'Specifies the Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(61; "Remaining Qty. (Base)"; Decimal)
        {
            Caption = 'Remaining Qty. (Base)';
            ToolTip = 'Specifies the Remaining Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(62; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            ToolTip = 'Specifies the Quantity (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(63; "Reserved Qty. (Base)"; Decimal)
        {
            Caption = 'Reserved Qty. (Base)';
            ToolTip = 'Specifies the Reserved Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = true;
        }
        field(71; "Reserved Quantity"; Decimal)
        {
            Caption = 'Reserved Quantity';
            ToolTip = 'Specifies the Reserved Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(73; "Expected Qty. (Base)"; Decimal)
        {
            Caption = 'Expected Qty. (Base)';
            ToolTip = 'Specifies the Expected Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;

        }
        field(76; "Due Date-Time"; DateTime)
        {
            Caption = 'Due Date-Time';
            ToolTip = 'Specifies the Due Date-Time';

        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            ToolTip = 'Specifies the Dimension Set ID';
            Editable = false;
        }
        field(5006; "Version No."; Integer)
        {
            Caption = 'Version No.';
            ToolTip = 'Specifies the Version No.';
        }
        field(5007; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
            ToolTip = 'Specifies the Doc. No. Occurrence';
        }
        field(5702; "Substitution Available"; Boolean)
        {
            CalcFormula = exist("Item Substitution" where(Type = const(Item),
                                                           "Substitute Type" = const(Item),
                                                           "No." = field("Item No."),
                                                           "Variant Code" = field("Variant Code")));
            Caption = 'Substitution Available';
            ToolTip = 'Specifies the Substitution Available';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5703; "Original Item No."; Code[20])
        {
            Caption = 'Original Item No.';
            ToolTip = 'Specifies the Original Item No.';
            Editable = false;
        }
        field(5704; "Original Variant Code"; Code[10])
        {
            Caption = 'Original Variant Code';
            ToolTip = 'Specifies the Original Variant Code';
            Editable = false;
        }
        field(5750; "Pick Qty."; Decimal)
        {
            Caption = 'Pick Qty.';
            ToolTip = 'Specifies the Pick Qty.';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(7300; "Qty. Picked"; Decimal)
        {
            Caption = 'Qty. Picked';
            ToolTip = 'Specifies the Qty. Picked';
            DecimalPlaces = 0 : 5;
            Editable = false;

        }
        field(7301; "Qty. Picked (Base)"; Decimal)
        {
            Caption = 'Qty. Picked (Base)';
            ToolTip = 'Specifies the Qty. Picked (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;

        }
        field(7302; "Completely Picked"; Boolean)
        {
            Caption = 'Completely Picked';
            ToolTip = 'Specifies the Completely Picked';
            Editable = false;
        }
        field(7303; "Pick Qty. (Base)"; Decimal)
        {
            Caption = 'Pick Qty. (Base)';
            ToolTip = 'Specifies the Pick Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(70103; "COL Position"; Code[2048])
        {
            Caption = 'Position (Weibel)';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the position of the component on the bill of material.';
        }
        field(70104; "COL Position 3"; Code[20])
        {
            Caption = 'Position 3 (Weibel)';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the third reference number for the component position on a bill of material, such as the alternate position number of a component on a print card.';
        }
        field(99000754; "Direct Unit Cost"; Decimal)
        {
            Caption = 'Direct Unit Cost';
            ToolTip = 'Specifies the Direct Unit Cost';
            DecimalPlaces = 2 : 5;
        }
        field(99000755; "Indirect Cost %"; Decimal)
        {
            Caption = 'Indirect Cost %';
            ToolTip = 'Specifies the Indirect Cost %';
            DecimalPlaces = 0 : 5;

        }
        field(99000756; "Overhead Rate"; Decimal)
        {
            Caption = 'Overhead Rate';
            ToolTip = 'Specifies the Overhead Rate';
            DecimalPlaces = 0 : 5;

        }
        field(99000757; "Direct Cost Amount"; Decimal)
        {
            Caption = 'Direct Cost Amount';
            ToolTip = 'Specifies the Direct Cost Amount';
            DecimalPlaces = 2 : 2;
        }
        field(99000758; "Overhead Amount"; Decimal)
        {
            Caption = 'Overhead Amount';
            ToolTip = 'Specifies the Overhead Amount';
            DecimalPlaces = 2 : 2;
        }
    }

    keys
    {
        key(Key1; Status, "Prod. Order No.", "Doc. No. Occurrence", "Version No.", "Prod. Order Line No.", "Line No.")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
    }

    var
        DimMgt: Codeunit DimensionManagement;

    procedure ShowDimensions()
    var
        DimSetLbl: Label 'Dimensions';
    begin
        DimMgt.ShowDimensionSet(Rec."Dimension Set ID", DimSetLbl);
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDimCode);
    end;

}

#pragma warning restore AS0099