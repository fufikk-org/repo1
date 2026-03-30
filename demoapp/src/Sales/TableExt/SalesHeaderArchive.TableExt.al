namespace Weibel.Sales.Archive;

using Microsoft.Sales.Archive;
using Weibel.Foundation.FinanceCategory;
using Weibel.Foundation.SalesOrderCategory;

tableextension 70130 "COL Sales Header Archive" extends "Sales Header Archive"
{
    fields
    {
        field(70136; "COL Sales Finance Category"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Finance Category';
            ToolTip = 'Specifies the value of the sales finance category code.';
            TableRelation = "COL Sales Finance Category";
        }
        field(70137; "COL Sales Order Category"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Order Category';
            ToolTip = 'Specifies the value of the sales order category code.';
            TableRelation = "COL Sales Order Category";
        }
    }

    keys
    {
        key(COL_1; "COL Sales Finance Category") { }
        key(COL_2; "COL Sales Order Category") { }
    }
}
