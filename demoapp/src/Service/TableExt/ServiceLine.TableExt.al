namespace Weibel.Service.Document;

using Microsoft.Service.Document;

tableextension 70158 "COL Service Line" extends "Service Line"
{
    fields
    {
        field(70102; "COL Status"; Enum "Service Doc. Release Status")
        {
            CalcFormula = lookup("Service Header"."Release Status" where("Document Type" = field("Document Type"), "No." = field("Document No.")));
            Caption = 'Status';
            ToolTip = 'Specifies the status of the service document.';
            FieldClass = FlowField;
        }
    }
}