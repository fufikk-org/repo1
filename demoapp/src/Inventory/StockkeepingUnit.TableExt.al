namespace Weibel.Inventory.Location;

using Microsoft.Inventory.Location;
using Microsoft.Inventory.Item;
using Microsoft.Purchases.Setup;
using Weibel.Inventory.Item;
using Weibel.Inventory.Setup;
using Microsoft.Inventory.Setup;
using Weibel.Inventory.Planning;
using Microsoft.Inventory.Requisition;
using Microsoft.Inventory.Item.Catalog;
using Microsoft.Warehouse.Structure;

tableextension 70159 "COL Stockkeeping Unit" extends "Stockkeeping Unit"
{
    fields
    {
        modify("Vendor No.")
        {
            trigger OnBeforeValidate()
            begin
                LastLeadTimeCalculation := Rec."Lead Time Calculation";
            end;

            trigger OnAfterValidate()
            var
                PurchSetup: Record "Purchases & Payables Setup";
            begin
                PurchSetup.SetLoadFields("COL Keep Vendor Lead Time I/S");
                PurchSetup.Get();
                if not PurchSetup."COL Keep Vendor Lead Time I/S" then
                    exit;
                Rec."Lead Time Calculation" := LastLeadTimeCalculation;
                Clear(LastLeadTimeCalculation);
            end;
        }
#if not HIDE_LOWLEVEL_SKU
        field(70100; "COL Item Low-Level Code"; Integer)
        {
            Caption = 'Item Low-Level Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Item."Low-Level Code" where("No." = field("Item No.")));
            ToolTip = 'Low-Level Code of the item that is associated with this SKU.';
            ObsoleteState = Pending;
            ObsoleteReason = 'Replaced by functionality from ITM8';

        }
        field(70101; "COL Low-Level Code"; Integer)
        {
            Caption = 'SKU Low-Level Code';
            ToolTip = 'Specifies low level code calculated for SKU.';
            DataClassification = SystemMetadata;
            Editable = false;
            ObsoleteState = Pending;
            ObsoleteReason = 'Replaced by functionality from ITM8';
        }
#endif        
        field(70110; "COL V.EU RoHS Dir. Compliant"; Enum "COL EU RoHS Dir. Compliant")
        {
            Caption = 'EU RoHS Directive Compliant';
            ToolTip = 'Specifies the value of the EU RoHS Directive Compliant field.';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Variant"."COL EU RoHS Dir. Compliant" where("Item No." = field("Item No."), Code = field("Variant Code")));
            AllowInCustomizations = Never;
        }
        field(70111; "COL V.EU REACH Reg. Compliant"; Enum "COL EU REACH Reg. Compliant")
        {
            Caption = 'EU REACH Regulation Compliant';
            ToolTip = 'Specifies the value of the EU REACH Regulation Compliant field.';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Variant"."COL EU REACH Reg. Compliant" where("Item No." = field("Item No."), Code = field("Variant Code")));
            AllowInCustomizations = Never;
        }
        field(70112; "COL V.EU RoHS Status"; Text[20])
        {
            Caption = 'EU RoHS Status';
            ToolTip = 'Specifies the value of the EU RoHS Status field.';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Variant"."COL EU RoHS Status" where("Item No." = field("Item No."), Code = field("Variant Code")));
            AllowInCustomizations = Never;
        }
        field(70113; "COL EU RoHS Dir. Compliant"; Enum "COL EU RoHS Dir. Compliant")
        {
            Caption = 'EU RoHS Directive Compliant';
            ToolTip = 'Specifies the value of the EU RoHS Directive Compliant field.';
            FieldClass = FlowField;
            CalcFormula = lookup("Item"."COL EU RoHS Dir. Compliant" where("No." = field("Item No.")));
            AllowInCustomizations = Never;
        }
        field(70114; "COL EU REACH Reg. Compliant"; Enum "COL EU REACH Reg. Compliant")
        {
            Caption = 'EU REACH Regulation Compliant';
            ToolTip = 'Specifies the value of the EU REACH Regulation Compliant field.';
            FieldClass = FlowField;
            CalcFormula = lookup("Item"."COL EU REACH Reg. Compliant" where("No." = field("Item No.")));
            AllowInCustomizations = Never;
        }
        field(70115; "COL EU RoHS Status"; Text[20])
        {
            Caption = 'EU RoHS Status';
            ToolTip = 'Specifies the value of the EU RoHS Status field.';
            FieldClass = FlowField;
            CalcFormula = lookup("Item"."COL EU RoHS Status" where("No." = field("Item No.")));
            AllowInCustomizations = Never;
        }
        field(70116; "COL Product Life Cycle"; Enum "COL Product Life Cycle")
        {
            Caption = 'Product Life Cycle';
            ToolTip = 'Specifies product life cycle.';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Variant"."COL Product Life Cycle" where("Item No." = field("Item No."), Code = field("Variant Code")));
            Editable = false;
        }
        field(70117; "COL Changed By"; Code[50])
        {
            Caption = 'Changed By';
            ToolTip = 'Specifies the user who changed the product life cycle.';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Variant"."COL Changed By" where("Item No." = field("Item No."), Code = field("Variant Code")));
            Editable = false;
        }
        field(70118; "COL Date Changed"; Date)
        {
            Caption = 'Date Changed';
            ToolTip = 'Specifies the date when the product life cycle was changed.';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Variant"."COL Date Changed" where("Item No." = field("Item No."), Code = field("Variant Code")));
            Editable = false;
        }
        field(70119; "COL Item Reference"; Code[50])
        {
            Caption = 'Reference No.';
            ToolTip = 'Specifies the reference number of the item.';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Reference"."Reference No." where("Item No." = field("Item No."), "Variant Code" = field("Variant Code"), "Reference Type" = const(Vendor), "Reference Type No." = field("Vendor No.")));
            Editable = false;
        }
        field(70120; "COL SKU Prevent Negative Inv."; Enum "COL Default Inventory")
        {
            Caption = 'Prevent Negative Inventory';
            ToolTip = 'Specifies whether to prevent negative inventory for the SKU.';
            DataClassification = CustomerContent;
        }
        field(70121; "COL Created By User"; Text[100])
        {
            Caption = 'Created By User';
            ToolTip = 'Specifies the user who created the SKU.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70122; "COL Creation Date"; Date)
        {
            Caption = 'Creation Date';
            ToolTip = 'Specifies the date when the SKU was created.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70123; "COL Item Created By User"; Text[100])
        {
            Caption = 'Parent Item Created By User';
            ToolTip = 'Specifies the user who created the item.';
            FieldClass = FlowField;
            CalcFormula = lookup("Item"."COL Created By User" where("No." = field("Item No.")));
            Editable = false;
        }
        field(70124; "COL Default Bin Code"; Code[20])
        {
            Caption = 'Default Bin Code';
            Editable = false;
            ToolTip = 'Specifies Default Bin Code from item''s variant.';
            FieldClass = FlowField;
            CalcFormula = lookup("Bin Content"."Bin Code" where("Default" = const(true), "Item No." = field("Item No."), "Variant Code" = field("Variant Code"))); // without location code (default is for any location in this case)
        }
    }


    keys
    {
        key(COL_Key1; "Production BOM No.") { }
        // key(COL_Key2; "COL Low-Level Code") { }
    }

    trigger OnAfterInsert()
    begin
        if "COL Created By User" = '' then begin
            "COL Created By User" := CopyStr(UserId, 1, MaxStrLen("COL Created By User"));
            "COL Creation Date" := Today;
        end;
    end;

    var
        LastLeadTimeCalculation: DateFormula;

    internal procedure UpdateROHS(EURoHSStatus: Text[20]; EURoHSDirCompliant: Enum "COL EU RoHS Dir. Compliant"; EUREACHRegCompliant: Enum "COL EU REACH Reg. Compliant";
                                                                                  FieldNo: Integer)
    var
        ItemVariant: Record "Item Variant";
        Item: Record Item;
    begin
        if Rec."Variant Code" <> '' then begin
            ItemVariant.SetRange("Item No.", Rec."Item No.");
            ItemVariant.SetRange(Code, Rec."Variant Code");
            case FieldNo of
                Rec.FieldNo("COL EU RoHS Status"):
                    ItemVariant.ModifyAll("COL EU RoHS Status", EURoHSStatus, true);
                Rec.FieldNo("COL EU RoHS Dir. Compliant"):
                    ItemVariant.ModifyAll("COL EU RoHS Dir. Compliant", EURoHSDirCompliant, true);
                Rec.FieldNo("COL EU REACH Reg. Compliant"):
                    ItemVariant.ModifyAll("COL EU REACH Reg. Compliant", EUREACHRegCompliant, true);
            end;
        end else begin
            Item.Get(Rec."Item No.");
            case FieldNo of
                Rec.FieldNo("COL EU RoHS Status"):
                    Item."COL EU RoHS Status" := EURoHSStatus;
                Rec.FieldNo("COL EU RoHS Dir. Compliant"):
                    Item."COL EU RoHS Dir. Compliant" := EURoHSDirCompliant;
                Rec.FieldNo("COL EU REACH Reg. Compliant"):
                    Item."COL EU REACH Reg. Compliant" := EUREACHRegCompliant;
            end;
            Item.Modify(true);
        end;
    end;

    procedure COL_SkuPreventNegativeInventory(): Boolean
    var
        InventorySetup: Record "Inventory Setup";
    begin
        case "COL SKU Prevent Negative Inv." of
            "COL SKU Prevent Negative Inv."::Yes:
                exit(true);
            "COL SKU Prevent Negative Inv."::No:
                exit(false);
            "COL SKU Prevent Negative Inv."::Default:
                begin
                    InventorySetup.Get();
                    exit(InventorySetup."COL SKU Prevent Negative Inv.");
                end;
        end;
    end;

    procedure COLGetQtyInPlanningWorksheet(): Decimal
    var
        ItemInPlanning: Query "COL Item In Planning";
        TotalQty: Decimal;
    begin
        ItemInPlanning.SetRange(ItemNo, Rec."Item No.");
        ItemInPlanning.SetRange(Variant_Code, Rec."Variant Code");
        ItemInPlanning.Open();
        while ItemInPlanning.Read() do
            TotalQty += ItemInPlanning.Quantity;

        ItemInPlanning.Close();
        exit(TotalQty);
    end;

    procedure COLDrillDownQtyInPlanningWorksheet()
    var
        TempRequisitionLine: Record "Requisition Line" temporary;
        LineNo: Integer;
    begin
        COLCalcVariant(Rec."Item No.", Rec."Variant Code", TempRequisitionLine, LineNo);
        Page.Run(Page::"Requisition Lines", TempRequisitionLine);
    end;

    local procedure COLCalcVariant(pItemNo: Code[20]; pVariantCode: Code[10]; var TempRequisitionLine: Record "Requisition Line"; var LineNo: Integer)
    var
        ItemInPlanning: Query "COL Item In Planning";
    begin
        ItemInPlanning.SetRange(ItemNo, pItemNo);
        if pVariantCode <> '' then
            ItemInPlanning.SetRange(Variant_Code, pVariantCode)
        else
            ItemInPlanning.SetFIlter(Variant_Code, '=%1', ''); // empty variant code

        ItemInPlanning.Open();
        while ItemInPlanning.Read() do begin
            LineNo += 10000;
            TempRequisitionLine.Init();
            TempRequisitionLine."Worksheet Template Name" := ItemInPlanning.Worksheet_Template_Name;
            TempRequisitionLine."Journal Batch Name" := ItemInPlanning.Journal_Batch_Name;
            TempRequisitionLine."Line No." := LineNo;
            TempRequisitionLine.Type := ItemInPlanning.Type;
            TempRequisitionLine."No." := ItemInPlanning.ItemNo;
            TempRequisitionLine.Description := ItemInPlanning.Description;
            TempRequisitionLine.Quantity := ItemInPlanning.Quantity;
            TempRequisitionLine."Location Code" := ItemInPlanning.Location_Code;
            TempRequisitionLine."Unit of Measure Code" := ItemInPlanning.Unit_of_Measure_Code;
            TempRequisitionLine."Variant Code" := ItemInPlanning.Variant_Code;
            TempRequisitionLine.Insert(false);
        end;
        ItemInPlanning.Close();
    end;
}
