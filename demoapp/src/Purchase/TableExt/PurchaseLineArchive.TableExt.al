namespace Weibel.Purchases.Archive;

using Microsoft.Purchases.Archive;

tableextension 70163 "COL Purchase Line Archive" extends "Purchase Line Archive"
{
    fields
    {
        field(70105; "COL Purchaser Code"; Code[20])
        {
            Caption = 'Purchaser Code';
            ToolTip = 'Specifies purchaser code from the document header.';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Purchase Header Archive"."Purchaser Code" where("Document Type" = field("Document Type"), "No." = field("Document No."), "Doc. No. Occurrence" = field("Doc. No. Occurrence"), "Version No." = field("Version No."));
        }
    }
}
