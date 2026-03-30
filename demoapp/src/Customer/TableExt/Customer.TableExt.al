namespace Weibel.Sales.Customer;

using Microsoft.Sales.Customer;
using Microsoft.Projects.Project.Job;
using Microsoft.Warehouse.Setup;

tableextension 70122 "COL Customer" extends Customer
{
    fields
    {
        field(70100; "COL End User"; Boolean)
        {
            Caption = 'End User ';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies if customer is end user';
        }
        field(70101; "COL Ongoing Jobs (SellTo)"; Integer)
        {
            CalcFormula = count("Job" where("Sell-to Customer No." = field("No.")));
            Caption = 'Ongoing Jobs (Projects in Progressus)';
            ToolTip = 'Specifies the number of Progressus projects for Sell to customer.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70102; "COL Ongoing Jobs (BillTo)"; Integer)
        {
            CalcFormula = count("Job" where("Bill-to Customer No." = field("No.")));
            Caption = 'Ongoing Jobs (Projects in Progressus)';
            ToolTip = 'Specifies the number of Progressus projects for Bill to customer.';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    trigger OnAfterInsert()
    var
        WarehouseSetup: Record "Warehouse Setup";
    begin
        if WarehouseSetup.Get() then
            if WarehouseSetup."COL Kardex Location Code" <> '' then
                Validate("Location Code", WarehouseSetup."COL Kardex Location Code");
    end;
}
