namespace Weibel.Shipping;

enum 70102 "COL Shipping Status"
{
    Extensible = true;
    ObsoleteReason = 'Replaced with COL Shipping Status dictionary table.';
    ObsoleteState = Pending;
    ObsoleteTag = 'WEIBEL-426-20241021';

    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; Awaiting)
    {
        Caption = 'Awaiting';
    }
    value(2; "Ready to Pack")
    {
        Caption = 'Ready to Pack';
    }
    value(3; Picked)
    {
        Caption = 'Picked';
    }
    value(4; Shipped)
    {
        Caption = 'Shipped';
    }
}
