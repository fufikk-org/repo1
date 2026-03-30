namespace Weibel.Purchases.Document;

using System.Email;
using Weibel.Common;
using Microsoft.Purchases.Vendor;

table 70146 "COL PO Reminder Log"
{
    Caption = 'PO Reminder Log';
    DataClassification = CustomerContent;
    DrillDownPageId = "COL PO Reminder Log";
    LookupPageId = "COL PO Reminder Log";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            ToolTip = 'Specifies the unique entry number for the log entry.';
        }
        field(2; "Sent Email ID"; BigInteger)
        {
            Caption = 'Sent Email ID';
            TableRelation = "Sent Email".Id;
            ToolTip = 'Specifies the ID of the sent email record.';
        }
        field(3; "Message ID"; Text[250])
        {
            Caption = 'Message ID';
            ToolTip = 'Specifies the message ID of the sent email.';
        }
        field(4; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            ToolTip = 'Specifies the purchase order number.';
        }
        field(5; "Email Type"; enum "COL Email Type")
        {
            Caption = 'Email Type';
            ToolTip = 'Specifies the type of reminder email that was sent.';
        }
        field(6; "Send Date"; DateTime)
        {
            Caption = 'Send Date';
            ToolTip = 'Specifies the date and time when the reminder email was sent.';
        }
        field(7; "User Name"; Code[50])
        {
            Caption = 'User Name';
            ToolTip = 'Specifies the user who sent the reminder email.';
        }
        field(8; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            ToolTip = 'Specifies the vendor number associated with the purchase order.';
            TableRelation = Vendor;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(OrderKey; "Order No.", "Email Type")
        {
        }
        key(VendorKey; "Vendor No.", "Email Type")
        {
        }

    }
}