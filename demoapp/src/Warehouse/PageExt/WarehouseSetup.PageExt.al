namespace Weibel.Warehouse.Setup;

using Microsoft.Warehouse.Setup;

pageextension 70248 "COL Warehouse Setup" extends "Warehouse Setup"
{
    layout
    {
        addafter(Numbering)
        {
            group("COL Kardex")
            {
                Caption = 'Kardex Setup';
                field("COL Kardex Location Code"; Rec."COL Kardex Location Code")
                {
                    ApplicationArea = All;
                }
                field("COL Kardex Bin Code"; Rec."COL Kardex Bin Code")
                {
                    ApplicationArea = All;
                }
                field("COL Journal Template Name"; Rec."COL Journal Template Name")
                {
                    ApplicationArea = All;
                }
                field("COL Journal Batch Name"; Rec."COL Journal Batch Name")
                {
                    ApplicationArea = All;
                }
                field("COL Kardex Skip Request"; Rec."COL Kardex Skip Request")
                {
                    ApplicationArea = All;
                }
                field("COL Kardex Input WS"; Rec."COL Kardex Input WS")
                {
                    ApplicationArea = All;
                }
                field("COL Kardex WS User"; Rec."COL Kardex WS User")
                {
                    ApplicationArea = All;
                }
                field("COL Kardex WS Password"; Rec."COL Kardex WS Password")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = Masked;
                }
            }
        }
        addlast(content)
        {
            group("COL Weibel")
            {
                Caption = 'Weibel';

                field("COL ROB-EX Reason Code"; Rec."COL ROB-EX Reason Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}