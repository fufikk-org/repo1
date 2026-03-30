namespace Weibel.Inventory.Item;

using Microsoft.Inventory.Item.Catalog;

pageextension 70194 "COL Item References" extends "Item References"
{
    layout
    {
        addfirst(Control1)
        {
            field("COL Primary Item Reference"; Rec."COL Primary Item Reference")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("COL MSL Moisture Sens. Level"; Rec."COL MSL Moisture Sens. Level")
            {
                ApplicationArea = All;
            }
            field("COL ECCN"; Rec."COL ECCN")
            {
                ApplicationArea = All;
            }
            field("COL Item Category Code"; Rec."COL Item Category Code")
            {
                ApplicationArea = All;
            }
            field("COL Manufacturer"; Rec."COL Manufacturer")
            {
                ApplicationArea = All;
            }
            field("COL MPN No."; Rec."COL MPN No.")
            {
                ApplicationArea = All;
            }
            field("COL Reach Cashed Source"; Rec."COL Reach Cashed Source")
            {
                ApplicationArea = All;
            }
            field("COL Contains SVHC"; Rec."COL Contains SVHC")
            {
                ApplicationArea = All;
            }
            field("COL SVHC Exceed Thr. Limit"; Rec."COL SVHC Exceed Thr. Limit")
            {
                ApplicationArea = All;
            }
            field("COL Substance Identification"; Rec."COL Substance Identification")
            {
                ApplicationArea = All;
            }
            field("COL Substance Location"; Rec."COL Substance Location")
            {
                ApplicationArea = All;
            }
            field("COL Substance Concentration"; Rec."COL Substance Concentration")
            {
                ApplicationArea = All;
            }
            field("COL Countries Of Origin"; Rec."COL Countries Of Origin")
            {
                ApplicationArea = All;
            }
            field("COL Part Status"; Rec."COL Part Status")
            {
                ApplicationArea = All;
            }
            field("COL LTB Date"; Rec."COL LTB Date")
            {
                ApplicationArea = All;
            }
            field("COL RoHS Status"; Rec."COL RoHS Status")
            {
                ApplicationArea = All;
            }
            field("COL RoHS Version"; Rec."COL RoHS Version")
            {
                ApplicationArea = All;
            }
            field("COL Exemption"; Rec."COL Exemption")
            {
                ApplicationArea = All;
            }
            field("COL Exemption Type"; Rec."COL Exemption Type")
            {
                ApplicationArea = All;
            }
            field("COL Estimated EOL Date"; Rec."COL Estimated EOL Date")
            {
                ApplicationArea = All;
            }
            field("COL Peak Pack. Body Temp."; Rec."COL Peak Pack. Body Temp.")
            {
                ApplicationArea = All;
            }
        }

        addlast(factboxes)
        {
            systempart("COL Links"; Links)
            {
                ApplicationArea = RecordLinks;
            }
        }
    }
}