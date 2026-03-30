namespace Weibel.Purchases.Document;

using Microsoft.Purchases.Document;
using System.Utilities;

reportextension 70108 "COL Standard Purchase - Order" extends "Standard Purchase - Order"
{
    dataset
    {
        add("Purchase Header")
        {
            column(COLNewBodyTextLbl; NewBodyTextLbl)
            { }
        }

        add("Purchase Line")
        {
            column(COLlineOrderLbl; OrderLbl)
            { }
            column(COLlineOrder; "Purchase Line"."Document No.")
            { }
            column(COLlineOutQtyLbl; "Purchase Line".FieldCaption("Outstanding Quantity"))
            { }
            column(COLlineOutQty; "Purchase Line"."Outstanding Quantity")
            { }
            column(COLlinePromRecDateLbl; ConfDateLbl)
            { }
            column(COLlinePromRecDate; "Purchase Line"."Promised Receipt Date")
            { }
            column(COLlineCommentLbl; CommentLbl)
            { }
            column(COLlineComment; CommentTxt)
            { }
        }

        modify("Purchase Line")
        {


            trigger OnBeforePreDataItem()
            begin
                if "Purchase Header"."COL Reminder Problem Exist" then
                    "Purchase Line".SetRange("COL Reminder Problem Exist", true)
                else
                    "Purchase Line".SetRange("COL Reminder Problem Exist", false);

            end;

            trigger OnBeforeAfterGetRecord()
            begin
                CommentTxt := "Purchase Line"."COL Reminder Comment";
            end;
        }
    }

    rendering
    {
        layout(COLReportLayout)
        {
            Caption = 'Order Reminder Email';
            Type = Word;
            LayoutFile = './src/Purchase/ReportLayout/PurchaseOrderReminderEmail.docx';
        }
    }

    var
        CompanyAddressIndex, CurrAddressIndex : Integer;
        CommentTxt: Text;
        OrderLbl: Label 'Order No.';
        ConfDateLbl: Label 'Confirmed Receipt Date';
        CommentLbl: Label 'Comment';
        NewBodyTextLbl: Label 'Delivery of below goods are late, please confirm new delivery date.';
}
