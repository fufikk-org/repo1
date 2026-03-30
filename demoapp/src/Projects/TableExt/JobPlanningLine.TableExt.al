namespace Weibel.Projects.Project.Planning;

using Microsoft.Projects.Project.Planning;
using Microsoft.Purchases.Document;
using Microsoft.Projects.Project.Job;
using Microsoft.Sales.Setup;
using Microsoft.Inventory.Item;
using Microsoft.Projects.Resources.Resource;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Utilities;
using Microsoft.Sales.Document;
using Microsoft.Inventory.BOM;

tableextension 70123 "COL Job Planning Line" extends "Job Planning Line"
{
    fields
    {
        field(70100; "COL Planning Approved"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Planning Approved';
            ToolTip = 'Specifies if a planning line has been approved for MRP calculations. It can only be set for projects with status open.';

            trigger OnValidate()
            var
                Job: Record Job;
                SalesSetup: Record "Sales & Receivables Setup";
                BomErr: Label 'Cannot Approve Planning, Item %1 has not been exploded', Comment = '%1 - item no';
                ItemForbErr: Label 'The Item %1 on this line cannot be marked as Planning Approved', Comment = '%1 - item no';
            begin
                if (Rec.Type = Enum::"Job Planning Line Type"::Item) and (Rec."No." <> '') then begin
                    if not SalesSetup.Get() then
                        SalesSetup.Init();

                    Rec.CalcFields("COL Assembly BOM");
                    if "COL Planning Approved" and Rec."COL Assembly BOM" then
                        Error(BomErr, Rec."No.");

                    if SalesSetup."COL Assembly Explode Item No." <> '' then
                        if "COL Planning Approved" and (SalesSetup."COL Assembly Explode Item No." = Rec."No.") then
                            Error(ItemForbErr, Rec."No.");
                end;

                Rec.TestField(Type, Enum::"Job Planning Line Type"::Item);
                Job.SetLoadFields(Status);
                if "COL Planning Approved" then
                    if Job.Get(Rec."Job No.") then
                        Job.TestField(Status, Enum::"Job Status"::Open);
            end;
        }
        field(70101; "COL Item Lead Time Calculation"; DateFormula)
        {
            Caption = 'Item Lead Time Calculation';
            ToolTip = 'Specifies a date formula for the amount of time it takes to replenish the item.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70102; "COL PO Planned Receipt Date"; Date)
        {
            Caption = 'Planned Receipt Date';
            ToolTip = 'Specifies planned receipt date from related purchase order line.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Line"."Planned Receipt Date" where("Document Type" = const(Order), "Job No." = field("Job No."), "Job Task No." = field("Job Task No."), "Job Planning Line No." = field("Line No.")));
        }
        field(70103; "COL PO Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';
            ToolTip = 'Specifies expected receipt date from related purchase order line.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Line"."Expected Receipt Date" where("Document Type" = const(Order), "Job No." = field("Job No."), "Job Task No." = field("Job Task No."), "Job Planning Line No." = field("Line No.")));
        }
        field(70104; "COL No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            ToolTip = 'Specifies the number of the job planning line.';
            TableRelation = if (Type = const(Resource)) Resource
            else
            if (Type = const(Item)) Item where(Blocked = const(false), "COL Project Blocked" = const(false))
            else
            if (Type = const("G/L Account")) "G/L Account"
            else
            if (Type = const(Text)) "Standard Text";
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                CurrFieldNo := Rec.FieldNo("No.");
                Validate("No.", "COL No.");
            end;
        }
        field(70105; "COL SO Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
            ToolTip = 'Specifies shipment date from related sales order line.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Sales Line"."Shipment Date" where("Document Type" = const(Order), "Document No." = field("Sales Order No. PGS"), "Line No." = field("Sales Order Line No. PGS")));
        }
        field(70106; "COL Assembly BOM"; Boolean)
        {
            CalcFormula = exist("BOM Component" where("Parent Item No." = field("No.")));
            Caption = 'Assembly BOM';
            ToolTip = 'Specifies if item is assembly BOM.';
            Editable = false;
            FieldClass = FlowField;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                Item: Record "Item";
                ProjectBlockedErr: Label 'You cannot select Item %1 because the Project Blocked check box is selected on the Item Card', Comment = '%1 - item';
            begin
                "COL No." := "No.";
                if Rec.Type <> Enum::"Job Planning Line Type"::Item then
                    exit;

                if Rec."No." = '' then
                    exit;

                if not Item.Get(Rec."No.") then
                    exit;

                if Item."COL Project Blocked" then
                    Error(ProjectBlockedErr, Rec."No.");

            end;
        }

        modify("Variant Code")
        {

            trigger OnAfterValidate()
            var
                ItemVariant: Record "Item Variant";
                ProjectBlockedErr: Label 'You cannot select Item Variant %1 because the Project Blocked check box is selected on the Item Variant', Comment = '%1 - item variant';
            begin
                if Rec.Type <> Enum::"Job Planning Line Type"::Item then
                    exit;

                if Rec."No." = '' then
                    exit;

                if not ItemVariant.Get(Rec."No.", Rec."Variant Code") then
                    exit;

                if ItemVariant."COL Project Blocked" then
                    Error(ProjectBlockedErr, Rec."Variant Code");
            end;
        }
    }

    procedure COLSetCurrFieldNo(currField: Integer)
    begin
        CurrFieldNo := currField;
    end;
}
