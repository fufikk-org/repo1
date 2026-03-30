namespace Weibel.Projects.Project.Job;

using Microsoft.Projects.Project.Job;

pageextension 70199 "COL Budget Mat.Res. Lines PGS" extends "Budget Matrix Res. Lines PGS"
{

    layout
    {
        modify(Col1)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col2)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col3)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col4)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col5)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col6)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col7)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col8)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col9)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col10)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col11)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col12)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col13)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col14)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col15)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col16)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col17)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col18)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col19)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col20)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col21)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col22)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col23)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col24)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col25)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col26)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col27)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col28)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col29)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col30)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col31)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Col32)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
    }

    var
        ChangeReason: Text[80];

    procedure COLSetChangeReason(pChangeReason: Text[80])
    begin
        ChangeReason := pChangeReason;
    end;

    local procedure CheckJobBeforeMod()
    var
        ChangeReasonErr: Label 'Please enter a change reason before modifying lines.';
    begin
        if ChangeReason = '' then
            Error(ChangeReasonErr);
    end;
}
