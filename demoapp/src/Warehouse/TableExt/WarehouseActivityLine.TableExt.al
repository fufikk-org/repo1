namespace Weibel.Warehouse.Activity;

using Microsoft.Warehouse.Activity;
using Weibel.Kardex;

tableextension 70172 "COL Warehouse Activity Line" extends "Warehouse Activity Line"
{
    fields
    {
        field(70100; "COL Print GTIN Label"; Boolean)
        {
            Caption = 'Print GTIN Label';
            ToolTip = 'Specifies if the GTIN label should be printed for this line.';
            DataClassification = CustomerContent;
        }

        modify("Qty. to Handle")
        {
            trigger OnBeforeValidate()
            var
                KardexMgt: Codeunit "COL Kardex Mgt.";
            begin
                if not SkipKardexCheck then
                    KardexMgt.DeleteWhseActivLineCheck(Rec, Rec.FieldNo("Qty. to Handle"));
            end;
        }
        modify("Qty. to Handle (Base)")
        {
            trigger OnBeforeValidate()
            var
                KardexMgt: Codeunit "COL Kardex Mgt.";
            begin
                if not SkipKardexCheck then
                    KardexMgt.DeleteWhseActivLineCheck(Rec, Rec.FieldNo("Qty. to Handle (Base)"));
            end;
        }
        modify("Bin Code")
        {
            trigger OnBeforeValidate()
            var
                KardexMgt: Codeunit "COL Kardex Mgt.";
            begin
                if not SkipKardexCheck then
                    KardexMgt.WhseActivLineBinCheck(Rec, xRec);
            end;
        }
    }

    trigger OnBeforeDelete()
    var
        KardexMgt: Codeunit "COL Kardex Mgt.";
    begin
        if not SkipKardexCheck then
            KardexMgt.DeleteWhseActivLineCheck(Rec, -1);
    end;

    var
        SkipKardexCheck: Boolean;

    procedure COL_SetSkipKardexCheck(newSkipKardexCheck: Boolean)
    begin
        SkipKardexCheck := newSkipKardexCheck;
    end;
}
