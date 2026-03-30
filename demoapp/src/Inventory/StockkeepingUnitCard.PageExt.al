namespace Weibel.Inventory.Location;

using Microsoft.Inventory.Location;
using Microsoft.Manufacturing.ProductionBOM;
using Weibel.Inventory.BOM;
using Microsoft.Manufacturing.Routing;
using Microsoft.Inventory.Item.Attribute;
using Microsoft.Inventory.BOM;
using Weibel.Inventory.Setup;
using Microsoft.Inventory.Item;
using Weibel.Manufacturing.ProductionBOM;
using Weibel.Inventory.Item;
using Weibel.Inventory.BOM.Tree;
using Microsoft.Inventory.Setup;
using Weibel.Manufacturing.Reports;

pageextension 70122 "COL Stockkeeping Unit Card" extends "Stockkeeping Unit Card"
{
    layout
    {
        modify("Variant Code")
        {
            trigger OnAfterValidate()
            begin
                ShowRohs();
            end;
        }

        addafter(Description)
        {
            field("COL Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the description 2 from the Item Card.';
            }
        }
        addlast(General)
        {
            field("COL Product Life Cycle"; Rec."COL Product Life Cycle")
            {
                ApplicationArea = All;
            }
            field("COL Changed By"; Rec."COL Changed By")
            {
                ApplicationArea = All;
            }
            field("COL Date Changed"; Rec."COL Date Changed")
            {
                ApplicationArea = All;
            }
            field("COL EU REACH Reg. Compliant"; EUREACHRegCompliant)
            {
                ApplicationArea = All;
                Caption = 'EU REACH Regulation Compliant';
                ToolTip = 'Specifies the value of the EU REACH Regulation Compliant field.';

                trigger OnValidate()
                begin
                    Rec.UpdateROHS(EURoHSStatus, EURoHSDirCompliant, EUREACHRegCompliant, Rec.FieldNo("COL EU REACH Reg. Compliant"));
                end;
            }
            field("COL EU RoHS Dir. Compliant"; EURoHSDirCompliant)
            {
                ApplicationArea = All;
                Caption = 'EU RoHS Directive Compliant';
                ToolTip = 'Specifies the value of the EU RoHS Directive Compliant field.';
                trigger OnValidate()
                begin
                    Rec.UpdateROHS(EURoHSStatus, EURoHSDirCompliant, EUREACHRegCompliant, Rec.FieldNo("COL EU RoHS Dir. Compliant"));
                end;
            }
            field("COL EU RoHS Status"; EURoHSStatus)
            {
                ApplicationArea = All;
                Caption = 'EU RoHS Status';
                ToolTip = 'Specifies the value of the EU RoHS Status field.';

                trigger OnValidate()
                begin
                    Rec.UpdateROHS(EURoHSStatus, EURoHSDirCompliant, EUREACHRegCompliant, Rec.FieldNo("COL EU RoHS Status"));
                end;
            }
            group("COL Prevent Negative Inventory")
            {
                Caption = 'SKU Prevent Negative Inventory';

                field("COL PreventNegInventoryDefaultYes"; Rec."COL SKU Prevent Negative Inv.")
                {
                    ApplicationArea = Basic, Suite;
                }

                field("COL CurrDefault"; CurrDefault)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Caption = 'Current Default Value';
                    ToolTip = 'Indicates whether the Prevent Negative Inventory setting is currently set to Yes.';
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
                field("COL Item Created By User"; Rec."COL Item Created By User")
                {
                    ApplicationArea = All;
                    DrillDown = false;
                }
            }
        }
        addlast(factboxes)
        {
            part("COL ItemAttributesFactbox"; "Item Attributes Factbox")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        addafter("&Picture")
        {
            action("COL Attributes")
            {
                AccessByPermission = tabledata "Item Attribute" = R;
                ApplicationArea = Basic, Suite;
                Caption = 'Attributes';
                Image = Category;
                ToolTip = 'View or edit the item''s attributes, such as color, size, or other characteristics that help to describe the item.';

                trigger OnAction()
                var
                    Item: Record Item;
                begin
                    Item.Get(Rec."Item No.");
                    Page.RunModal(Page::"Item Attribute Value Editor", Item);
                    CurrPage.SaveRecord();
                    CurrPage."COL ItemAttributesFactbox".Page.LoadItemAttributesData(Rec."Item No.");
                end;
            }
        }
        addlast(processing)
        {
            action("COL PrintLabel")
            {
                AccessByPermission = TableData Item = I;
                ApplicationArea = Basic, Suite;
                Image = Print;
                Caption = 'Print Label';
                ToolTip = 'Print Label';

                trigger OnAction()
                var
                    StockkeepingUnit: Record "Stockkeeping Unit";
                    WeibelItemODCLabel: Report "COL Weibel Item ODC Label";
                begin
                    StockkeepingUnit.SetRange("Location Code", Rec."Location Code");
                    StockkeepingUnit.SetRange("Item No.", Rec."Item No.");
                    StockkeepingUnit.SetRange("Variant Code", Rec."Variant Code");
                    StockkeepingUnit.FindFirst();
                    WeibelItemODCLabel.InitFrom(StockkeepingUnit);
                    WeibelItemODCLabel.RunModal();
                end;
            }
            action("COL SMD Print")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print SMD Label';
                Image = Copy;
                ToolTip = 'Print SMD Label for item.';

                trigger OnAction()
                var
                    StockkeepingUnit: Record "Stockkeeping Unit";
                    SMDLabel: Report "COL SMD Label";
                begin
                    StockkeepingUnit.SetRange("Location Code", Rec."Location Code");
                    StockkeepingUnit.SetRange("Item No.", Rec."Item No.");
                    StockkeepingUnit.SetRange("Variant Code", Rec."Variant Code");
                    SMDLabel.SetTableView(StockkeepingUnit);
                    SMDLabel.RunModal();
                end;
            }

            action("COL Create BOM and Routing")
            {
                Caption = 'Create BOM and Routing';
                ToolTip = 'Create Production BOM and Routing for the item.';
                Image = CreateBinContent;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Codeunit.Run(Codeunit::"COL Create BOM and Routing", Rec);
                end;
            }
        }

        addlast(navigation)
        {
            group("COL Production")
            {
                Caption = 'Production';
                Image = Production;

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
                action("COL Where-Used")
                {
                    AccessByPermission = TableData "BOM Component" = R;
                    ApplicationArea = Assembly;
                    Caption = 'Where-Used';
                    Image = Track;
                    ToolTip = 'View a list of assembly BOMs in which the item SKU is used.';

                    trigger OnAction()
                    var
                        ProdBOMWhereUsed: Page "COL SKU Prod. BOM Where-Used";
                    begin
                        ProdBOMWhereUsed.SetSKU(Rec, WorkDate());
                        ProdBOMWhereUsed.RunModal();
                    end;
                }
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
                        GenBOMStructure: Codeunit "COL Gen. BOM Structure";
                    begin
                        GenBOMStructure.GenerateBOMStructure(Rec);
                    end;
                }
                action("COL SKU BOM Compare")
                {
                    ApplicationArea = Basic, Suite;
                    Image = Components;
                    Caption = 'SKU BOM Compare';
                    ToolTip = 'Print SKU BOM Compare Report';

                    trigger OnAction()
                    var
                        SKUCompareList: Report "COL SKU Compare List";
                    begin
                        SKUCompareList.InitializeRequest(Rec, Today());
                        SKUCompareList.RunModal();
                    end;
                }
                action("COL Calc Unit Cost")
                {
                    Caption = 'Calc. Unit Cost';
                    ToolTip = 'Calculate Unit Cost for selected SKU and Item.';
                    Image = Calculate;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        CalcSKUUnitCost: Codeunit "COL Calc. SKU Unit Cost";
                        uc: Decimal;
                    begin
                        uc := CalcSKUUnitCost.CalculateSkuUnitCost(Rec, true);
                        CalcSKUUnitCost.UpdateSKU(Rec, uc, true);
                    end;
                }
            }
        }
        addlast("&SKU")
        {
            action("COL ImportBOMLine")
            {
                ApplicationArea = All;
                Caption = 'Import Production BOM';
                Image = Import;
                ToolTip = 'Import Production BOM lines from a text file.';

                trigger OnAction()
                var
                    ImportProductionBOM: Codeunit "COL Import Prod. BOM Lines";
                begin
                    ImportProductionBOM.ImportProdBOMLines(Rec);
                end;
            }
        }

        addafter("&Picture_Promoted")
        {
            actionref("COL Attributes_Promoted"; "COL Attributes") { }
        }
        addlast(Category_Process)
        {
            actionref("COL PrintLabel_Promoted"; "COL PrintLabel") { }
            actionref("COL SMD Print _Promoted"; "COL SMD Print") { }
            // actionref("COL SKU Structure_Promoted"; "COL SKU Structure") { }
            actionref("COL SKU Structure2_Promoted"; "COL SKU Structure2") { }
            actionref("COL SKU BOM Compare_Promoted"; "COL SKU BOM Compare") { }
        }
        addlast(Category_SKU)
        {
            actionref("COL Show Routing_Promoted"; "COL Show Routing") { }
            actionref("COL Show Production BOM_Promoted"; "COL Show Production BOM") { }
            actionref("COL Where-Used_Promoted"; "COL Where-Used") { }
            actionref("COL Calc Unit Cost_Promoted"; "COL Calc Unit Cost") { }
            actionref("COL Create BOM and Routing_Promoted"; "COL Create BOM and Routing") { }
            actionref("COL ImportBOMLine_Promoted"; "COL ImportBOMLine") { }
        }

    }
    var
        EURoHSStatus: Text[20];
        EURoHSDirCompliant: Enum "COL EU RoHS Dir. Compliant";
        EUREACHRegCompliant: Enum "COL EU REACH Reg. Compliant";
        CurrDefault: Boolean;

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage."COL ItemAttributesFactbox".Page.LoadItemAttributesData(Rec."Item No.");
        ShowRohs();
    end;

    trigger OnOpenPage()
    var
        InventorySetup: Record "Inventory Setup";
    begin
        if InventorySetup.Get() then
            CurrDefault := InventorySetup."COL SKU Prevent Negative Inv.";
    end;

    local procedure ShowRohs()
    begin
        if Rec."Variant Code" <> '' then begin
            Rec.CalcFields("COL V.EU RoHS Status", "COL V.EU RoHS Dir. Compliant", "COL V.EU REACH Reg. Compliant");
            EURoHSStatus := Rec."COL V.EU RoHS Status";
            EURoHSDirCompliant := Rec."COL V.EU RoHS Dir. Compliant";
            EUREACHRegCompliant := Rec."COL V.EU REACH Reg. Compliant";
        end else begin
            Rec.CalcFields("COL EU RoHS Status", "COL EU RoHS Dir. Compliant", "COL EU REACH Reg. Compliant");
            EURoHSStatus := Rec."COL EU RoHS Status";
            EURoHSDirCompliant := Rec."COL EU RoHS Dir. Compliant";
            EUREACHRegCompliant := Rec."COL EU REACH Reg. Compliant";
        end;
    end;
}