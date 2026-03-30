namespace Weibel.Sales.Document;

using Microsoft.Sales.Document;

query 70103 "COL Count Sales Orders"
{
    Caption = 'Count Sales Orders';
    DataAccessIntent = ReadOnly;

    elements
    {
        dataitem(Sales_Header; "Sales Header")
        {
            DataItemTableFilter = "Document Type" = const(Order);
            filter(SalesFinanceCategory; "COL Sales Finance Category")
            {
            }
            column(Count_Orders)
            {
                Method = Count;
            }
        }
    }
}

