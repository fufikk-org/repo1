namespace Weibel.Service.Document;

using Microsoft.Service.Document;

pageextension 70218 "COL Service Quote Subform" extends "Service Quote Subform"
{
    layout
    {
        addafter("Repair Status Code")
        {
            field("COL Export Classification"; ClassificationTxt)
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Export Classification Code';
                ToolTip = 'Specifies export classification.';
            }
        }
    }

    var
        ClassificationTxt: Text;

    trigger OnAfterGetRecord()
    begin
        ClassificationTxt := '';
        if Rec."COL Export Classification Code" <> Rec."COL Export Classification Code"::Unknown then
            ClassificationTxt := Format(Rec."COL Export Classification Code");
    end;
}
