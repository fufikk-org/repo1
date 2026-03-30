namespace Weibel.Inventory.Item;

using Microsoft.Inventory.Item;
using Weibel.Common;
using Weibel.Inventory.LegacyItems;

tableextension 70124 "COL Item Variant" extends "Item Variant"
{
    fields
    {
        modify(Blocked)
        {
            trigger OnAfterValidate()
            begin
                if Rec.Blocked <> xRec.Blocked then
                    if Rec.Blocked then
                        LogComment(Rec.FieldName(Blocked), Rec.Blocked)
                    else
                        InventoryBlockingMgt.DoUnBlock(Rec);

            end;
        }
        modify("Sales Blocked")
        {
            trigger OnAfterValidate()
            begin
                if Rec."Sales Blocked" <> xRec."Sales Blocked" then
                    LogComment(Rec.FieldName("Sales Blocked"), Rec."Sales Blocked");
            end;
        }
        modify("Purchasing Blocked")
        {
            trigger OnAfterValidate()
            begin
                if Rec."Purchasing Blocked" <> xRec."Purchasing Blocked" then
                    LogComment(Rec.FieldName("Purchasing Blocked"), Rec."Purchasing Blocked");
            end;
        }
        modify("Service Blocked")
        {
            trigger OnAfterValidate()
            begin
                if Rec."Service Blocked" <> xRec."Service Blocked" then
                    LogComment(Rec.FieldName("Service Blocked"), Rec."Service Blocked");
            end;
        }

        field(70100; "COL Product Life Cycle"; Enum "COL Product Life Cycle")
        {
            Caption = 'Product Life Cycle';
            ToolTip = 'Specifies product life cycle.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                InventoryBlockingMgt.CheckPLC(Rec, xRec);
                UpdateBlockade();
            end;
        }
        field(70101; "COL Changed By"; Code[50])
        {
            DataClassification = SystemMetadata;
            Caption = 'Changed By';
            ToolTip = 'Specifies the user who changed the product life cycle.';
            Editable = false;
        }
        field(70102; "COL Date Changed"; Date)
        {
            DataClassification = SystemMetadata;
            Caption = 'Date Changed';
            ToolTip = 'Specifies the date when the product life cycle was changed.';
            Editable = false;
        }
        field(70103; "COL Production Blocked"; Boolean)
        {
            Caption = 'Production Blocked';
            ToolTip = 'Specifies whether the item is blocked for production.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Rec."COL Production Blocked" <> xRec."COL Production Blocked" then
                    LogComment(Rec.FieldName("COL Production Blocked"), Rec."COL Production Blocked");
            end;
        }
        field(70104; "COL Project Blocked"; Boolean)
        {
            Caption = 'Project Blocked';
            ToolTip = 'Specifies whether the item is blocked for project.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Rec."COL Project Blocked" <> xRec."COL Project Blocked" then
                    LogComment(Rec.FieldName("COL Project Blocked"), Rec."COL Project Blocked");
            end;
        }
        field(70105; "COL Planning Blocked"; Boolean)
        {
            Caption = 'Planning Blocked';
            ToolTip = 'Specifies whether the item is blocked for planning.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Rec."COL Planning Blocked" <> xRec."COL Planning Blocked" then
                    LogComment(Rec.FieldName("COL Planning Blocked"), Rec."COL Planning Blocked");
            end;
        }
        field(70106; "COL Legacy Item No."; Code[20])
        {
            Caption = 'Legacy Item No.';
            ToolTip = 'Specifies legacy item no. for current combination of item no. and variant code.';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("COL Legacy Item"."NAV Item No." where("Item No." = field("Item No."), "Variant Code" = field(Code)));
        }

        field(70110; "COL EU RoHS Dir. Compliant"; Enum "COL EU RoHS Dir. Compliant")
        {
            Caption = 'EU RoHS Directive Compliant';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the value of the EU RoHS Directive Compliant field.';
        }
        field(70111; "COL EU REACH Reg. Compliant"; Enum "COL EU REACH Reg. Compliant")
        {
            Caption = 'EU REACH Regulation Compliant';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the value of the EU REACH Regulation Compliant field.';
        }
        field(70112; "COL EU RoHS Status"; Text[20])
        {
            Caption = 'EU RoHS Status';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the value of the EU RoHS Status field.';
        }
        field(70113; "COL Silent Mode"; Boolean) // to not display reason code
        {
            Caption = 'Silent Mode';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies whether the item variant is in silent mode. Silent mode is used to exclude item variants from being blocked by product life cycle code changes.';
        }
    }

    var
        InventoryBlockingMgt: Codeunit "COL Inventory Blocking Mgt.";

    local procedure UpdateBlockade()
    var
        PLCCodeMatrix: Record "COL PLC Code Matrix";
    begin
        if Rec."COL Product Life Cycle" = xRec."COL Product Life Cycle" then
            exit;

        if PLCCodeMatrix.Get(Rec."COL Product Life Cycle") then begin
            Rec."COL Production Blocked" := PLCCodeMatrix."Blocked for Production";
            Rec."COL Project Blocked" := PLCCodeMatrix."Blocked for Projects";
            Rec."Sales Blocked" := PLCCodeMatrix."Blocked for Sales";
            Rec."Purchasing Blocked" := PLCCodeMatrix."Blocked for Purchase";
            Rec."Service Blocked" := PLCCodeMatrix."Blocked for Service";
            Rec."COL Planning Blocked" := PLCCodeMatrix."Blocked for Planning";
        end;
    end;

    local procedure LogComment(FieldName: Text; NewValue: Boolean)
    var
        ReasonText: Text[80];
        ValueChangedOutsideUILbl: Label 'Value changed outside UI, no reason provided.';
    begin
        if Rec."COL Silent Mode" then
            exit;

        if GuiAllowed() then
            ReasonText := GetReasonFromDialog()
        else
            ReasonText := ValueChangedOutsideUILbl;

        COLAddItemVariantComment(FieldName, NewValue, ReasonText);
    end;

    procedure COLAddItemVariantComment(FieldName: Text; NewValue: Boolean; ReasonText: Text[80]) // to add comment in batch for multiple variants with one reason, the ReasonText is passed in as parameter instead of getting reason from dialog in this procedure
    var
        ItemVariantComment: Record "COL Item Variant Comment";
    begin
        if ReasonText <> '' then begin
            ItemVariantComment.Init();
            ItemVariantComment."Item No." := Rec."Item No.";
            ItemVariantComment."Variant Code" := Rec.Code;
            ItemVariantComment."Line No." := GetNextCommentLineNo();
            ItemVariantComment.Date := Today();
            ItemVariantComment.Comment := CopyStr(ReasonText, 1, MaxStrLen(ItemVariantComment.Comment));
            ItemVariantComment."Changed By" := CopyStr(UserId(), 1, MaxStrLen(ItemVariantComment."Changed By"));
            ItemVariantComment."Field Name" := CopyStr(FieldName, 1, MaxStrLen(ItemVariantComment."Field Name"));
            ItemVariantComment."New Value" := NewValue;
            ItemVariantComment.Insert(true);
        end;
    end;

    local procedure GetReasonFromDialog(): Text[80]
    var
        BlockingReasonDialog: Page "COL Blocking Reason Dialog";
        OpCanceledErr: Label 'Operation Canceled.';
    begin
        BlockingReasonDialog.SetReason('');
        if BlockingReasonDialog.RunModal() = Action::OK then
            exit(BlockingReasonDialog.GetReason());
        Error(OpCanceledErr);
    end;

    local procedure GetNextCommentLineNo(): Integer
    var
        ItemVariantComment: Record "COL Item Variant Comment";
    begin
        ItemVariantComment.SetRange("Item No.", Rec."Item No.");
        ItemVariantComment.SetRange("Variant Code", Rec.Code);
        if ItemVariantComment.FindLast() then
            exit(ItemVariantComment."Line No." + 10000)
        else
            exit(10000);
    end;
}
