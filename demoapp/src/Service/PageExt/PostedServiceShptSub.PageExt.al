namespace Weibel.Service.History;

using Microsoft.Service.History;

pageextension 70176 "COL Posted Service Shpt. Sub" extends "Posted Service Shpt. Subform"
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
