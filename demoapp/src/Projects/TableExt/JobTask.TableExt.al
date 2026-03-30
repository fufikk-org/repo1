namespace Weibel.Projects.Project.Job;

using Microsoft.Projects.Project.Job;
using Microsoft.Service.Item;
using Microsoft.Service.Document;

tableextension 70132 "COL Job Task" extends "Job Task"
{
    fields
    {
        field(70100; "COL Service Item No."; Code[20])
        {
            Caption = 'Service Item No.';
            ToolTip = 'Specifies the Service Item No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ServiceItem: Record "Service Item";
                Job: Record Job;
                ItemMustBeErr: Label 'Customer on Service Item must be same as Project End User %1', Comment = '%1 = end user';
                ServiceOrderExistErr: Label 'Service Item No. cannot be changed when Service Order is already created for task.';
            begin
                if (xRec."COL Service Item No." <> '') and (Rec."COL Service Item No." <> xRec."COL Service Item No.")
                   and (Rec."COL Service Order" <> '') then
                    Error(ServiceOrderExistErr);

                if "COL Service Item No." = '' then
                    exit;

                Job.Get("Job No.");
                ServiceItem.SetRange("No.", "COL Service Item No.");
                ServiceItem.SetRange("Customer No.", Job."COL Existing End User No.");
                if ServiceItem.IsEmpty() then
                    Error(ItemMustBeErr, Job."COL Existing End User No.");
            end;

            trigger OnLookup()
            var
                ServiceItem: Record "Service Item";
                Job: Record Job;
                ServiceItemList: Page "Service Item List";
            begin
                Job.Get("Job No.");
                ServiceItem.SetRange("Customer No.", Job."COL Existing End User No.");
                ServiceItemList.SetTableView(ServiceItem);
                ServiceItemList.LookupMode := true;
                if ServiceItemList.RunModal() = Action::LookupOK then begin
                    ServiceItemList.GetRecord(ServiceItem);
                    Rec."COL Service Item No." := ServiceItem."No.";
                end;

            end;
        }
        field(70101; "COL Service Item Description"; Text[100])
        {
            Caption = 'Service Item Description';
            ToolTip = 'Specifies the Service Item Description';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Service Item".Description where("No." = Field("COL Service Item No.")));
        }
        field(70102; "COL Service Order"; Code[20])
        {
            Caption = 'Service Order';
            ToolTip = 'Specifies the Service Order';
            DataClassification = CustomerContent;
            editable = false;
        }
        field(70103; "COL Service Order Status"; Enum "Service Document Status")
        {
            Caption = 'Status';
            ToolTip = 'Specifies the Service Order Status';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Status" where("No." = Field("COL Service Order")));
        }
    }
}
