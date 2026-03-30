namespace Weibel.Inventory.Item;

// note: the values for enums start with 10 not with 0, otherwise the filtering on item list doesn't work
// for some reason, when enum id, value and caption somehow match the filtering doesn't work

enum 70111 "COL Moisture Sensitivity Level"
{
    Extensible = true;
    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(10; "1")
    {
        Caption = '1', Locked = true;
    }
    value(11; "2")
    {
        Caption = '2', Locked = true;
    }
    value(12; "2a")
    {
        Caption = '2a', Locked = true;
    }
    value(13; "3")
    {
        Caption = '3', Locked = true;
    }
    value(14; "4")
    {
        Caption = '4', Locked = true;
    }
    value(15; "5")
    {
        Caption = '5', Locked = true;
    }
    value(16; "5a")
    {
        Caption = '5a', Locked = true;
    }
    value(17; "6")
    {
        Caption = '6', Locked = true;
    }
}
