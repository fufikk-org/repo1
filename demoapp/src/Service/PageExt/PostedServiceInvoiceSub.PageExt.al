namespace Weibel.Service.History;

using Microsoft.Service.History;

pageextension 70174 "COL Posted Service Invoice Sub" extends "Posted Service Invoice Subform"
{
    layout
    {
        addafter("Service Item No.")
        {
            field("COL Export Classification"; Rec."COL Export Classification Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
