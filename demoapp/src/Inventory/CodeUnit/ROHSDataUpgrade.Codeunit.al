codeunit 70177 "COL ROHS Data Upgrade"
{
    Subtype = Upgrade;
    trigger OnUpgradePerCompany()
    var
        UpgradeTag: Codeunit "Upgrade Tag";
        TagLbl: Label 'COL-ROHS-250813-7365';
    begin
        //copy ROHS fields from item to variant
        if not UpgradeTag.HasUpgradeTag(TagLbl) then begin
            UpgradeRohs();
            UpgradeTag.SetUpgradeTag(TagLbl);
        end;
    end;

    local procedure UpgradeRohs()
    var
        Item: Record Item;
        ItemVariant: Record "Item Variant";
    begin
        Item.SetLoadFields("COL EU RoHS Status", "COL EU REACH Reg. Compliant", "COL EU RoHS Dir. Compliant");
        if Item.FindSet() then
            repeat
                ItemVariant.SetRange("Item No.", Item."No.");
                ItemVariant.ModifyAll("COL EU RoHS Status", Item."COL EU RoHS Status");
                ItemVariant.ModifyAll("COL EU REACH Reg. Compliant", Item."COL EU REACH Reg. Compliant");
                ItemVariant.ModifyAll("COL EU RoHS Dir. Compliant", Item."COL EU RoHS Dir. Compliant");
            until Item.Next() = 0;
    end;
}