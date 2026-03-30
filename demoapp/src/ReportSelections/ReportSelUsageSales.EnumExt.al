namespace Weibel.Sales.Setup;

using Microsoft.Sales.Setup;

enumextension 70100 "COL Report Sel. Usage Sales" extends "Report Selection Usage Sales"
{

    value(70100; "COL Shipment Label")
    {
        Caption = 'Shipment Label';
    }
    value(70101; "COL IC Sales Invoice")
    {
        Caption = 'I/C Sales Invoice';
    }
}
