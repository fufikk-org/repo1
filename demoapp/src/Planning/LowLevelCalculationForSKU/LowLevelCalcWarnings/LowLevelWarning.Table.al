#if not HIDE_LOWLEVEL_SKU

namespace Weibel.Manufacturing.ProductionBOM;

table 70133 "COL Low Level Warning"
{
    Caption = 'Low Level Warning';
    DataClassification = SystemMetadata;
    LookupPageId = "COL Low Level Warnings";
    DrillDownPageId = "COL Low Level Warnings";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            ToolTip = 'Specifies entry no.';
        }
        field(2; "Warning Code"; Code[20])
        {
            Caption = 'Warning Code';
            ToolTip = 'Specifies warning type.';
        }
        field(3; "Warning Information"; Text[150])
        {
            Caption = 'Warning Information';
            ToolTip = 'Specifies warning details.';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Warning Code") { }
    }
}
#endif