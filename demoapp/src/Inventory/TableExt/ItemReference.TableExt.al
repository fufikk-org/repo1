namespace Weibel.Inventory.Item;

using Microsoft.Inventory.Item.Catalog;
using Microsoft.Inventory.Item;

tableextension 70131 "COL Item Reference" extends "Item Reference"
{
    fields
    {
        field(70100; "COL Primary Item Reference"; Boolean)
        {
            Caption = 'Primary Item Reference';
            DataClassification = CustomerContent;
            ToolTip = 'Indicates whether this is the primary item reference.';

            trigger OnValidate()
            begin
                if Rec."COL Primary Item Reference" then begin
                    this.CheckPrimaryItemUniqueness();
                    this.SetItemDataFromPrimaryReference();
                end;
            end;
        }
        field(70101; "COL MSL Moisture Sens. Level"; Enum "COL Moisture Sensitivity Level")
        {
            Caption = 'MSL Moisture Sensitivity Level';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the moisture sensitivity level of the item.';
        }
        field(70102; "COL ECCN"; Text[30])
        {
            Caption = 'ECCN';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Export Control Classification Number (ECCN) for the item.';
        }
        field(70103; "COL Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the category code assigned to the item.';
        }
        field(70104; "COL Manufacturer"; Code[10])
        {
            Caption = 'Manufacturer';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the manufacturer of the item.';
        }
        field(70105; "COL MPN No."; Text[100])
        {
            Caption = 'MPN No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Manufacturer Part Number (MPN) for the item.';
        }
        field(70106; "COL Reach Cashed Source"; Text[200])
        {
            Caption = 'REACH Cashed Source';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the source of the REACH compliance information.';
        }
        field(70107; "COL Contains SVHC"; Text[20])
        {
            Caption = 'Contains SVHC';
            DataClassification = CustomerContent;
            ToolTip = 'Indicates whether the item contains Substances of Very High Concern (SVHC).';
        }
        field(70108; "COL SVHC Exceed Thr. Limit"; Text[20])
        {
            Caption = 'SVHC Exceed Threshold Limit';
            DataClassification = CustomerContent;
            ToolTip = 'Indicates whether the SVHC concentration exceeds the threshold limit.';
        }
        field(70109; "COL Substance Identification"; Text[50])
        {
            Caption = 'Substance Identification';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the identification of the substance in the item.';
        }
        field(70110; "COL Substance Location"; Text[100])
        {
            Caption = 'Substance Location';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the location of the substance in the item.';
        }
        field(70111; "COL Substance Concentration"; Text[20])
        {
            Caption = 'Substance Concentration';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the concentration of the substance in the item.';
        }
        field(70112; "COL Countries Of Origin"; Text[50])
        {
            Caption = 'Countries Of Origin';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the countries of origin for the item.';
        }
        field(70113; "COL Part Status"; Text[20])
        {
            Caption = 'Part Status';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the current status of the part.';
        }
        field(70114; "COL LTB Date"; Date)
        {
            Caption = 'LTB Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Last Time Buy (LTB) date for the item.';
        }
        field(70115; "COL RoHS Status"; Text[20])
        {
            Caption = 'RoHS Status';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Restriction of Hazardous Substances (RoHS) compliance status.';
        }
        field(70116; "COL RoHS Version"; Text[20])
        {
            Caption = 'RoHS Version';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the version of RoHS compliance for the item.';
        }
        field(70117; "COL Exemption"; Text[10])
        {
            Caption = 'Exemption';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies any exemptions applicable to the item.';
        }
        field(70118; "COL Exemption Type"; Text[350])
        {
            Caption = 'Exemption Type';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the type of exemption applicable to the item.';
        }
        field(70119; "COL Estimated EOL Date"; Text[10])
        {
            Caption = 'Estimated EOL Date';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the estimated End of Life (EOL) date for the item.';
        }
        field(70120; "COL Peak Pack. Body Temp."; Decimal)
        {
            Caption = 'Peak Package Body Temp.';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            ToolTip = 'Specifies the peak package body temperature for the item.';
        }
    }

    local procedure CheckPrimaryItemUniqueness()
    var
        ItemReference: Record "Item Reference";
        PrimaryItemReferenceErr: Label 'Only one item reference can be marked as primary for the same item and variant.';
    begin
        ItemReference.SetRange("Item No.", Rec."Item No.");
        ItemReference.SetRange("Variant Code", Rec."Variant Code");
        ItemReference.SetRange("COL Primary Item Reference", true);
        if ItemReference.IsEmpty() then
            exit;

        Error(PrimaryItemReferenceErr);
    end;

    local procedure SetItemDataFromPrimaryReference()
    var
        Item: Record Item;
        ModifyRecord: Boolean;
    begin
        if not Item.Get(Rec."Item No.") then
            exit;

        if Item.Description <> Rec.Description then begin
            Item.Validate(Description, Rec.Description);
            ModifyRecord := true;
        end;

        if Item."Manufacturer Code" <> Rec."COL Manufacturer" then begin
            Item.Validate("Manufacturer Code", Rec."COL Manufacturer");
            ModifyRecord := true;
        end;

        if Item."Item Category Code" <> Rec."COL Item Category Code" then begin
            Item.Validate("Item Category Code", Rec."COL Item Category Code");
            ModifyRecord := true;
        end;

        if Item."COL Manufacturer Item No." <> Rec."COL MPN No." then begin
            Item.Validate("COL Manufacturer Item No.", Rec."COL MPN No.");
            ModifyRecord := true;
        end;

        if Item."COL US Classification No." <> Rec."COL ECCN" then begin
            Item.Validate("COL US Classification No.", Rec."COL ECCN");
            ModifyRecord := true;
        end;

        if Item."COL Moisture Sensitivity Level" <> Rec."COL MSL Moisture Sens. Level" then begin
            Item.Validate("COL Moisture Sensitivity Level", Rec."COL MSL Moisture Sens. Level");
            ModifyRecord := true;
        end;

        if Item."COL EU RoHS Status" <> Rec."COL RoHS Status" then begin
            Item.Validate("COL EU RoHS Status", Rec."COL RoHS Status");
            ModifyRecord := true;
        end;

        if ModifyRecord then
            Item.Modify(true);
    end;
}