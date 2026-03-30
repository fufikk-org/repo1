namespace Weibel.Manufacturing.Document;

using Weibel.Common;
using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Item;
using Microsoft.Warehouse.Structure;

pageextension 70166 "COL Prod. Order Components" extends "Prod. Order Components"
{
    layout
    {
        modify("Item No.")
        {
            ShowMandatory = true;
            trigger OnBeforeValidate()
            begin
                if xRec."Item No." <> '' then
                    if Rec."Item No." = '' then
                        Error(ItemNoErr);
            end;
        }
        addafter("Location Code")
        {
            field("COL Source Item No"; SourceItemNo)
            {
                ApplicationArea = All;
                Caption = 'Source Item No.';
                Editable = false;
                ToolTip = 'Specifies the source item number for the component.';

                trigger OnDrillDown()
                var
                    Item: Record Item;
                begin
                    if Item.Get(SourceItemNo) then
                        Page.RunModal(Page::"Item Card", Item);
                end;
            }
            field("COL Source Item Description"; SourceItemDescription)
            {
                ApplicationArea = All;
                Caption = 'Source Item Description';
                Editable = false;
                ToolTip = 'Specifies the source item variant code for the component.';
            }
            field("COL Default Bin Code"; Rec."COL Default Bin Code")
            {
                ApplicationArea = All;
            }
            field("COL Fixed Bin Code"; Rec."COL Fixed Bin Code")
            {
                ApplicationArea = All;
            }

        }
        addafter(Position)
        {
            field("COL Position"; Rec."COL Position")
            {
                ApplicationArea = All;
            }
            field("COL Position 3"; Rec."COL Position 3")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
        addafter("Location Code")
        {
            field("COL Zone Code"; GetZoneCodeFromBin())
            {
                Editable = false;
                Caption = 'Zone Code';
                ToolTip = 'Specifies zone code from selected bin.';
                ApplicationArea = All;
                Visible = false;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if Rec."Item No." = '' then
            Error(ItemNoErr);
    end;

    trigger OnModifyRecord(): Boolean
    var
        ProductionOrder: Record "Production Order";
        FieldSelect: Codeunit "COL Field Select Mgt";
    begin
        if not GuiAllowed() then
            exit;

        ProductionOrder.Get(Rec.Status, Rec."Prod. Order No.");
        if (ProductionOrder."COL Internal Status" = ProductionOrder."COL Internal Status"::Released) then
            FieldSelect.CheckIfModifyAllowed(Rec, xRec);
    end;

    trigger OnAfterGetRecord();
    begin
        this.SetSourceItem();
    end;

    internal procedure SetSourceItem()
    begin
        if not GetProdOrderOnce() then
            exit;

        if GlobalProductionOrder."Source Type" <> GlobalProductionOrder."Source Type"::Item then
            exit;

        SourceItemNo := GlobalProductionOrder."Source No.";
        SourceItemDescription := GlobalProductionOrder."Description";
    end;

    var
        GlobalProductionOrder: Record "Production Order";
        BinZoneDict: Dictionary of [Code[30], Code[10]];
        SourceItemNo: Code[20];
        SourceItemDescription: Text[100];
        RecordHasBeenRead: Boolean;
        ItemNoErr: Label 'Item No. field cannot be left blank, please enter a value or delete line.';

    local procedure GetZoneCodeFromBin(): Code[10]
    var
        Bin: Record Bin;
        DictKey: Code[30];
        ZoneCode: Code[10];
    begin
        if (Rec."Location Code" = '') or (Rec."Bin Code" = '') then
            exit('');

        DictKey := Rec."Location Code" + Rec."Bin Code";
        if BinZoneDict.Get(DictKey, ZoneCode) then
            exit(ZoneCode);

        Bin.ReadIsolation := IsolationLevel::ReadUncommitted;
        Bin.SetLoadFields("Zone Code");
        if Bin.Get(Rec."Location Code", Rec."Bin Code") then begin
            BinZoneDict.Add(DictKey, Bin."Zone Code");
            exit(Bin."Zone Code");
        end;
    end;

    local procedure GetProdOrderOnce(): Boolean
    begin
        if RecordHasBeenRead then
            exit(true);

        if not GlobalProductionOrder.Get(Rec.Status, Rec."Prod. Order No.") then
            exit(false);

        RecordHasBeenRead := true;
        exit(true)
    end;
}
