namespace Weibel.Manufacturing.Archive;

using Microsoft.Manufacturing.Document;

table 70109 "COL Prod. Order Comment Arch"
{
    Caption = 'Prod. Order Comment Line Archive';
    DrillDownPageID = "Prod. Order Comment List";
    LookupPageID = "Prod. Order Comment List";
    DataClassification = CustomerContent;

    fields
    {
        field(1; Status; Enum "Production Order Status")
        {
            Caption = 'Status';
            ToolTip = 'Specifies the Status';
        }
        field(2; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
            ToolTip = 'Specifies the Prod. Order No.';
            NotBlank = true;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            ToolTip = 'Specifies the Line No.';
        }
        field(4; "Date"; Date)
        {
            Caption = 'Date';
            ToolTip = 'Specifies the Date';
        }
        field(5; "Code"; Code[10])
        {
            Caption = 'Code';
            ToolTip = 'Specifies the Code';
        }
        field(6; Comment; Text[80])
        {
            Caption = 'Comment';
            ToolTip = 'Specifies the Comment';
        }
        field(5006; "Version No."; Integer)
        {
            Caption = 'Version No.';
            ToolTip = 'Specifies the Version No.';
        }
        field(5007; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
            ToolTip = 'Specifies the Doc. No. Occurrence';
        }
    }

    keys
    {
        key(Key1; Status, "Prod. Order No.", "Doc. No. Occurrence", "Version No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

}

