namespace Weibel.Service.Document;

using Microsoft.Service.Document;
using Weibel.Inventory.Item;

tableextension 70133 "COL Service Item Line" extends "Service Item Line"
{
    fields
    {
        field(70100; "COL Export Classification Code"; Enum "COL Item Export Classification")
        {
            Caption = 'Export Classification Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies export classification.';
        }
        field(70121; "COL Project Code"; Code[20])
        {
            Caption = 'Project No.';
            ToolTip = 'Specifies the Project Code.';
            DataClassification = CustomerContent;
        }
        field(70122; "COL Project Task Code"; Code[20])
        {
            Caption = 'Project Line';
            ToolTip = 'Specifies the Project Task Code.';
            DataClassification = CustomerContent;
        }
    }
}
