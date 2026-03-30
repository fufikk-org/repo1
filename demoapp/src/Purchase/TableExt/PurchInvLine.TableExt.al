namespace Weibel.Purchases.History;

using Microsoft.Purchases.History;

tableextension 70161 "COL Purch. Inv. Line" extends "Purch. Inv. Line"
{
    fields
    {
        field(70105; "COL Purchaser Code"; Code[20])
        {
            Caption = 'Purchaser Code';
            ToolTip = 'Specifies purchaser code from the document header.';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Purch. Inv. Header"."Purchaser Code" where("No." = field("Document No."));
        }
    }
}
