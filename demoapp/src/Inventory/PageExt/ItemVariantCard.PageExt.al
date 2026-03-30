namespace Weibel.Inventory.Item;

using Microsoft.Inventory.Item;

pageextension 70160 "COL Item Variant Card" extends "Item Variant Card"
{
    layout
    {
        addafter(Description)
        {
            field("COL Product Life Cycle"; Rec."COL Product Life Cycle")
            {
                ApplicationArea = All;
            }
        }
        addafter("Purchasing Blocked")
        {
            field("COL Production Blocked"; Rec."COL Production Blocked")
            {
                ApplicationArea = All;
            }
            field("COL Project Blocked"; Rec."COL Project Blocked")
            {
                ApplicationArea = All;
            }
            field("COL Planning Blocked"; Rec."COL Planning Blocked")
            {
                ApplicationArea = All;
            }
        }
        addafter(ItemVariant)
        {
            group("COL Item Variant PLC Changes")
            {
                Caption = 'Item Variant PLC Changes';
                field("COL Changed By"; Rec."COL Changed By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("COL Date Changed"; Rec."COL Date Changed")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
        addlast(ItemVariant)
        {
            field("COL Legacy Item No."; Rec."COL Legacy Item No.")
            {
                ApplicationArea = All;
            }
        }
        addlast(factboxes)
        {
            systempart("COLG Variant Links"; Links)
            {
                ApplicationArea = RecordLinks;
            }
        }
    }
    actions
    {
        addlast(navigation)
        {
            action("COL PLC Change Log")
            {
                ApplicationArea = All;
                Caption = 'PLC Change Log';
                ToolTip = 'View the PLC change log for the item variant.';
                Image = History;
                RunObject = Page "COL Item Variant PLC Chng. Log";
                RunPageLink = "Item No." = field("Item No."), "Variant Code" = field("Code");
            }
        }
    }
}