namespace Weibel.Manufacturing.Order;

using Microsoft.Manufacturing.Document;

pageextension 70139 "COL Change Prod. Order Status" extends "Change Production Order Status"
{
    layout
    {
        addlast(General)
        {
            group("COL COLFilter")
            {
                Caption = 'Order Filter';
                field("COL Show No Remaining Qty."; ShowNoRemainingQtyAndOutput)
                {
                    Caption = 'Show No Remaining Quantity & Output';
                    ToolTip = 'Filter to show only production orders with no remaining quantity and no remaining output';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        FilterOnRemainingQtyAndOutput();
                        CurrPage.Update();
                    end;

                }
                field("COL Show Capacity Ledger Entries Exist"; ShowCapacityLedgerEntriesExist)
                {
                    Caption = 'Show Capacity Ledger Entries Exist';
                    ToolTip = 'Filter to show only production orders with capacity ledger entries';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        FilterOnCapacityLedgerEntries();
                        CurrPage.Update();
                    end;
                }
            }
        }
        addlast(Control1)
        {
            field("COL Remaining Quantity"; Rec."COL Remaining Quantity")
            {
                ApplicationArea = All;
            }
            field("COL Capacity Ledger Entries"; Rec."COL Capacity Ledger Entries")
            {
                ApplicationArea = All;
            }
        }
    }

    var
        ShowNoRemainingQtyAndOutput, ShowCapacityLedgerEntriesExist : Boolean;

    local procedure FilterOnRemainingQtyAndOutput()
    begin
        if ShowNoRemainingQtyAndOutput then begin
            Rec.SetRange("COL Remaining Quantity", false);
            Rec.SetRange("COL Remaining Output", false);
        end
        else begin
            Rec.SetRange("COL Remaining Quantity");
            Rec.SetRange("COL Remaining Output");
        end;
    end;

    local procedure FilterOnCapacityLedgerEntries()
    begin
        if ShowCapacityLedgerEntriesExist then
            Rec.SetRange("COL Capacity Ledger Entries", true)
        else
            Rec.SetRange("COL Capacity Ledger Entries");
    end;
}