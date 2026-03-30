namespace Weibel.Foundation.Comment;

using Microsoft.Foundation.Comment;

tableextension 70126 "COL Comment Line" extends "Comment Line"
{
    fields
    {
        field(70100; "COL Budget Change"; Boolean)
        {
            Caption = 'Budget Change';
            ToolTip = 'Specifies if the comment is related to a budget change.';
            DataClassification = CustomerContent;
        }
        field(70101; "COL Budget Change By"; Text[100])
        {
            Caption = 'Budget Change By';
            ToolTip = 'Specifies who change a budget.';
            DataClassification = CustomerContent;
        }
    }
}
