namespace Weibel.Manufacturing.Document;

using Microsoft.Manufacturing.Document;
using Weibel.Common;

pageextension 70192 "COL Firm Planned Prod. Order" extends "Firm Planned Prod. Order"
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

    actions
    {
        addafter("Re&fresh Production Order")
        {
            action("COL Change In.Status")
            {
                ApplicationArea = All;
                Caption = 'Change Internal Status';
                ShortcutKey = 'Ctrl+F9';
                Image = Change;
                ToolTip = 'Change Internal Status to Opposite (Ctrl+F9).';

                trigger OnAction()
                begin
                    if Rec."COL Internal Status" = Rec."COL Internal Status"::Open then begin
                        CurrPage.SaveRecord();
                        Rec.Validate("COL Internal Status", Rec."COL Internal Status"::Released)
                    end else
                        Rec.Validate("COL Internal Status", Rec."COL Internal Status"::Open);
                    Rec.Modify();
                end;
            }
        }

        addlast(Category_Process)
        {
            actionref("COL Change In.Status_Promoted"; "COL Change In.Status") { }
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
