namespace Weibel.Manufacturing.WorkCenter;

using Microsoft.Manufacturing.WorkCenter;

tableextension 70175 "COL Work Center" extends "Work Center"
{
    fields
    {
        field(70100; "COL Setup Time"; Decimal)
        {
            Caption = 'COL Setup Time';
            ToolTip = 'Specifies the setup time for the work center.';
            DataClassification = CustomerContent;
        }
        field(70101; "COL Wait Time"; Decimal)
        {
            Caption = 'COL Wait Time';
            ToolTip = 'Specifies the wait time for the work center.';
            DataClassification = CustomerContent;
        }
        field(70102; "COL Move Time"; Decimal)
        {
            Caption = 'COL Move Time';
            ToolTip = 'Specifies the move time for the work center.';
            DataClassification = CustomerContent;
        }
        field(70103; "COL Run Time"; Decimal)
        {
            Caption = 'COL Run Time';
            ToolTip = 'Specifies the run time for the work center.';
            DataClassification = CustomerContent;
        }
    }
}
