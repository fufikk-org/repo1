namespace Weibel.AppManagement;

using System.Upgrade;
using System.Security.User;
using Microsoft.Inventory.Planning;
using Microsoft.Inventory.Requisition;
using Microsoft.Inventory.Location;
using Weibel.Manufacturing.Order;
using Microsoft.Inventory.Item;
using System.Security.AccessControl;

codeunit 70125 "COL Upgrade App"
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    begin
        UpdateLeadTimeOnJobPlanningLines();
        AddShippingStatusOptions();
        AddTablesForRetentionPolicy();
        UpdateItemMoistureLevel();
        UpdateItemROHSDirectiveComplaint();
        PopulateAllowedFieldsForProductionOrders();
#if not HIDE_LOWLEVEL_SKU
        UpdateLowLevelCalculationSetup();
#endif        
        UpdateDescription2OnProdBOMLines();
        UpdateSalesOrderInformationField();
        UpdateSalesOrderResponsibilityGroupField();
        UpdateSalesOrderOrderCategoryOldField();
        UpdateSalesSetupForCustomerSearch();
        UpdatePurchaseSetupForVendorSearch();
        AddOrderCategoriesOldForSalesOrders();
        ClearOrphanedWarnings();
        UpdateProdOrdersTrackInfo();
        UpdateCreatedByOnItem();
        UpdateCreatedByOnSKU();
    end;

    local procedure UpdateCreatedByOnItem()
    var
        Item: Record Item;
        ToModify: Boolean;
    begin
        if UpgradeTag.HasUpgradeTag(UpgradeTagDefinitions.GetCreatedByOnItemUpgradeTag()) then
            exit;

        Item.SetLoadFields("COL Created By User", "COL Creation Date", SystemCreatedBy, SystemCreatedAt);
        if Item.FindSet() then
            repeat
                ToModify := false;
                if Item."COL Created By User" = '' then begin
                    Item."COL Created By User" := GetUserNameFromGuid(Item.SystemCreatedBy);
                    ToModify := true;
                end;

                if Item."COL Creation Date" = 0D then begin
                    Item."COL Creation Date" := Item.SystemCreatedAt.Date;
                    ToModify := true;
                end;

                if ToModify then
                    Item.Modify();

            until Item.Next() = 0;

        UpgradeTag.SetUpgradeTag(UpgradeTagDefinitions.GetCreatedByOnItemUpgradeTag());
    end;

    local procedure UpdateCreatedByOnSKU()
    var
        StockkeepingUnit: Record "Stockkeeping Unit";
        ToModify: Boolean;
    begin
        if UpgradeTag.HasUpgradeTag(UpgradeTagDefinitions.GetCreatedByOnSKUUpgradeTag()) then
            exit;

        StockkeepingUnit.SetLoadFields("COL Created By User", "COL Creation Date", SystemCreatedBy, SystemCreatedAt);
        if StockkeepingUnit.FindSet() then
            repeat
                ToModify := false;
                if StockkeepingUnit."COL Created By User" = '' then begin
                    StockkeepingUnit."COL Created By User" := GetUserNameFromGuid(StockkeepingUnit.SystemCreatedBy);
                    ToModify := true;
                end;

                if StockkeepingUnit."COL Creation Date" = 0D then begin
                    StockkeepingUnit."COL Creation Date" := StockkeepingUnit.SystemCreatedAt.Date;
                    ToModify := true;
                end;

                if ToModify then
                    StockkeepingUnit.Modify();

            until StockkeepingUnit.Next() = 0;

        UpgradeTag.SetUpgradeTag(UpgradeTagDefinitions.GetCreatedByOnSKUUpgradeTag());
    end;

    local procedure ClearOrphanedWarnings();
    var
        UntrackedPlanningElement: Record "Untracked Planning Element";
        RequisitionLine: Record "Requisition Line";
    begin
        if UpgradeTag.HasUpgradeTag(UpgradeTagDefinitions.GetClearOrphanedWarningsUpgradeTag()) then
            exit;

        if UntrackedPlanningElement.FindSet() then
            repeat
                if not RequisitionLine.Get(UntrackedPlanningElement."Worksheet Template Name", UntrackedPlanningElement."Worksheet Batch Name", UntrackedPlanningElement."Worksheet Line No.") then
                    UntrackedPlanningElement.Delete();
            until UntrackedPlanningElement.Next() = 0;

        UpgradeTag.SetUpgradeTag(UpgradeTagDefinitions.GetClearOrphanedWarningsUpgradeTag());
    end;

    local procedure UpdateLeadTimeOnJobPlanningLines()
    begin
        if UpgradeTag.HasUpgradeTag(UpgradeTagDefinitions.GetItemLeadTimeOnJPLUpgradeTag()) then
            exit;

        InstallApp.UpdateLeadTimeOnJobPlanningLines();

        UpgradeTag.SetUpgradeTag(UpgradeTagDefinitions.GetItemLeadTimeOnJPLUpgradeTag());
    end;

    local procedure AddShippingStatusOptions()
    begin
        if UpgradeTag.HasUpgradeTag(UpgradeTagDefinitions.GetShippingStatusUpgradeTag()) then
            exit;

        InstallApp.AddShippingStatusOptions();

        UpgradeTag.SetUpgradeTag(UpgradeTagDefinitions.GetShippingStatusUpgradeTag());
    end;

    local procedure AddTablesForRetentionPolicy()
    begin
        InstallApp.AddTablesForRetentionPolicy();
    end;

    local procedure UpdateItemMoistureLevel()
    begin
        if UpgradeTag.HasUpgradeTag(UpgradeTagDefinitions.GetItemMoistureLevelUpgradeTag()) then
            exit;

        InstallApp.UpdateItemMoistureLevel();

        UpgradeTag.SetUpgradeTag(UpgradeTagDefinitions.GetItemMoistureLevelUpgradeTag());
    end;

    local procedure UpdateItemROHSDirectiveComplaint()
    begin
        if UpgradeTag.HasUpgradeTag(UpgradeTagDefinitions.GetItemROHSDirComplaintUpgradeTag()) then
            exit;

        InstallApp.UpdateItemROHSDirectiveComplaint();

        UpgradeTag.SetUpgradeTag(UpgradeTagDefinitions.GetItemROHSDirComplaintUpgradeTag());
    end;

    local procedure PopulateAllowedFieldsForProductionOrders()
    begin
        if UpgradeTag.HasUpgradeTag(UpgradeTagDefinitions.GetPopulateAllowedFieldsForProductionOrdersUpgradeTag()) then
            exit;

        InstallApp.PopulateAllowedFieldsForProductionOrders();

        UpgradeTag.SetUpgradeTag(UpgradeTagDefinitions.GetPopulateAllowedFieldsForProductionOrdersUpgradeTag());
    end;

