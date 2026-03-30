namespace Weibel.Inventory.BOM;

using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Inventory.Location;
using Weibel.Inventory.Item;
using Microsoft.Manufacturing.MachineCenter;
using Microsoft.Manufacturing.WorkCenter;
using Microsoft.Manufacturing.Routing;

table 70142 "COL BOM Structure"
{
    Caption = 'BOM Structure';
    DataCaptionFields = "No.", Description;
    ReplicateData = false;
    TableType = Temporary;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            ToolTip = 'Specifies the value of the Entry No. field.';
        }
        field(2; Type; Enum "COL BOM Element Type")
        {
            Caption = 'Type';
            ToolTip = 'Specifies the value of the Type field.';
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type = const(Item)) Item
            else
            if (Type = const("Production BOM")) "Production BOM Header"
            else
            if (Type = const("Work Center")) "Work Center"
            else
            if (Type = const("Machine Center")) "Machine Center";
            ToolTip = 'Specifies the value of the No. field.';
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the value of the Description field.';
        }
        field(6; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = if (Type = const(Item)) "Item Unit of Measure".Code where("Item No." = field("No."));
            ToolTip = 'Specifies the value of the Unit of Measure Code field.';
        }
        field(7; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = if (Type = const(Item)) "Item Variant".Code where("Item No." = field("No."));
            ToolTip = 'Specifies the value of the Variant Code field.';
        }
        field(8; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = SystemMetadata;
            TableRelation = Location;
            ToolTip = 'Specifies the value of the Location Code field.';
        }
        field(9; "Replenishment System"; Enum "Replenishment System")
        {
            Caption = 'Replenishment System';
            ToolTip = 'Specifies the value of the Replenishment System field.';
        }
        field(10; Indentation; Integer)
        {
            Caption = 'Indentation';
            ToolTip = 'Specifies the value of the Indentation field.';
        }
        field(11; "Is Leaf"; Boolean)
        {
            Caption = 'Is Leaf';
        }
        // field(13; Bottleneck; Boolean)
        // {
        //     Caption = 'Bottleneck';
        //     DataClassification = SystemMetadata;
        // }
        field(15; "Routing No."; Code[20])
        {
            Caption = 'Routing No.';
            DataClassification = SystemMetadata;
            TableRelation = "Routing Header";
            ToolTip = 'Specifies the value of the Routing No. field.';
        }
        field(16; "Production BOM No."; Code[20])
        {
            Caption = 'Production BOM No.';
            DataClassification = SystemMetadata;
            TableRelation = "Production BOM Header";
            ToolTip = 'Specifies the value of the Production BOM No. field.';
        }
        // field(20; "Lot Size"; Decimal)
        // {
        //     AccessByPermission = TableData "Production Order" = R;
        //     Caption = 'Lot Size';
        //     DataClassification = SystemMetadata;
        //     DecimalPlaces = 0 : 5;
        //     MinValue = 0;
        // }

#if not HIDE_IT8M_LOW_LEVEL
        field(21; "Low-Level Code"; Integer)
        {
            Caption = 'Low-Level Code (ITM8)';
            DataClassification = SystemMetadata;
            Editable = false;
            ToolTip = 'Specifies the value of the Low-Level Code (ITM8) field.';
        }
