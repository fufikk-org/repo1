namespace Weibel.Warehouse.Activity;

using Microsoft.Warehouse.Activity;
using Weibel.Inventory.Item;
using Weibel.Kardex;
using Weibel.Warehouse.Structure;

pageextension 70255 "COL Warehouse Put-away" extends "Warehouse Put-away"
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
        addafter(Control1901796907)
        {
            part(COL_BinContents; "COL Bin Content FactBox")
            {
                Editable = false;
                ApplicationArea = Warehouse;
                Provider = WhseActivityLines;
                SubPageLink = "Item No." = field("Item No."), "Variant Code" = field("Variant Code");
                Visible = true;
            }
        }
    }

    actions
    {
        addafter("Autofill Qty. to Handle")
        {
            action("COL Print Label")
            {
                ApplicationArea = All;
                Caption = 'Print Weibel Item Label';
                Image = Print;
                ToolTip = 'Print Label for selected line.';

                trigger OnAction()
                var
                    WeibelItemODCLabel: Report "COL Weibel Item ODC Label";
                begin
                    WeibelItemODCLabel.InitFrom(Rec);
                    WeibelItemODCLabel.RunModal();
                end;
            }
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

        addafter("Registered Put-aways_Promoted")
        {
            actionref("COL Print Label_Promoted"; "COL Print Label")
            {
            }
            actionref("COL Send To Kardex_Promoted"; "COL Send To Kardex")
            {
            }
        }
    }
}