codeunit 70152 "COL Item Variant Table Events"
{
    [EventSubscriber(ObjectType::Table, Database::"Item Variant", OnAfterModifyEvent, '', false, false)]
    local procedure ItemVariant_OnAfterModifyEvent(var Rec: Record "Item Variant"; var xRec: Record "Item Variant")
    var
        ItemVariantPLCChngLog: Record "COL Item Variant PLC Chng. Log";
        IsHandled: Boolean;
    begin
        Clear(IsHandled);
        OnBeforeCheckChangeInProductLifeCycle(Rec, xRec, IsHandled);
        if IsHandled then
            exit;

        if Rec."COL Product Life Cycle" <> xRec."COL Product Life Cycle" then begin
            Rec."COL Changed By" := CopyStr(UserId(), 1, MaxStrLen(Rec."COL Changed By"));
            Rec."COL Date Changed" := Today();
            Rec.Modify();

            ItemVariantPLCChngLog.Init();
            ItemVariantPLCChngLog."Item No." := Rec."Item No.";
            ItemVariantPLCChngLog."Variant Code" := Rec."Code";
            ItemVariantPLCChngLog."Old PLC" := xRec."COL Product Life Cycle";
            ItemVariantPLCChngLog."New PLC" := Rec."COL Product Life Cycle";
            ItemVariantPLCChngLog."Changed By" := CopyStr(UserId(), 1, MaxStrLen(Rec."COL Changed By"));
            ItemVariantPLCChngLog."Date Changed" := CurrentDateTime();
            ItemVariantPLCChngLog.Insert(true);
        end
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Variant", OnAfterOnDelete, '', false, false)]
    local procedure "Item Variant_OnAfterOnDelete"(ItemVariant: Record "Item Variant")
    var
        ItemVariantPLCChngLog: Record "COL Item Variant PLC Chng. Log";
    begin
        ItemVariantPLCChngLog.SetRange("Item No.", ItemVariant."Item No.");
        ItemVariantPLCChngLog.SetRange("Variant Code", ItemVariant."Code");
        ItemVariantPLCChngLog.DeleteAll(true);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Item Variant", 'OnBeforeInsertEvent', '', false, false)]
    local procedure RunOnBeforeInsertEvent(var Rec: Record "Item Variant")
    var
        Item: Record Item;
    begin
        if Rec."Item No." = '' then
            exit;
        Item.SetLoadFields("COL EU RoHS Status", "COL EU RoHS Dir. Compliant", "COL EU REACH Reg. Compliant");
        if Item.Get(Rec."Item No.") then begin
            Rec."COL EU RoHS Status" := Item."COL EU RoHS Status";
            Rec."COL EU RoHS Dir. Compliant" := Item."COL EU RoHS Dir. Compliant";
            Rec."COL EU REACH Reg. Compliant" := Item."COL EU REACH Reg. Compliant";
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckChangeInProductLifeCycle(var ItemVariant: Record "Item Variant"; var xItemVariant: Record "Item Variant"; var IsHandled: Boolean)
    begin
    end;
}
