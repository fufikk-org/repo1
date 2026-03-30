namespace Weibel.Inventory.Requisition;

using Microsoft.Inventory.Requisition;
using Microsoft.Inventory.Item.Attribute;
using Microsoft.Inventory.Item;
using System.Reflection;
using System.Environment;
using Weibel.Inventory.Item.Attribute;
using Microsoft.Purchases.Document;
using Weibel.Purchases.Document;
using Weibel.Inventory.Item;
using Weibel.Inventory.Planning;
using Microsoft.Inventory.Planning;
using Microsoft.Manufacturing.Planning;
using Microsoft.Inventory.Tracking;

pageextension 70137 "COL Req.Worksheet" extends "Req. Worksheet"
{
    layout
    {
        addlast(factboxes)
        {
            part(COLSKUReplenishmentFB; "COL SKU Replenishment FactBox")
            {
                ApplicationArea = Planning;
                SubPageLink = "Item No." = field("No."), "Variant Code" = field("Variant Code"), "Location Code" = field("Location Code");
            }
            part(COLSKUPlanningFB; "COL SKU Planning FactBox")
            {
                ApplicationArea = Planning;
                SubPageLink = "Item No." = field("No."), "Variant Code" = field("Variant Code"), "Location Code" = field("Location Code");
            }
        }
        modify(Control1903326807)
        {
            Visible = false;
        }
        addlast(Control1)
        {
            field("COL Purchaser Code"; Rec."COL Purchaser Code")
            {
                ApplicationArea = All;
            }
            field("COL Qty. On Purch. Order"; Rec."COL Qty. On Purch. Order")
            {
                ApplicationArea = All;
            }
#pragma warning disable AA0218
        }

        addafter("Variant Code")
        {
            field("COL Product Life Cycle"; Rec."COL Product Life Cycle")
            {
                ApplicationArea = All;
            }
        }
        modify("No.")
        {
            LookupPageId = "COL Item Planning Lookup";
        }
        modify("Variant Code")
        {
            ShowMandatory = VariantCodeMandatory2;
            trigger OnLookup(var Text: Text): Boolean
            var
                ItemVariant: Record "Item Variant";
                ItemVariants: Page "Item Variants";
            begin
                if Rec.Type <> Enum::"Requisition Line Type"::Item then
                    exit;

                if Rec."No." = '' then
                    exit;

                ItemVariant.SetRange("COL Planning Blocked", false);
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

        addfirst(Control1)
        {
            field("COL Warning"; Warning)
            {
                ApplicationArea = All;
                Caption = 'Warning';
                Editable = false;
                ShowMandatory = false;
                ToolTip = 'Displays potential warning for the line';

                trigger OnDrillDown()
                begin
                    PlanningTransparency.SetCurrReqLine(Rec);
                    PlanningTransparency.DrillDownUntrackedQty('');
                end;
            }
        }
        addlast(factboxes)
        {
            // part(COLPromisedDatesLine; "COL Promised Dates Line")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Promised Purchase Receipt Dates';
            //     SubPageLink = "No." = Field("No."), Type = filter(Item), "Document Type" = filter("Order"), "Promised Receipt Date" = filter(<> 0D);
            // }
            part(COLpurchaseOrderLines; "COL Purchase Line Details")
            {
                ApplicationArea = All;
                Caption = 'Purchase Line Details';
                SubPageLink = "No." = Field("No."), Type = filter(Item), "Document Type" = filter("Order" | "Blanket Order");
            }
        }
    }

    actions
    {
        addlast("F&unctions")
        {
            action(COLAcceptActionMessages)
            {
                ApplicationArea = Planning;
                Caption = 'Calculate Action Messages';
                Ellipsis = true;
                Image = SuggestLines;
                ToolTip = 'Accept the action message for the valid lines. This will set the "Accept Action Message" field to true for eligible lines and false otherwise.';
                trigger OnAction()
                begin
                    CalculateActionMessages();
                end;
            }
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
                    if Rec.Type <> Enum::"Requisition Line Type"::Item then
                        exit;
                    Item.Get(Rec."No.");
                    Page.RunModal(Page::"Item Attribute Value Editor", Item);
                    CurrPage.SaveRecord();
                end;
            }
            action("COL FilterByAttributes")
            {
                AccessByPermission = tabledata "Item Attribute" = R;
                ApplicationArea = Basic, Suite;
                Caption = 'Filter by Attributes';
                Image = EditFilter;
                ToolTip = 'Find items that match specific attributes. To make sure you include recent changes made by other users, clear the filter and then reset it.';

                trigger OnAction()
                var
                    ItemAttrFilterMgt: Codeunit "COL Item Attr. Filter Mgt.";
                    FilterText: Text;
                    FilterCriteriaId: Guid;
                begin
                    FilterCriteriaId := CreateGuid();
                    if ItemAttrFilterMgt.GetItemAttributeFilterOrInsertCriteria(FilterText, Database::"Requisition Line", FilterCriteriaId) then begin
                        Rec.FilterGroup(0);
                        Rec.MarkedOnly(false);
                        Rec.SetFilter("COL Filter Criteria ID", '');
                        Rec.SetRange("COL Matches Criteria");
                        Rec.SetRange(Type, Enum::"Requisition Line Type"::Item);
                        Rec.SetFilter("No.", FilterText);
                    end else begin
                        Rec.FilterGroup(0);
                        Rec.MarkedOnly(false);
                        Rec.SetAutoCalcFields("COL Matches Criteria");
                        Rec.SetRange(Type, Enum::"Requisition Line Type"::Item);
                        Rec.SetRange("No.");
                        Rec.SetFilter("COL Filter Criteria ID", FilterCriteriaId);
                        Rec.SetRange("COL Matches Criteria", true);
                    end;
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
            action("COL Set All")
            {
                Caption = 'Set All Action Messages';
                ApplicationArea = Basic, Suite;
                Image = Approve;
                ToolTip = 'Set all action messages for the selected items.';
                trigger OnAction()
                var
                    RequisitionLine: Record "Requisition Line";
                begin
                    RequisitionLine.CopyFilters(Rec);
                    RequisitionLine.SetRange("Worksheet Template Name", Rec."Worksheet Template Name");
                    RequisitionLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    RequisitionLine.SetRange(Type, Rec.Type);
                    RequisitionLine.SetRange("Action Message", RequisitionLine."Action Message"::New);
                    RequisitionLine.ModifyAll("Accept Action Message", true);
                end;
            }
            action("COL UnSet All")
            {
                Caption = 'Remove All Action Messages';
                ApplicationArea = Basic, Suite;
                Image = UnApply;
                ToolTip = 'Remove all action messages for the selected items.';
                trigger OnAction()
                var
                    RequisitionLine: Record "Requisition Line";
                begin
                    RequisitionLine.CopyFilters(Rec);
                    RequisitionLine.SetRange("Worksheet Template Name", Rec."Worksheet Template Name");
                    RequisitionLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    RequisitionLine.SetRange(Type, Rec.Type);
                    RequisitionLine.ModifyAll("Accept Action Message", false);
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
        }
        addlast(Category_Process)
        {
            actionref(COLAcceptActionMessages_Promoted; COLAcceptActionMessages) { }
            actionref("COL Set All_Promoted"; "COL Set All") { }
            actionref("COL UnSet All_Promoted"; "COL UnSet All") { }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.COLpurchaseOrderLines.Page.SetOrder(Rec."Ref. Order No.", Rec."Ref. Line No.");
        //CurrPage.COLPromisedDatesLine.Page.SetOrder(Rec."Ref. Order No.", Rec."Ref. Line No.");
    end;

    trigger OnAfterGetRecord()
    var
        Item: Record Item;
    begin
        if Rec."Variant Code" = '' then
            VariantCodeMandatory2 := Item.IsVariantMandatory(Rec.Type = Rec.Type::Item, Rec."No.");
        if Rec."No." = '' then
            clear(Warning);
        COLPlanningWarningLevel();
    end;

    var
        PlanningTransparency: Codeunit "Planning Transparency";
        VariantCodeMandatory2: Boolean;
        Warning: Enum "COL Requisition Warning type";

    local procedure ClearAttributesFilter()
    begin
        Rec.ClearMarks();
        Rec.MarkedOnly(false);
        Rec.FilterGroup(0);
        Rec.SetRange(Type);
        Rec.SetRange("No.");
        Rec.SetFilter("COL Filter Criteria ID", '');
        Rec.SetRange("COL Matches Criteria");
    end;

    procedure COLPlanningWarningLevel()
    var
        Transparency: Codeunit "Planning Transparency";
    begin
        Warning := Enum::"COL Requisition Warning type".FromInteger(Transparency.ReqLineWarningLevel(Rec));
    end;

    local procedure CalculateActionMessages();
    var
        ReqLine: Record "Requisition Line";
        Transparency: Codeunit "Planning Transparency";
        Window: Dialog;
        ProgressLbl: Label 'Processing Line: #1######### out of #2#########', Comment = '#1 - Current Line No, #2 - Total Lines';
        SummaryInfoLbl: Label '%1 Lines set to true out of %2\Run Time = %3', Comment = '%1 - Number of Lines, %2 - Total Number of lines, %3 - Duration';
        StartTime: DateTime;
        Counter: array[3] of Integer;
    begin
        StartTime := CurrentDateTime;
        ReqLine.SetRange("Worksheet Template Name", Rec."Worksheet Template Name");
        ReqLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        ReqLine.ModifyAll("Accept Action Message", false);
        Window.Open(ProgressLbl);
        Window.Update(2, ReqLine.Count);
        Window.Update(1, 1);
        if ReqLine.FindSet() then
            repeat
                Counter[3] += 1;
                if Counter[3] MOD 10 = 0 then
                    Window.Update(1, Counter[3]);
                case false of
                    ReqLine.Type = ReqLine.Type::Item,
                    ReqLine."Action Message" = ReqLine."Action Message"::New,
                    ReqLine."Vendor No." <> '',
                    Transparency.ReqLineWarningLevel(ReqLine) = 0:
                        Counter[2] += 1;//keep "Accept Action Message" = false;
                    else begin
                        Counter[1] += 1;
                        ReqLine."Accept Action Message" := true;
                        ReqLine.Modify(true);
                    end;
                end;
            until ReqLine.Next() = 0;
        Window.Close();
        Message(SummaryInfoLbl, Counter[1], Counter[3], CurrentDateTime - StartTime);
    end;
}