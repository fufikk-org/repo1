namespace Weibel.Warehouse.Request;

using Microsoft.Warehouse.Request;
using Microsoft.Manufacturing.Routing;
using Microsoft.Manufacturing.WorkCenter;

tableextension 70103 "COL Warehouse Request" extends "Warehouse Request"
{
    fields
    {
        field(70100; "COL Routing Link Code"; Text[250])
        {
            Caption = 'Routing Link Code';
            Editable = false;
            TableRelation = "Routing Link";
            Description = 'Technical field used to filter the Prod. Order Components based on the Routing Link Code when creating picks.';
            DataClassification = CustomerContent;
        }
        field(70101; "COL Work Center Code"; Text[250])
        {
            Caption = 'Work Center Code';
            Editable = false;
            TableRelation = "Work Center";
            Description = 'Technical field used to filter the Prod. Order Components based on the work center Code when creating picks.';
            DataClassification = CustomerContent;
        }
    }
}