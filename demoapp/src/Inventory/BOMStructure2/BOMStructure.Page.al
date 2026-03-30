namespace Weibel.Inventory.BOM;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Manufacturing.Routing;

page 70245 "COL BOM Structure"
{
    ApplicationArea = All;
    Caption = 'BOM Structure';
    PageType = Worksheet;
    SourceTable = "COL BOM Structure";
    UsageCategory = None;
    SourceTableTemporary = true;
    Editable = false;

    layout
    {
        area(Content)
        {
            group("COL SKU Data")
            {
                Caption = 'SKU Information';
                grid("COL SKU Fixed")
                {
                    GridLayout = Columns;


                    field("COL Item No."; SKU."Item No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Item No.';
                        Editable = false;
                        ToolTip = 'Specifies item no. from SKU.';

                        trigger OnDrillDown()
                        var
                            Item: Record Item;
                        begin
                            Item.Get(SKU."Item No.");
                            Page.Run(Page::"Item Card", Item);
                        end;
                    }
                    field("COL Variant Code"; SKU."Variant Code")
                    {
                        ApplicationArea = All;
                        Caption = 'Variant Code';
                        Editable = false;
                        ToolTip = 'Specifies variant code from SKU.';

                        trigger OnDrillDown()
                        var
                            ItemVariant: Record "Item Variant";
                        begin
                            ItemVariant.Get(SKU."Item No.", SKU."Variant Code");
                            Page.Run(Page::"Item Variants", ItemVariant);
                        end;
                    }
                    field("COL LocationCode"; SKU."Location Code")
                    {
                        ApplicationArea = All;
                        Caption = 'Location Code';
                        Editable = false;
                        ToolTip = 'Specifies location code from SKU.';
                    }
                }
            }
            repeater(General)
            {

                ShowAsTree = true;
                IndentationColumn = Rec.Indentation;

                field(Type; Rec."Type")
                {
                }
                field("No."; Rec."No.")
                {
                    Style = Strong;
                    StyleExpr = not Rec."Is Leaf";
                }
                field(Description; Rec.Description)
                {
                    Style = Strong;
                    StyleExpr = not Rec."Is Leaf";
                }
                field(IndentationColumn; Rec.Indentation)
                {
                }
                field("Has Warnings"; Format(Rec."Has Warnings", 0, '<Text>'))
                {
                    Caption = 'Warning';
                    Style = Attention;
                    StyleExpr = Rec."Has Warnings";
                    ToolTip = 'Specifies if there exist warnings for current line.';
                    HideValue = not ShowLineWarningsEnabled;

                    trigger OnDrillDown()
                    begin
                        OpenLineWarnings();
                    end;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field("Variant Code"; Rec."Variant Code")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Production BOM No."; Rec."Production BOM No.")
                {
                    HideValue = Rec."Replenishment System" <> Rec."Replenishment System"::"Prod. Order";
                }
                field("Routing No."; Rec."Routing No.")
                {
                }
                field("Phantom BOM"; Rec."Phantom BOM")
                {
                }
#if not HIDE_IT8M_LOW_LEVEL
                field("Low-Level Code"; Rec."Low-Level Code")
                {
                    HideValue = Rec.Type <> Rec.Type::Item;
                }
#endif                
                field("Qty. per Parent"; Rec."Qty. per Parent")
                {
                }
                field("Replenishment System"; Rec."Replenishment System")
                {
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                }
                field("Item Tracking Code"; Rec."Item Tracking Code")
                {
                }
                field("COL Product Life Cycle"; Rec."COL Product Life Cycle")
                {
                    HideValue = Rec.Type <> Rec.Type::Item;
                }
                field("COL EU RoHS Dir. Compliant"; Rec."COL EU RoHS Dir. Compliant")
                {
                    HideValue = Rec.Type <> Rec.Type::Item;
                }
                field("COL EU REACH Reg. Compliant"; Rec."COL EU REACH Reg. Compliant")
                {
                    HideValue = Rec.Type <> Rec.Type::Item;
                }
                field("COL EU RoHS Status"; Rec."COL EU RoHS Status")
                {
                    HideValue = Rec.Type <> Rec.Type::Item;
                }
                field(Blocked; Rec.Blocked)
                {
                    HideValue = Rec.Type <> Rec.Type::Item;
                }
                field("Sales Blocked"; Rec."Sales Blocked")
                {
                    HideValue = Rec.Type <> Rec.Type::Item;
                }
                field("Purchasing Blocked"; Rec."Purchasing Blocked")
                {
                    HideValue = Rec.Type <> Rec.Type::Item;
                }
                field("Service Blocked"; Rec."Service Blocked")
                {
                    HideValue = Rec.Type <> Rec.Type::Item;
                }
                field("COL Production Blocked"; Rec."COL Production Blocked")
                {
                    HideValue = Rec.Type <> Rec.Type::Item;
                }
                field("COL Planning Blocked"; Rec."COL Planning Blocked")
                {
                    HideValue = Rec.Type <> Rec.Type::Item;
                }
                field("COL Project Blocked"; Rec."COL Project Blocked")
                {
                    HideValue = Rec.Type <> Rec.Type::Item;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(OnlyWarnings)
            {
                Caption = 'Only Warnings';
                Image = ErrorLog;
                ToolTip = 'Show only lines with warnings (clicking again removes the filter).';

                trigger OnAction()
                begin
                    if Rec.GetFilter("Has Warnings") <> '' then
                        Rec.SetRange("Has Warnings")
                    else
                        Rec.SetRange("Has Warnings", true);
                end;
            }
            action(ShowWarnings)
            {
                Caption = 'Show Warnings';
                Image = ErrorLog;
                ToolTip = 'Show all collected warnings.';

                trigger OnAction()
                begin
                    OpenAllWarnings();
                end;
            }
        }
        area(Navigation)
        {
            action(SKUCard)
            {
                Caption = 'SKU Card';
                ToolTip = 'Open SKU Card for related item, variant and location code.';
                Image = SKU;
                ApplicationArea = All;
                Enabled = Rec.Type = Rec.Type::Item;
                RunObject = page "Stockkeeping Unit Card";
                RunPageLink = "Location Code" = field("Location Code"), "Item No." = field("No."), "Variant Code" = field("Variant Code");
                RunPageMode = View;
            }
            action("Variant")
            {
                Caption = 'Variant';
                ToolTip = 'Open variant list for selected item and variant.';
                Image = ItemVariant;
                ApplicationArea = All;
                Enabled = Rec.Type = Rec.Type::Item;
                RunObject = page "Item Variants";
                RunPageLink = "Item No." = field("No."), "Code" = field("Variant Code");
                RunPageMode = View;
            }
            action(Item)
            {
                Caption = 'Item';
                ToolTip = 'Open item card for selected item.';
                Image = Item;
                ApplicationArea = All;
                Enabled = Rec.Type = Rec.Type::Item;
                RunObject = page "Item Card";
                RunPageLink = "No." = field("No.");
                RunPageMode = View;
            }
            action("Production BOM")
            {
                Caption = 'Production BOM';
                ToolTip = 'Open production bom.';
                Image = BOM;
                ApplicationArea = All;
                Enabled = Rec."Production BOM No." <> '';
                RunObject = page "Production BOM";
                RunPageLink = "No." = field("Production BOM No.");
                RunPageMode = View;
            }
            action(Routing)
            {
                Caption = 'Routing';
                ToolTip = 'Open routing.';
                Image = ExplodeRouting;
                ApplicationArea = All;
                Enabled = Rec."Routing No." <> '';
                RunObject = page "Routing";
                RunPageLink = "No." = field("Routing No.");
                RunPageMode = View;
            }
            action(ShowLineWarnings)
            {
                Caption = 'Show Line Warnings';
                Image = ErrorLog;
                Scope = Repeater;
                Enabled = ShowLineWarningsEnabled;
                ToolTip = 'Executes the Show Line Warnings action.';

                trigger OnAction()
                begin
                    OpenLineWarnings();
                end;
            }
        }

        area(Promoted)
        {
            actionref("OnlyWarnings_Promoted"; "OnlyWarnings") { }
            actionref(ShowWarnings_Promoted; ShowWarnings) { }
            actionref("SKUCard_Promoted"; "SKUCard") { }
            actionref("Variant_Promoted"; "Variant") { }
            actionref("Item_Promoted"; "Item") { }
            actionref("Production BOM_Promoted"; "Production BOM") { }
            actionref("Routing_Promoted"; "Routing") { }
        }
    }

    var
        SKU: Record "Stockkeeping Unit";
        TempBOMStructureWarning: Record "COL BOM Structure Warning" temporary;
        ShowLineWarningsEnabled: Boolean;

    trigger OnAfterGetRecord()
    begin
        ShowLineWarningsEnabled := Rec."Has Warnings";
    end;

    local procedure OpenLineWarnings()
    begin
        if not Rec."Has Warnings" then
            exit;
        TempBOMStructureWarning.SetRange("Parent Entry No.", Rec."Entry No.");
        Page.Run(Page::"COL BOM Structure Warnings", TempBOMStructureWarning);
    end;

    local procedure OpenAllWarnings()
    begin
        TempBOMStructureWarning.Reset();
        if TempBOMStructureWarning.FindFirst() then
            Page.Run(Page::"COL BOM Structure Warnings", TempBOMStructureWarning);
    end;

    procedure SetData(var NewSKU: Record "Stockkeeping Unit"; var TempBOMStructure: Record "COL BOM Structure" temporary; var TempBOMStructureWarning2: Record "COL BOM Structure Warning" temporary)
    begin
        SKU := NewSKU;
        CurrPage.Caption := SKU."Item No.";

        Rec.Reset();
        Rec.DeleteAll();
        Rec.Copy(TempBOMStructure, true);
        if Rec.FindFirst() then;

        TempBOMStructureWarning.Copy(TempBOMStructureWarning2, true);
    end;
}
