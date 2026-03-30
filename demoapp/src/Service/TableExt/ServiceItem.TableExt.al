namespace Weibel.Service.Item;

using Microsoft.Service.Item;
using Weibel.Inventory.Item;

tableextension 70134 "COL Service Item" extends "Service Item"
{
    fields
    {
        field(70100; "COL Export Classification Code"; Enum "COL Item Export Classification")
        {
            Caption = 'Export Classification Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies export classification.';
        }
        field(70101; "COL EU Classification No."; Text[30])
        {
            Caption = 'EU Classification No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies item''s EU Classification No. When value is present, US Classification No. cannot be specified.';

            trigger OnValidate()
            begin
                if Rec."COL US Classification No." <> '' then
                    Rec.FieldError("COL EU Classification No.", StrSubstNo(ClassificationFieldErr, Rec.FieldCaption("COL US Classification No.")));
            end;
        }
        field(70102; "COL US Classification No."; Text[30])
        {
            Caption = 'US Classification No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies item''s US Classification No. When value is present, EU Classification No. cannot be specified.';

            trigger OnValidate()
            begin
                if Rec."COL EU Classification No." <> '' then
                    Rec.FieldError("COL US Classification No.", StrSubstNo(ClassificationFieldErr, Rec.FieldCaption("COL EU Classification No.")));
            end;
        }
    }

    var
        ClassificationFieldErr: Label 'cannot be specified if %1 has a value', Comment = '%1 = field caption';
}
