namespace Weibel.Common;

using Weibel.Inventory.Item;

table 70118 "COL PLC Code Matrix"
{
    Caption = 'PLC Code Matrix';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Status; enum "COL Product Life Cycle")
        {
            Caption = 'Status';
            ToolTip = 'Specifies the status of the PLC Code Matrix.';
        }
        field(2; "Blocked for Planning"; Boolean)
        {
            Caption = 'Blocked for Planning';
            ToolTip = 'Specifies if the PLC Code Matrix is blocked for Planning.';
        }
        field(3; "Blocked for Purchase"; Boolean)
        {
            Caption = 'Blocked for Purchase';
            ToolTip = 'Specifies if the PLC Code Matrix is blocked for Purchase.';
        }
        field(4; "Blocked for Sales"; Boolean)
        {
            Caption = 'Blocked for Sales';
            ToolTip = 'Specifies if the PLC Code Matrix is blocked for Sales.';
        }
        field(5; "Blocked for Service"; Boolean)
        {
            Caption = 'Blocked for Service';
            ToolTip = 'Specifies if the PLC Code Matrix is blocked for Service.';
        }
        field(6; "Blocked for Projects"; Boolean)
        {
            Caption = 'Blocked for Projects';
            ToolTip = 'Specifies if the PLC Code Matrix is blocked for Projects.';
        }
        field(7; "Blocked for Production"; Boolean)
        {
            Caption = 'Blocked for Production';
            ToolTip = 'Specifies if the PLC Code Matrix is blocked for Production.';
        }
    }
    keys
    {
        key(PK; Status)
        {
            Clustered = true;
        }
    }

    procedure IsPlanningBlockade(plc: enum "COL Product Life Cycle"): Boolean
    var
        PLCCodeMatrix: Record "COL PLC Code Matrix";
    begin
        if not PLCCodeMatrix.Get(plc) then
            exit(false);

        exit(PLCCodeMatrix."Blocked for Planning");
    end;
}
