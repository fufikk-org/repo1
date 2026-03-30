namespace Weibel.Inventory.Item;

using Microsoft.Inventory.Item;

codeunit 70230 "COL Inventory Blocking Mgt."
{
    var
        BlockingReasonErr: Label 'Reason message can''t be empty.';


    [EventSubscriber(ObjectType::Table, Database::"Item", 'OnAfterValidateEvent', 'Blocked', true, true)]
    local procedure OnAfterModifyItem(var Rec: Record "Item"; var xRec: Record "Item")
    begin
        if Rec.IsTemporary then
            exit;

        if not GuiAllowed() then
            exit;

        if Rec."COL Silent Mode" then
            exit;

        if (Rec.Blocked <> xRec.Blocked) then
            if Rec.Blocked then
                DoBlock(Rec)
            else
                DoUnBlock(Rec);

    end;

    local procedure DoBlock(var Rec: Record "Item")
    var
        ItemVariant: Record "Item Variant";
        ReasonText: Text[80];
        BlockedWarningQst: Label 'All related Variants will be blocked.';

    begin
        ItemVariant.SetRange("Item No.", Rec."No.");
        ItemVariant.SetRange("Blocked", false);
        if ItemVariant.IsEmpty() then
            exit;

        if GuiAllowed() then
            if not Confirm(BlockedWarningQst, true) then
                Error('');

        if GuiAllowed() then
            ReasonText := GetReasonFromDialog(true, false);

        if ReasonText = '' then
            Error(BlockingReasonErr);

        ItemVariant.SetRange("Blocked");
        if ItemVariant.FindSet() then
            repeat
                if not ItemVariant.Blocked then begin
                    ItemVariant."COL Silent Mode" := true;
                    ItemVariant.validate(Blocked, true);
                    ItemVariant.COLAddItemVariantComment(Rec.FieldName(Blocked), true, ReasonText);
                    ItemVariant."COL Silent Mode" := false;
                    ItemVariant.Modify();
                end;
            until ItemVariant.Next() = 0;
    end;

    local procedure DoUnBlock(var Rec: Record "Item")
    var
        ItemVariant: Record "Item Variant";
        ReasonText: Text[80];
        BlockedWarningQst: Label 'All related Variants will be unblocked.';
    begin
        ItemVariant.SetRange("Item No.", Rec."No.");
        ItemVariant.SetRange("Blocked", true);
        if ItemVariant.IsEmpty() then
            exit;

        if GuiAllowed() then
            if not Confirm(BlockedWarningQst, true) then
                Error('');

        if GuiAllowed() then
            ReasonText := GetReasonFromDialog(false, false);

        if ReasonText = '' then
            Error(BlockingReasonErr);

        ItemVariant.SetRange("Blocked");
        if ItemVariant.FindSet() then
            repeat
                if ItemVariant.Blocked then begin
                    ItemVariant."COL Silent Mode" := true;
                    ItemVariant.validate(Blocked, false);
                    ItemVariant.COLAddItemVariantComment(Rec.FieldName(Blocked), false, ReasonText);
                    ItemVariant."COL Silent Mode" := false;
                    ItemVariant.Modify();
                end;
            until ItemVariant.Next() = 0;
    end;

    procedure DoUnBlock(var Rec: Record "Item Variant")
    var
        Item: Record "Item";
        ReasonText: Text[80];
        ItemUnBlockQst: Label 'Item will be Unblocked';
    begin
        if Rec.IsTemporary then
            exit;

        Item.Get(Rec."Item No.");
        if not Item.Blocked then
            exit;

        if not Confirm(ItemUnBlockQst, true) then
            Error('');

        if GuiAllowed() then
            ReasonText := GetReasonFromDialog(false, true);

        if ReasonText = '' then
            Error(BlockingReasonErr);

        Item."COL Silent Mode" := true;
        Item.validate(Blocked, false);
        Rec.COLAddItemVariantComment(Rec.FieldName(Blocked), false, ReasonText);
        Item."COL Silent Mode" := false;
        Item.Modify();
    end;

    local procedure GetReasonFromDialog(doRecBlock: Boolean; fromVariant: Boolean): Text[80]
    var
        BlockingReasonDialog: Page "COL Blocking Reason Dialog";
        ItemBlockedLbl: Label 'Item Blocked';
        ItemUnBlockedLbl: Label 'Item Unblocked';
        VariantUnBlockedLbl: Label 'Item Variant Unblocked';
    begin
        if fromVariant then
            if not doRecBlock then
                BlockingReasonDialog.SetReason(VariantUnBlockedLbl);

        if not fromVariant then
            if doRecBlock then
                BlockingReasonDialog.SetReason(ItemBlockedLbl)
            else
                BlockingReasonDialog.SetReason(ItemUnBlockedLbl);

        if BlockingReasonDialog.RunModal() = Action::OK then
            exit(BlockingReasonDialog.GetReason());

        exit('');
    end;

    procedure CheckPLC(var Rec: Record "Item Variant"; xRec: Record "Item Variant")
    var
        Item: Record "Item";
        plcBlockadeErr: Label 'Product Life Cycle must not change status. Item is Blocked';
    begin
        if Rec.IsTemporary then
            exit;

        if rec."COL Product Life Cycle" = xRec."COL Product Life Cycle" then
            exit;

        Item.Get(Rec."Item No.");
        if Item.Blocked then
            Error(plcBlockadeErr);
    end;
}
