namespace Weibel.Inventory.Requisition;

using Microsoft.Manufacturing.Journal;
using Microsoft.Inventory.Requisition;
using Microsoft.Inventory.Item;
using Weibel.Inventory.Item;

pageextension 70107 "COL Subcontracting Worksheet" extends "Subcontracting Worksheet"
{
    layout
    {
        modify("No.")
        {
            LookupPageId = "COL Item Planning Lookup";
        }
        modify("Variant Code")
        {
            ShowMandatory = VariantCodeMandatory2;
            trigger OnLookup(var Text: Text): Boolean
            var
                ItemVariant: Record "Item Variant";
                ItemVariants: Page "Item Variants";
            begin
                if Rec.Type <> Enum::"Requisition Line Type"::Item then
                    exit;

                if Rec."No." = '' then
                    exit;

                ItemVariant.SetRange("COL Planning Blocked", false);
                ItemVariant.SetRange("Item No.", Rec."No.");
                ItemVariants.SetTableView(ItemVariant);
                ItemVariants.LookupMode := true;
                if ItemVariants.RunModal() = Action::LookupOK then begin
                    ItemVariants.GetRecord(ItemVariant);
                    Text := ItemVariant.Code;
                    exit(true);
                end;

            end;

            trigger OnAfterValidate()
            var
                Item: Record "Item";
            begin
                if Rec."Variant Code" = '' then
                    VariantCodeMandatory2 := Item.IsVariantMandatory(Rec.Type = Rec.Type::Item, Rec."No.");
            end;
        }
    }


    actions
    {
        addafter(CarryOutActionMessage)
        {
            action("COL Set All Action Messages")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Set All Action Messages';
                ToolTip = 'Set the Action Messages for all lines to True';
                Image = Approve;
                Ellipsis = true;

                trigger OnAction()
                begin
                    SetActionMessages(true);
                end;
            }
            action("COL Remove All Action Messages")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Remove All Action Messages';
                ToolTip = 'Set the Action Messages for all lines to False';
                Image = UnApply;
                Ellipsis = true;

                trigger OnAction()
                begin
                    SetActionMessages(false);
                end;
            }
        }

        addafter(CarryOutActionMessage_Promoted)
        {
            actionref("COL Set All Action Messages_Promoted"; "COL Set All Action Messages")
            {
            }
            actionref("COL Remove All Action Messages_Promoted"; "COL Remove All Action Messages")
            {
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        Item: Record Item;
    begin

        if Rec."Variant Code" = '' then
            VariantCodeMandatory2 := Item.IsVariantMandatory(Rec.Type = Rec.Type::Item, Rec."No.");
    end;

    var
        VariantCodeMandatory2: Boolean;

    local procedure SetActionMessages(NewVal: Boolean)
    var
        RequisitionLine: Record "Requisition Line";
    begin
        RequisitionLine.CopyFilters(Rec);
        RequisitionLine.SetRange("Worksheet Template Name", Rec."Worksheet Template Name");
        RequisitionLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        RequisitionLine.SetRange(Type, Rec.Type);
        if NewVal then
            RequisitionLine.SetRange("Action Message", RequisitionLine."Action Message"::New);
        if RequisitionLine.FindSet() then
            repeat
                RequisitionLine.Validate("Accept Action Message", NewVal);
                RequisitionLine.Modify(true);
            until RequisitionLine.Next() = 0;
    end;
}
