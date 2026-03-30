namespace Weibel.Inventory.Item.Attribute;

using Microsoft.Inventory.Item.Attribute;
using System.Environment;
using System.Reflection;

codeunit 70117 "COL Item Attr. Filter Mgt."
{
    internal procedure GetItemAttributeFilter(var ItemAttributeFilterText: Text)
    var
        TempItemFilteredFromAttributes: Record Microsoft.Inventory.Item.Item temporary;
        TempFilterItemAttributesBuffer: Record "Filter Item Attributes Buffer" temporary;
        ItemAttributeManagement: Codeunit "Item Attribute Management";
        ClientTypeManagement: Codeunit "Client Type Management";
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
            ItemAttributeFilterText := '';
            exit;
        end;
        TempItemFilteredFromAttributes.Reset();
        TempItemFilteredFromAttributes.DeleteAll();
        ItemAttributeManagement.FindItemsByAttributes(TempFilterItemAttributesBuffer, TempItemFilteredFromAttributes);
        FilterText := ItemAttributeManagement.GetItemNoFilterText(TempItemFilteredFromAttributes, ParameterCount);

        if ParameterCount < TypeHelper.GetMaxNumberOfParametersInSQLQuery() - 100 then
            ItemAttributeFilterText := FilterText
        else
            Error(TooManyMatchesErr);
    end;

    internal procedure GetItemAttributeFilterOrInsertCriteria(var ItemAttributeFilterText: Text; SourceTableId: Integer; FilterId: GUID): Boolean
    var
        TempItemFilteredFromAttributes: Record Microsoft.Inventory.Item.Item temporary;
        TempFilterItemAttributesBuffer: Record "Filter Item Attributes Buffer" temporary;
        ItemAttributeManagement: Codeunit "Item Attribute Management";
        ClientTypeManagement: Codeunit "Client Type Management";
        TypeHelper: Codeunit "Type Helper";
        CloseAction: Action;
        FilterText: Text;
        FilterPageID: Integer;
        ParameterCount: Integer;
    begin
        FilterPageID := Page::"Filter Items by Attribute";
        if ClientTypeManagement.GetCurrentClientType() = ClientType::Phone then
            FilterPageID := Page::"Filter Items by Att. Phone";

        CloseAction := Page.RunModal(FilterPageID, TempFilterItemAttributesBuffer);
        if (ClientTypeManagement.GetCurrentClientType() <> ClientType::Phone) and (CloseAction <> Action::LookupOK) then
            exit;

        if TempFilterItemAttributesBuffer.IsEmpty() then begin
            ItemAttributeFilterText := '';
            exit;
        end;
        TempItemFilteredFromAttributes.Reset();
        TempItemFilteredFromAttributes.DeleteAll();
        ItemAttributeManagement.FindItemsByAttributes(TempFilterItemAttributesBuffer, TempItemFilteredFromAttributes);
        FilterText := ItemAttributeManagement.GetItemNoFilterText(TempItemFilteredFromAttributes, ParameterCount);

        if ParameterCount < TypeHelper.GetMaxNumberOfParametersInSQLQuery() - 100 then begin
            ItemAttributeFilterText := FilterText;
            exit(true);
        end else
            if TempItemFilteredFromAttributes.FindSet() then
                repeat
                    InsertItemAttrFilterCriteria(SourceTableId, FilterId, TempItemFilteredFromAttributes."No.");
                until TempItemFilteredFromAttributes.Next() = 0;
    end;

    local procedure InsertItemAttrFilterCriteria(SourceTableId: Integer; FilterId: GUID; ItemNo: Code[20])
    var
        ItemAttrFilterCriteria: Record "COL Item Attr. Filter Criteria";
    begin
        ItemAttrFilterCriteria.Init();
        ItemAttrFilterCriteria."Table Id" := SourceTableId;
        ItemAttrFilterCriteria."Filter Id" := FilterId;
        ItemAttrFilterCriteria."Item No." := ItemNo;
        ItemAttrFilterCriteria.Insert();
    end;

}