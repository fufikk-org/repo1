namespace Weibel.Foundation.Reporting;

using Microsoft.Foundation.Reporting;

enumextension 70101 "COL Report Selection Usage" extends "Report Selection Usage"
{

    value(70100; "COL S.Shipment Label")
    {
        Caption = 'Sales Shipment Label';
    }
    value(70101; "COL SM.Shipment Label")
    {
        Caption = 'Service Shipment Label';
    }
    value(70102; "COL Pro Forma SM. Invoice")
    {
        Caption = 'Pro Forma Service Invoice';
    }
    value(70103; "COL Order - Reminder")
    {
        Caption = 'Order - Reminder';
    }
    value(70104; "COL IC Sales Invoice")
    {
        Caption = 'I/C Sales Invoice';
    }
}
