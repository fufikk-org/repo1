namespace Weibel.Inventory.BOM;

using Microsoft.Inventory.BOM;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Location;

pageextension 70221 "COL Bom Structure" extends "BOM Structure"
{
    layout
    {
        modify(ItemFilter)
        {
            Visible = not IsItemFilterHidden;
        }
        modify("Low-Level Code")
        {
            Visible = true;
        }
        addafter("Low-Level Code")
        {
            field("COL Indentation"; Rec.Indentation)
            {
                ApplicationArea = All;
                Caption = 'Indentation';
                Editable = false;
                ToolTip = 'Specifies the indentation level of the BOM line.';
                Visible = false;
            }
        }
        addafter(ItemFilter)
        {
            group("COL SKU Data")
            {
                // ShowCaption = false;
                Caption = 'SKU Information';
                Visible = IsItemFilterHidden;
                grid("COL SKU Fixed")
                {
                    GridLayout = Columns;

                    field("COL LocationCode"; SKU."Location Code")
                    {
                        ApplicationArea = All;
                        Caption = 'Location Code';
                        Editable = false;
                        ToolTip = 'Specifies location code from SKU.';
                    }
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
                }
            }
        }
        modify("Variant Code")
        {
            Visible = true;
        }

        addafter("Variant Code")
        {
#pragma warning disable AA0218
            field("COL Production BOM No."; Rec."Production BOM No.")
            {
                ApplicationArea = All;
            }
            field("COL Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
            }
#pragma warning restore AA0218
            field("COL Product Life Cycle"; Rec."COL Product Life Cycle")
            {
                DrillDown = false;
                Lookup = false;
                ApplicationArea = All;
                HideValue = (Rec.Type <> Rec.Type::Item) or (Rec."Variant Code" = '');
            }
            field("COL EU RoHS Dir. Compliant"; Rec."COL EU RoHS Dir. Compliant")
            {
                ApplicationArea = All;
                HideValue = Rec.Type <> Rec.Type::Item;
            }
            field("COL EU REACH Reg. Compliant"; Rec."COL EU REACH Reg. Compliant")
            {
                ApplicationArea = All;
                HideValue = Rec.Type <> Rec.Type::Item;
            }
            field("COL EU RoHS Status"; Rec."COL EU RoHS Status")
            {
                ApplicationArea = All;
                HideValue = Rec.Type <> Rec.Type::Item;
            }
        }
    }

    actions
    {
        addafter("Show Warnings")
        {
            action("COL SKU")
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
            action("COL Variant")
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
            action("COL Item")
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
            action("COL Production BOM")
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
        }

        addafter("Show Warnings_Promoted")
        {
            actionref("COL SKU_Promoted"; "COL SKU") { }
            actionref("COL Variant_Promoted"; "COL Variant") { }
            actionref("COL Item_Promoted"; "COL Item") { }
            actionref("COL Production BOM_Promoted"; "COL Production BOM") { }
        }
    }

    var
        SKU: Record "Stockkeeping Unit";
        BOMStructureWarnings: Codeunit "COL BOM Structure Warnings";
        IsItemFilterHidden: Boolean;

    procedure COLInitFromSKU(var NewSKU: Record "Stockkeeping Unit")
    begin
        BindSubscription(BOMStructureWarnings);
        SKU := NewSKU;
        ItemFilter := Format(NewSKU.SystemId);
        ShowBy := ShowBy::"COL SKU";
        IsItemFilterHidden := true;
    end;
}