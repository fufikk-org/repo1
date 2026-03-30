namespace Weibel.Service.Setup;

using Microsoft.Service.Setup;

enumextension 70102 "COL Report Sel. Usage Service" extends "Report Selection Usage Service"
{

    value(70100; "COL Shipment Label")
    {
        Caption = 'Shipment Label';
    }
    value(70101; "COL Pro Forma Invoice")
    {
        Caption = 'Pro Forma Invoice';
    }
}
