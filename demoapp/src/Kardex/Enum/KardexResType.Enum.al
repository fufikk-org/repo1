namespace Weibel.Kardex;

enum 70120 "COL Kardex Res. Type"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; PickingOrderDone)
    {
        Caption = 'PickingOrderDone';
    }
    value(2; PickingLineDone)
    {
        Caption = 'PickingLineDone';
    }
    value(3; PickingLineProgress)
    {
        Caption = 'PickingLineProgress';
    }
    value(4; StoringOrderDone)
    {
        Caption = 'StoringOrderDone';
    }
    value(5; StoringLineDone)
    {
        Caption = 'StoringLineDone';
    }
    value(6; StoringLineProgress)
    {
        Caption = 'StoringLineProgress';
    }
    value(7; InventoryCorrection)
    {
        Caption = 'InventoryCorrection';
    }
    value(8; ItemInventoryResult)
    {
        Caption = 'ItemInventoryResult';
    }
    value(9; StockBalanceResult)
    {
        Caption = 'StockBalanceResult';
    }
    value(10; DeletePickingOrder)
    {
        Caption = 'DeletePickingOrder';
    }
    value(11; DeleteStoringOrder)
    {
        Caption = 'DeleteStoringOrder';
    }
}
