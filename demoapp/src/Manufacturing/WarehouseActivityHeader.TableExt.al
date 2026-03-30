namespace Weibel.Warehouse.Activity;

using Microsoft.Warehouse.Activity;
using Microsoft.Manufacturing.Routing;
using Weibel.Kardex;
using Microsoft.Manufacturing.WorkCenter;

tableextension 70104 "COL Warehouse Activity Header" extends "Warehouse Activity Header"
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
        field(70102; "COL Kardex Log No."; Integer)
        {
            Caption = 'Kardex Log No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies Kardex Log No.';
        }
    }

    trigger OnBeforeDelete()
    var
        KardexLogLine: Record "COL Kardex Log Line";
        KardexMgt: Codeunit "COL Kardex Mgt.";
    begin
        KardexMgt.DeleteWhseActivHeaderCheck(Rec);

        if "COL Kardex Log No." <> 0 then
            if KardexLogLine.Get("COL Kardex Log No.") then
                KardexLogLine.Delete(true);
    end;
}