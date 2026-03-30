namespace Weibel.Manufacturing.Archive;

using Microsoft.Manufacturing.Document;
using Microsoft.Manufacturing.Capacity;
using Microsoft.Inventory.Tracking;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Finance.Dimension;

#pragma warning disable AS0099
table 70108 "COL Prod. Order Line Archive"
{
    Caption = 'Prod. Order Line Archive';
    DataCaptionFields = "Prod. Order No.";
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
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            ToolTip = 'Specifies the Line No.';
        }
        field(11; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            ToolTip = 'Specifies the Item No.';
        }
        field(12; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            ToolTip = 'Specifies the Variant Code';
        }
        field(13; Description; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the Description';
        }
        field(14; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            ToolTip = 'Specifies the Description 2';
        }
        field(20; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            ToolTip = 'Specifies the Location Code';
        }
        field(21; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            ToolTip = 'Specifies the Shortcut Dimension 1 Code';

        }
        field(22; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            ToolTip = 'Specifies the Shortcut Dimension 2 Code';

        }
        field(23; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            ToolTip = 'Specifies the Bin Code';
        }
        field(40; Quantity; Decimal)
        {
            Caption = 'Quantity';
            ToolTip = 'Specifies the Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(41; "Finished Quantity"; Decimal)
        {
            Caption = 'Finished Quantity';
            ToolTip = 'Specifies the Finished Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
        }
        field(42; "Remaining Quantity"; Decimal)
        {
            Caption = 'Remaining Quantity';
            ToolTip = 'Specifies the Remaining Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
        }
        field(45; "Scrap %"; Decimal)
        {
            Caption = 'Scrap %';
            ToolTip = 'Specifies the Scrap %';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(47; "Due Date"; Date)
        {
            Caption = 'Due Date';
            ToolTip = 'Specifies the Due Date';
            Editable = false;

        }
        field(48; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            ToolTip = 'Specifies the Starting Date';
        }
        field(49; "Starting Time"; Time)
        {
            Caption = 'Starting Time';
            ToolTip = 'Specifies the Starting Time';
        }
        field(50; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            ToolTip = 'Specifies the Ending Date';
        }
        field(51; "Ending Time"; Time)
        {
            Caption = 'Ending Time';
            ToolTip = 'Specifies the Ending Time';
        }
        field(52; "Planning Level Code"; Integer)
        {
            Caption = 'Planning Level Code';
            ToolTip = 'Specifies the Planning Level Code';
            Editable = false;
        }
        field(53; Priority; Integer)
        {
            Caption = 'Priority';
            ToolTip = 'Specifies the Priority';
        }
        field(60; "Production BOM No."; Code[20])
        {
            Caption = 'Production BOM No.';
            ToolTip = 'Specifies the Production BOM No.';
        }
        field(61; "Routing No."; Code[20])
        {
            Caption = 'Routing No.';
            ToolTip = 'Specifies the Routing No.';
        }
        field(62; "Inventory Posting Group"; Code[20])
        {
            Caption = 'Inventory Posting Group';
            ToolTip = 'Specifies the Inventory Posting Group';
        }
        field(63; "Routing Reference No."; Integer)
        {
            Caption = 'Routing Reference No.';
            ToolTip = 'Specifies the Routing Reference No.';
            Editable = false;
        }
        field(65; "Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            ToolTip = 'Specifies the Unit Cost';

        }
        field(67; "Cost Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost Amount';
            ToolTip = 'Specifies the Cost Amount';
            Editable = false;
        }
        field(68; "Reserved Quantity"; Decimal)
        {
            Caption = 'Reserved Quantity';
            ToolTip = 'Specifies the Reserved Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(70; "Capacity Type Filter"; Enum "Capacity Type")
        {
            Caption = 'Capacity Type Filter';
            ToolTip = 'Specifies the Capacity Type Filter';
            FieldClass = FlowFilter;
        }
        field(71; "Capacity No. Filter"; Code[20])
        {
            Caption = 'Capacity No. Filter';
            ToolTip = 'Specifies the Capacity No. Filter';
            FieldClass = FlowFilter;
        }
        field(72; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            ToolTip = 'Specifies the Date Filter';
            FieldClass = FlowFilter;
        }
        field(73; "Qty. Rounding Precision"; Decimal)
        {
            Caption = 'Qty. Rounding Precision';
            ToolTip = 'Specifies the Qty. Rounding Precision';
            InitValue = 0;
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 1;
            Editable = false;
        }
        field(74; "Qty. Rounding Precision (Base)"; Decimal)
        {
            Caption = 'Qty. Rounding Precision (Base)';
            ToolTip = 'Specifies the Qty. Rounding Precision (Base)';
            InitValue = 0;
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 1;
            Editable = false;
        }
        field(80; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            ToolTip = 'Specifies the Unit of Measure Code';
        }
        field(81; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)';
            ToolTip = 'Specifies the Quantity (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(82; "Finished Qty. (Base)"; Decimal)
        {
            Caption = 'Finished Qty. (Base)';
            ToolTip = 'Specifies the Finished Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(83; "Remaining Qty. (Base)"; Decimal)
        {
            Caption = 'Remaining Qty. (Base)';
            ToolTip = 'Specifies the Remaining Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(84; "Reserved Qty. (Base)"; Decimal)
        {
            Caption = 'Reserved Qty. (Base)';
            ToolTip = 'Specifies the Reserved Qty. (Base)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
#pragma warning disable AA0232
        field(90; "Expected Operation Cost Amt."; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("COL Prod.Or. Routing Line Arch"."Expected Operation Cost Amt." where(Status = field(Status),
                                                                                               "Prod. Order No." = field("Prod. Order No."),
                                                                                               "Routing No." = field("Routing No."),
                                                                                               "Routing Reference No." = field("Routing Reference No."),
                                                                                               "Version No." = field("Version No.")));
            Caption = 'Expected Operation Cost Amt.';
            ToolTip = 'Specifies the Expected Operation Cost Amt.';
            Editable = false;
            FieldClass = FlowField;
        }
#pragma warning restore AA0232
        field(91; "Total Exp. Oper. Output (Qty.)"; Decimal)
        {
            CalcFormula = sum("COL Prod. Order Line Archive".Quantity where(Status = field(Status),
                                                                 "Prod. Order No." = field("Prod. Order No."),
                                                                 "Routing No." = field("Routing No."),
                                                                 "Routing Reference No." = field("Routing Reference No."),
                                                                 "Ending Date" = field("Date Filter"),
                                                                 "Doc. No. Occurrence" = field("Doc. No. Occurrence"),
                                                                 "Version No." = field("Version No.")));
            Caption = 'Total Exp. Oper. Output (Qty.)';
            ToolTip = 'Specifies the Total Exp. Oper. Output (Qty.)';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(94; "Expected Component Cost Amt."; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("COL Prod. Order Component Arch"."Cost Amount" where(Status = field(Status),
                                                                           "Prod. Order No." = field("Prod. Order No."),
                                                                           "Prod. Order Line No." = field("Line No."),
                                                                           "Due Date" = field("Date Filter"),
                                                                           "Version No." = field("Version No.")));
            Caption = 'Expected Component Cost Amt.';
            ToolTip = 'Specifies the Expected Component Cost Amt.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(198; "Starting Date-Time"; DateTime)
        {
            Caption = 'Starting Date-Time';
            ToolTip = 'Specifies the Starting Date-Time';
        }
        field(199; "Ending Date-Time"; DateTime)
        {
            Caption = 'Ending Date-Time';
            ToolTip = 'Specifies the Ending Date-Time';
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
        field(5831; "Cost Amount (ACY)"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            Caption = 'Cost Amount (ACY)';
            ToolTip = 'Specifies the Cost Amount (ACY)';
            Editable = false;
        }
        field(5832; "Unit Cost (ACY)"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode();
            AutoFormatType = 1;
            Caption = 'Unit Cost (ACY)';
            ToolTip = 'Specifies the Unit Cost (ACY)';
            Editable = false;
        }
        field(99000750; "Production BOM Version Code"; Code[20])
        {
            Caption = 'Production BOM Version Code';
            ToolTip = 'Specifies the Production BOM Version Code';
        }
        field(99000751; "Routing Version Code"; Code[20])
        {
            Caption = 'Routing Version Code';
            ToolTip = 'Specifies the Routing Version Code';
        }
        field(99000752; "Routing Type"; Option)
        {
            Caption = 'Routing Type';
            ToolTip = 'Specifies the Routing Type';
            OptionCaption = 'Serial,Parallel';
            OptionMembers = Serial,Parallel;
        }
        field(99000753; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            ToolTip = 'Specifies the Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(99000754; "MPS Order"; Boolean)
        {
            Caption = 'MPS Order';
            ToolTip = 'Specifies the MPS Order';
        }
        field(99000755; "Planning Flexibility"; Enum "Reservation Planning Flexibility")
        {
            Caption = 'Planning Flexibility';
            ToolTip = 'Specifies the Planning Flexibility';
        }
        field(99000764; "Indirect Cost %"; Decimal)
        {
            Caption = 'Indirect Cost %';
            ToolTip = 'Specifies the Indirect Cost %';
            DecimalPlaces = 0 : 5;
        }
        field(99000765; "Overhead Rate"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Overhead Rate';
            ToolTip = 'Specifies the Overhead Rate';
        }
    }

    keys
    {
        key(Key1; Status, "Prod. Order No.", "Doc. No. Occurrence", "Version No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; Status, "Prod. Order No.", "Routing No.", "Routing Reference No.", "Doc. No. Occurrence", "Version No.")
        {
            IncludedFields = "Item No.", "Variant Code";
        }
    }

    fieldgroups
    {
    }

    var
        GLSetup: Record "General Ledger Setup";
        DimMgt: Codeunit DimensionManagement;
        GLSetupRead: Boolean;


    local procedure GetCurrencyCode(): Code[10]
    begin
        if not GLSetupRead then begin
            GLSetup.Get();
            GLSetupRead := true;
        end;
        exit(GLSetup."Additional Reporting Currency");
    end;

    procedure GetStartingEndingDateAndTime(var StartingTime: Time; var StartingDate: Date; var EndingTime: Time; var EndingDate: Date)
    begin
        StartingTime := DT2Time("Starting Date-Time");
        StartingDate := DT2Date("Starting Date-Time");
        EndingTime := DT2Time("Ending Date-Time");
        EndingDate := DT2Date("Ending Date-Time");
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDimCode);
    end;

    procedure ShowDimensions()
    var
        DimSetLbl: Label 'Dimensions';
    begin
        DimMgt.ShowDimensionSet(Rec."Dimension Set ID", DimSetLbl);
    end;

    procedure ShowRouting()
    var
        ProdOrderRoutingLineArch: Record "COL Prod.Or. Routing Line Arch";
    begin
        ProdOrderRoutingLineArch.SetRange(Status, Status);
        ProdOrderRoutingLineArch.SetRange("Prod. Order No.", "Prod. Order No.");
        ProdOrderRoutingLineArch.SetRange("Routing Reference No.", "Routing Reference No.");
        ProdOrderRoutingLineArch.SetRange("Routing No.", "Routing No.");
        ProdOrderRoutingLineArch.SetRange("Doc. No. Occurrence", "Doc. No. Occurrence");
        ProdOrderRoutingLineArch.SetRange("Version No.", "Version No.");

        Page.RunModal(Page::"COL Prod. Order Routing Arch.", ProdOrderRoutingLineArch);
    end;
}

#pragma warning restore AS0099