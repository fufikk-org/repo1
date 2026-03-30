namespace Weibel.Warehouse.Worksheet;

using Microsoft.Warehouse.Worksheet;
using Microsoft.Manufacturing.Routing;

tableextension 70109 "COL Whse. Worksheet Line" extends "Whse. Worksheet Line"
{
    fields
    {
        field(70100; "COL Routing Link Code"; Code[20])
        {
            Caption = 'Routing Link Code';
            TableRelation = "Routing Link";
            Editable = false;
            Description = 'Technical field used to filter the Prod. Order Components based on the Routing Link Code when creating picks.';
            DataClassification = CustomerContent;
        }
        field(70101; "COL Valid Work Center"; Boolean)
        {
            Caption = 'Work Center';
            Editable = false;
            Description = 'Technical field used to filter the Prod. Order Components based on the Work Center Code when creating picks.';
            DataClassification = CustomerContent;
        }
    }
}
