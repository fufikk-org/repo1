namespace Weibel.Service.Ledger;

using Microsoft.Service.Ledger;

pageextension 70175 "COL Service Ledger Entries" extends "Service Ledger Entries"
{
    layout
    {
        addafter("Service Item No. (Serviced)")
        {
            field("COL Export Classification"; Rec."COL Export Classification Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
