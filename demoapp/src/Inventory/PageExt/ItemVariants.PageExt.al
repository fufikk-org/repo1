namespace Weibel.Inventory.Item;

using Microsoft.Inventory.Item;

pageextension 70152 "COL Item Variants" extends "Item Variants"
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
        addlast(Control1)
        {
            field("COL EU RoHS Dir. Compliant"; Rec."COL EU RoHS Dir. Compliant")
            {
                ApplicationArea = All;
            }
            field("COL EU RoHS Status"; Rec."COL EU RoHS Status")
            {
                ApplicationArea = All;
            }
            field("COL EU REACH Reg. Compliant"; Rec."COL EU REACH Reg. Compliant")
            {
                ApplicationArea = All;
            }
            field("COL Changed By"; Rec."COL Changed By")
            {
                ApplicationArea = All;
            }
            field("COL Date Changed"; Rec."COL Date Changed")
            {
                ApplicationArea = All;
            }
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
            action("COL Item Variant Change Log")
            {
                ApplicationArea = All;
                Caption = 'Item Variant Change Log';
                ToolTip = 'View comments and change reasons for blocking fields.';
                Image = Notes;
                RunObject = Page "COL Item Variant Comments";
                RunPageLink = "Item No." = field("Item No."), "Variant Code" = field("Code");
            }
        }
    }
}