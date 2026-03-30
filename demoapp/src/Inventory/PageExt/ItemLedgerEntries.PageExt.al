namespace Weibel.Inventory.Ledger;

using Microsoft.Inventory.Ledger;
using Weibel.Inventory.Item;

pageextension 70180 "COL Item Ledger Entries" extends "Item Ledger Entries"
{
    layout
    {
        addafter("Item No.")
        {
            field("COL Export Classification"; Rec."COL Export Classification Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }

    actions
    {
        addafter("&Navigate")
        {
            action("COL Print Cable")
            {
                ApplicationArea = All;
                Caption = 'Print Cable Label';
                Image = Print;
                ToolTip = 'Print Cable Labels';

                trigger OnAction()
                var
                    ItemLedgerEntry: Record "Item Ledger Entry";
                    CableLabel: Report "COL Cable Label2";
                begin
                    ItemLedgerEntry.CopyFilters(Rec);
                    CurrPage.SetSelectionFilter(ItemLedgerEntry);
                    CableLabel.SetData(ItemLedgerEntry);
                    CableLabel.RunModal();
                end;
            }
        }

        addlast(Category_Process)
        {
            actionref("COL Print Cable_Promoted"; "COL Print Cable") { }
        }
    }
}
