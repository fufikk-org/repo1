namespace Weibel.Packaging;

using Microsoft.Sales.Document;
using Microsoft.Sales.Setup;
using Microsoft.Warehouse.Activity;
using Microsoft.Service.Document;
using Microsoft.Sales.History;
using Microsoft.Service.History;

codeunit 70129 "COL Package Posting Mgt."
{
    internal procedure CheckIfPackagesForDocumentExist(var SalesHeader: Record "Sales Header")
    var
        PackageDimension: Record "COL Package Dimension";
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        if not SalesHeader.Ship then
            exit;
        if not (SalesHeader."Document Type" = Enum::"Sales Document Type"::Order) then
            exit;
        SalesSetup.SetLoadFields("COL Internal Customer No.");
        SalesSetup.Get();
        if SalesHeader."Sell-to Customer No." <> SalesSetup."COL Internal Customer No." then begin
            FilterPackageDimension(PackageDimension, Enum::"Warehouse Activity Source Document"::"Sales Order", SalesHeader."No.");
            CheckPackageDimension(PackageDimension, Enum::"Warehouse Activity Source Document"::"Sales Order", SalesHeader."No.");
        end;
    end;

    internal procedure CheckIfPackagesForDocumentExist(var ServiceHeader: Record "Service Header")
    var
        PackageDimension: Record "COL Package Dimension";
    begin
        if not (ServiceHeader."Document Type" = Enum::"Service Document Type"::Order) then
            exit;
        FilterPackageDimension(PackageDimension, Enum::"Warehouse Activity Source Document"::"Service Order", ServiceHeader."No.");
        CheckPackageDimension(PackageDimension, Enum::"Warehouse Activity Source Document"::"Service Order", ServiceHeader."No.");
    end;

    local procedure FilterPackageDimension(var PackageDimension: Record "COL Package Dimension"; DocumentType: Enum "Warehouse Activity Source Document"; DocumentNo: Code[20])
    begin
        PackageDimension.Reset();
        PackageDimension.SetRange("Document Type", DocumentType);
        PackageDimension.SetRange("Document No.", DocumentNo);
    end;

    local procedure CheckPackageDimension(var PackageDimension: Record "COL Package Dimension"; DocumentType: Enum "Warehouse Activity Source Document"; DocumentNo: Code[20])
    var
        SalesLine: Record "Sales Line";
        ServiceLine: Record "Service Line";
        MissingPackagingErr: Label 'Packaging information is missing for document %1.', Comment = '%1 = order no.';
    begin
        // check if document has item lines
        case DocumentType of
            Enum::"Warehouse Activity Source Document"::"Sales Order":
                begin
                    SalesLine.SetRange("Document No.", DocumentNo);
                    SalesLine.SetRange("Document Type", Enum::"Sales Document Type"::Order);
                    SalesLine.SetRange(Type, Enum::"Sales Line Type"::Item);
                    if SalesLine.IsEmpty() then
                        exit;
                    SalesLine.SetRange("Completely Shipped", false);
                    if SalesLine.IsEmpty() then
                        exit;
                end;
            Enum::"Warehouse Activity Source Document"::"Service Order":
                begin
                    ServiceLine.SetRange("Document No.", DocumentNo);
                    ServiceLine.SetRange("Document Type", Enum::"Service Document Type"::Order);
                    ServiceLine.SetRange(Type, Enum::"Service Line Type"::Item);
                    if ServiceLine.IsEmpty() then
                        exit;
                    ServiceLine.SetRange("Completely Shipped", false);
                    if ServiceLine.IsEmpty() then
                        exit;
                end;
            else
                exit;
        end;
        if PackageDimension.IsEmpty() then
            Error(ErrorInfo.Create(StrSubstNo(MissingPackagingErr, DocumentNo), true));

        if PackageDimension.FindSet() then
            repeat
                PackageDimension.TestField("Gross Shipment Weight", ErrorInfo.Create());
                PackageDimension.TestField("Package Type Code", ErrorInfo.Create());
                PackageDimension.TestField("COL Warehouse Shipment No.", ErrorInfo.Create());
            until PackageDimension.Next() = 0;
    end;

    local procedure GetSourceLineNumbers(DestinationTableId: Integer; ShipmentDocumentNo: Code[20]; var SourceLines: List of [Integer])
    var
        SalesShipmentLine: Record "Sales Shipment Line";
        ServiceShipmentLine: Record "Service Shipment Line";
    begin
        Clear(SourceLines);
        case DestinationTableId of
            Database::"Sales Shipment Header":
                begin
                    SalesShipmentLine.SetRange("Document No.", ShipmentDocumentNo);
                    SalesShipmentLine.SetFilter(Quantity, '>0');
                    if SalesShipmentLine.FindSet() then
                        repeat
                            SourceLines.Add(SalesShipmentLine."Order Line No.");
                        until SalesShipmentLine.Next() = 0;
                end;

            Database::"Service Shipment Header":
                begin
                    ServiceShipmentLine.SetRange("Document No.", ShipmentDocumentNo);
                    ServiceShipmentLine.SetFilter(Quantity, '>0');
                    if ServiceShipmentLine.FindSet() then
                        repeat
                            SourceLines.Add(ServiceShipmentLine."Order Line No.");
                        until ServiceShipmentLine.Next() = 0;
                end;
            else
                exit;
        end;
    end;

    internal procedure TransferPackagesToPostedDocument(SourceDocumentNo: Code[20]; DestinationTableId: Integer; ShipmentDocumentNo: Code[20])
    var
        PackageDimension: Record "COL Package Dimension";
        PostedPackageDimension: Record "COL Posted Package Dimension";
        SourceLines: List of [Integer];
        SourceLine: Integer;
        PackageNo: Integer;
    begin
        case DestinationTableId of
            Database::"Sales Shipment Header":
                FilterPackageDimension(PackageDimension, Enum::"Warehouse Activity Source Document"::"Sales Order", SourceDocumentNo);
            Database::"Service Shipment Header":
                FilterPackageDimension(PackageDimension, Enum::"Warehouse Activity Source Document"::"Service Order", SourceDocumentNo);
            else
                exit;
        end;

        if PackageDimension.FindLast() then
            PackageNo := PackageDimension."Package No." + 1
        else
            PackageNo := 1;

        GetSourceLineNumbers(DestinationTableId, ShipmentDocumentNo, SourceLines);

        foreach SourceLine in SourceLines do begin

            PackageDimension.SetRange("COL Source Line", SourceLine);
            if PackageDimension.FindSet() then
                repeat
                    PostedPackageDimension.Init();
                    PostedPackageDimension."Table Id" := DestinationTableId;
                    PostedPackageDimension."Document No." := ShipmentDocumentNo;
                    PostedPackageDimension.Description := PackageDimension.Description;
                    PostedPackageDimension."Gross Shipment Weight" := PackageDimension."Gross Shipment Weight";
                    PostedPackageDimension.Height := PackageDimension.Height;
                    PostedPackageDimension.Width := PackageDimension.Width;
                    PostedPackageDimension.Length := PackageDimension.Length;
                    PostedPackageDimension."Package No." := PackageNo;
                    PostedPackageDimension."Package Type Code" := PackageDimension."Package Type Code";
                    PostedPackageDimension."COL Warehouse Shipment No." := PackageDimension."COL Warehouse Shipment No.";
                    PostedPackageDimension."COL Source Line" := PackageDimension."COL Source Line";
                    PostedPackageDimension.Insert(false);
                    PackageNo += 1;
                until PackageDimension.Next() = 0;
            PackageDimension.DeleteAll(true);

        end;
    end;
}