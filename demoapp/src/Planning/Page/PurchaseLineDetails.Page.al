namespace Weibel.Purchases.Document;

using Microsoft.Purchases.Document;
using Microsoft.Inventory.Item;

page 70132 "COL Purchase Line Details"
{
    ApplicationArea = All;
    Caption = 'Purchase Line Details';
    PageType = ListPart;
    SourceTable = "Purchase Line";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            // field("Promised Receipt Date"; PromisedReceiptDate)
            // {
            //     Editable = false;
            //     Caption = 'Promised Receipt Date';
            //     ToolTip = 'Specifies the date that the vendor has promised to deliver the order.';
            // }
            // repeater(Dates)
            // {
            //     field("Promised Receipt Date2"; PromisedReceiptDate)
            //     {
            //         Editable = false;
            //         Caption = 'Promised Receipt Date';
            //         ToolTip = 'Specifies the date that the vendor has promised to deliver the order.';
            //                             trigger OnDrillDown()
            // begin
            //     OpenRelated();
            //end;
            //     }
            // }
            repeater(General)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ToolTip = 'Specifies the type of document that you are about to create.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the type of document that you are about to create.';

                    trigger OnDrillDown()
                    begin
                        OpenRelated();
                    end;
                }
                field("Promised Receipt Date"; PromisedReceiptDate)
                {
                    Editable = false;
                    Caption = 'Promised Receipt Date';
                    ToolTip = 'Specifies the date that the vendor has promised to deliver the order.';

                    trigger OnDrillDown()
                    begin
                        OpenRelated();
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the quantity of the purchase order line.';
                    trigger OnDrillDown()
                    begin
                        OpenRelated();
                    end;
                }
                field("COLG Out. Qty. on Lines"; OutQty)
                {
                    DecimalPlaces = 0 : 5;
                    Editable = false;
                    BlankZero = true;
                    Caption = 'Outstanding Qty. on Order Lines';
                    ToolTip = 'Specifies the outstanding quantity of the purchase line.';
                    trigger OnDrillDown()
                    begin
                        OpenRelated();
                    end;
                }
                field(OutQuantity; Rec."Outstanding Quantity")
                {
                    ToolTip = 'Specifies the outstanding quantity of the purchase order line.';
                    trigger OnDrillDown()
                    begin
                        OpenRelated();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OutQty := 0;
        Rec.CalcFields("COLG Out. Qty. on Lines");
        if Rec."Document Type" = Rec."Document Type"::"Blanket Order" then
            OutQty := Rec.Quantity - Rec."COLG Out. Qty. on Lines";

        PromisedReceiptDate := Rec."Promised Receipt Date";
    end;

    var
        PromisedReceiptDate: Date;
        OutQty: Decimal;

    procedure SetOrder(DocNo: Code[20]; RefLine: Integer)
    var
        PurchaseLine: Record "Purchase Line";
    begin
        PromisedReceiptDate := 0D;
        if PurchaseLine.Get(PurchaseLine."Document Type"::Order, DocNo, RefLine) then
            PromisedReceiptDate := PurchaseLine."Promised Receipt Date";
    end;

    local procedure OpenRelated()
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseOrder: Page "Purchase Order";
        BlanketPurchaseOrder: Page "Blanket Purchase Order";
    begin
        if PurchaseHeader.Get(rec."Document Type", Rec."Document No.") then
            if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
                PurchaseOrder.SetRecord(PurchaseHeader);
                PurchaseOrder.Run();
            end
            else begin
                BlanketPurchaseOrder.SetRecord(PurchaseHeader);
                BlanketPurchaseOrder.Run();
            end;
    end;
}
