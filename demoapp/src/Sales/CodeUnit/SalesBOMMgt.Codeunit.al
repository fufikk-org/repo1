namespace Weibel.Sales.Document;

using Microsoft.Sales.Document;
using Microsoft.Sales.Setup;

codeunit 70144 "COL Sales BOM Mgt."
{
    procedure AddBomItem(var ToSalesLine: Record "Sales Line"; FromSalesLine: Record "Sales Line")
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        if not SalesReceivablesSetup.Get() then
            SalesReceivablesSetup.Init();

        SalesReceivablesSetup.TestField("COL Assembly Explode Item No.");

        ToSalesLine := FromSalesLine;
        ToSalesLine.Init();
        ToSalesLine.Type := ToSalesLine.Type::Item;
        ToSalesLine.Validate("No.", SalesReceivablesSetup."COL Assembly Explode Item No.");
        ToSalesLine.Description := FromSalesLine.Description;
        ToSalesLine."Description 2" := FromSalesLine."Description 2";
        ToSalesLine.Validate("Quantity", FromSalesLine.Quantity);
        ToSalesLine.Validate("Unit Price", FromSalesLine."Unit Price");
        ToSalesLine.Validate("Posting Group", FromSalesLine."Posting Group");
        ToSalesLine.Validate("Gen. Bus. Posting Group", FromSalesLine."Gen. Bus. Posting Group");
        ToSalesLine.Validate("Gen. Prod. Posting Group", FromSalesLine."Gen. Prod. Posting Group");
        ToSalesLine.Validate("VAT Bus. Posting Group", FromSalesLine."VAT Bus. Posting Group");
        ToSalesLine.Validate("VAT Prod. Posting Group", FromSalesLine."VAT Prod. Posting Group");
        ToSalesLine.Modify();
    end;

    procedure CheckReleaseSalesDoc(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        BomNotExplodedErr: Label 'Cannot release order, item %1 has not been exploded.', Comment = '%1 = item no.';
    begin
        if not (SalesHeader."Document Type" in [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice]) then
            exit;

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange("Type", SalesLine.Type::Item);
        SalesLine.SetAutoCalcFields("COL Assembly BOM");
        if SalesLine.FindSet() then
            repeat
                if SalesLine."COL Assembly BOM" then
                    Error(BomNotExplodedErr, SalesLine."No.");
            until SalesLine.Next() = 0;
    end;
}
