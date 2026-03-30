namespace Weibel.Inventory.Item;

using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.Routing;
using Microsoft.Purchases.Document;
using Weibel.Inventory.Ledger;
using Microsoft.Manufacturing.ProductionBOM;
using Weibel.Inventory.LegacyItems;
using Weibel.Inventory.BOM.Tree;

pageextension 70101 "COL Item Card" extends "Item Card"
{
    layout
    {
        addlast(Item)
        {
            field("COL Manufacturer Item No."; Rec."COL Manufacturer Item No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the manufacturer item number used for the reporting purposes.';
            }
            group("COL Compliance Fields")
            {
                ShowCaption = false;
                field("COL EU RoHS Dir. Compliant"; Rec."COL EU RoHS Dir. Compliant")
                {
                    ApplicationArea = All;
                }
                field("COL EU REACH Reg. Compliant"; Rec."COL EU REACH Reg. Compliant")
                {
                    ApplicationArea = All;
                }
                field("COL EU RoHS Status"; Rec."COL EU RoHS Status")
                {
                    ApplicationArea = All;
                }
                field("COL Moisture Sensitivity Level"; Rec."COL Moisture Sensitivity Level")
                {
                    ApplicationArea = All;
                }
                field("COL NATO Stock No."; Rec."COL NATO Stock No.")
                {
                    ApplicationArea = All;
                }
            }
            field("COL Legacy Items Nos."; Rec."COL Legacy Items Nos.")
            {
                ApplicationArea = All;
                Importance = Additional;
            }
            group("COL MTBF")
            {
                ShowCaption = false;
                grid("COL MTBF Grid")
                {
                    group("COL Caption Group")
                    {
                        ShowCaption = false;
                        field("COL MTBF No."; Rec."COL MTBF No.")
                        {
                            ApplicationArea = All;
                        }
                        field("COL MTBF No. 2"; Rec."COL MTBF No. 2")
                        {
                            ApplicationArea = All;
                        }
                    }

                    group("COL Comment Group")
                    {
                        ShowCaption = false;
                        field("COL MTBF Comment"; Rec."COL MTBF Comment")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                        }
                        field("COL MTBF Comment 2"; Rec."COL MTBF Comment 2")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                        }
                    }
                }
            }

            group(COLOwner)
            {
                Caption = 'Owner';

                field("COL Created By User"; Rec."COL Created By User")
                {
                    ApplicationArea = All;
                }
                field("COL Creation Date"; Rec."COL Creation Date")
                {
                    ApplicationArea = All;
                }
            }
            field("COL Stockkeeping Units"; Rec."COL Stockkeeping Units")
            {
                ApplicationArea = All;
            }

        }
        addafter("Qty. on Purch. Order")
        {
            field("COL Out.Qty.Blank.Purch.Order"; OutQtyBase)
            {
                ApplicationArea = All;
                Caption = 'Qty. on Blanket Purch. Order';
                ToolTip = 'Specifies the quantity of an item on blanket purchase orders.';
                Editable = false;
                DecimalPlaces = 0 : 5;

                trigger OnDrillDown()
                begin
                    OpenBPL();
                end;
            }
        }
        addafter("Qty. on Asm. Component")
        {
            field("COL Qty. in Planning"; Rec.COLGetQtyInPlanningWorksheet())
            {
                ApplicationArea = All;
                Caption = 'Qty. in Planning';
                ToolTip = 'Specifies the quantity of an item in planning worksheet lines.';
                DecimalPlaces = 0 : 5;
                Editable = false;

                trigger OnDrillDown()
                begin
                    Rec.COLDrillDownQtyInPlanningWorksheet();
                end;
            }
        }
        addbefore(ForeignTrade)
        {
            group("COL Export Classification Group")
            {
                Caption = 'Export Classification';
                field("COL Export Classification"; Rec."COL Export Classification Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Export Classification Code field.';
                }
                field("COL EU Classification No."; Rec."COL EU Classification No.")
                {
                    ApplicationArea = All;
                    Editable = Rec."COL US Classification No." = '';
                    ToolTip = 'Specifies the value of the EU Classification No. field.';
                }
                field("COL US Classification No."; Rec."COL US Classification No.")
                {
                    ApplicationArea = All;
                    Editable = Rec."COL EU Classification No." = '';
                    ToolTip = 'Specifies the value of the US Classification No. field.';
                }
            }
        }
        addlast(Planning)
        {
            field("COL Item Configuration Type"; Rec."COL Item Configuration Type")
            {
                ApplicationArea = All;
            }
            field("COL Planning Blocked"; Rec."COL Planning Blocked")
            {
                ApplicationArea = All;
            }
        }
        addlast(Replenishment_Production)
        {
            field("COL Production Blocked"; Rec."COL Production Blocked")
            {
                ApplicationArea = All;
            }
            field("COL Proces.(Mont.For Routings)"; Rec."COL Proces.(Mont.For Routings)")
            {
                ApplicationArea = All;
            }
        }
        addafter("Service Blocked")
        {
            field("COL Project Blocked"; Rec."COL Project Blocked")
            {
                ApplicationArea = All;
            }
        }
        addlast(Warehouse)
        {
            field("COL Standard Placing Code"; Rec."COL Standard Placing Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Vendor Item No.")
        {
            field("COL Manufacturer"; Rec."COL Manufacturer")
            {
                ApplicationArea = All;
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

        addafter(CopyItem)
        {
            action("COL Copy Item")
            {
                AccessByPermission = TableData Item = I;
                ApplicationArea = Basic, Suite;
                Caption = 'Copy Item (New)';
                Image = Copy;
                ToolTip = 'Create a copy of the current item.';

                trigger OnAction()
                var
                    CopyItemSub: Codeunit "COL Copy Item Sub.";
                begin
                    BindSubscription(CopyItemSub);
                    Codeunit.Run(Codeunit::"Copy Item", Rec);
                    UnbindSubscription(CopyItemSub);
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
        addlast(Production)
        {
            action("COL Show Routing")
            {
                Caption = 'Show Routing';
                ToolTip = 'Open related routing for the item.';
                Enabled = Rec."Routing No." <> '';
                Image = RoutingVersions;
                ApplicationArea = All;
                ShortcutKey = 'Alt+R';

                trigger OnAction()
                var
                    RoutingHeader: Record "Routing Header";
                begin
                    if RoutingHeader.Get(Rec."Routing No.") then
                        Page.Run(Page::Routing, RoutingHeader);
                end;
            }
            action("COL Show Production BOM")
            {
                Caption = 'Show Production BOM';
                ToolTip = 'Open related production BOM for the item.';
                Enabled = Rec."Production BOM No." <> '';
                Image = BOM;
                ApplicationArea = All;
                ShortcutKey = 'Alt+W';

                trigger OnAction()
                var
                    ProductionBOMHeader: Record "Production BOM Header";
                begin
                    if ProductionBOMHeader.Get(Rec."Production BOM No.") then
                        Page.Run(Page::"Production BOM", ProductionBOMHeader);
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
        }

        addlast(Navigation_Item)
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

        addafter(BOMStructure)
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

        addafter(BOMStructure_Promoted)
        {
            // actionref("COL SKU Structure_Promoted"; "COL SKU Structure") { }
            actionref("COL SKU Structure2_Promoted"; "COL SKU Structure2") { }
        }

        addafter(CopyItem_Promoted)
        {
            actionref("COL Copy _Promoted"; "COL Copy Item") { }
            actionref("COL Print Cable_Promoted"; "COL Print Cable") { }
        }


        addlast(Category_Category4)
        {
            actionref("COL Show Routing_Promoted"; "COL Show Routing") { }
            actionref("COL Show Production BOM_Promoted"; "COL Show Production BOM") { }
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

    var
        OutQtyBase: Decimal;

    trigger OnAfterGetRecord()
    begin
        OutQtyBase := 0;
        Rec.CalcFields("COL Out.Qty.Blank.Purch.Order", "COL Qty. Purch.Order");
        OutQtyBase := Rec."COL Out.Qty.Blank.Purch.Order" - Rec."COL Qty. Purch.Order";
    end;

    local procedure OpenBPL()
    var
        PurchaseLine: Record "Purchase Line";
        PurchaseLines: Page "Purchase Lines";
    begin
        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::"Blanket Order");
        PurchaseLine.SetRange(Type, PurchaseLine.Type::Item);
        PurchaseLine.SetRange("No.", Rec."No.");

        PurchaseLine.SetFilter("Drop Shipment", Rec.GetFilter("Drop Shipment Filter"));
        PurchaseLine.SetFilter("Variant Code", Rec.GetFilter("Variant Filter"));
        PurchaseLine.SetFilter("Location Code", Rec.GetFilter("Location Filter"));
        PurchaseLine.SetFilter("Expected Receipt Date", Rec.GetFilter("Date Filter"));
        PurchaseLine.SetFilter("Shortcut Dimension 1 Code", Rec.GetFilter("Global Dimension 1 Filter"));
        PurchaseLine.SetFilter("Shortcut Dimension 2 Code", Rec.GetFilter("Global Dimension 2 Filter"));
        PurchaseLine.SetFilter("Unit of Measure Code", Rec.GetFilter("Unit of Measure Filter"));

        PurchaseLines.SetTableView(PurchaseLine);
        PurchaseLines.RunModal();
    end;
}