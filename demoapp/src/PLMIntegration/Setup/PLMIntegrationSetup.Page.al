namespace Weibel.Integration.PLM;

page 70104 "COL PLM Integration Setup"
{
    ApplicationArea = All;
    Caption = 'PLM Integration Setup';
    AdditionalSearchTerms = 'plm setup';
    PageType = Card;
    SourceTable = "COL PLM Integration Setup";
    UsageCategory = Administration;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("PLM Item Template Code"; Rec."PLM Item Template Code")
                {
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
