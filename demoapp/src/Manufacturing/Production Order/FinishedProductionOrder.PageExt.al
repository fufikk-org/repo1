namespace Weibel.Manufacturing.Document;

using Microsoft.Manufacturing.Document;
using Weibel.Common;

pageextension 70212 "COL Finished Production Order" extends "Finished Production Order"
{
    layout
    {
        addafter("Source No.")
        {
            field("COL Variant Code"; Rec."Variant Code")
            {
                ApplicationArea = Suite;
                Importance = Additional;
                ToolTip = 'Specifies the variant code for the production order.';
            }
            field("COL Product Life Cycle"; Rec."COL Product Life Cycle")
            {
                ApplicationArea = Suite;
                Importance = Additional;
            }
        }
        addlast(General)
        {
            group("COL EU")
            {
                Caption = 'EU Regulations';
                field("COL EU RoHS Dir. Compliant"; Rec."COL EU RoHS Dir. Compliant")
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    Editable = false;
                }
                field("COL EU REACH Reg. Compliant"; Rec."COL EU REACH Reg. Compliant")
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    Editable = false;
                }
                field("COL EU RoHS Status"; Rec."COL EU RoHS Status")
                {
                    ApplicationArea = Suite;
                    Importance = Promoted;
                    Editable = false;
                }
            }
        }
        addafter("No.")
        {
            field("COL Internal Status"; Rec."COL Internal Status")
            {
                ApplicationArea = Suite;
                Importance = Additional;
            }
            field("COL Reason Code"; Rec."COL Reason Code")
            {
                ApplicationArea = Suite;
                Importance = Additional;

                trigger OnValidate()
                begin
                    CurrPage.SaveRecord();
                end;
            }
            field("COL No. of Archived Versions"; Rec."COL No. of Archived Versions")
            {
                ApplicationArea = Suite;
                Importance = Additional;
            }
        }
    }

    trigger OnModifyRecord(): Boolean
    var
        FieldSelect: Codeunit "COL Field Select Mgt";
    begin
        if GuiAllowed() then
            if (Rec."COL Internal Status" = Rec."COL Internal Status"::Released) and (xRec."COL Internal Status" = xRec."COL Internal Status"::Released) then
                FieldSelect.CheckIfModifyAllowed(Rec, xRec);
    end;
}
