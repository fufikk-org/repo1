namespace Weibel.Finance.GeneralLedger.Ledger;

using Microsoft.Finance.GeneralLedger.Ledger;

tableextension 70160 "COL G/L Entry" extends "G/L Entry"
{
    fields
    {
        field(70100; "COL Source Name"; Text[100])
        {
            Caption = 'Source Name';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies source name.';
        }
        field(70101; "COL Acubiz Travel ID"; Text[50])
        {
            Caption = 'Acubiz Travel ID';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies Acubiz Travel ID.';
            Editable = false;
        }
    }

    keys
    {
        key(COL_1; "Source Type", "Source No.")
        {
            SqlIndex = "Source No.", "Source Type";
        }
        key(COL_2; "COL Source Name") { }
    }
}
