namespace Weibel.Finance.GeneralLedger.Ledger;

using Microsoft.Finance.GeneralLedger.Ledger;

pageextension 70238 "COL G/L Entries Preview" extends "G/L Entries Preview"
{
    layout
    {
        addlast(Control1)
        {
#pragma warning disable AA0218
            // standard fields, no custom tooltips created
            field("COL Source Type"; Rec."Source Type")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("COL Source No."; Rec."Source No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
#pragma warning restore AA0218
            field("COL Source Name"; Rec."COL Source Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}