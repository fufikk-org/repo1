namespace Weibel.Sales.History;

using Microsoft.Sales.History;

pageextension 70179 "COL Posted Sales Invoice Sub" extends "Posted Sales Invoice Subform"
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
