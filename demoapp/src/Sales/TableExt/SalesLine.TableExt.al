namespace Weibel.Sales.Document;

using Microsoft.Sales.Document;
using Weibel.Inventory.Item;
using Microsoft.Inventory.BOM;

tableextension 70138 "COL Sales Line" extends "Sales Line"
{
    fields
    {
        field(70100; "COL Export Classification Code"; Enum "COL Item Export Classification")
        {
            Caption = 'Export Classification Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies export classification.';
        }
        field(70101; "COL Assembly BOM"; Boolean)
        {
            Caption = 'Assembly BOM';
            ToolTip = 'Specifies Assembly BOM.';
            CalcFormula = exist("BOM Component" where("Parent Item No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(70102; "COL Status"; Enum "Sales Document Status")
        {
            CalcFormula = lookup("Sales Header".Status where("Document Type" = field("Document Type"), "No." = field("Document No.")));
            Caption = 'Status';
            ToolTip = 'Specifies the status of the sales document.';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(COL_1; "Document No.", "Document Type")
        {
            IncludedFields = "Promised Delivery Date";
        }
        key(COL_2; "Document No.", "Document Type", Type, "No.")
        {
            IncludedFields = Amount;
        }
    }
}
