namespace Weibel.Intercompany;

using System.Environment;
using Microsoft.Sales.Setup;

page 70228 "COL Intercompany Companies"
{
    ApplicationArea = All;
    Caption = 'Intercompany Companies';
    PageType = List;
    SourceTable = Company;
    SourceTableTemporary = true;
    UsageCategory = None;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies company''s name';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        Company: Record Company;
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        Company.SetFilter(Name, '<>%1', CompanyName());
        if Company.FindSet() then
            repeat
                SalesSetup.ChangeCompany(Company.Name);
                if SalesSetup.Get() then
                    if SalesSetup.HasValidIntercompanySetup() then begin
                        Rec.Init();
                        Rec := Company;
                        Rec.Insert();
                    end;
            until Company.Next() = 0;
    end;
}
