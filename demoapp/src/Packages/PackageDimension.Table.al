namespace Weibel.Packaging;

using Microsoft.Sales.Document;
using Microsoft.Warehouse.Document;
using Microsoft.Service.Document;
using Microsoft.Warehouse.Activity;

table 70103 "COL Package Dimension"
{
    Caption = 'Package Dimension';
    DataClassification = CustomerContent;
    LookupPageId = "COL Package Dimension List";
    DrillDownPageId = "COL Package Dimension List";

    fields
    {
        field(1; "Document Type"; Enum "Warehouse Activity Source Document")
        {
            Caption = 'Document Type';
            ToolTip = 'Specifies Document Type';
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            ToolTip = 'Specifies document no.';
            TableRelation = if ("Document Type" = const("Sales Order")) "Sales Header"."No." where("Document Type" = const(Order))
            else if ("Document Type" = const("Service Order")) "Service Header"."No." where("Document Type" = const(Order));
        }
        field(3; "Package No."; Integer)
        {
            Caption = 'Package No.';
            ToolTip = 'Specifies package no.';
        }
        field(4; "Package Type Code"; Code[20])
        {
            Caption = 'Package Type Code';
            ToolTip = 'Specifies the package code.';
            TableRelation = "COL Package Type".Code;

            trigger OnValidate()
            begin
                CopyFromPackageTypeCode(Rec."Package Type Code");
            end;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies package type description.';
        }
        field(6; Length; Decimal)
        {
            Caption = 'Length';
            MinValue = 0;
            DecimalPlaces = 0 : 2;
            ToolTip = 'Specifies package length.';
        }
        field(7; Width; Decimal)
        {
            Caption = 'Width';
            MinValue = 0;
            DecimalPlaces = 0 : 2;
            ToolTip = 'Specifies package width.';
        }
        field(8; Height; Decimal)
        {
            Caption = 'Height';
            MinValue = 0;
            DecimalPlaces = 0 : 2;
            ToolTip = 'Specifies package height.';
        }
        field(9; "Gross Shipment Weight"; Decimal)
        {
            Caption = 'Gross Shipment Weight';
            MinValue = 0;
            DecimalPlaces = 0 : 2;
            ToolTip = 'Specifies gross shipment weight.';
        }
        field(10; "COL Warehouse Shipment No."; Code[20])
        {
            Caption = 'Warehouse Shipment No.';
            ToolTip = 'Specifies shipment no. where the order is present.';
            TableRelation = "Warehouse Shipment Line"."No." where("Source No." = field("Document No."), "Source Subtype" = const(1), "Source Document" = field("Document Type"));

            trigger OnValidate()
            var
                WarehouseShipmentLine: Record "Warehouse Shipment Line";
            begin
                if Rec."COL Warehouse Shipment No." = '' then begin
                    Rec."COL Source Line" := 0;
                    exit;
                end;

                WarehouseShipmentLine.SetRange("Source No.", Rec."Document No.");
                WarehouseShipmentLine.SetRange("Source Document", Rec."Document Type");
                WarehouseShipmentLine.SetRange("Source Subtype", 1); // 1 = Order
                WarehouseShipmentLine.SetRange("No.", Rec."COL Warehouse Shipment No.");
                WarehouseShipmentLine.FindFirst();
                Rec."COL Source Line" := WarehouseShipmentLine."Source Line No.";
            end;

            trigger OnLookup()
            var
                WarehouseShipmentLine: Record "Warehouse Shipment Line";
                WhseShipmentLines: Page "Whse. Shipment Lines";
            begin
                WarehouseShipmentLine.SetRange("Source No.", Rec."Document No.");
                WarehouseShipmentLine.SetRange("Source Document", Rec."Document Type");
                WarehouseShipmentLine.SetRange("Source Subtype", 1); // 1 = Order
                WhseShipmentLines.LookupMode := true;
                WhseShipmentLines.SetTableView(WarehouseShipmentLine);
                if WhseShipmentLines.RunModal() = Action::LookupOK then begin
                    WhseShipmentLines.GetRecord(WarehouseShipmentLine);
                    Rec."COL Warehouse Shipment No." := WarehouseShipmentLine."No.";
                    Rec."COL Source Line" := WarehouseShipmentLine."Source Line No.";
                end;
            end;
        }
        field(11; "COL Source Line"; Integer)
        {
            Caption = 'Source Line';
            ToolTip = 'Specifies source line no. where the order is present.';
        }
    }
    keys
    {
        key(PK; "Document Type", "Document No.", "Package No.")
        {
            Clustered = true;
        }
        key(Key_2; "Document Type", "Document No.")
        {
            SumIndexFields = "Gross Shipment Weight";
        }
    }

    local procedure CopyFromPackageTypeCode(PackageTypeCode: Code[20])
    var
        PackageType: Record "COL Package Type";
    begin
        if PackageTypeCode = '' then begin
            Clear(Rec.Width);
            Clear(Rec.Height);
            Clear(Rec.Length);
            exit;
        end;

        PackageType.Get(PackageTypeCode);
        Rec.Width := PackageType.Width;
        Rec.Length := PackageType.Length;
        Rec.Height := PackageType.Height;
        if Rec.Description = '' then
            Rec.Description := PackageType.Description;
    end;

    internal procedure SetupNewLine(BelowxRec: Boolean; var LastRecord: Record "COL Package Dimension")
    var
        PackageDimension: Record "COL Package Dimension";
    begin
        if BelowxRec then
            Rec."Package No." := xRec."Package No." + 1
        else begin
            if (Rec.GetFilter("Document Type") <> '') and (Rec.GetRangeMax("Document Type") = Rec.GetRangeMin("Document Type")) then
                Rec.CopyFilter("Document Type", PackageDimension."Document Type")
            else
                exit;
            if (Rec.GetFilter("Document No.") <> '') and (Rec.GetRangeMax("Document No.") = Rec.GetRangeMin("Document No.")) then
                Rec.CopyFilter("Document No.", PackageDimension."Document No.")
            else
                exit;
            PackageDimension.ReadIsolation := IsolationLevel::ReadUncommitted;
            PackageDimension.SetLoadFields("Package No.");
            if PackageDimension.FindLast() then
                Rec."Package No." := PackageDimension."Package No." + 1;
        end;
    end;
}
