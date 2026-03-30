namespace Weibel.Purchases.Vendor;

using Microsoft.Purchases.Vendor;
using Microsoft.Warehouse.Setup;
using Weibel.Purchases.Document;

tableextension 70168 "COL Vendor" extends Vendor
{
    fields
    {
        field(70100; "COL Missing Conf. Remi.Sent"; Integer)
        {
            Caption = 'Missing Confirmation Reminder Sent';
            Tooltip = 'Number of Missing Confirmation Reminder emails sent';
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = count("COL PO Reminder Log" where("Email Type" = filter("Purch. Missing Conf. Reminder" | "Missing Conf. and Overdue Delivery"), "Vendor No." = field("No.")));
        }
        field(70101; "COL Overdue Delivery Remi.Sent"; Integer)
        {
            Caption = 'Overdue Delivery Reminder Sent';
            Tooltip = 'Number of Overdue Delivery Reminder emails sent';
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = count("COL PO Reminder Log" where("Email Type" = filter("Purch. Overdue Delivery Reminder" | "Missing Conf. and Overdue Delivery"), "Vendor No." = field("No.")));
        }
#pragma warning disable AA0232
        field(70102; "COL Missing Conf. - Date"; DateTime)
        {
            Caption = 'Missing Confirmation Last Date';
            Tooltip = 'Last date the Missing Confirmation Reminder was sent';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Max("COL PO Reminder Log"."Send Date" where("Email Type" = filter("Purch. Missing Conf. Reminder" | "Missing Conf. and Overdue Delivery"), "Vendor No." = field("No.")));
        }
#pragma warning restore AA0232
        field(70103; "COL Overdue Delivery - Date"; DateTime)
        {
            Caption = 'Overdue Delivery - Last Date';
            Tooltip = 'Last date the Overdue Delivery Reminder was sent';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Max("COL PO Reminder Log"."Send Date" where("Email Type" = filter("Purch. Overdue Delivery Reminder" | "Missing Conf. and Overdue Delivery"), "Vendor No." = field("No.")));
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