#endif
        // field(22; "Rounding Precision"; Decimal)
        // {
        //     Caption = 'Rounding Precision';
        //     DataClassification = SystemMetadata;
        //     DecimalPlaces = 0 : 5;
        //     InitValue = 1;
        // }
        field(30; "Qty. per Parent"; Decimal)
        {
            Caption = 'Qty. per Parent';
            DecimalPlaces = 0 : 5;
            ToolTip = 'Specifies the value of the Qty. per Parent field.';
        }
        // field(31; "Qty. per Top Item"; Decimal)
        // {
        //     Caption = 'Qty. per Top Item';
        //     DataClassification = SystemMetadata;
        //     DecimalPlaces = 0 : 5;
        // }
        // field(32; "Able to Make Top Item"; Decimal)
        // {
        //     Caption = 'Able to Make Top Item';
        //     DataClassification = SystemMetadata;
        //     DecimalPlaces = 0 : 5;
        // }
        // field(33; "Able to Make Parent"; Decimal)
        // {
        //     Caption = 'Able to Make Parent';
        //     DataClassification = SystemMetadata;
        //     DecimalPlaces = 0 : 5;
        // }
        // field(35; "Available Quantity"; Decimal)
        // {
        //     Caption = 'Available Quantity';
        //     DataClassification = SystemMetadata;
        //     DecimalPlaces = 0 : 5;
        // }
        // field(36; "Gross Requirement"; Decimal)
        // {
        //     Caption = 'Gross Requirement';
        //     DataClassification = SystemMetadata;
        //     DecimalPlaces = 0 : 5;
        // }
        // field(37; "Scheduled Receipts"; Decimal)
        // {
        //     Caption = 'Scheduled Receipts';
        //     DataClassification = SystemMetadata;
        //     DecimalPlaces = 0 : 5;
        // }
        // field(38; "Unused Quantity"; Decimal)
        // {
        //     Caption = 'Unused Quantity';
        //     DataClassification = SystemMetadata;
        //     DecimalPlaces = 0 : 5;
        // }
        field(40; "Lead Time Calculation"; DateFormula)
        {
            Caption = 'Lead Time Calculation';
            ToolTip = 'Specifies the value of the Lead Time Calculation field.';
            DataClassification = SystemMetadata;
        }
        // field(41; "Lead-Time Offset"; DateFormula)
        // {
        //     Caption = 'Lead-Time Offset';
        //     DataClassification = SystemMetadata;
        // }
        // field(42; "Rolled-up Lead-Time Offset"; Integer)
        // {
        //     Caption = 'Rolled-up Lead-Time Offset';
        //     DataClassification = SystemMetadata;
        // }
        // field(43; "Needed by Date"; Date)
        // {
        //     Caption = 'Needed by Date';
        //     DataClassification = SystemMetadata;
        // }
        field(45; "Safety Lead Time"; DateFormula)
        {
            Caption = 'Safety Lead Time';
            DataClassification = SystemMetadata;
        }
        // field(50; "Unit Cost"; Decimal)
        // {
        //     AutoFormatType = 2;
        //     Caption = 'Unit Cost';
        //     DataClassification = SystemMetadata;
        // }
        // field(52; "Indirect Cost %"; Decimal)
        // {
        //     Caption = 'Indirect Cost %';
        //     DataClassification = SystemMetadata;
        //     DecimalPlaces = 0 : 5;
        // }
        // field(54; "Overhead Rate"; Decimal)
        // {
        //     AutoFormatType = 2;
        //     Caption = 'Overhead Rate';
        //     DataClassification = SystemMetadata;
        // }
        // field(55; "Scrap %"; Decimal)
        // {
        //     BlankZero = true;
        //     Caption = 'Scrap %';
        //     DataClassification = SystemMetadata;
        // }
        // field(56; "Scrap Qty. per Parent"; Decimal)
        // {
        //     Caption = 'Scrap Qty. per Parent';
        //     DataClassification = SystemMetadata;
        //     DecimalPlaces = 0 : 5;
        // }
        // field(57; "Scrap Qty. per Top Item"; Decimal)
        // {
        //     Caption = 'Scrap Qty. per Top Item';
        //     DataClassification = SystemMetadata;
        //     DecimalPlaces = 0 : 5;
        // }
        // field(59; "Resource Usage Type"; Option)
        // {
        //     Caption = 'Resource Usage Type';
        //     DataClassification = SystemMetadata;
        //     OptionCaption = 'Direct,Fixed';
        //     OptionMembers = Direct,"Fixed";
        // }
        // field(61; "Single-Level Material Cost"; Decimal)
        // {
        //     AutoFormatType = 2;
        //     BlankZero = true;
        //     Caption = 'Single-Level Material Cost';
        //     DataClassification = SystemMetadata;
        //     DecimalPlaces = 2 : 5;
        // }
        // field(62; "Single-Level Capacity Cost"; Decimal)
        // {
        //     AutoFormatType = 2;
        //     BlankZero = true;
        //     Caption = 'Single-Level Capacity Cost';
        //     DataClassification = SystemMetadata;
        //     DecimalPlaces = 2 : 5;
        // }
        // field(63; "Single-Level Subcontrd. Cost"; Decimal)
        // {
        //     AccessByPermission = TableData "Machine Center" = R;
        //     AutoFormatType = 2;
        //     BlankZero = true;
        //     Caption = 'Single-Level Subcontrd. Cost';
        //     DataClassification = SystemMetadata;
        //     DecimalPlaces = 2 : 5;
        // }
        // field(64; "Single-Level Cap. Ovhd Cost"; Decimal)
        // {
        //     AutoFormatType = 2;
        //     BlankZero = true;
        //     Caption = 'Single-Level Cap. Ovhd Cost';
        //     DataClassification = SystemMetadata;
        //     DecimalPlaces = 2 : 5;
        // }
        // field(65; "Single-Level Mfg. Ovhd Cost"; Decimal)
        // {
        //     AutoFormatType = 2;
        //     BlankZero = true;
        //     Caption = 'Single-Level Mfg. Ovhd Cost';
        //     DataClassification = SystemMetadata;
        //     DecimalPlaces = 2 : 5;
        // }
        // field(66; "Single-Level Scrap Cost"; Decimal)
        // {
        //     BlankZero = true;
        //     Caption = 'Single-Level Scrap Cost';
        //     DataClassification = SystemMetadata;
        //     DecimalPlaces = 2 : 5;
        // }
        // field(71; "Rolled-up Material Cost"; Decimal)
        // {
        //     AutoFormatType = 2;
        //     BlankZero = true;
        //     Caption = 'Rolled-up Material Cost';
        //     DataClassification = SystemMetadata;
        //     DecimalPlaces = 2 : 5;
        //     Editable = false;
        // }
        // field(72; "Rolled-up Capacity Cost"; Decimal)
        // {
        //     AutoFormatType = 2;
        //     BlankZero = true;
        //     Caption = 'Rolled-up Capacity Cost';
        //     DataClassification = SystemMetadata;
        //     DecimalPlaces = 2 : 5;
        //     Editable = false;
        // }
        // field(73; "Rolled-up Subcontracted Cost"; Decimal)
        // {
        //     AccessByPermission = TableData "Machine Center" = R;
        //     AutoFormatType = 2;
        //     BlankZero = true;
        //     Caption = 'Rolled-up Subcontracted Cost';
        //     DataClassification = SystemMetadata;
        //     Editable = false;
        // }
        // field(74; "Rolled-up Capacity Ovhd. Cost"; Decimal)
        // {
        //     AutoFormatType = 2;
        //     BlankZero = true;
        //     Caption = 'Rolled-up Capacity Ovhd. Cost';
        //     DataClassification = SystemMetadata;
        //     Editable = false;
        // }
        // field(75; "Rolled-up Mfg. Ovhd Cost"; Decimal)
        // {
        //     AutoFormatType = 2;
        //     BlankZero = true;
        //     Caption = 'Rolled-up Mfg. Ovhd Cost';
        //     DataClassification = SystemMetadata;
        //     Editable = false;
        // }
        // field(76; "Rolled-up Scrap Cost"; Decimal)
        // {
        //     BlankZero = true;
        //     Caption = 'Rolled-up Scrap Cost';
        //     DataClassification = SystemMetadata;
        //     DecimalPlaces = 2 : 5;
        // }
        // field(77; "Single-Lvl Mat. Non-Invt. Cost"; Decimal)
        // {
        //     AutoFormatType = 2;
        //     BlankZero = true;
        //     Caption = 'Single-Level Material Non-Inventory Cost';
        //     DataClassification = CustomerContent;
        //     DecimalPlaces = 2 : 5;
        // }
        // field(78; "Rolled-up Mat. Non-Invt. Cost"; Decimal)
        // {
        //     AutoFormatType = 2;
        //     BlankZero = true;
        //     Caption = 'Rolled-up Material Non-Inventory Cost';
        //     DataClassification = CustomerContent;
        //     DecimalPlaces = 2 : 5;
        //     Editable = false;
        // }
        // field(81; "Total Cost"; Decimal)
        // {
        //     BlankZero = true;
        //     Caption = 'Total Cost';
        //     DataClassification = SystemMetadata;
        //     DecimalPlaces = 2 : 5;
        // }
        // field(82; "BOM Unit of Measure Code"; Code[10])
        // {
        //     Caption = 'BOM Unit of Measure Code';
        //     DataClassification = SystemMetadata;
        //     TableRelation = if (Type = const(Item)) "Item Unit of Measure".Code where("Item No." = field("No."))
        //     else
        //     if (Type = const(Resource)) "Resource Unit of Measure".Code where("Resource No." = field("No."));
        // }
        // field(83; "Qty. per BOM Line"; Decimal)
        // {
        //     Caption = 'Qty. per BOM Line';
        //     DataClassification = SystemMetadata;
        //     DecimalPlaces = 0 : 5;
        // }
        // field(84; Inventoriable; Boolean)
        // {
        //     Caption = 'Inventoriable';
        //     DataClassification = SystemMetadata;
        // }
        // field(85; "Calculation Formula"; Enum "Quantity Calculation Formula")
        // {
        //     Caption = 'Calculation Formula';
        //     DataClassification = SystemMetadata;
        // }
        field(6500; "Item Tracking Code"; Code[10])
        {
            Caption = 'Item Tracking Code';
            ToolTip = 'Specifies the value of the Item Tracking Code field.';
            Editable = false;
        }
        field(70100; "COL Product Life Cycle"; Enum "COL Product Life Cycle")
        {
            Caption = 'Product Life Cycle';
            ToolTip = 'Specifies product life cycle.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70101; "COL EU RoHS Dir. Compliant"; Enum "COL EU RoHS Dir. Compliant")
        {
            Caption = 'EU RoHS Directive Compliant';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the value of the EU RoHS Directive Compliant field.';
        }
        field(70102; "COL EU REACH Reg. Compliant"; Enum "COL EU REACH Reg. Compliant")
        {
            Caption = 'EU REACH Regulation Compliant';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the value of the EU REACH Regulation Compliant field.';
        }
        field(70103; "COL EU RoHS Status"; Text[20])
        {
            Caption = 'EU RoHS Status';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the value of the EU RoHS Status field.';
        }
        field(70104; "COL Production Blocked"; Boolean)
        {
            Caption = 'Production Blocked';
            ToolTip = 'Specifies whether the item is blocked for production.';
            DataClassification = CustomerContent;
        }
        field(70105; "COL Project Blocked"; Boolean)
        {
            Caption = 'Project Blocked';
            ToolTip = 'Specifies whether the item is blocked for project.';
            DataClassification = CustomerContent;
        }
        field(70106; "COL Planning Blocked"; Boolean)
        {
            Caption = 'Planning Blocked';
            ToolTip = 'Specifies whether the item is blocked for planning.';
            DataClassification = CustomerContent;
        }
        field(70107; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the value of the Blocked field.';
        }
        field(70108; "Sales Blocked"; Boolean)
        {
            Caption = 'Sales Blocked';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the value of the Sales Blocked field.';
        }
        field(70109; "Purchasing Blocked"; Boolean)
        {
            Caption = 'Purchasing Blocked';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the value of the Purchasing Blocked field.';
        }
        field(70110; "Service Blocked"; Boolean)
        {
            Caption = 'Service Blocked';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the value of the Service Blocked field.';
        }
        field(70998; "Phantom BOM"; Boolean)
        {
            Caption = 'Is Phantom BOM';
            ToolTip = 'Specifies the value of the Is Phantom BOM field.';
        }
        field(70999; "Has Warnings"; Boolean)
        {
            Caption = 'Has Warnings';
        }
    }

    procedure CopyFromItemVariant()
    begin
        CopyFromItemVariant(Rec."No.", Rec."Variant Code");
    end;

    procedure CopyFromItemVariant(ItemNo: Code[20]; VariantCode: Code[10])
    var
        ItemVariant: Record "Item Variant";
        Item: Record Item;
    begin
        Item.ReadIsolation := IsolationLevel::ReadUncommitted;
        Item.SetLoadFields(Description, "Base Unit of Measure", "Item Tracking Code");
        Item.Get(ItemNo);

        ItemVariant.ReadIsolation := IsolationLevel::ReadUncommitted;
        ItemVariant.SetLoadFields(Description, "COL Product Life Cycle", "COL EU REACH Reg. Compliant", "COL EU RoHS Status", "COL EU RoHS Dir. Compliant",
            "COL Project Blocked", "COL Planning Blocked", "COL Production Blocked", Blocked, "Sales Blocked", "Purchasing Blocked", "Service Blocked");
        if ItemVariant.Get(ItemNo, VariantCode) then begin
            Rec."COL Product Life Cycle" := ItemVariant."COL Product Life Cycle";
            Rec."COL EU REACH Reg. Compliant" := ItemVariant."COL EU REACH Reg. Compliant";
            Rec."COL EU RoHS Status" := ItemVariant."COL EU RoHS Status";
            Rec."COL EU RoHS Dir. Compliant" := ItemVariant."COL EU RoHS Dir. Compliant";
            Rec."COL Project Blocked" := ItemVariant."COL Project Blocked";
            Rec."COL Planning Blocked" := ItemVariant."COL Planning Blocked";
            Rec."COL Production Blocked" := ItemVariant."COL Production Blocked";
            Rec.Blocked := ItemVariant.Blocked;
            Rec."Sales Blocked" := ItemVariant."Sales Blocked";
            Rec."Purchasing Blocked" := ItemVariant."Purchasing Blocked";
            Rec."Service Blocked" := ItemVariant."Service Blocked";
        end;
        Rec."Unit of Measure Code" := Item."Base Unit of Measure";
        Rec."Item Tracking Code" := Item."Item Tracking Code";
    end;

    procedure CopyFromSKU(var StockkeepingUnit: Record "Stockkeeping Unit")
