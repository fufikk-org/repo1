namespace Weibel.Manufacturing.ProductionBOM;

table 70106 "COL Prod. BOM Line Buffer"
{
    Caption = 'Prod. BOM Line Buffer';
    DataClassification = CustomerContent;
    TableType = Temporary;

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(2; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(4; Position; Text[1500])
        {
            Caption = 'Position';
        }
    }
    keys
    {
        key(PK; "Line No.")
        {
            Clustered = true;
        }
    }
}
