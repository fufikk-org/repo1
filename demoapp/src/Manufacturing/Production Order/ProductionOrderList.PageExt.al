namespace Weibel.Manufacturing.Document;

using Microsoft.Manufacturing.Document;
using Weibel.Common;

pageextension 70157 "COL Production Order List" extends "Production Order List"
{
    layout
    {
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

    trigger OnModifyRecord(): Boolean
    var
        FieldSelect: Codeunit "COL Field Select Mgt";
    begin
        if GuiAllowed() then
            if (Rec."COL Internal Status" = Rec."COL Internal Status"::Released) and (xRec."COL Internal Status" = xRec."COL Internal Status"::Released) then
                FieldSelect.CheckIfModifyAllowed(Rec, xRec);
    end;
}
