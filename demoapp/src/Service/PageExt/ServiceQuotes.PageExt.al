namespace Weibel.Service.Document;

using Microsoft.Service.Document;
using Weibel.Common;

pageextension 70112 "COL Service Quotes" extends "Service Quotes"
{
    layout
    {
        addafter("External Document No.")
        {
            field("COL Quote Valid Until Date"; Rec."COL Quote Valid Until Date")
            {
                ApplicationArea = Service;
                StyleExpr = StyleTxt;
            }
            field("COL Export Classification Code"; Rec."COL Export Classification Code")
            {
                ApplicationArea = All;
            }
            field("COL Export Permit No."; Rec."COL Export Permit No.")
            {
                ApplicationArea = All;
            }
        }

        modify("No.")
        {
            StyleExpr = StyleTxt;
        }
    }

    var
        StyleTxt: Text;

    trigger OnAfterGetRecord()
    begin
        StyleTxt := COLSetStyle();
    end;

    procedure COLSetStyle(): Text
    var
        StyleLbl: Label 'Unfavorable', Locked = true;
    begin
        if (Rec."COL Quote Valid Until Date" <> 0D) and (WorkDate() > Rec."COL Quote Valid Until Date") then
            exit(StyleLbl);

        exit('');
    end;
}
