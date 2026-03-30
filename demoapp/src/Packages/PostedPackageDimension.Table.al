namespace Weibel.Packaging;

using Microsoft.Sales.History;
using Microsoft.Service.History;

table 70104 "COL Posted Package Dimension"
{
    Caption = 'Posted Package Dimension';
    DataClassification = CustomerContent;
    LookupPageId = "COL Posted Package Dimensions";
    DrillDownPageId = "COL Posted Package Dimensions";

    fields
    {
        field(1; "Table Id"; Integer)
        {
            Caption = 'Document Type';
            ToolTip = 'Specifies Document Type';
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            ToolTip = 'Specifies document no.';
            TableRelation = if ("Table Id" = const(Database::"Sales Shipment Header")) "Sales Shipment Header"."No."
            else if ("Table Id" = const(Database::"Service Shipment Header")) "Service Shipment Header"."No.";
        }
        field(3; "Package No."; Integer)
        {
            Caption = 'Package No.';
            ToolTip = 'Specifies package no.';
            MinValue = 0;
        }
        field(4; "Package Type Code"; Code[20])
        {
            Caption = 'Package Type Code';
            ToolTip = 'Specifies the package type code.';
            TableRelation = "COL Package Type";
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
        }
        field(11; "COL Source Line"; Integer)
        {
            Caption = 'Source Line';
            ToolTip = 'Specifies source line no. where the order is present.';
        }
    }
    keys
    {
        key(PK; "Table Id", "Document No.", "Package No.")
        {
            Clustered = true;
        }
        key(Key_2; "Table Id", "Document No.")
        {
            SumIndexFields = "Gross Shipment Weight";
        }
    }
}
