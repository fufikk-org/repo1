namespace Weibel.Sales.Document;

using Microsoft.Sales.Document;
using Microsoft.Utilities;
using Microsoft.Inventory.Item;

codeunit 70137 "COL Sales Line Sub"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterCopyFromItem', '', false, false)]
    local procedure OnAfterCopyFromItem(var SalesLine: Record "Sales Line"; Item: Record Item; CurrentFieldNo: Integer; xSalesLine: Record "Sales Line")
    begin
        SalesLine."COL Export Classification Code" := Item."COL Export Classification Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopySalesDocSalesLineOnBeforeFinishSalesDocSalesLine', '', false, false)]
    local procedure OnCopySalesDocSalesLineOnBeforeFinishSalesDocSalesLine(FromSalesHeader: Record "Sales Header"; var ToSalesHeader: Record "Sales Header"; var ToSalesLine: Record "Sales Line"; var FromSalesLine: Record "Sales Line"; RecalculateLines: Boolean)
    var
        Item: Record Item;
    begin
        if FromSalesLine.Type = FromSalesLine.Type::Item then begin
            Item.SetLoadFields("No.", "COL Export Classification Code");
            Item.ReadIsolation := Item.ReadIsolation::ReadCommitted;
            if Item.Get(FromSalesLine."No.") then
                ToSalesLine."COL Export Classification Code" := Item."COL Export Classification Code";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Explode BOM", 'OnBeforeToSalesLineModify', '', false, false)]
    local procedure OnBeforeToSalesLineModify(var ToSalesLine: Record "Sales Line"; FromSalesLine: Record "Sales Line")
    var
        SalesBOMMgt: Codeunit "COL Sales BOM Mgt.";
    begin
        SalesBOMMgt.AddBomItem(ToSalesLine, FromSalesLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Explode BOM", 'OnInsertOfExplodedBOMLineToSalesLine', '', false, false)]
    local procedure OnInsertOfExplodedBOMLineToSalesLine(var ToSalesLine: Record "Sales Line"; SalesLine: Record "Sales Line")
    begin
        ToSalesLine.Validate("Unit Price", 0);
    end;
}
