namespace Weibel.Manufacturing.Document;

using Microsoft.Manufacturing.Document;
using Weibel.Common;

pageextension 70213 "COL Finished Production Orders" extends "Finished Production Orders"
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
        addlast(Control1)
        {
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
        addafter("No.")
        {
            field("COL Internal Status"; Rec."COL Internal Status")
            {
                ApplicationArea = Suite;
                Importance = Additional;
            }
        }
    }
}
