namespace Weibel.Manufacturing.ProductionBOM;

using Microsoft.Manufacturing.ProductionBOM;

pageextension 70189 "COL Production BOM Ver. Lines" extends "Production BOM Version Lines"
{
    layout
    {
        addlast(Control1)
        {
            field("COL Product Life Cycle"; Rec."COL Product Life Cycle")
            {
                ApplicationArea = All;
                HideValue = (Rec.Type <> Rec.Type::Item) or (Rec."Variant Code" = '');
            }
            field("COL EU RoHS Dir. Compliant"; (Rec."Variant Code" = '') ? Rec."COL EU RoHS Dir. Compliant" : Rec."COL V.EU RoHS Dir. Compliant")
            {
                ApplicationArea = All;
                Caption = 'EU RoHS Directive Compliant';
                ToolTip = 'Specifies the value of the EU RoHS Directive Compliant field from related item.';
                HideValue = Rec.Type <> Rec.Type::Item;
                Lookup = false;
                DrillDown = false;
            }
            field("COL EU RoHS Status"; (Rec."Variant Code" = '') ? Rec."COL EU RoHS Status" : Rec."COL V.EU RoHS Status")
            {
                ApplicationArea = All;
                Caption = 'EU RoHS Status';
                ToolTip = 'Specifies the value of the EU RoHS Status field from related item.';
                HideValue = Rec.Type <> Rec.Type::Item;
                Lookup = false;
                DrillDown = false;
            }
            field("COL Position"; Rec."COL Position")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("COL Position 3"; Rec."COL Position 3")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }

        modify("Variant Code")
        {
            Visible = true;
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetAutoCalcFields("COL EU RoHS Status", "COL V.EU RoHS Status", "COL EU RoHS Dir. Compliant", "COL V.EU RoHS Dir. Compliant");
    end;
}
