namespace Weibel.Manufacturing.Document;

using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Item;

pageextension 70200 "COL Prod.Order Comp. Line List" extends "Prod. Order Comp. Line List"
{
    layout
    {
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
            field("COL Source Item Variant Code"; SourceItemVariantCode)
            {
                ApplicationArea = All;
                Caption = 'Source Variant Code';
                Editable = false;
                ToolTip = 'Specifies the source item variant code for the component.';
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
        addafter("Remaining Quantity")
        {
#pragma warning disable AA0218
            // this is a standard field, no custom tooltip added
            field("COL Qty. Picked"; Rec."Qty. Picked")
#pragma warning restore AA0218
            {
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        this.SetSourceItem();
    end;

    var
        SourceItemNo: Code[20];
        SourceItemDescription: Text[100];
        SourceItemVariantCode: Code[10];

    internal procedure SetSourceItem()
    var
        ProductionOrder: Record "Production Order";
    begin
        SourceItemNo := '';
        SourceItemVariantCode := '';
        SourceItemDescription := '';

        if not ProductionOrder.Get(Rec.Status, Rec."Prod. Order No.") then
            exit;

        if ProductionOrder."Source Type" <> ProductionOrder."Source Type"::Item then
            exit;

        SourceItemNo := ProductionOrder."Source No.";
        SourceItemDescription := ProductionOrder."Description";
        SourceItemVariantCode := ProductionOrder."Variant Code";
    end;
}