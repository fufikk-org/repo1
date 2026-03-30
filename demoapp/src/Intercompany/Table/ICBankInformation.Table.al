namespace Weibel.Intercompany;

using System.Environment;
using Microsoft.Bank.Setup;

table 70144 "COL I/C Bank Information"
{
    Caption = 'I/C Bank Information';
    DataClassification = CustomerContent;

    LookupPageId = "COL I/C Bank Informations";

    fields
    {
        field(1; "IC Company"; Text[30])
        {
            Caption = 'IC Company';
            ToolTip = 'Intercompany Company Code';
            TableRelation = "Company";
        }
        field(2; "I/C Bank Name"; Text[100])
        {
            Caption = 'I/C Bank Name';
            ToolTip = 'Name of the bank';
        }
        field(3; "I/C SWIFT"; Code[20])
        {
            Caption = 'I/C SWIFT';
            ToolTip = 'SWIFT/BIC Code';
            TableRelation = "SWIFT Code";
            ValidateTableRelation = false;
        }
        field(4; "I/C IBAN"; Code[50])
        {
            Caption = 'I/C IBAN';
            ToolTip = 'International Bank Account Number';
        }
        field(5; "I/C ACH"; Code[50])
        {
            Caption = 'I/C ACH';
            ToolTip = 'ACH Routing Number for wire transfers';
        }
    }
    keys
    {
        key(PK; "IC Company")
        {
            Clustered = true;
        }
    }
}
