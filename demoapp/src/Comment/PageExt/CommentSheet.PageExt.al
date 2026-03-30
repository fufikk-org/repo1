namespace Weibel.Foundation.Comment;

using Microsoft.Foundation.Comment;

pageextension 70150 "COL Comment Sheet" extends "Comment Sheet"
{
    layout
    {
        addafter("Comment")
        {
            field("COL Budget Change"; Rec."COL Budget Change")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = ShowBudgetChange;
            }
            field("COL Budget Change By"; Rec."COL Budget Change By")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = ShowBudgetChange;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.GetFilter("Table Name") = Format(Rec."Table Name"::Job) then
            ShowBudgetChange := true;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if Rec."COL Budget Change" then
            Error(BudgetChangeErr);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if Rec."COL Budget Change" then
            Error(BudgetChangeErr);
    end;

    var
        ShowBudgetChange: Boolean;
        BudgetChangeErr: Label 'Comments on Budget line changes are not allowed to be deleted and modified.';
}
