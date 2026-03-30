namespace Weibel.Inventory.Location;

using Microsoft.Inventory.Location;
using Microsoft.Inventory.Item.Attribute;
using System.Reflection;
using System.Environment;
using Microsoft.Inventory.Item;
using Weibel.Inventory.Item;
using Weibel.Inventory.BOM.Tree;
using Weibel.Inventory.BOM;
using Weibel.Manufacturing.ProductionBOM;
using Weibel.Manufacturing.Reports;

pageextension 70121 "COL Stockkeeping Unit List" extends "Stockkeeping Unit List"
{
    layout
    {
        addlast(Control1)
        {
#pragma warning disable AA0218
            field("COL Production BOM No."; Rec."Production BOM No.")
#pragma warning restore AA0218
            {
                ApplicationArea = All;
            }
#if not HIDE_LOWLEVEL_SKU
            field("COL Low-Level Code"; Rec."COL Low-Level Code")
            {
                ApplicationArea = All;

                trigger OnDrillDown()
                var
                    SKULowLevelDetail: Record "COL SKU Low Level Detail";
                begin
                    SKULowLevelDetail.SetRange("Item No.", Rec."Item No.");
                    SKULowLevelDetail.SetRange("Variant Code", Rec."Variant Code");
                    SKULowLevelDetail.SetRange("Location Code", Rec."Location Code");
                    Page.Run(Page::"COL SKU Low Level Detail", SKULowLevelDetail);
                end;
            }
            field("COL Item Low-Level Code"; Rec."COL Item Low-Level Code")
            {
                ApplicationArea = All;
                Visible = false;
            }
#endif
            field("COL Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity of this item that is on purchase orders.';
            }
            field("COL Qty. on Prod. Order"; Rec."Qty. on Prod. Order")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity of this item that is on production orders.';
            }
            field("COL Qty. in Transit"; Rec."Qty. in Transit")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity of this item that is in transit.';
            }
            field("COL Qty. on Component Lines"; Rec."Qty. on Component Lines")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity of this item that is on component lines.';
            }
            field("COL Qty. on Sales Order"; Rec."Qty. on Sales Order")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity of this item that is on sales orders.';
            }
            field("COL Qty. on Service Order"; Rec."Qty. on Service Order")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity of this item that is on service orders.';
            }
            field("COL Qty. on Job Order"; Rec."Qty. on Job Order")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity of this item that is on job orders.';
            }
            field("COL Qty. on Assembly Order"; Rec."Qty. on Assembly Order")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity of this item that is on assembly orders.';
            }
            field("COL Trans. Ord. Receipt (Qty.)"; Rec."Trans. Ord. Receipt (Qty.)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity of this item that is on transfer order receipts.';
            }
            field("COL Trans. Ord. Shipment (Qty.)"; Rec."Trans. Ord. Shipment (Qty.)")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity of this item that is on transfer order shipments.';
            }
        }
        addafter(Description)
        {
            field("COL Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the description 2 from the Item Card.';
                Visible = false;
            }
        }
        addlast(factboxes)
        {
            part("COL ItemAttributesFactBox"; "Item Attributes Factbox")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        addlast("&Item")
        {
            action("COL Attributes")
            {
                AccessByPermission = tabledata "Item Attribute" = R;
                ApplicationArea = Suite;
                Caption = 'Attributes';
                Image = Category;
                Scope = Repeater;
                ToolTip = 'View or edit the item''s attributes, such as color, size, or other characteristics that help to describe the item.';

                trigger OnAction()
                var
                    Item: Record Item;
                begin
                    Item.Get(Rec."Item No.");
                    Page.RunModal(Page::"Item Attribute Value Editor", Item);
                    CurrPage.SaveRecord();
                    CurrPage."COL ItemAttributesFactBox".Page.LoadItemAttributesData(Rec."Item No.");
                end;
            }
        }
        addlast("F&unctions")
        {
            action("COL FilterByAttributes")
            {
                AccessByPermission = tabledata "Item Attribute" = R;
                ApplicationArea = Basic, Suite;
                Caption = 'Filter by Attributes';
                Image = EditFilter;
                ToolTip = 'Find items that match specific attributes. To make sure you include recent changes made by other users, clear the filter and then reset it.';

                trigger OnAction()
                var
                    TempItemFilteredFromAttributes: Record Item temporary;
                    ItemAttributeManagement: Codeunit "Item Attribute Management";
                    TypeHelper: Codeunit "Type Helper";
                    CloseAction: Action;
                    FilterText: Text;
                    FilterPageID: Integer;
                    ParameterCount: Integer;
                    TooManyMatchesErr: Label 'There are too many items that match the filter. Narrow your search and try again.';
                begin
                    FilterPageID := Page::"Filter Items by Attribute";
                    if ClientTypeManagement.GetCurrentClientType() = ClientType::Phone then
                        FilterPageID := Page::"Filter Items by Att. Phone";

                    CloseAction := Page.RunModal(FilterPageID, TempFilterItemAttributesBuffer);
                    if (ClientTypeManagement.GetCurrentClientType() <> ClientType::Phone) and (CloseAction <> Action::LookupOK) then
                        exit;

                    if TempFilterItemAttributesBuffer.IsEmpty() then begin
                        ClearAttributesFilter();
                        exit;
                    end;
                    TempItemFilteredFromAttributes.Reset();
                    TempItemFilteredFromAttributes.DeleteAll();
                    ItemAttributeManagement.FindItemsByAttributes(TempFilterItemAttributesBuffer, TempItemFilteredFromAttributes);
                    FilterText := ItemAttributeManagement.GetItemNoFilterText(TempItemFilteredFromAttributes, ParameterCount);

                    if ParameterCount < TypeHelper.GetMaxNumberOfParametersInSQLQuery() - 100 then begin
                        Rec.FilterGroup(0);
                        Rec.MarkedOnly(false);
                        Rec.SetFilter("Item No.", FilterText);
                    end else
                        Error(TooManyMatchesErr);
                end;
            }
            action("COL ClearAttributes")
            {
                AccessByPermission = tabledata "Item Attribute" = R;
                ApplicationArea = Basic, Suite;
                Caption = 'Clear Attributes Filter';
                Image = RemoveFilterLines;
                ToolTip = 'Remove the filter for specific item attributes.';

                trigger OnAction()
                begin
                    ClearAttributesFilter();
                end;
            }
        }

#if not HIDE_LOWLEVEL_SKU
        addlast(Processing)
        {
            action("COL WeibelCalculateLowLevelForSKU")
            {
                ApplicationArea = All;
                Caption = 'Calculate Low Level for SKU (Weibel)';
                Image = Calculate;
                ToolTip = 'Calculate Low Level Code values for SKUs.';

                trigger OnAction()
                var
                    WeibelLowLevelCalc: Codeunit "COL Weibel Low Level Calc.";
                begin
                    WeibelLowLevelCalc.RunLowLevelCalculations();
                end;
            }
        }

        addlast(navigation)
        {
            group("COL Low Level Codes")
            {
                Caption = 'Low Level Codes';
                Image = Inventory;

                action("COL LowLevel Warnings")
                {
                    ApplicationArea = All;
                    Caption = 'Low Level Warnings';
                    ToolTip = 'Opens list of low level calculation warnings.';
                    Image = Log;

                    trigger OnAction()
                    var
                        LowLevelCalcWarningMgt: Codeunit "COL LowLevel Calc. Warning Mgt";
                    begin
                        LowLevelCalcWarningMgt.ShowWarnings();
                    end;
                }
                action("COL LowLevel Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Low Level Setup';
                    ToolTip = 'Open setup for low level code calculations.';
                    Image = Setup;
                    RunObject = page "COL Weibel Low Level Setup";
                }
            }
        }
#endif

        addlast(reporting)
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
                    CurrPage.SetSelectionFilter(StockkeepingUnit);
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
                    CurrPage.SetSelectionFilter(StockkeepingUnit);
                    SMDLabel.SetTableView(StockkeepingUnit);
                    SMDLabel.RunModal();
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
                    StockkeepingUnit: Record "Stockkeeping Unit";
                    SKUCompareList: Report "COL SKU Compare List";
                begin
                    CurrPage.SetSelectionFilter(StockkeepingUnit);
                    SKUCompareList.InitializeRequest(StockkeepingUnit, Today());
                    SKUCompareList.RunModal();
                end;
            }
        }

        addlast(Production_Navigation)
        {
#if not HIDE_OLD_SKU_STRUCTURE
            action("COL SKU Structure")
            {
                ApplicationArea = All;
                Caption = 'SKU Structure (old)';
                Scope = Repeater;
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
                Scope = Repeater;
                Image = Hierarchy;
                ToolTip = 'View which child items are used in an item''s stockkeeping unit production BOM. Each item level can be collapsed or expanded to obtain an overview or detailed view.';

                trigger OnAction()
                var
                    GenBOMStructure: Codeunit "COL Gen. BOM Structure";
                begin
                    GenBOMStructure.GenerateBOMStructure(Rec);
                end;
            }
        }

        addlast(Promoted)
        {
            group("COL Attributes Group Promoted")
            {
                Caption = 'Attributes';

                actionref("COL Attributes_Promoted"; "COL Attributes") { }
                actionref("COL FilterByAttributes_Promoted"; "COL FilterByAttributes") { }
                actionref("COL ClearAttributes_Promoted"; "COL ClearAttributes") { }
            }
#if not HIDE_LOWLEVEL_SKU
            group("COL Weibel Low Level")
            {
                Caption = 'Weibel Low-Level';
                Image = Inventory;

                actionref("COL WeibelCalculateLowLevelForSKU_Promoted"; "COL WeibelCalculateLowLevelForSKU") { }
                actionref("COL LowLevel Warnings_Promoted"; "COL LowLevel Warnings") { }
                actionref("COL LowLevel Setup_Promoted"; "COL LowLevel Setup") { }
            }
#endif            
        }
        addlast(Category_Report)
        {
            actionref("COL PrintLabel_Promoted"; "COL PrintLabel") { }
            actionref("COL SMD Print _Promoted"; "COL SMD Print") { }
            actionref("COL SKU BOM Compare_Promoted"; "COL SKU BOM Compare") { }
        }
        addlast(Category_Item)
        {
            // actionref("COL SKU Structure_Promoted"; "COL SKU Structure") { }
            actionref("COL SKU Structure2_Promoted"; "COL SKU Structure2") { }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage."COL ItemAttributesFactBox".Page.LoadItemAttributesData(Rec."Item No.");
    end;

    var
        TempFilterItemAttributesBuffer: Record "Filter Item Attributes Buffer" temporary;
        ClientTypeManagement: Codeunit "Client Type Management";

    local procedure ClearAttributesFilter()
    begin
        Rec.ClearMarks();
        Rec.MarkedOnly(false);
        Rec.FilterGroup(0);
        Rec.SetRange("Item No.");
    end;
}