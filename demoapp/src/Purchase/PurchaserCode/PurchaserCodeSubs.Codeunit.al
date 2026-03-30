namespace Weibel.Purchases.Document;

using Microsoft.Purchases.Document;

codeunit 70213 "COL Purchaser Code Subs"
{
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnAfterRecreatePurchLine, '', false, false)]
    local procedure "Purchase Header_OnAfterRecreatePurchLine"(var PurchLine: Record "Purchase Line"; var TempPurchLine: Record "Purchase Line" temporary; var PurchaseHeader: Record "Purchase Header")
    begin
        if PurchLine."COL Purchaser Code" <> PurchaseHeader."Purchaser Code" then begin
            PurchLine."COL Purchaser Code" := PurchaseHeader."Purchaser Code";
            PurchLine.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", OnAfterInitHeaderDefaults, '', false, false)]
    local procedure "Purchase Line_OnAfterInitHeaderDefaults"(var PurchLine: Record "Purchase Line"; PurchHeader: Record "Purchase Header"; var TempPurchLine: Record "Purchase Line" temporary)
    begin
        PurchLine."COL Purchaser Code" := PurchHeader."Purchaser Code";
    end;
}