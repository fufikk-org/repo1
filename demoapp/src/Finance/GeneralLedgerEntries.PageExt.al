namespace Weibel.Finance.GeneralLedger.Ledger;

using Microsoft.Finance.GeneralLedger.Ledger;

pageextension 70237 "COL General Ledger Entries" extends "General Ledger Entries"
{
    Editable = false;
    layout
    {
        modify("Source Type")
        {
            Visible = true;
        }
        modify("Source No.")
        {
            Visible = true;
        }
        addafter("Source No.")
        {
            field("COL Source Name"; Rec."COL Source Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addlast(Control1)
        {
            field("COL Acubiz Travel ID"; Rec."COL Acubiz Travel ID")
            {
                ApplicationArea = All;
                trigger OnDrillDown()
                var
                    AcuBizMgt: Codeunit "COL AcuBizMgt";
                begin
                    AcuBizMgt.ShowAcubizDoc(Rec."COL Acubiz Travel ID");
                end;
            }
        }
    }

    actions
    {
        addlast(processing)
        {
            action("COL Update Source Name")
            {
                Caption = 'Update Source Name';
                ToolTip = 'Run this action to update source name column on all G/L Entries, unless the column already has a value.';
                Image = UpdateDescription;
                ApplicationArea = All;
                RunObject = codeunit "COL G/L Entry Source Name";
            }
            action("COL Show Acubiz Doc")
            {
                ApplicationArea = All;
                Caption = 'Show Acubiz Document';
                ToolTip = 'Open the Acubiz expense document in a browser.';
                Image = Web;
                Enabled = Rec."COL Acubiz Travel ID" <> '';

                trigger OnAction()
                var
                    AcuBizMgt: Codeunit "COL AcuBizMgt";
                begin
                    AcuBizMgt.ShowAcubizDoc(Rec."COL Acubiz Travel ID");
                end;
            }
        }
    }
}
