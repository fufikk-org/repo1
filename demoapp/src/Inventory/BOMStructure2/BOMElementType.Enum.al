namespace Weibel.Inventory.BOM;

enum 70122 "COL BOM Element Type"
{
    value(0; "Item")
    {
        Caption = 'Item';
    }
    value(1; "Production BOM")
    {
        Caption = 'Production BOM';
    }
    value(2; Assembly)
    {
        Caption = 'Assembly';
    }
    value(3; "Work Center")
    {
        Caption = 'Work Center';
    }
    value(4; "Machine Center")
    {
        Caption = 'Machine Center';
    }
}
