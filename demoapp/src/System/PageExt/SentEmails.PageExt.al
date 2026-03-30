namespace weibel.System.Email;

using System.Email;
using Weibel.Common;

pageextension 70187 "COL Sent Emails" extends "Sent Emails"
{
    layout
    {
        addafter(SentFrom)
        {
            field("COL Email Type"; Rec."COL Email Type")
            {
                ApplicationArea = All;
                Visible = true;

            }
            field("COL Related Document"; Rec."COL Related Document")
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
    }

    var
        SentEmailFilters: Record "Sent Email";
        FiltersSet: Boolean;

    trigger OnOpenPage()
    begin
        if not FiltersSet then
            exit;

        // Rec.SetRange("COL Email Type", SentEmailFilters."COL Email Type");
        // Rec.SetRange("COL Related Document", SentEmailFilters."COL Related Document");
        Rec.CopyFilters(SentEmailFilters);
    end;

    procedure COLSetFilters(var SentEmail: Record "Sent Email")
    begin
        SentEmailFilters.CopyFilters(SentEmail);
        FiltersSet := true;
    end;


}
