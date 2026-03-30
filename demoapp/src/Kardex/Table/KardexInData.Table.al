table 70137 "COL Kardex In Data"
{
    Caption = 'Kardex In Data';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Some Data"; Integer)
        {
            Caption = 'Some Data';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
