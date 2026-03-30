namespace Weibel.Inventory.Requisition;

enum 70110 "COL Requisition Warning type"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; Emergency)
    {
        Caption = 'Emergency';
    }
    value(2; Exception)
    {
        Caption = 'Exception';
    }
    value(3; Attention)
    {
        Caption = 'Attention';
    }
}
