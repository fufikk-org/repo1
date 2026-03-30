table 70125 "COL Manufacturing Tech Setup"
{
    Caption = 'Manufacturing Tech Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; "COL SMD Batch Code"; Code[20])
        {
            Caption = 'Last SMD Batch Code';
            ToolTip = 'Specifies last batch value for SMD report.';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
