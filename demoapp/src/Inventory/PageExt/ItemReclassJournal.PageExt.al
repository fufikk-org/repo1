namespace Weibel.Inventory.Journal;

using Microsoft.Inventory.Journal;
using Weibel.Kardex;

pageextension 70259 "COL Item Reclass. Journal" extends "Item Reclass. Journal"
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
    }

    actions
    {
        addafter("Bin Contents")
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
                    KardexMgt.SendFileFromItemReclassJrnl(Rec);
                end;
            }
        }

        addafter("&Print_Promoted")
        {
            actionref("COL Create Kardex Msg_Promoted"; "COL Create Kardex Msg") { }
        }
    }
}
