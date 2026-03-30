namespace Weibel.Projects.Project.Planning;

using Microsoft.Projects.Project.Planning;
using Microsoft.Inventory.Item;
using Microsoft.Projects.Resources.Resource;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Utilities;
using Microsoft.Inventory.BOM;

pageextension 70140 "COL Job Planning Lines" extends "Job Planning Lines"
{
    layout
    {
        addafter("Job Task No.")
        {
            field("COL Planning Approved"; Rec."COL Planning Approved")
            {
                ApplicationArea = All;
            }
        }
        addlast(Control1)
        {
            field("COL Item Lead Time Calculation"; Rec."COL Item Lead Time Calculation")
            {
                ApplicationArea = All;
                HideValue = Rec.Type <> Enum::"Job Planning Line Type"::Item;
            }
            field("COL PO Planned Receipt Date"; Rec."COL PO Planned Receipt Date")
            {
                ApplicationArea = All;
            }
            field("COL PO Expected Receipt Date"; Rec."COL PO Expected Receipt Date")
            {
                ApplicationArea = All;
            }
        }
        addafter(Type)
        {
            field("COL No."; Rec."COL No.")
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                    Item: Record "Item";
                begin
                    NoOnAfterValidate();
                    if Rec."Variant Code" = '' then
                        VariantCodeMandatory2 := Item.IsVariantMandatory(Rec.Type = Rec.Type::Item, Rec."No.");
                end;
            }
            field("COL Assembly BOM"; Rec."COL Assembly BOM")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        modify("No.")
        {
            Visible = false;
        }

        modify("Variant Code")
        {
            ShowMandatory = VariantCodeMandatory2;

            trigger OnLookup(var Text: Text): Boolean
            var
                ItemVariant: Record "Item Variant";
                ItemVariants: Page "Item Variants";
            begin
                if Rec.Type <> Enum::"Job Planning Line Type"::Item then
                    exit;

                if Rec."No." = '' then
                    exit;

                ItemVariant.SetRange("COL Project Blocked", false);
                ItemVariant.SetRange("Item No.", Rec."No.");
                ItemVariants.SetTableView(ItemVariant);
                ItemVariants.LookupMode := true;
                if ItemVariants.RunModal() = Action::LookupOK then begin
                    ItemVariants.GetRecord(ItemVariant);
                    Text := ItemVariant.Code;
                    exit(true);
                end;

            end;

            trigger OnAfterValidate()
            var
                Item: Record "Item";
            begin
                if Rec."Variant Code" = '' then
                    VariantCodeMandatory2 := Item.IsVariantMandatory(Rec.Type = Rec.Type::Item, Rec."No.");
            end;
        }
        addbefore("Sales Order Action PGS")
        {
            field("COL SO Shipment Date"; Rec."COL SO Shipment Date")
            {
                ApplicationArea = All;
                HideValue = Rec."Sales Order No. PGS" = '';
            }
        }
    }

    actions
    {
        modify(ExplodeBOM_Functions)
        {
            Visible = false;
        }
        addafter(ExplodeBOM_Functions)
        {
            action(COL_ExplodeBOM_Functions)
            {
                AccessByPermission = TableData "BOM Component" = R;
                ApplicationArea = Suite;
                Caption = 'E&xplode BOM';
                Image = ExplodeBOM;
                ToolTip = 'Add a line for each component on the bill of materials for the selected item. For example, this is useful for selling the parent item as a kit. CAUTION: The line for the parent item will be deleted and only its description will display. To undo this action, delete the component lines and add a line for the parent item again.';

                trigger OnAction()
                begin
                    COL_ExplodeBOM();
                end;
            }
        }
        addlast("F&unctions")
        {
            action("COL Approve for Planning")
            {
                Caption = 'Approve for Planning';
                Image = Approval;
                ToolTip = 'Approve selected planning lines for planning.';
                ApplicationArea = All;

                trigger OnAction()
                var
                    JobPlanningLine: Record "Job Planning Line";
                    JobPlanningApprMg: Codeunit "COL Job Planning Appr. Mgt.";
                begin
                    CurrPage.SetSelectionFilter(JobPlanningLine);
                    JobPlanningApprMg.ApproveJobPlanningLinesForPlanning(JobPlanningLine);
                    CurrPage.Update(false);
                end;
            }
        }

        addlast(Category_Process)
        {
            actionref("COL Approve for Planning_Promoted"; "COL Approve for Planning") { }
            actionref("COL_ExplodeBOM_Functions_Promoted"; COL_ExplodeBOM_Functions) { }
        }
    }

    var
        VariantCodeMandatory2: Boolean;

    trigger OnAfterGetRecord()
    var
        Item: Record Item;
    begin
        if Rec."COL No." <> Rec."No." then
            Rec."COL No." := Rec."No.";

        if Rec."Variant Code" = '' then
            VariantCodeMandatory2 := Item.IsVariantMandatory(Rec.Type = Rec.Type::Item, Rec."No.");
    end;

#pragma warning disable AA0228
    local procedure CalcItemBOM(ItemNo: Code[20]): Boolean
    begin
        if (Rec.Type = Enum::"Job Planning Line Type"::Item) and (ItemNo <> '') then begin
            Rec.CalcFields("COL Assembly BOM");
            if Rec."COL Assembly BOM" then
                exit(true);
        end;
        exit(false);
    end;
#pragma warning restore AA0228

    local procedure COL_ExplodeBOM()
    begin
        Codeunit.Run(Codeunit::"COL Job-Explode BOM", Rec);
    end;

}