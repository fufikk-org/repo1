namespace Weibel.Manufacturing.ProductionBOM;

using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Inventory.Item;
using Weibel.Inventory.Item;
using Weibel.Manufacturing.BlockProduction;
using Microsoft.Warehouse.Structure;

tableextension 70127 "COL Production BOM Line" extends "Production BOM Line"
{
    fields
    {
        field(70100; "COL Product Life Cycle"; Enum "COL Product Life Cycle")
        {
            Caption = 'Product Life Cycle';
            Editable = false;
            ToolTip = 'Specifies product life cycle from item''s variant.';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Variant"."COL Product Life Cycle" where("Item No." = field("No."), "Code" = field("Variant Code")));
        }

        field(70101; "COL EU RoHS Dir. Compliant"; Enum "COL EU RoHS Dir. Compliant")
        {
            Caption = 'EU RoHS Directive Compliant';
            ToolTip = 'Specifies the value of the EU RoHS Directive Compliant field from related item.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Item."COL EU RoHS Dir. Compliant" where("No." = field("No.")));
            AllowInCustomizations = Never;
        }
        field(70102; "COL EU RoHS Status"; Text[20])
        {
            Caption = 'EU RoHS Status';
            ToolTip = 'Specifies the value of the EU RoHS Status field from related item.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Item."COL EU RoHS Status" where("No." = field("No.")));
            AllowInCustomizations = Never;
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
        field(70105; "COL Description 2"; Text[50])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies information in addition to the description.';
        }
        field(70106; "COL Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Item Unit Price';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies item unit price.';
        }
        field(70107; "COL Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Item Unit Cost';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies item unit cost.';
        }
        field(70108; "COL V.EU RoHS Dir. Compliant"; Enum "COL EU RoHS Dir. Compliant")
        {
            Caption = 'EU RoHS Directive Compliant';
            ToolTip = 'Specifies the value of the EU RoHS Directive Compliant field from related item.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Item Variant"."COL EU RoHS Dir. Compliant" where("Item No." = field("No."), Code = field("Variant Code")));
            AllowInCustomizations = Never;
        }
        field(70109; "COL V.EU RoHS Status"; Text[20])
        {
            Caption = 'EU RoHS Status';
            ToolTip = 'Specifies the value of the EU RoHS Status field from related item.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Item Variant"."COL EU RoHS Status" where("Item No." = field("No."), Code = field("Variant Code")));
            AllowInCustomizations = Never;
        }
        field(70110; "COL EU REACH Reg. Compliant"; Enum "COL EU REACH Reg. Compliant")
        {
            Caption = 'EU Reach Regulation Compliant';
            Editable = false;
            ToolTip = 'Specifies EU REACH Regulation Compliant from item''s variant.';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Variant"."COL EU REACH Reg. Compliant" where("Item No." = field("No."), "Code" = field("Variant Code")));
        }
        field(70111; "COL Default Bin Code"; Code[20])
        {
            Caption = 'Default Bin Code';
            Editable = false;
            ToolTip = 'Specifies Default Bin Code from item''s variant.';
            FieldClass = FlowField;
            CalcFormula = lookup("Bin Content"."Bin Code" where("Default" = const(true), "Item No." = field("No."), "Variant Code" = field("Variant Code")));
        }
        field(70112; "COL Fixed Bin Code"; Code[20])
        {
            Caption = 'Fixed Bin Code';
            Editable = false;
            ToolTip = 'Specifies Fixed Bin Code from item''s variant.';
            FieldClass = FlowField;
            CalcFormula = lookup("Bin Content"."Bin Code" where("Fixed" = const(true), "Item No." = field("No."), "Variant Code" = field("Variant Code")));
        }

        modify("Quantity per")
        {
            trigger OnAfterValidate()
            begin
                CheckProductionBOMLine();
            end;
        }
        modify("Variant Code")
        {
            trigger OnAfterValidate()
            begin
                CheckProductionBOMLine();

                UpdateDescription2FromVariant();
            end;
        }
    }

    var
        BlockProductionMgt: Codeunit "COL Block Production Mgt.";

    local procedure CheckProductionBOMLine()
    var
        ProdBlockedNotification: Notification;
        ErrMsg: Text;
        NotificationIdTok: Label 'b4a4b7f2-94d2-4a96-8d74-bc18767d7330', Locked = true;
        LineBlockedForProductionMsg: Label 'Production BOM line contains an item, variant or production bom that is blocked for production. Details: %1', Comment = '%1 = error details';
    begin
        ProdBlockedNotification.Id(NotificationIdTok);
        if not BlockProductionMgt.CheckProductionBOMLine(Rec, true, ErrMsg) then begin
            ProdBlockedNotification.Message(StrSubstNo(LineBlockedForProductionMsg, ErrMsg));
            ProdBlockedNotification.Send();
        end else
            ProdBlockedNotification.Recall();
    end;

    local procedure UpdateDescription2FromVariant()
    var
        ItemVariant: Record "Item Variant";
        Item: Record Item;
    begin
        if Rec."Variant Code" = '' then
            exit;
        ItemVariant.SetLoadFields("Description 2");
        Item.SetLoadFields("Description 2");

        ItemVariant.Get("No.", "Variant Code");
        Rec."COL Description 2" := ItemVariant."Description 2";
        if Rec."COL Description 2" = '' then
            if Item.Get(Rec."No.") then
                Rec."COL Description 2" := Item."Description 2";
    end;
}
