table 70132 "COL Item Attr. Filter Criteria"
{
    Caption = 'Item Attribute Filter Criteria';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            ToolTip = 'Specifies the source table that owns this filter criteria.';
        }
        field(2; "Filter ID"; Guid)
        {
            Caption = 'Filter ID';
            ToolTip = 'Represents the unique identifier of the filter criteria set.';
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            ToolTip = 'Specifies the item included in this attribute filter criteria.';
        }
    }

    keys
    {
        key(PK; "Table ID", "Filter ID", "Item No.")
        {
            Clustered = true;
        }
    }
}