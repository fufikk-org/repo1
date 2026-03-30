namespace Weibel.Service.Item;

using Microsoft.Service.Item;

pageextension 70173 "COL Service Item List" extends "Service Item List"
{
    layout
    {
        addafter("Item Description")
        {
            field("COL Export Classification"; Rec."COL Export Classification Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("COL EU Classification No."; Rec."COL EU Classification No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("COL US Classification No."; Rec."COL US Classification No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
