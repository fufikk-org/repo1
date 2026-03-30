namespace Weibel.Finance.GeneralLedger.Journal;

using Microsoft.Finance.GeneralLedger.Journal;

pageextension 70254 "COL General Journal" extends "General Journal"
{
    layout
    {
        addlast(Control1)
        {
            field("COL Acubiz Travel ID"; Rec."COL Acubiz Travel ID")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addlast(processing)
        {
            action("COL Import Acubiz File")
            {
                ApplicationArea = All;
                Caption = 'Import Acubiz File';
                ToolTip = 'Import journal lines from CSV file';
                Image = Import;

                trigger OnAction()
                var
                    ImportAcubizFile: Codeunit "COL Import Acubiz File";
                begin
                    ImportAcubizFile.ImportCSVFile(Rec);
                end;
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
        addlast(Category_Process)
        {
            actionref("COL Import Acubiz File_Promoted"; "COL Import Acubiz File")
            {
            }
            actionref("COL Show Acubiz Doc_Promoted"; "COL Show Acubiz Doc")
            {
            }
        }

    }


}