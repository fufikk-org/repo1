namespace Weibel.Common;

using Microsoft.Sales.Document;
using Microsoft.Service.Document;
using Microsoft.Sales.Customer;
using Microsoft.CRM.BusinessRelation;
using Microsoft.Projects.Project.Job;

codeunit 70118 "COL Common Cust. Mgt"
{

    procedure CreateEndUserCust(var Rec: Record "Sales Header")
    var
        CustomerTemplate: Record "Customer Templ.";
        Customer: Record Customer;
        CustomerTemplMgt: Codeunit "Customer Templ. Mgt.";
        CustContUpdate: Codeunit "CustCont-Update";
        CustomerTemplList: Page "Customer Templ. List";
    begin
        CustomerTemplList.LookupMode := True;
        if not (CustomerTemplList.RunModal() = Action::LookupOK) then
            exit;

        CustomerTemplList.GetRecord(CustomerTemplate);

        Customer.Init();
        Customer.Insert(true);

        Customer.Name := Rec."COL End User Name";
        Customer."Name 2" := Rec."COL End User Name 2";
        Customer.Address := Rec."COL End User Address";
        Customer."Address 2" := Rec."COL End User Address 2";
        Customer.City := Rec."COL End User City";
        Customer."Post Code" := Rec."COL End User Post Code";
        Customer."Country/Region Code" := Rec."COL End User Country/Region";
        Customer.County := Rec."COL End User County";
        Customer."E-Mail" := Rec."COL End User E-Mail";
        CustomerTemplMgt.ApplyCustomerTemplate(Customer, CustomerTemplate);
        Customer."COL End User" := true;
        Customer.Modify();
        Commit();

        if not (Page.RunModal(Page::"Customer Card", Customer) in [Action::OK, Action::LookupOK]) then begin
            CustContUpdate.DeleteCustomerContacts(Customer);
            Customer.Delete(true);
            Commit();
            exit;
        end;

        if Customer."COL End User" then begin
            Rec."COL End User Type" := Rec."COL End User Type"::"Existing End User";
            Rec."COL Existing End User No." := Customer."No.";
            CopyFromCust(Rec, Customer);
            Rec.Modify();
        end;
    end;

    procedure CreateEndUserCust(var Rec: Record "Service Header")
    var
        CustomerTemplate: Record "Customer Templ.";
        Customer: Record Customer;
        CustomerTemplMgt: Codeunit "Customer Templ. Mgt.";
        CustContUpdate: Codeunit "CustCont-Update";
        CustomerTemplList: Page "Customer Templ. List";
    begin
        CustomerTemplList.LookupMode := True;
        if not (CustomerTemplList.RunModal() = Action::LookupOK) then
            exit;

        CustomerTemplList.GetRecord(CustomerTemplate);

        Customer.Init();
        Customer.Insert(true);

        Customer.Name := Rec."COL End User Name";
        Customer."Name 2" := Rec."COL End User Name 2";
        Customer.Address := Rec."COL End User Address";
        Customer."Address 2" := Rec."COL End User Address 2";
        Customer.City := Rec."COL End User City";
        Customer."Post Code" := Rec."COL End User Post Code";
        Customer."Country/Region Code" := Rec."COL End User Country/Region";
        Customer.County := Rec."COL End User County";
        Customer."E-Mail" := Rec."COL End User E-Mail";
        CustomerTemplMgt.ApplyCustomerTemplate(Customer, CustomerTemplate);
        Customer."COL End User" := true;
        Customer.Modify();
        Commit();

        if not (Page.RunModal(Page::"Customer Card", Customer) in [Action::OK, Action::LookupOK]) then begin
            CustContUpdate.DeleteCustomerContacts(Customer);
            Customer.Delete(true);
            Commit();
            exit;
        end;

        if Customer."COL End User" then begin
            Rec."COL End User Type" := Rec."COL End User Type"::"Existing End User";
            Rec."COL Existing End User No." := Customer."No.";
            CopyFromCust(Rec, Customer);
            Rec.Modify();
        end;
    end;

    procedure CreateEndUserCust(var Rec: Record "Job")
    var
        CustomerTemplate: Record "Customer Templ.";
        Customer: Record Customer;
        CustomerTemplMgt: Codeunit "Customer Templ. Mgt.";
        CustContUpdate: Codeunit "CustCont-Update";
        CustomerTemplList: Page "Customer Templ. List";
    begin
        CustomerTemplList.LookupMode := True;
        if not (CustomerTemplList.RunModal() = Action::LookupOK) then
            exit;

        CustomerTemplList.GetRecord(CustomerTemplate);

        Customer.Init();
        Customer.Insert(true);

        Customer.Name := Rec."COL End User Name";
        Customer."Name 2" := Rec."COL End User Name 2";
        Customer.Address := Rec."COL End User Address";
        Customer."Address 2" := Rec."COL End User Address 2";
        Customer.City := Rec."COL End User City";
        Customer."Post Code" := Rec."COL End User Post Code";
        Customer."Country/Region Code" := Rec."COL End User Country/Region";
        Customer.County := Rec."COL End User County";
        Customer."E-Mail" := Rec."COL End User E-Mail";
        CustomerTemplMgt.ApplyCustomerTemplate(Customer, CustomerTemplate);
        Customer."COL End User" := true;
        Customer.Modify();
        Commit();

        if not (Page.RunModal(Page::"Customer Card", Customer) in [Action::OK, Action::LookupOK]) then begin
            CustContUpdate.DeleteCustomerContacts(Customer);
            Customer.Delete(true);
            Commit();
            exit;
        end;

        if Customer."COL End User" then begin
            Rec."COL End User Type" := Rec."COL End User Type"::"Existing End User";
            Rec."COL Existing End User No." := Customer."No.";
            CopyFromCust(Rec, Customer);
            Rec.Modify();
        end;

    end;

    procedure CopyFromCust(var Rec: Record "Sales Header"; var Customer: Record Customer)
    begin
        Rec."COL End User Name" := Customer.Name;
        Rec."COL End User Name 2" := Customer."Name 2";
        Rec."COL End User Address" := Customer.Address;
        Rec."COL End User Address 2" := Customer."Address 2";
        Rec."COL End User City" := Customer.City;
        Rec."COL End User Post Code" := Customer."Post Code";
        Rec."COL End User Country/Region" := Customer."Country/Region Code";
        Rec."COL End User County" := Customer.County;
        Rec."COL End User E-Mail" := Customer."E-Mail";
    end;

    procedure CopyFromCust(var Rec: Record "Service Header"; var Customer: Record Customer)
    begin
        Rec."COL End User Name" := Customer.Name;
        Rec."COL End User Name 2" := Customer."Name 2";
        Rec."COL End User Address" := Customer.Address;
        Rec."COL End User Address 2" := Customer."Address 2";
        Rec."COL End User City" := Customer.City;
        Rec."COL End User Post Code" := Customer."Post Code";
        Rec."COL End User Country/Region" := Customer."Country/Region Code";
        Rec."COL End User County" := Customer.County;
        Rec."COL End User E-Mail" := Customer."E-Mail";
    end;

    procedure CopyFromCust(var Rec: Record "Job"; var Customer: Record Customer)
    begin
        Rec."COL End User Name" := Customer.Name;
        Rec."COL End User Name 2" := Customer."Name 2";
        Rec."COL End User Address" := Customer.Address;
        Rec."COL End User Address 2" := Customer."Address 2";
        Rec."COL End User City" := Customer.City;
        Rec."COL End User Post Code" := Customer."Post Code";
        Rec."COL End User Country/Region" := Customer."Country/Region Code";
        Rec."COL End User County" := Customer.County;
        Rec."COL End User E-Mail" := Customer."E-Mail";
    end;

    procedure CopyFromJob(var Rec: Record "Sales Header"; var Job: Record Job)
    begin
        Rec."COL End User Type" := Job."COL End User Type";
        Rec."COL Existing End User No." := Job."COL Existing End User No.";
        Rec."COL End User Name" := Job."COL End User Name";
        Rec."COL End User Name 2" := Job."COL End User Name 2";
        Rec."COL End User Address" := Job."COL End User Address";
        Rec."COL End User Address 2" := Job."COL End User Address 2";
        Rec."COL End User City" := Job."COL End User City";
        Rec."COL End User Post Code" := Job."COL End User Post Code";
        Rec."COL End User Country/Region" := Job."COL End User Country/Region";
        Rec."COL End User County" := Job."COL End User County";
        Rec."COL End User E-Mail" := Job."COL End User E-Mail";
    end;

    procedure CopyFromJob(var Rec: Record "Service Header"; var Job: Record Job)
    begin
        Rec."COL End User Type" := Job."COL End User Type";
        Rec."COL Existing End User No." := Job."COL Existing End User No.";
        Rec."COL End User Name" := Job."COL End User Name";
        Rec."COL End User Name 2" := Job."COL End User Name 2";
        Rec."COL End User Address" := Job."COL End User Address";
        Rec."COL End User Address 2" := Job."COL End User Address 2";
        Rec."COL End User City" := Job."COL End User City";
        Rec."COL End User Post Code" := Job."COL End User Post Code";
        Rec."COL End User Country/Region" := Job."COL End User Country/Region";
        Rec."COL End User County" := Job."COL End User County";
        Rec."COL End User E-Mail" := Job."COL End User E-Mail";
    end;

    local procedure FindCustomer(var ExistingEndUserNo: Code[20]; EndUserType: Enum "COL End User Type"; BillTo: Code[20]; var Customer: Record Customer)
    begin
        if EndUserType = Enum::"COL End User Type"::"Existing End User" then
            if (not Customer.Get(ExistingEndUserNo)) or (ExistingEndUserNo = '') then
                Customer.Init();

        if EndUserType = Enum::"COL End User Type"::"New End User" then begin
            if (not Customer.Get(BillTo)) then
                Customer.Init();
            ExistingEndUserNo := '';
        end;
    end;

    procedure SetCustomerEndUser(var Rec: Record "Sales Header")
    var
        Customer: Record Customer;
    begin
        FindCustomer(Rec."COL Existing End User No.", Rec."COL End User Type", Rec."Bill-to Customer No.", Customer);
        CopyFromCust(Rec, Customer);
    end;

    procedure SetCustomerEndUser(var Rec: Record "Service Header")
    var
        Customer: Record Customer;
    begin
        FindCustomer(Rec."COL Existing End User No.", Rec."COL End User Type", Rec."Bill-to Customer No.", Customer);
        CopyFromCust(Rec, Customer);
    end;

    procedure SetCustomerEndUser(var Rec: Record "Job")
    var
        Customer: Record Customer;
    begin
        FindCustomer(Rec."COL Existing End User No.", Rec."COL End User Type", Rec."Bill-to Customer No.", Customer);
        CopyFromCust(Rec, Customer);
    end;

    procedure PickCompanyCustomer(FromCompany: Text[30]; var Rec: Record "Sales Header")
    var
        TempCustomer: Record Customer temporary;
    begin
        if FindCustomers(FromCompany, TempCustomer) then
            CopyFromCustToGs(Rec, TempCustomer);
    end;

    procedure PickCompanyCustomer(FromCompany: Text[30]; var Rec: Record "Service Header")
    var
        TempCustomer: Record Customer temporary;
    begin
        if FindCustomers(FromCompany, TempCustomer) then
            CopyFromCustToGs(Rec, TempCustomer);
    end;

    procedure CopyFromCustToGs(var Rec: Record "Sales Header"; var Cust: Record Customer temporary)
    begin
        Rec."COL GS. Customer No." := Cust."No.";
        Rec."COL GS. Name" := Cust."Name";
        Rec."COL GS. Name 2" := Cust."Name 2";
        Rec."COL GS. Address" := Cust."Address";
        Rec."COL GS. Address 2" := Cust."Address 2";
        Rec."COL GS. City" := Cust."City";
        Rec."COL GS. Post Code" := Cust."Post Code";
        Rec."COL GS. Country/Region" := Cust."Country/Region Code";
        Rec."COL GS. County" := Cust."County";
        Rec."COL GS. E-Mail" := Cust."E-Mail";
        Rec.Validate("COL GS. Salesperson Code", Cust."Salesperson Code");
    end;

    procedure CopyFromCustToGs(var Rec: Record "Service Header"; var Cust: Record Customer temporary)
    begin
        Rec."COL GS. Customer No." := Cust."No.";
        Rec."COL GS. Name" := Cust."Name";
        Rec."COL GS. Name 2" := Cust."Name 2";
        Rec."COL GS. Address" := Cust."Address";
        Rec."COL GS. Address 2" := Cust."Address 2";
        Rec."COL GS. City" := Cust."City";
        Rec."COL GS. Post Code" := Cust."Post Code";
        Rec."COL GS. Country/Region" := Cust."Country/Region Code";
        Rec."COL GS. County" := Cust."County";
        Rec."COL GS. E-Mail" := Cust."E-Mail";
        Rec.Validate("COL GS. Salesperson Code", Cust."Salesperson Code");
    end;

    procedure ClearGs(var Rec: Record "Sales Header")
    begin
        Rec."COL GS. Customer No." := '';
        Rec."COL GS. Name" := '';
        Rec."COL GS. Name 2" := '';
        Rec."COL GS. Address" := '';
        Rec."COL GS. Address 2" := '';
        Rec."COL GS. City" := '';
        Rec."COL GS. Post Code" := '';
        Rec."COL GS. Country/Region" := '';
        Rec."COL GS. County" := '';
        Rec."COL GS. E-Mail" := '';
        Rec.Validate("COL GS. Salesperson Code", '');
    end;

    procedure ClearGs(var Rec: Record "Service Header")
    begin
        Rec."COL GS. Customer No." := '';
        Rec."COL GS. Name" := '';
        Rec."COL GS. Name 2" := '';
        Rec."COL GS. Address" := '';
        Rec."COL GS. Address 2" := '';
        Rec."COL GS. City" := '';
        Rec."COL GS. Post Code" := '';
        Rec."COL GS. Country/Region" := '';
        Rec."COL GS. County" := '';
        Rec."COL GS. E-Mail" := '';
        Rec.Validate("COL GS. Salesperson Code", '');
    end;

    local procedure FindCustomers(FromCompany: Text[30]; var TempCustomer: Record Customer temporary): Boolean
    var
        Customer: Record Customer;
        TempPickCustomer: Record Customer temporary;
        CustomerPickList: Page "COL Customer Pick List";
    begin
        if CompanyName <> FromCompany then
            Customer.ChangeCompany(FromCompany);

        if Customer.FindSet() then
            repeat
                TempPickCustomer.TransferFields(Customer);
                TempPickCustomer.Insert();
            until Customer.Next() = 0;

        CustomerPickList.SetCustData(TempPickCustomer);
        CustomerPickList.LookupMode := True;
        if CustomerPickList.RunModal() = Action::LookupOK then begin
            CustomerPickList.GetRecord(TempCustomer);
            exit(true);
        end
        else
            exit(false);
    end;
}
