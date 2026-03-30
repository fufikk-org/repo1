pageextension 70271 "COL General Ledger Setup" extends "General Ledger Setup"
{
    layout
    {
        addlast(General)
        {
            group("COL Weibel")
            {
                Caption = 'Weibel';
                field("COL Acubiz Expense URL"; Rec."COL Acubiz Expense URL")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
