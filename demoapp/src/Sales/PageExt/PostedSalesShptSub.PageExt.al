namespace Weibel.Sales.History;

using Microsoft.Sales.History;

pageextension 70178 "COL Posted Sales Shpt. Sub" extends "Posted Sales Shpt. Subform"
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
