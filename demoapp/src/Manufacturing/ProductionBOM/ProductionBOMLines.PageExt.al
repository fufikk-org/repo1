namespace Weibel.Manufacturing.ProductionBOM;

using Microsoft.Manufacturing.ProductionBOM;

pageextension 70161 "COL Production BOM Lines" extends "Production BOM Lines"
{
    layout
    {
        addafter("Unit of Measure Code")
        {
            field("COL Default Bin Code"; Rec."COL Default Bin Code")
            {
                ApplicationArea = All;
            }
            field("COL Fixed Bin Code"; Rec."COL Fixed Bin Code")
            {
                ApplicationArea = All;
            }
        }
        addlast(Control1)
        {
            field("COL EU REACH Reg. Compliant"; Rec."COL EU REACH Reg. Compliant")
            {
                ApplicationArea = All;
            }
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
                Caption = 'EU RoHS Status';
                ToolTip = 'Specifies the value of the EU RoHS Status field from related item.';
                ApplicationArea = All;
                HideValue = Rec.Type <> Rec.Type::Item;
                Lookup = false;
                DrillDown = false;
            }
        }
        addafter("Unit of Measure Code")
        {
            field("COL Unit Price"; Rec."COL Unit Price")
            {
                ApplicationArea = All;
                Editable = false;
                HideValue = Rec.Type <> Rec.Type::Item;
            }
            field("COL Item Unit Cost"; Rec."COL Unit Cost")
            {
                ApplicationArea = All;
                Editable = false;
                HideValue = Rec.Type <> Rec.Type::Item;
            }
            field("COL Position"; Rec."COL Position")
            {
                ApplicationArea = All;
            }
            field("COL Position 3"; Rec."COL Position 3")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }

        addafter(Description)
        {
            field("COL Description 2"; Rec."COL Description 2")
            {
                ApplicationArea = All;
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
