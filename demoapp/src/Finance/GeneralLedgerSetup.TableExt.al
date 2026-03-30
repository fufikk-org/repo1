tableextension 70170 "COL General Ledger Setup" extends "General Ledger Setup"
{
    fields
    {
        field(70100; "COL Acubiz Expense URL"; Text[200])
        {
            Caption = 'Acubiz Expense URL';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the Acubiz expense URL format.';
        }
    }
}
