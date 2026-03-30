namespace Weibel.Manufacturing.Document;

using Microsoft.Manufacturing.Document;

pageextension 70169 "COL Firm Planned Prod. Orders" extends "Firm Planned Prod. Orders"
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
        addlast(factboxes)
        {
            part("COL Prod. Block Information"; "COL Prod. Order Factbox")
            {
                ApplicationArea = All;
                Caption = 'Production Blocked Details';
                Editable = false;
                SubPageLink = "No." = field("No."), Status = field("Status");
            }
        }
    }
}
