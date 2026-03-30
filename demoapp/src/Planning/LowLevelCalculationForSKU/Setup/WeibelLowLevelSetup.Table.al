#if not HIDE_LOWLEVEL_SKU
namespace Weibel.Manufacturing.ProductionBOM;

table 70131 "COL Weibel Low Level Setup"
{
    Caption = 'Weibel Low Level Setup';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Log Warnings"; Boolean)
        {
            Caption = 'Log Warnings';
            ToolTip = 'Specifies, if low level calculation should store information about missing SKUs, Production BOMs, etc.';
        }
        field(3; "Log Low Level Details"; Boolean)
        {
            Caption = 'Log Low Level Details';
            ToolTip = 'Specifies, if low level calculation should store information about SKUs, related production or assembly boms that indicates where the low level value is coming from.';
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        RecordHasBeenRead: Boolean;

    procedure GetRecordOnce()
    begin
        if RecordHasBeenRead then
            exit;
        Get();
        RecordHasBeenRead := true;
    end;
}

#endif