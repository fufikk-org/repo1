namespace Weibel.Sales.History;
using Microsoft.Sales.History;
pageextension 70266 "COL Posted Sales Inv. Update" extends "Posted Sales Inv. - Update"
{
    layout
    {
        addlast(General)
        {
            group("COL Weibel")
            {
                Caption = 'Weibel';

                field("COL Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the order number.';
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