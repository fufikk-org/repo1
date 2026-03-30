namespace Weibel.Purchases.History;

using Microsoft.Purchases.History;

tableextension 70162 "COL Purch. Cr. Memo Line" extends "Purch. Cr. Memo Line"
{
    fields
    {
        field(70105; "COL Purchaser Code"; Code[20])
        {
            Caption = 'Purchaser Code';
            ToolTip = 'Specifies purchaser code from the document header.';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Purch. Cr. Memo Hdr."."Purchaser Code" where("No." = field("Document No."));
        }
    }
}
