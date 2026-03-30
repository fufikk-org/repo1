namespace Weibel.Purchases.Document;

using Microsoft.Purchases.Document;
using Microsoft.Inventory.Item;

page 70139 "COL Promised Dates Line"
{
    ApplicationArea = All;
    Caption = 'Promised Purchase Receipt Dates';
    PageType = ListPart;
    SourceTable = "Purchase Line";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Dates)
            {
                field("Promised Receipt Date2"; PromisedReceiptDate)
                {
                    Editable = false;
                    Caption = 'Promised Receipt Date';
                    ToolTip = 'Specifies the date that the vendor has promised to deliver the order.';
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
        Rec.CalcFields("COLG Out. Qty. on Lines");
        PromisedReceiptDate := Rec."Promised Receipt Date";
    end;

    var
        PromisedReceiptDate: Date;

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
