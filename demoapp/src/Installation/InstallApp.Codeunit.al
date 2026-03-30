namespace Weibel.AppManagement;

using Microsoft.Projects.Project.Planning;
using Weibel.Foundation.OrderCategoryOld;
using Microsoft.Purchases.Setup;
using Weibel.Manufacturing.Archive;
using Weibel.Manufacturing.ProductionBOM;
using Weibel.Shipping;
using Microsoft.Sales.Setup;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Inventory.Item;
using System.DataAdministration;
using Weibel.Inventory.Item;
using Microsoft.Manufacturing.Document;
using Weibel.Common;
using Weibel.Inventory.Planning;
using Microsoft.Sales.Document;
using Weibel.Manufacturing.Order;

codeunit 70124 "COL Install App"
{
    Subtype = Install;

    Permissions = tabledata "Job Planning Line" = RM,
        tabledata Item = R;

    trigger OnInstallAppPerCompany()
    begin
        UpdateLeadTimeOnJobPlanningLines();
        AddShippingStatusOptions();
        UpdateItemMoistureLevel();
        UpdateItemROHSDirectiveComplaint();
        AddTablesForRetentionPolicy();
        PopulateAllowedFieldsForProductionOrders();
        UpdateDescription2OnProdBOMLines();
        UpdateSalesOrderInformationField();
        UpdateSalesOrderResponsibilityGroupField();
        UpdateSalesOrderOrderCategoryOldField();
        AddOrderCategoriesOldForSalesOrders();
        UpdatePurchaseSetupForVendorSearch();
        UpdateSalesSetupForCustomerSearch();
        UpdateProdOrdersTrackInfo();
    end;

    internal procedure UpdateLeadTimeOnJobPlanningLines()
    var
        JobPlanningLine: Record "Job Planning Line";
        Item: Record Item;
    begin
        JobPlanningLine.SetRange(Type, Enum::"Job Planning Line Type"::Item);
        JobPlanningLine.SetFilter("No.", '<>%1', '');
        if JobPlanningLine.FindSet(true) then
            repeat
                Item.SetLoadFields("Lead Time Calculation");
                if Item.Get(JobPlanningLine."No.") then begin
                    JobPlanningLine."COL Item Lead Time Calculation" := Item."Lead Time Calculation";
                    JobPlanningLine.Modify();
                end;
            until JobPlanningLine.Next() = 0;
    end;

    internal procedure AddShippingStatusOptions()
    var
        ShippingStatus: Record "COL Shipping Status";
        ShippingStatusDict: Dictionary of [Code[20], Text[100]];
        ShippingStatusCode: Code[20];
    begin
        if not ShippingStatus.IsEmpty() then
            exit;

        ShippingStatusDict.Add('AWAITING', 'Waiting');
        ShippingStatusDict.Add('PICKED', 'Picked');
        ShippingStatusDict.Add('READY PACK', 'Ready to Pack');
        ShippingStatusDict.Add('SHIPPED', 'Shipped');

        foreach ShippingStatusCode in ShippingStatusDict.Keys do begin
            ShippingStatus.Init();
            ShippingStatus.Code := ShippingStatusCode;
            ShippingStatus.Description := ShippingStatusDict.Get(ShippingStatusCode);
            ShippingStatus.Insert(false);
        end;
    end;

    internal procedure UpdateItemMoistureLevel()
    var
        Item: Record Item;
    begin
        Item.ModifyAll("COL Moisture Sensitivity Level", Enum::"COL Moisture Sensitivity Level"::" ");
    end;

    internal procedure AddTablesForRetentionPolicy()
    var
        ProductionOrderArchive: Record "COL Production Order Archive";
        ProdOrderLineArchive: Record "COL Prod. Order Line Archive";
        ProdOrderCommentArch: Record "COL Prod. Order Comment Arch";
        ProdOrRoutingLineArch: Record "COL Prod.Or. Routing Line Arch";
        ProdOrderComponentArch: Record "COL Prod. Order Component Arch";
        ItemAttrFilterCriteria: Record "COL Item Attr. Filter Criteria";
        RetenPolAllowedTables: Codeunit "Reten. Pol. Allowed Tables";
    begin
        RetenPolAllowedTables.AddAllowedTable(Database::"COL Item Variant PLC Chng. Log");
        RetenPolAllowedTables.AddAllowedTable(Database::"COL Production Order Archive", ProductionOrderArchive.FieldNo(SystemCreatedAt), 365);
        RetenPolAllowedTables.AddAllowedTable(Database::"COL Prod. Order Line Archive", ProdOrderLineArchive.FieldNo(SystemCreatedAt), 365);
        RetenPolAllowedTables.AddAllowedTable(Database::"COL Prod. Order Comment Arch", ProdOrderCommentArch.FieldNo(SystemCreatedAt), 365);
        RetenPolAllowedTables.AddAllowedTable(Database::"COL Prod.Or. Routing Line Arch", ProdOrRoutingLineArch.FieldNo(SystemCreatedAt), 365);
        RetenPolAllowedTables.AddAllowedTable(Database::"COL Prod. Order Component Arch", ProdOrderComponentArch.FieldNo(SystemCreatedAt), 365);
        RetenPolAllowedTables.AddAllowedTable(Database::"COL Item Attr. Filter Criteria", ItemAttrFilterCriteria.FieldNo(SystemCreatedAt), 1);
        RetenPolAllowedTables.AddAllowedTable(Database::"COL Planning Error Log Arch.");
    end;

    internal procedure UpdateItemROHSDirectiveComplaint()
    var
        Item: Record Item;
    begin
        Item.ModifyAll("COL EU RoHS Dir. Compliant", Enum::"COL EU RoHS Dir. Compliant"::" ");
    end;

    internal procedure PopulateAllowedFieldsForProductionOrders()
    var
        FieldSelect: Record "COL Field Selected";
        ProductionOrder: Record "Production Order";
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderComponent: Record "Prod. Order Component";
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        FieldSelectMgt: Codeunit "COL Field Select Mgt";
    begin
        FieldSelect.SetRange("Table No.", Database::"Production Order");
        if FieldSelect.IsEmpty() then
            FieldSelectMgt.FillTemplateFieldFromTable(ProductionOrder);

        FieldSelect.SetRange("Table No.", Database::"Prod. Order Line");
        if FieldSelect.IsEmpty() then
            FieldSelectMgt.FillTemplateFieldFromTable(ProdOrderLine);

        FieldSelect.SetRange("Table No.", Database::"Prod. Order Component");
        if FieldSelect.IsEmpty() then
            FieldSelectMgt.FillTemplateFieldFromTable(ProdOrderComponent);

        FieldSelect.SetRange("Table No.", Database::"Prod. Order Routing Line");
        if FieldSelect.IsEmpty() then
            FieldSelectMgt.FillTemplateFieldFromTable(ProdOrderRoutingLine);
    end;
#if not HIDE_LOWLEVEL_SKU
    internal procedure UpdateLowLevelCalculationSetup()
    var
        WeibelLowLevelSetup: Record "COL Weibel Low Level Setup";
    begin
        if not WeibelLowLevelSetup.Get() then begin
            WeibelLowLevelSetup.Init();
            WeibelLowLevelSetup.Insert();
        end;
    end;
#endif

    internal procedure UpdateDescription2OnProdBOMLines()
    var
        Item: Record Item;
        ItemVariant: Record "Item Variant";
        ProductionBOMHeader: Record "Production BOM Header";
        ProductionBOMLine, xProductionBOMLine : Record "Production BOM Line";
    begin
        Item.SetLoadFields("Description 2");
        ItemVariant.SetLoadFields("Description 2");
        ProductionBOMHeader.SetLoadFields("Description 2");
        Item.ReadIsolation := IsolationLevel::ReadUncommitted;
        ItemVariant.ReadIsolation := IsolationLevel::ReadUncommitted;
        ProductionBOMHeader.ReadIsolation := IsolationLevel::ReadUncommitted;

        ProductionBOMLine.SetFilter(Type, '<>%1', Enum::"Production BOM Line Type"::" ");
        ProductionBOMLine.SetFilter("No.", '<>%1', '');
        if ProductionBOMLine.FindSet(true) then
            repeat
                xProductionBOMLine := ProductionBOMLine;
                case ProductionBOMLine.Type of
                    ProductionBOMLine.Type::Item:
                        begin
                            if Item.Get(ProductionBOMLine."No.") then
                                ProductionBOMLine."COL Description 2" := Item."Description 2";
                            if ProductionBOMLine."Variant Code" <> '' then
                                if ItemVariant.Get(ProductionBOMLine."No.", ProductionBOMLine."Variant Code") then
                                    if ItemVariant."Description 2" <> '' then
                                        ProductionBOMLine."COL Description 2" := ItemVariant."Description 2";
                        end;
                    ProductionBOMLine.Type::"Production BOM":
                        if ProductionBOMHeader.Get(ProductionBOMLine."No.") then
                            ProductionBOMLine."COL Description 2" := ProductionBOMHeader."Description 2";
                end;
                if xProductionBOMLine."COL Description 2" <> ProductionBOMLine."COL Description 2" then
                    ProductionBOMLine.Modify();
            until ProductionBOMLine.Next() = 0;
    end;

    internal procedure UpdateSalesOrderInformationField()
    var
        SalesHeader: Record "Sales Header";
        RRef: RecordRef;
        MIGFieldNo, DestFieldNo : Integer;
    begin
        MIGFieldNo := 51434; // this is a field from BC25 data matching app used during migration; app might not be present
        RRef.Open(Database::"Sales Header");
        if not RRef.FieldExist(MIGFieldNo) then
            exit;

        DestFieldNo := SalesHeader.FieldNo("COL Order Information");

        if RRef.FindSet(true) then
            repeat
                if Format(RRef.Field(MIGFieldNo).Value) <> '' then begin
                    RRef.Field(DestFieldNo).Value := RRef.Field(MIGFieldNo).Value;
                    RRef.Modify();
                end;
            until RRef.Next() = 0;

        RRef.Close();
    end;

    internal procedure UpdateSalesOrderResponsibilityGroupField()
    var
        SalesHeader: Record "Sales Header";
        RRef: RecordRef;
        MIGFieldNo, DestFieldNo : Integer;
    begin
        MIGFieldNo := 51419; // this is a field from BC25 data matching app used during migration; app might not be present
        RRef.Open(Database::"Sales Header");
        if not RRef.FieldExist(MIGFieldNo) then
            exit;

        DestFieldNo := SalesHeader.FieldNo("COL Responsibility Group");

        if RRef.FindSet(true) then
            repeat
                RRef.Field(DestFieldNo).Value := RRef.Field(MIGFieldNo).Value;
                RRef.Modify();
            until RRef.Next() = 0;

        RRef.Close();
    end;

    internal procedure UpdateSalesOrderOrderCategoryOldField()
    var
        SalesHeader: Record "Sales Header";
        RRef: RecordRef;
        MIGFieldNo, DestFieldNo : Integer;
    begin
        MIGFieldNo := 51420; // this is a field from BC25 data matching app used during migration; app might not be present
        RRef.Open(Database::"Sales Header");
        if not RRef.FieldExist(MIGFieldNo) then
            exit;

        DestFieldNo := SalesHeader.FieldNo("COL Order Category (Old)");

        if RRef.FindSet(true) then
            repeat
                RRef.Field(DestFieldNo).Value := RRef.Field(MIGFieldNo).Value;
                RRef.Modify();
            until RRef.Next() = 0;

        RRef.Close();
    end;

    internal procedure AddOrderCategoriesOldForSalesOrders()
    var
        OrderCategoryOld: Record "COL Order Category (Old)";
        InitOrderCategoryOld: Codeunit "COL Init Order Category (Old)";
    begin
        if not OrderCategoryOld.IsEmpty() then
            exit;

        InitOrderCategoryOld.InitOrderCategories();
    end;

    internal procedure UpdatePurchaseSetupForVendorSearch()
    var
        PurchaseSetup: Record "Purchases & Payables Setup";
    begin
        if PurchaseSetup.Get() then
            if not PurchaseSetup."Disable Search by Name" then begin
                PurchaseSetup.Validate("Disable Search by Name", true);
                PurchaseSetup.Modify(true);
            end;
    end;

    internal procedure UpdateSalesSetupForCustomerSearch()
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        if SalesSetup.Get() then
            if not SalesSetup."Disable Search by Name" then begin
                SalesSetup.Validate("Disable Search by Name", true);
                SalesSetup.Modify(true);
            end;
    end;

    local procedure UpdateProdOrdersTrackInfo()
    var
        ProdOrderSub: Codeunit "COL Prod. Order Sub.";
    begin
        ProdOrderSub.UpdateAllProductionOrderTrackingInfo();
    end;
}