#if not HIDE_LOWLEVEL_SKU
    local procedure UpdateLowLevelCalculationSetup()
    begin
        if UpgradeTag.HasUpgradeTag(UpgradeTagDefinitions.GetUpdateLowLevelCalculationSetupUpgradeTag()) then
            exit;

        InstallApp.UpdateLowLevelCalculationSetup();

        UpgradeTag.SetUpgradeTag(UpgradeTagDefinitions.GetUpdateLowLevelCalculationSetupUpgradeTag());
    end;
#endif

    local procedure UpdateDescription2OnProdBOMLines()
    begin
        if UpgradeTag.HasUpgradeTag(UpgradeTagDefinitions.GetUpdateDescription2OnProdBOMLinesUpgradeTag()) then
            exit;

        InstallApp.UpdateDescription2OnProdBOMLines();

        UpgradeTag.SetUpgradeTag(UpgradeTagDefinitions.GetUpdateDescription2OnProdBOMLinesUpgradeTag());
    end;

    local procedure UpdateSalesOrderInformationField()
    begin
        if UpgradeTag.HasUpgradeTag(UpgradeTagDefinitions.GetUpdateSalesOrderInformationFieldUpgradeTag()) then
            exit;

        InstallApp.UpdateSalesOrderInformationField();

        UpgradeTag.SetUpgradeTag(UpgradeTagDefinitions.GetUpdateSalesOrderInformationFieldUpgradeTag());
    end;

    local procedure UpdateSalesOrderResponsibilityGroupField()
    begin
        if UpgradeTag.HasUpgradeTag(UpgradeTagDefinitions.GetUpdateSalesOrderResponsibilityGroupFieldUpgradeTag()) then
            exit;

        InstallApp.UpdateSalesOrderResponsibilityGroupField();

        UpgradeTag.SetUpgradeTag(UpgradeTagDefinitions.GetUpdateSalesOrderResponsibilityGroupFieldUpgradeTag());
    end;

    local procedure UpdateSalesOrderOrderCategoryOldField()
    begin
        if UpgradeTag.HasUpgradeTag(UpgradeTagDefinitions.GetUpdateSalesOrderOrderCategoryOldFieldUpgradeTag()) then
            exit;

        InstallApp.UpdateSalesOrderOrderCategoryOldField();

        UpgradeTag.SetUpgradeTag(UpgradeTagDefinitions.GetUpdateSalesOrderOrderCategoryOldFieldUpgradeTag());
    end;

    local procedure UpdateSalesSetupForCustomerSearch()
    begin
        if UpgradeTag.HasUpgradeTag(UpgradeTagDefinitions.GetUpdateSalesSetupForCustomerSearchUpgradeTag()) then
            exit;

        InstallApp.UpdateSalesSetupForCustomerSearch();

        UpgradeTag.SetUpgradeTag(UpgradeTagDefinitions.GetUpdateSalesSetupForCustomerSearchUpgradeTag());
    end;

    local procedure UpdatePurchaseSetupForVendorSearch()
    begin
        if UpgradeTag.HasUpgradeTag(UpgradeTagDefinitions.GetUpdatePurchaseSetupForVendorSearchUpgradeTag()) then
            exit;

        InstallApp.UpdatePurchaseSetupForVendorSearch();

        UpgradeTag.SetUpgradeTag(UpgradeTagDefinitions.GetUpdatePurchaseSetupForVendorSearchUpgradeTag());
    end;

    local procedure AddOrderCategoriesOldForSalesOrders()
    begin
        if UpgradeTag.HasUpgradeTag(UpgradeTagDefinitions.GetAddOrderCategoriesOldForSalesOrdersUpgradeTag()) then
            exit;

        InstallApp.AddOrderCategoriesOldForSalesOrders();

        UpgradeTag.SetUpgradeTag(UpgradeTagDefinitions.GetAddOrderCategoriesOldForSalesOrdersUpgradeTag());
    end;

    local procedure UpdateProdOrdersTrackInfo()
    var
        ProdOrderSub: Codeunit "COL Prod. Order Sub.";
    begin
        if UpgradeTag.HasUpgradeTag(UpgradeTagDefinitions.GetTrackInfosUpgradeTag()) then
            exit;

        ProdOrderSub.UpdateAllProductionOrderTrackingInfo();

        UpgradeTag.SetUpgradeTag(UpgradeTagDefinitions.GetTrackInfosUpgradeTag());
    end;

    local procedure GetUserNameFromGuid(UserGuid: Guid): Text[50]
    var
        User: Record User;
    begin
        if IsNullGuid(UserGuid) then
            exit('');

        if User.Get(UserGuid) then
            exit(User."User Name");

        exit('');
    end;

    var
        UpgradeTag: Codeunit "Upgrade Tag";
        UpgradeTagDefinitions: Codeunit "COL Upgrade Tag Definitions";
        InstallApp: Codeunit "COL Install App";

}