namespace Weibel.Inventory.Requisition;

using Microsoft.Inventory.Requisition;
using Weibel.Inventory.Item.Attribute;
using Microsoft.Inventory.Item;

reportextension 70106 "COL Calculate Plan-Req. Wksh." extends "Calculate Plan - Req. Wksh."
{

    dataset
    {
        modify(Item)
        {
            trigger OnBeforePreDataItem()
            begin
                if ItemAttributeFilterText <> '' then
                    Item.SetFilter("No.", ItemAttributeFilterText)
                else
                    if not IsNullGuid(FilterCriteriaId) then begin
                        Item.SetFilter("COL Filter Criteria ID", FilterCriteriaId);
                        Item.SetAutoCalcFields("COL Matches Criteria");
                        Item.SetRange("COL Matches Criteria", true);
                    end;
            end;

        }
    }
    requestpage
    {
        layout
        {
            addafter(Options)
            {
                group("COL ItemAttributes")
                {
                    Caption = 'Item Attributes';
                    field("COL ItemAttributeFilterText"; ItemAttributeFilterText)
                    {
                        Caption = 'Attribute Filter';
                        ToolTip = 'Specifies item no. filter based on selected attributes and their values. This filter overrides any filter set in the default filtering section for Item No. field.';
                        ApplicationArea = All;

                        trigger OnAssistEdit()
                        var
                            ItemAttrFilterMgt: Codeunit "COL Item Attr. Filter Mgt.";
                            ItemNoFilterTooLongNotification: Notification;
                        begin
                            ShowWarning := false;
                            FilterCriteriaId := CreateGuid();
                            if ItemAttrFilterMgt.GetItemAttributeFilterOrInsertCriteria(ItemAttributeFilterText, Database::Item, FilterCriteriaId) then
                                Clear(FilterCriteriaId)
                            else begin
                                Clear(ItemAttributeFilterText);
                                ShowWarning := true;
                                ItemNoFilterTooLongNotification.Message(ItemNoFilterTooLongMsg);
                                ItemNoFilterTooLongNotification.Send();
                            end;
                        end;
                    }

                    group("COLWarningGroup")
                    {
                        ShowCaption = false;
                        Visible = ShowWarning;
                        field(COLWarning; ItemNoFilterTooLongMsg)
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                            Editable = false;
                        }

                    }
                }
            }
        }
    }

    var
        ShowWarning: Boolean;
        ItemAttributeFilterText: Text;
        FilterCriteriaId: Guid;
        ItemNoFilterTooLongMsg: Label 'The item no. filter was too long. Attribute filter criteria will be matched in an alternative way.';
}