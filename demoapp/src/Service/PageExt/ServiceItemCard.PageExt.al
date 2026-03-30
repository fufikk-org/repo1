namespace Weibel.Service.Item;

using Microsoft.Service.Item;

pageextension 70172 "COL Service Item Card" extends "Service Item Card"
{
    layout
    {
        addlast(General)
        {
            group("COL Export Classification Group")
            {
                Caption = 'Export Classification';
                field("COL Export Classification"; Rec."COL Export Classification Code")
                {
                    ApplicationArea = All;
                }
                field("COL EU Classification No."; Rec."COL EU Classification No.")
                {
                    ApplicationArea = All;
                    Editable = Rec."COL US Classification No." = '';
                }
                field("COL US Classification No."; Rec."COL US Classification No.")
                {
                    ApplicationArea = All;
                    Editable = Rec."COL EU Classification No." = '';
                }
            }
        }
    }
}
