namespace Weibel.Foundation.Address;

using Microsoft.Foundation.Address;

pageextension 70224 "COL Countries/Regions" extends "Countries/Regions"
{
    layout
    {
        addlast(Control1)
        {

            field("COL EU Country"; Rec."COL EU Country")
            {
                ApplicationArea = All;
            }
            field("COL Safa Country"; Rec."COL Safa Country")
            {
                ApplicationArea = All;
            }
            field("COL Other Country"; Rec."COL Other Country")
            {
                ApplicationArea = All;
            }
            field("COL Special Text 1"; Rec."COL Special Text 1")
            {
                ApplicationArea = All;
            }
            field("COL Special Text 2"; Rec."COL Special Text 2")
            {
                ApplicationArea = All;
            }
            field("COL Special Text 3"; Rec."COL Special Text 3")
            {
                ApplicationArea = All;
            }
            field("COL No Special Text"; Rec."COL No Special Text")
            {
                ApplicationArea = All;
            }
        }
    }

    trigger OnModifyRecord(): Boolean
    begin
        Rec.COLCheckGroupFieldsBeforeSaving();
    end;
}