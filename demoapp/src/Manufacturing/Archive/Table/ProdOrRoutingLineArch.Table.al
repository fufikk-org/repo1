namespace Weibel.Manufacturing.Archive;

using Microsoft.Manufacturing.Document;
using Microsoft.Foundation.Enums;
using Microsoft.Manufacturing.Capacity;
using Microsoft.Manufacturing.Setup;
using Microsoft.Inventory.Item;

table 70111 "COL Prod.Or. Routing Line Arch"
{
    Caption = 'Prod. Order Routing Line Archive';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Routing No."; Code[20])
        {
            Caption = 'Routing No.';
            ToolTip = 'Specifies the Routing No.';
        }
        field(3; "Routing Reference No."; Integer)
        {
            Caption = 'Routing Reference No.';
            ToolTip = 'Specifies the Routing Reference No.';
            Editable = false;
        }
        field(4; "Operation No."; Code[10])
        {
            Caption = 'Operation No.';
            ToolTip = 'Specifies the Operation No.';
            NotBlank = true;
        }
        field(5; "Next Operation No."; Code[30])
        {
            Caption = 'Next Operation No.';
            ToolTip = 'Specifies the Next Operation No.';
        }
        field(6; "Previous Operation No."; Code[30])
        {
            Caption = 'Previous Operation No.';
            ToolTip = 'Specifies the Previous Operation No.';
        }
        field(7; Type; Enum "Capacity Type")
        {
            Caption = 'Type';
            ToolTip = 'Specifies the Type';
        }
        field(8; "No."; Code[20])
        {
            Caption = 'No.';
            ToolTip = 'Specifies the No.';
        }
        field(9; "Work Center No."; Code[20])
        {
            Caption = 'Work Center No.';
            ToolTip = 'Specifies the Work Center No.';
            Editable = false;
        }
        field(10; "Work Center Group Code"; Code[10])
        {
            Caption = 'Work Center Group Code';
            ToolTip = 'Specifies the Work Center Group Code';
            Editable = false;
        }
        field(11; Description; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the Description';
        }
        field(12; "Setup Time"; Decimal)
        {
            Caption = 'Setup Time';
            ToolTip = 'Specifies the Setup Time';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(13; "Run Time"; Decimal)
        {
            Caption = 'Run Time';
            ToolTip = 'Specifies the Run Time';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(14; "Wait Time"; Decimal)
        {
            Caption = 'Wait Time';
            ToolTip = 'Specifies the Wait Time';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(15; "Move Time"; Decimal)
        {
            Caption = 'Move Time';
            ToolTip = 'Specifies the Move Time';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(16; "Fixed Scrap Quantity"; Decimal)
        {
            Caption = 'Fixed Scrap Quantity';
            ToolTip = 'Specifies the Fixed Scrap Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(17; "Lot Size"; Decimal)
        {
            Caption = 'Lot Size';
            ToolTip = 'Specifies the Lot Size';
            DecimalPlaces = 0 : 5;
        }
        field(18; "Scrap Factor %"; Decimal)
        {
            Caption = 'Scrap Factor %';
            ToolTip = 'Specifies the Scrap Factor %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(19; "Setup Time Unit of Meas. Code"; Code[10])
        {
            Caption = 'Setup Time Unit of Meas. Code';
            ToolTip = 'Specifies the Setup Time Unit of Meas. Code';
        }
        field(20; "Run Time Unit of Meas. Code"; Code[10])
        {
            Caption = 'Run Time Unit of Meas. Code';
            ToolTip = 'Specifies the Run Time Unit of Meas. Code';
        }
        field(21; "Wait Time Unit of Meas. Code"; Code[10])
        {
            Caption = 'Wait Time Unit of Meas. Code';
            ToolTip = 'Specifies the Wait Time Unit of Meas. Code';
        }
        field(22; "Move Time Unit of Meas. Code"; Code[10])
        {
            Caption = 'Move Time Unit of Meas. Code';
            ToolTip = 'Specifies the Move Time Unit of Meas. Code';
        }
        field(27; "Minimum Process Time"; Decimal)
        {
            Caption = 'Minimum Process Time';
            ToolTip = 'Specifies the Minimum Process Time';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(28; "Maximum Process Time"; Decimal)
        {
            Caption = 'Maximum Process Time';
            ToolTip = 'Specifies the Maximum Process Time';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(30; "Concurrent Capacities"; Decimal)
        {
            Caption = 'Concurrent Capacities';
            ToolTip = 'Specifies the Concurrent Capacities';
            DecimalPlaces = 0 : 5;
            InitValue = 1;
            MinValue = 0;
        }
        field(31; "Send-Ahead Quantity"; Decimal)
        {
            Caption = 'Send-Ahead Quantity';
            ToolTip = 'Specifies the Send-Ahead Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(34; "Routing Link Code"; Code[10])
        {
            Caption = 'Routing Link Code';
            ToolTip = 'Specifies the Routing Link Code';
            Editable = false;
        }
        field(35; "Standard Task Code"; Code[10])
        {
            Caption = 'Standard Task Code';
            ToolTip = 'Specifies the Standard Task Code';
        }
        field(40; "Unit Cost per"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost per';
            ToolTip = 'Specifies the Unit Cost per';
            MinValue = 0;
        }
        field(41; Recalculate; Boolean)
        {
            Caption = 'Recalculate';
            ToolTip = 'Specifies the Recalculate';
        }
        field(50; "Sequence No. (Forward)"; Integer)
        {
            Caption = 'Sequence No. (Forward)';
            ToolTip = 'Specifies the Sequence No. (Forward)';
            Editable = false;
        }
        field(51; "Sequence No. (Backward)"; Integer)
        {
            Caption = 'Sequence No. (Backward)';
            ToolTip = 'Specifies the Sequence No. (Backward)';
            Editable = false;
        }
        field(52; "Fixed Scrap Qty. (Accum.)"; Decimal)
        {
            Caption = 'Fixed Scrap Qty. (Accum.)';
            ToolTip = 'Specifies the Fixed Scrap Qty. (Accum.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(53; "Scrap Factor % (Accumulated)"; Decimal)
        {
            Caption = 'Scrap Factor % (Accumulated)';
            ToolTip = 'Specifies the Scrap Factor % (Accumulated)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(55; "Sequence No. (Actual)"; Integer)
        {
            Caption = 'Sequence No. (Actual)';
            ToolTip = 'Specifies the Sequence No. (Actual)';
            Editable = false;
        }
        field(56; "Direct Unit Cost"; Decimal)
        {
            Caption = 'Direct Unit Cost';
            ToolTip = 'Specifies the Direct Unit Cost';
            DecimalPlaces = 2 : 5;
        }
        field(57; "Indirect Cost %"; Decimal)
        {
            Caption = 'Indirect Cost %';
            ToolTip = 'Specifies the Indirect Cost %';
            DecimalPlaces = 0 : 5;
        }
        field(58; "Overhead Rate"; Decimal)
        {
            Caption = 'Overhead Rate';
            ToolTip = 'Specifies the Overhead Rate';
            DecimalPlaces = 0 : 5;
        }
        field(70; "Starting Time"; Time)
        {
            Caption = 'Starting Time';
            ToolTip = 'Specifies the Starting Time';
        }
        field(71; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            ToolTip = 'Specifies the Starting Date';
        }
        field(72; "Ending Time"; Time)
        {
            Caption = 'Ending Time';
            ToolTip = 'Specifies the Ending Time';
        }
        field(73; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            ToolTip = 'Specifies the Ending Date';
        }
        field(74; Status; Enum "Production Order Status")
        {
            Caption = 'Status';
            ToolTip = 'Specifies the Status';
        }
        field(75; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            ToolTip = 'Specifies the Prod. Order No.';
            Editable = false;
            NotBlank = true;
        }
        field(76; "Unit Cost Calculation"; Enum "Unit Cost Calculation Type")
        {
            Caption = 'Unit Cost Calculation';
            ToolTip = 'Specifies the Unit Cost Calculation';
        }
        field(77; "Input Quantity"; Decimal)
        {
            Caption = 'Input Quantity';
            ToolTip = 'Specifies the Input Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(78; "Critical Path"; Boolean)
        {
            Caption = 'Critical Path';
            ToolTip = 'Specifies the Critical Path';
            Editable = false;
        }
        field(79; "Routing Status"; Enum "Prod. Order Routing Status")
        {
            Caption = 'Routing Status';
            ToolTip = 'Specifies the Routing Status';
        }
        field(81; "Flushing Method"; Enum "Flushing Method Routing")
        {
            Caption = 'Flushing Method';
            ToolTip = 'Specifies the Flushing Method';
        }
        field(90; "Expected Operation Cost Amt."; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Expected Operation Cost Amt.';
            ToolTip = 'Specifies the Expected Operation Cost Amt.';
            Editable = false;
        }
        field(91; "Expected Capacity Need"; Decimal)
        {
            Caption = 'Expected Capacity Need';
            ToolTip = 'Specifies the Expected Capacity Need';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = Normal;
        }
        field(96; "Expected Capacity Ovhd. Cost"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Expected Capacity Ovhd. Cost';
            ToolTip = 'Specifies the Expected Capacity Ovhd. Cost';
            Editable = false;
        }
        field(98; "Starting Date-Time"; DateTime)
        {
            Caption = 'Starting Date-Time';
            ToolTip = 'Specifies the Starting Date-Time';

        }
        field(99; "Ending Date-Time"; DateTime)
        {
            Caption = 'Ending Date-Time';
            ToolTip = 'Specifies the Ending Date-Time';
        }
        field(100; "Schedule Manually"; Boolean)
        {
            Caption = 'Schedule Manually';
            ToolTip = 'Specifies the Schedule Manually';
        }
        field(101; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            ToolTip = 'Specifies the Location Code';
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
        field(7301; "Open Shop Floor Bin Code"; Code[20])
        {
            Caption = 'Open Shop Floor Bin Code';
            ToolTip = 'Specifies the Open Shop Floor Bin Code';
            Editable = false;
        }
        field(7302; "To-Production Bin Code"; Code[20])
        {
            Caption = 'To-Production Bin Code';
            ToolTip = 'Specifies the To-Production Bin Code';
            Editable = false;
        }
        field(7303; "From-Production Bin Code"; Code[20])
        {
            Caption = 'From-Production Bin Code';
            ToolTip = 'Specifies the From-Production Bin Code';
            Editable = false;
        }
        field(70101; "COL In Progress Set By User"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'In Progress Set By User';
            ToolTip = 'Specifies the user who set the routing line in progress.';
            Editable = false;
        }
        field(70102; "COL In Progress Date-Time"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'In Progress Date-Time';
            ToolTip = 'Specifies the date and time when the routing line was set to in-progress.';
            Editable = false;
        }
        field(70103; "COL Finished By User"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Finished By User';
            ToolTip = 'Specifies the user who finished the routing line.';
            Editable = false;
        }
        field(70104; "COL Finished Date-Time"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Finished Date-Time';
            ToolTip = 'Specifies the date and time when the routing line was finished.';
            Editable = false;
        }
        field(70106; "COL Prod. Order Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Item;
            Caption = 'Prod. Order Item No.';
            ToolTip = 'Specifies the item number of the production order.';
        }
        field(70107; "COL Prod. Order Variant Code"; Code[10])
        {
            Caption = 'Prod. Order Variant Code';
            ToolTip = 'Specifies the variant code of the production order.';
            DataClassification = CustomerContent;
            TableRelation = "Item Variant"."Code" where("Item No." = field("COL Prod. Order Item No."));
        }
    }

    keys
    {
        key(Key1; Status, "Prod. Order No.", "Doc. No. Occurrence", "Version No.", "Routing Reference No.", "Routing No.", "Operation No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    procedure GetStartingEndingDateAndTime(var StartingTime: Time; var StartingDate: Date; var EndingTime: Time; var EndingDate: Date)
    begin
        StartingTime := DT2Time("Starting Date-Time");
        StartingDate := DT2Date("Starting Date-Time");
        EndingTime := DT2Time("Ending Date-Time");
        EndingDate := DT2Date("Ending Date-Time");
    end;

}

