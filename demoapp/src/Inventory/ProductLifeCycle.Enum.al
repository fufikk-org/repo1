namespace Weibel.Inventory.Item;

enum 70105 "COL Product Life Cycle"
{
    Extensible = true;

    value(0; "Not Relevant")
    {
        Caption = 'Not Relevant';
    }
    value(1; "Not Released")
    {
        Caption = 'Not Released';
    }
    value(2; Prototype)
    {
        Caption = 'Prototype';
    }
    value(3; "0-series")
    {
        Caption = '0-series';
    }
    value(4; "Standard Product")
    {
        Caption = 'Standard Product';
    }
    value(5; "Phased Out")
    {
        Caption = 'Phased Out';
    }
}
