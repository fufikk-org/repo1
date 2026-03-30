namespace Weibel.Sales.Document;

enum 70117 "COL Resp. Group Option"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; IP)
    {
        Caption = 'IP', Locked = true;
    }
    value(2; OD)
    {
        Caption = 'OD', Locked = true;
    }
    value(3; "IP+OD")
    {
        Caption = 'IP+OD', Locked = true;
    }
    value(4; CS)
    {
        Caption = 'CS', Locked = true;
    }
}
