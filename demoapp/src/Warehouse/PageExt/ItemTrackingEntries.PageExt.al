namespace Weibel.Inventory.Tracking;

using Microsoft.Inventory.Tracking;
using Microsoft.Inventory.Ledger;
using Weibel.Inventory.Ledger;

pageextension 70195 "COL Item Tracking Entries" extends "Item Tracking Entries"
{
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
