namespace Weibel.Inventory.Journal;

using Microsoft.Inventory.Journal;
using Weibel.Kardex;

pageextension 70260 "COL Item Journal" extends "Item Journal"
{
    layout
    {
        addafter(Quantity)
        {
            field("COL Kardex Quantity"; Rec."COL Kardex Quantity")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("COL Kardex Quantity To Confirm"; Rec."COL Kardex Quantity To Confirm")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = All;
            }
            field("COL Kardex Log No."; Rec."COL Kardex Log No.")
            {
                Editable = false;
                ApplicationArea = All;

                trigger OnDrillDown()
                var
                    KardexMgt: Codeunit "COL Kardex Mgt.";
                begin
                    KardexMgt.OpenLog(Rec."COL Kardex Log No.");
                end;
            }
            field("COL Logia User ID"; Rec."COL Logia User ID")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addlast(factboxes)
        {
            part(COLSKUReplenishmentFB; "COL SKU Replenishment FactBox")
            {
                ApplicationArea = Planning;
                SubPageLink = "Item No." = field("No."), "Variant Code" = field("Variant Code"), "Location Code" = field("Location Code");
                Visible = false;
            }
        }
    }

    actions
    {
        addafter("E&xplode BOM")
        {
            action("COL Create Kardex Msg")
            {
                ApplicationArea = All;
                Caption = 'Send to Kardex';
                ToolTip = 'Send to Kardex system.';
                Image = SendTo;

                trigger OnAction()
                var
                    KardexMgt: Codeunit "COL Kardex Mgt.";
                begin
                    KardexMgt.SendToKardex(Rec);
                end;
            }
        }

        addafter("E&xplode BOM_Promoted")
        {
            actionref("COL Create Kardex Msg_Promoted"; "COL Create Kardex Msg") { }
        }

    }
}