#if not HIDE_IT8M_LOW_LEVEL
    var
        RRef: RecordRef;
        FRef: FieldRef;
#endif
    begin
        Rec."Replenishment System" := StockkeepingUnit."Replenishment System";
        Rec."Lead Time Calculation" := StockkeepingUnit."Lead Time Calculation";
        Rec."Safety Lead Time" := StockkeepingUnit."Safety Lead Time";
        Rec.Description := StockkeepingUnit.Description;
#if not HIDE_IT8M_LOW_LEVEL
        RRef.GetTable(StockkeepingUnit);
        if RRef.FieldExist(62000) then begin // "WS Low-Level Code ITM8"; to avoid adding app dependency
            FRef := RRef.Field(62000);
            if FRef.Type = FRef.Type::Integer then
                Rec."Low-Level Code" := RRef.Field(62000).Value();
        end;
#endif
    end;

    procedure CopyFromProductionBOM(ProductionBOMNo: Code[20])
    var
        ProductionBOMHeader: Record "Production BOM Header";
    begin
        ProductionBOMHeader.ReadIsolation := IsolationLevel::ReadUncommitted;
        ProductionBOMHeader.SetLoadFields(Description);
        ProductionBOMHeader.Get(ProductionBOMNo);
        Rec.Description := ProductionBOMHeader.Description;
    end;
}