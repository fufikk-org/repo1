namespace Weibel.AppManagement;

using System.Upgrade;

/// <summary>
/// Upgrade tag: WEIBEL-[DevOps Work Item Id]-[Date]
/// </summary>
codeunit 70126 "COL Upgrade Tag Definitions"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Upgrade Tag", OnGetPerCompanyUpgradeTags, '', false, false)]
    local procedure "Upgrade Tag_OnGetPerCompanyUpgradeTags"(var PerCompanyUpgradeTags: List of [Code[250]])
    begin

    end;

    procedure GetCreatedByOnItemUpgradeTag(): Text[250]
    begin
        exit('WEIBEL-7772-20251015-001');
    end;

    procedure GetCreatedByOnSKUUpgradeTag(): Text[250]
    begin
        exit('WEIBEL-7772-20251015-002');
    end;

    procedure GetClearOrphanedWarningsUpgradeTag(): Text[250]
    begin
        exit('WEIBEL-6638-20250820');
    end;

    procedure GetItemLeadTimeOnJPLUpgradeTag(): Text[250]
    begin
        exit('WEIBEL-384-20241015');
    end;

    procedure GetShippingStatusUpgradeTag(): Text[250]
    begin
        exit('WEIBEL-426-20241021');
    end;

    procedure GetItemMoistureLevelUpgradeTag(): Text[250]
    begin
        exit('WEIBEL-349-20250109');
    end;

    procedure GetItemROHSDirComplaintUpgradeTag(): Text[250]
    begin
        exit('WEIBEL-349-20250115');
    end;

    procedure GetPopulateAllowedFieldsForProductionOrdersUpgradeTag(): Text[250]
    begin
        exit('WEIBEL-236-20250218');
    end;

    internal procedure GetUpdateLowLevelCalculationSetupUpgradeTag(): Code[250]
    begin
        exit('WEIBEL-7202-20250625');
    end;

    internal procedure GetUpdateDescription2OnProdBOMLinesUpgradeTag(): Code[250]
    begin
        exit('WEIBEL-7292-20250704');
    end;

    internal procedure GetUpdateSalesOrderInformationFieldUpgradeTag(): Code[250]
    begin
        exit('WEIBEL-7280-20250704');
    end;

    internal procedure GetUpdateSalesOrderResponsibilityGroupFieldUpgradeTag(): Code[250]
    begin
        exit('WEIBEL-7280-20250714');
    end;

    internal procedure GetUpdateSalesOrderOrderCategoryOldFieldUpgradeTag(): Code[250]
    begin
        exit('WEIBEL-7280-20250714-2');
    end;

    internal procedure GetAddOrderCategoriesOldForSalesOrdersUpgradeTag(): Code[250]
    begin
        exit('WEIBEL-7280-20250718');
    end;

    internal procedure GetUpdatePurchaseSetupForVendorSearchUpgradeTag(): Code[250]
    begin
        exit('WEIBEL-7241-20250714');
    end;

    internal procedure GetUpdateSalesSetupForCustomerSearchUpgradeTag(): Code[250]
    begin
        exit('WEIBEL-7295-20250709');
    end;

    procedure GetTrackInfosUpgradeTag(): Text[250]
    begin
        exit('WEIBEL-9524-20251008');
    end;
}