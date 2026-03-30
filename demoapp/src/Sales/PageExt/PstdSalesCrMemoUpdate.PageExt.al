namespace Weibel.Sales.History;

using Microsoft.Sales.History;
using Weibel.Foundation.FinanceCategory;
using Weibel.Foundation.SalesOrderCategory;
using Weibel.Foundation.SalesResponsibilityGroup;

pageextension 70267 "COL Pstd. Sales Cr.Memo Update" extends "Pstd. Sales Cr. Memo - Update"
{
    layout
    {
        addlast(General)
        {
            group("COL Weibel")
            {
                Caption = 'Weibel';

                field("COL Order No"; Rec."COL Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the return order number.';
                }
                field("COL Sales Finance Category"; Rec."COL Sales Finance Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sales finance category.';
                }
                field("COL Sales Order Category"; Rec."COL Sales Order Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sales order category.';
                }
                field("COL Project Name"; Rec."COL Project Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the project name.';
                }
                field("COL Sales Resp. Group"; Rec."COL Sales Resp. Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sales responsibility group.';
                }
            }
        }
    }
}