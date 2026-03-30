namespace Weibel.Purchases.Document;

using Microsoft.Sales.Document;
using Microsoft.Purchases.Document;

tableextension 70107 "COL Purchase Line" extends "Purchase Line"
{
    fields
    {
        field(70100; "COLG Out. Qty. on Lines"; Decimal)
        {
            Caption = 'Outstanding Qty. on Order Lines';
            Editable = false;
            DecimalPlaces = 0 : 5;
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line"."Quantity" where("Document Type" = filter(Order), "Blanket Order Line No." = field("Line No."), "Blanket Order No." = field("Document No.")));
        }
        field(70101; "COLG Out. Qty. on Lines (Base)"; Decimal)
        {
            Caption = 'Outstanding Qty. on Order Lines (base)';
            Editable = false;
            DecimalPlaces = 0 : 5;
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line"."Quantity (Base)" where("Document Type" = filter(Order), "Blanket Order Line No." = field("Line No."), "Blanket Order No." = field("Document No.")));
        }
        field(70102; "COL Reminder Problem Exist"; Boolean)
        {
            Caption = 'Reminder Problem';
            ToolTip = 'Specifies if a reminder exists for the purchase line.';
            DataClassification = CustomerContent;
        }
        field(70103; "COL Reminder Comment"; Text[50])
        {
            Caption = 'Reminder Comment';
            ToolTip = 'Specifies the comment for the reminder.';
            DataClassification = CustomerContent;
        }
        field(70104; "COL Previously Released"; Boolean)
        {
            Caption = 'Previously Released';
            ToolTip = 'Specifies if the purchase order was previously released.';
            Editable = false;
            FieldClass = FlowField;
            ObsoleteReason = 'No longer used';
            ObsoleteState = Removed;
            CalcFormula = lookup("Purchase Header"."COL Previously Released" where("Document Type" = field("Document Type"), "No." = field("Document No.")));
        }
        field(70105; "COL Purchaser Code"; Code[20])
        {
            Caption = 'Purchaser Code';
            ToolTip = 'Specifies purchaser code from the document header.';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Purchase Header"."Purchaser Code" where("Document Type" = field("Document Type"), "No." = field("Document No."));
        }
    }

    keys
    {
        key(COL_1; "COL Purchaser Code") { }
    }
}
