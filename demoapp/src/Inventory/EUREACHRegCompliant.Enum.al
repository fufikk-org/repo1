namespace Weibel.Inventory.Item;

enum 70114 "COL EU REACH Reg. Compliant"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; "No REACH Substance")
    {
        Caption = 'No REACH Substance';
    }
    value(2; "REACH Substance")
    {
        Caption = 'REACH Substance';
    }
    value(3; "Other (specify in comments)")
    {
        Caption = 'Other (specify in comments)';
    }
}
