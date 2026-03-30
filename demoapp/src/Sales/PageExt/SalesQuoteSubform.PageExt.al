namespace Weibel.Sales.Document;

using Microsoft.Sales.Document;

pageextension 70183 "COL Sales Quote Subform" extends "Sales Quote Subform"
{
    layout
    {
        addafter(Description)
        {
            field("COL Export Classification"; ClassificationTxt)
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Export Classification Code';
                ToolTip = 'Specifies export classification.';
            }
            field("COL Assembly BOM"; Rec."COL Assembly BOM")
            {
                ApplicationArea = All;
                Editable = false;
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
