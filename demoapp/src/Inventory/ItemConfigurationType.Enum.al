namespace Weibel.Inventory.Item;
enum 70112 "COL Item Configuration Type"
{
    Caption = 'Item Configuration Type';

    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; "Customer Configuration Item")
    {
        Caption = 'Customer Configuration Item';
    }
    value(2; "Internal Configuration Item")
    {
        Caption = 'Internal Configuration Item';
    }
    value(3; "Non-configuration Item")
    {
        Caption = 'Non-Configuration Item';
    }
}