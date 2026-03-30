namespace Weibel.Warehouse.Activity;

using Microsoft.Warehouse.Activity;
using Weibel.Inventory.Item;
using Weibel.Kardex;

pageextension 70262 "COL Inventory Put-away" extends "Inventory Put-away"
{
    layout
    {
        addlast(General)
        {
            field("COL Kardex Log No."; Rec."COL Kardex Log No.")
            {
                ApplicationArea = All;
                Editable = false;

                trigger OnDrillDown()
                var
                    KardexMgt: Codeunit "COL Kardex Mgt.";
                begin
                    KardexMgt.OpenLog(Rec."COL Kardex Log No.");
                end;
            }
        }
    }

    actions
    {
        addafter("Autofill Qty. to Handle")
        {
            action("COL Send To Kardex")
            {
                ApplicationArea = All;
                Caption = 'Send to Kardex';
                ToolTip = 'Send to Kardex system.';
                Image = SendTo;

                trigger OnAction()
                var
                    KardexMgt: Codeunit "COL Kardex Mgt.";
                begin
                    KardexMgt.SendToKardex(Rec, true);
                end;
            }
        }

        addafter("SourceDocument_Promoted")
        {
            actionref("COL Send To Kardex_Promoted"; "COL Send To Kardex")
            {
            }
        }
    }
}
