namespace Weibel.Inventory.Item;

using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.ProductionBOM;
using Weibel.Inventory.LegacyItems;
using Weibel.Inventory.Ledger;
using Weibel.Inventory.BOM.Tree;

pageextension 70103 "COL Item List" extends "Item List"
{
    layout
    {
        addlast(Control1)
        {
            field("COL Qty. in Planning"; Rec.COLGetQtyInPlanningWorksheet())
            {
                ApplicationArea = All;
                Caption = 'Qty. in Planning';
                ToolTip = 'Specifies the quantity of an item in planning worksheet lines.';
                DecimalPlaces = 0 : 5;
                Editable = false;
                Visible = false;

                trigger OnDrillDown()
                begin
                    Rec.COLDrillDownQtyInPlanningWorksheet();
                end;
            }
            field("COL Export Classification"; Rec."COL Export Classification Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("COL EU Classification No."; Rec."COL EU Classification No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("COL US Classification No."; Rec."COL US Classification No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("COL EU RoHS Dir. Compliant"; Rec."COL EU RoHS Dir. Compliant")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("COL EU REACH Reg. Compliant"; Rec."COL EU REACH Reg. Compliant")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("COL Moisture Sensitivity Level"; Rec."COL Moisture Sensitivity Level")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("COL NATO Stock No."; Rec."COL NATO Stock No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("COL Item Configuration Type"; Rec."COL Item Configuration Type")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        modify(Control1900383207)
        {
            Visible = false;
            Enabled = false;
        }
    }

    actions
    {
        modify(PrintLabel)
        {
            Visible = false;
        }

        addafter(PrintLabel)
        {
            action("COL Print Item Label")
            {
                Caption = 'Print Label';
                ToolTip = 'Print Label';
                ApplicationArea = Basic, Suite;
                Image = Print;

                trigger OnAction()
                var
                    WeibelItemODCLabel: Report "COL Weibel Item ODC Label";
                begin
                    WeibelItemODCLabel.InitFrom(Rec);
                    WeibelItemODCLabel.RunModal();
                end;
            }
        }

        addlast(reporting)
        {
            action("COL Print BOM")
            {
                ApplicationArea = All;
                Caption = 'Print BOM';
                ToolTip = 'Print information about Production BOM.';
                Image = Report;
                Enabled = Rec."Production BOM No." <> '';

                trigger OnAction()
                var
                    ProductionBOMHeader: Record "Production BOM Header";
                begin
                    if ProductionBOMHeader.Get(Rec."Production BOM No.") then
                        ProductionBOMHeader.COLPrintBOM();
                end;
            }
            action("COL Print Cable")
            {
                ApplicationArea = All;
                Caption = 'Print Cable Label';
                Image = Print;
                ToolTip = 'Print Cable Labels';

                trigger OnAction()
                var
                    CableLabel: Report "COL Cable Label2";
                begin
                    CableLabel.SetData(Rec);
                    CableLabel.RunModal();
                end;
            }

        }

        addlast(Action126)
        {
            action("COL LegacyItems")
            {
                ApplicationArea = All;
                Caption = 'Legacy Items';
                ToolTip = 'View legacy NAV items for the item.';
                Image = Item;
                RunObject = Page "COL Legacy Items";
                RunPageLink = "Item No." = field("No.");
            }
        }

        addafter(Structure)
        {
#if not HIDE_OLD_SKU_STRUCTURE
            action("COL SKU Structure")
            {
                ApplicationArea = All;
                Caption = 'SKU Structure (old)';
                Image = Hierarchy;
                ToolTip = 'View which child items are used in an item''s stockkeeping unit production BOM. Each item level can be collapsed or expanded to obtain an overview or detailed view.';

                trigger OnAction()
                var
                    CalculateSKUTree: Codeunit "COL Calculate SKU Tree";
                begin
                    CalculateSKUTree.OpenSKUStructure(Rec);
                end;
            }
#endif
            action("COL SKU Structure2")
            {
                ApplicationArea = All;
                Caption = 'SKU Structure';
                Image = Hierarchy;
                ToolTip = 'View which child items are used in an item''s stockkeeping unit production BOM. Each item level can be collapsed or expanded to obtain an overview or detailed view.';

                trigger OnAction()
                var
                    GenBOMStructure: Codeunit Weibel.Inventory.BOM."COL Gen. BOM Structure";
                begin
                    GenBOMStructure.GenerateBOMStructure(Rec);
                end;
            }
        }

        addafter(Structure_Promoted)
        {
            // actionref("COL SKU Structure_Promoted"; "COL SKU Structure") { }
            actionref("COL SKU Structure2_Promoted"; "COL SKU Structure2") { }
        }

        addafter(CopyItem_Promoted)
        {
            actionref("COL Print Cable_Promoted"; "COL Print Cable") { }
        }

        addlast(Category_Process)
        {
            actionref("COL Print BOM_Promoted"; "COL Print BOM") { }
        }

        addlast(Category_Report)
        {
            actionref("COL Print Item Label_Promoted"; "COL Print Item Label") { }
        }
    }
}