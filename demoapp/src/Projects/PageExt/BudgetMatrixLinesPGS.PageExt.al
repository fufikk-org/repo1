namespace Weibel.Projects.Project.Job;

using Microsoft.Projects.Project.Job;

pageextension 70151 "COL Budget Matrix Lines (PGS)" extends "Budget Matrix Lines (PGS)"
{

    layout
    {
        modify(Field1)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field2)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field3)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field4)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field5)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field6)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field7)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field8)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field9)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field10)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field11)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field12)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field13)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field14)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field15)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field16)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field17)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field18)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field19)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field20)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field21)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field22)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field23)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field24)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field25)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field26)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field27)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field28)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field29)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field30)
        {
            trigger OnBeforeValidate()
            begin
                CheckJobBeforeMod();
            end;
        }
        modify(Field31)
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
