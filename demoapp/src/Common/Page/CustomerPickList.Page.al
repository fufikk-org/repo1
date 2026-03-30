namespace Weibel.Common;

using Microsoft.Sales.Customer;

page 70128 "COL Customer Pick List"
{
    ApplicationArea = All;
    Caption = 'Customer Pick List';
    PageType = List;
    SourceTable = Customer;
    UsageCategory = None;
    SourceTableTemporary = true;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the customer. The field is either filled automatically from a defined number series, or you enter the number manually because you have enabled manual number entry in the number-series setup.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the name of the customer.';
                }
                field("Name 2"; Rec."Name 2")
                {
                    ToolTip = 'Specifies an additional part of the name.';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the customer''s address. This address will appear on all sales documents for the customer.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies additional address information.';
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the customer''s city.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ToolTip = 'Specifies the postal code.';
                }
                field(County; Rec.County)
                {
                    ToolTip = 'Specifies the state, province or county as a part of the address.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ToolTip = 'Specifies the country/region of the address.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the customer''s email address.';
                }
            }
        }
    }

    procedure SetCustData(var TempCustomer: Record Customer temporary)
    begin
        if TempCustomer.FindSet() then
            repeat
                Rec.TransferFields(TempCustomer);
                Rec.Insert();
            until TempCustomer.Next() = 0;
    end;
}
