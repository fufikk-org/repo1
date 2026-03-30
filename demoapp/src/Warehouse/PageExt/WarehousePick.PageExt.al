namespace Weibel.Warehouse.Activity;

using Microsoft.Warehouse.Activity;
using Weibel.Kardex;

pageextension 70253 "COL Warehouse Pick" extends "Warehouse Pick"
{
    layout
    {
        addlast(General)
        {
            field("COL Kardex Log No."; Rec."COL Kardex Log No.")
            {
                ApplicationArea = All;
                Editable = false;

                trigger OnDrillDown()
                var
                    KardexMgt: Codeunit "COL Kardex Mgt.";
                begin
                    KardexMgt.OpenLog(Rec."COL Kardex Log No.");
                end;
            }
        }
    }
}
