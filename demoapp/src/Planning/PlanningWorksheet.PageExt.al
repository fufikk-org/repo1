namespace Weibel.Inventory.Requisition;

using Microsoft.Inventory.Requisition;
using Microsoft.Inventory.Item.Attribute;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Planning;
using Microsoft.Inventory.Tracking;
using System.Reflection;
using System.Utilities;
using Weibel.Inventory.Item.Attribute;
using Weibel.Inventory.Item;
using Weibel.Manufacturing.BlockProduction;
using Weibel.Manufacturing.Planning.Batch;
using Microsoft.Manufacturing.Document;
using Microsoft.Manufacturing.WorkCenter;
using weibel.Inventory.Tracking;

pageextension 70136 "COL Planning Worksheet" extends "Planning Worksheet"
{
    layout
    {
        addbefore(Control1)
        {
            group("COL-Filters1")
            {
                Caption = 'Filters';
                grid(COL_Filters)
                {
                    Caption = 'Filters';
                    GridLayout = Columns;

                    field("COL FilterActionMessage"; FilterActionMessage)
                    {
                        ApplicationArea = All;
                        Caption = 'Action Message Filter';
                        ToolTip = 'Filter the requisition lines by Action Message type.';

                        trigger OnValidate()
                        begin
                            if FilterActionMessage = Enum::"Action Message Type"::" " then
                                Rec.SetRange("Action Message")
                            else
                                Rec.SetRange("Action Message", FilterActionMessage);

                            CurrPage.Update(false);
                        end;
                    }
                    field("COL Ref. Order Status Filter"; FilterStatus)
                    {
                        ApplicationArea = All;
                        Caption = 'Ref. Order Status Filter';
                        ToolTip = 'Filter the requisition lines by reference order status.';

                        trigger OnValidate()
                        begin
                            if FilterStatus = Enum::"COL Production Order Status"::" " then
                                Rec.SetRange("Ref. Order Status")
                            else
                                Rec.SetRange("Ref. Order Status", FilterStatus);
                            CurrPage.Update(false);
                        end;
                    }
                    field("COL Filter Work Center No."; FilterWorkCenterNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Work Center No. Filter';
                        TableRelation = "Work Center";
                        ToolTip = 'Filter the requisition lines by work center number.';
                        trigger OnValidate()
                        begin
                            if FilterWorkCenterNo = '' then
                                Rec.SetRange("COL First Opr. Work Center")
                            else
                                Rec.SetRange("COL First Opr. Work Center", FilterWorkCenterNo);

                            CurrPage.Update(false);
                        end;
                    }
                    field("COL Filter Work Center Group Code"; FilterWorkCenterGroupCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Work Center Group Filter';
                        TableRelation = "Work Center Group";
                        ToolTip = 'Filter the requisition lines by work center group code.';
                        trigger OnValidate()
                        begin
                            if FilterWorkCenterGroupCode = '' then
                                Rec.SetRange("COL First Opr. Wrk Center Grp")
                            else
                                Rec.SetRange("COL First Opr. Wrk Center Grp", FilterWorkCenterGroupCode);

                            CurrPage.Update(false);
                        end;
                    }
                }
            }
        }

        addfirst(factboxes)
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
        modify(Control11)
        {
            Visible = false;
        }
        modify(Control9)
        {
            Visible = false;
        }

        addafter("Ref. Order Status")
        {
            field("COL First Opr. Work Center"; Rec."COL First Opr. Work Center")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("COL First Opr. Wrk Center Grp"; Rec."COL First Opr. Wrk Center Grp")
            {
                ApplicationArea = All;
                Editable = false;
            }
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
    }

    actions
    {
        addlast("F&unctions")
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
            // action("COL Batch Plan")
            // {
            //     Caption = 'Batch Plan';
            //     ApplicationArea = Basic, Suite;
            //     Image = Planning;
            //     ToolTip = 'Calculate the master production schedule (MPS) and material requirements planning (MRP) for the selected items.';
            //     trigger OnAction()
            //     var
            //         ConfirmManagement: Codeunit "Confirm Management";
            //         BatchPlanningService: Codeunit "COL Batch Planning Service";
            //     begin
            //         if not ConfirmManagement.GetResponseOrDefault('Do you want to batch plan the MPS and MRP?', true) then
            //             exit;

            //         BatchPlanningService.Run();
            //     end;
            // }
            action("COL Std Batch Plan")
            {
                Caption = 'Standard Batch Plan';
                ApplicationArea = Basic, Suite;
                Image = Planning;
                ToolTip = 'Calculate the master production schedule (MPS) and material requirements planning (MRP) for the selected items.';
                trigger OnAction()
                var
                    ConfirmManagement: Codeunit "Confirm Management";
                    BatchPlanningService: Codeunit "COL Std Batch Planning Service";
                begin
                    if not ConfirmManagement.GetResponseOrDefault('Do you want to Std batch plan the MPS and MRP?', true) then
                        exit;

                    BatchPlanningService.Run();
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
                    if Rec."Worksheet Template Name" = '' then
                        exit;
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
                    if Rec."Worksheet Template Name" = '' then
                        exit;
                    RequisitionLine.CopyFilters(Rec);
                    RequisitionLine.SetRange("Worksheet Template Name", Rec."Worksheet Template Name");
                    RequisitionLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    RequisitionLine.SetRange(Type, Rec.Type);
                    RequisitionLine.ModifyAll("Accept Action Message", false);
                end;
            }
            action("COL Clear FIlters")
            {
                Caption = 'Clear Filters';
                ApplicationArea = Basic, Suite;
                Image = UnApply;
                ToolTip = 'Clear Filters from header.';
                trigger OnAction()
                begin
                    ClearFilters();
                    CurrPage.Update(false);
                end;
            }
            action("COL Get FO")
            {
                Caption = 'Get First Operation Data';
                ApplicationArea = Basic, Suite;
                Image = UnApply;
                ToolTip = 'Get First Operation Data from routings.';
                trigger OnAction()
                var
                    RequisitionLine: Record "Requisition Line";
                begin
                    Rec.FilterGroup(2);
                    RequisitionLine.CopyFilters(Rec);
                    Rec.FilterGroup(0);

                    if RequisitionLine.FindSet(true) then
                        repeat
                            RequisitionLine.COL_FillFromRouting();
#pragma warning disable AA0214
                            RequisitionLine.Modify(false);
#pragma warning restore AA0214
                        until RequisitionLine.Next() = 0;
                end;
            }

        }
        modify(CarryOutActionMessage)
        {
            Visible = false;
        }
        addafter(CarryOutActionMessage)
        {
            action("COL CarryOutActionMessage")
            {
                ApplicationArea = Planning;
                Caption = 'Carry &Out Action Message';
                Ellipsis = true;
                Image = CarryOutActionMessage;
                ToolTip = 'Use a batch job to help you create actual supply orders from the order proposals.';

                trigger OnAction()
                begin
                    CarryOutActionMsg();
                    CurrPage.Update(true);
                end;
            }
        }
        modify(CarryOutActionMessage_Promoted)
        {
            Visible = false;
        }
        modify("Calculate &Net Change Plan")
        {
            trigger OnAfterAction()
            begin
                FillWorkInfo();
            end;
        }
        modify(CalculateRegenerativePlan)
        {
            trigger OnAfterAction()
            begin
                FillWorkInfo();
            end;
        }
        modify("Re&fresh Planning Line")
        {
            trigger OnAfterAction()
            begin
                FillWorkInfo();
            end;
        }
        addafter(CarryOutActionMessage_Promoted)
        {
            actionref("COL CarryOutActionMessage_Promoted"; "COL CarryOutActionMessage") { }
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
            actionref("COL Set All_Promoted"; "COL Set All") { }
            actionref("COL UnSet All_Promoted"; "COL UnSet All") { }
            actionref("COL Clear FIlters_Promoted"; "COL Clear FIlters") { }
            actionref("COL Get FO_Promoted"; "COL Get FO") { }
        }
    }

    trigger OnOpenPage()
    begin
        ClearFilters();
    end;

    trigger OnAfterGetRecord()
    var
        Item: Record Item;
    begin
        if Rec."Variant Code" = '' then
            VariantCodeMandatory2 := Item.IsVariantMandatory(Rec.Type = Rec.Type::Item, Rec."No.");

        if FilterWorkCenterNo <> '' then
            if Rec.GetFilter("COL First Opr. Work Center") = '' then
                FilterWorkCenterNo := '';

        if FilterWorkCenterGroupCode <> '' then
            if Rec.GetFilter("COL First Opr. Wrk Center Grp") = '' then
                FilterWorkCenterGroupCode := '';

        if Rec.GetFilter("Action Message") = '' then
            FilterActionMessage := Enum::"Action Message Type"::" ";

        if Rec.GetFilter("Ref. Order Status") = '' then
            FilterStatus := Enum::"COL Production Order Status"::" ";
    end;

    var
        VariantCodeMandatory2: Boolean;
        FilterWorkCenterNo: Code[20];
        FilterWorkCenterGroupCode: Code[20];
        FilterStatus: Enum "COL Production Order Status";
        FilterActionMessage: Enum "Action Message Type";

    local procedure FillWorkInfo()
    var
        RequisitionLine: Record "Requisition Line";
    begin
        Rec.FilterGroup(2);
        RequisitionLine.CopyFilters(Rec);
        Rec.FilterGroup(0);

        if RequisitionLine.FindSet() then
            repeat
                if (RequisitionLine."COL First Opr. Work Center" = '') or (RequisitionLine."COL First Opr. Wrk Center Grp" = '') then begin
                    RequisitionLine.COL_FillFromRouting();
                    RequisitionLine.Modify(false);
                end;
            until RequisitionLine.Next() = 0;
    end;

    local procedure ClearFilters()
    begin
        Rec.SetRange("COL First Opr. Work Center");
        Rec.SetRange("COL First Opr. Wrk Center Grp");
        Rec.SetRange("Action Message");
        Rec.SetRange("Ref. Order Status");

        FilterActionMessage := Enum::"Action Message Type"::" ";
        FilterStatus := Enum::"COL Production Order Status"::" ";
        FilterStatus := Enum::"COL Production Order Status"::" ";
        FilterWorkCenterNo := '';
        FilterWorkCenterGroupCode := '';
    end;

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

    local procedure CarryOutActionMsg()
    var
        CarryOutActionMsgPlan: Report "Carry Out Action Msg. - Plan.";
        BlockProdPlanEvents: Codeunit "COL Block Prod. Plan. Events";
    begin
        BindSubscription(BlockProdPlanEvents);
        CarryOutActionMsgPlan.SetReqWkshLine(Rec);
        CarryOutActionMsgPlan.RunModal();
        BlockProdPlanEvents.ShowBlockedProductionWarning();
        UnbindSubscription(BlockProdPlanEvents)
    end;
}