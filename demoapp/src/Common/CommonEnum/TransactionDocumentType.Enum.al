namespace Weibel.Common;

enum 70107 "COL Transaction Document Type"
{
    Extensible = true;

    value(0; "Sales Invoice")
    {
        Caption = 'Sales Invoice';
    }
    value(1; "Service Invoice")
    {
        Caption = 'Service Invoice';
    }
    value(2; "Sales Cr. Memo")
    {
        Caption = 'Sales Cr. Memo';
    }
}
