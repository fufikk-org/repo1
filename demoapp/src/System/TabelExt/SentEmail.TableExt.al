namespace weibel.System.Email;

using System.Email;
using Weibel.Common;

tableextension 70143 "COL Sent Email" extends "Sent Email"
{
    fields
    {
        field(70100; "COL Email Type"; enum "COL Email Type")
        {
            Caption = 'Email Type';
            DataClassification = CustomerContent;
            ToolTip = 'Type of email that was sent.';
        }
        field(70101; "COL Related Document"; Code[20])
        {
            Caption = 'Related Document';
            DataClassification = CustomerContent;
            ToolTip = 'Document that the email is related to.';
        }
        field(70103; "COL Send Date"; DateTime)
        {
            Caption = 'Send Date';
            DataClassification = CustomerContent;
            ToolTip = 'Date the email was sent.';
        }
    }
}
