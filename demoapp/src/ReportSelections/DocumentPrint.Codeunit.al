namespace Weibel.Foundation.Reporting;

using Microsoft.Sales.Document;
using Microsoft.Foundation.Reporting;
using Microsoft.Service.Document;

codeunit 70115 "COL Document-Print"
{
    procedure PrintSalesHeaderShipmentLabel(SalesHeader: Record "Sales Header")
    var
        ReportSelection: Record "Report Selections";
        ShipmentLblReportSubs: Codeunit "COL Shipment Lbl Report Subs";
        ReportUsage: Enum "Report Selection Usage";
    begin
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order then
            exit;

        SalesHeader.SetRecFilter();

        ReportUsage := Enum::"Report Selection Usage"::"COL S.Shipment Label";

        BindSubscription(ShipmentLblReportSubs);
        ReportSelection.PrintWithDialogForCust(ReportUsage, SalesHeader, GuiAllowed(), SalesHeader.FieldNo("Bill-to Customer No."));
        UnbindSubscription(ShipmentLblReportSubs);
    end;

    procedure PrintServiceHeaderShipmentLabel(ServiceHeader: Record "Service Header")
    var
        ReportSelection: Record "Report Selections";
        ShipmentLblReportSubs: Codeunit "COL Shipment Lbl Report Subs";
        ReportUsage: Enum "Report Selection Usage";
    begin
        if ServiceHeader."Document Type" <> ServiceHeader."Document Type"::Order then
            exit;

        ServiceHeader.SetRecFilter();

        ReportUsage := Enum::"Report Selection Usage"::"COL SM.Shipment Label";

        BindSubscription(ShipmentLblReportSubs);
        ReportSelection.PrintWithDialogForCust(ReportUsage, ServiceHeader, GuiAllowed(), ServiceHeader.FieldNo("Bill-to Customer No."));
        UnbindSubscription(ShipmentLblReportSubs);
    end;

    internal procedure PrintProformaServiceInvoice(ServiceHeader: Record "Service Header")
    var
        ReportSelection: Record "Report Selections";
        ReportUsage: Enum "Report Selection Usage";
    begin
        if ServiceHeader."Document Type" <> ServiceHeader."Document Type"::Order then
            exit;

        ServiceHeader.SetRecFilter();

        ReportUsage := Enum::"Report Selection Usage"::"COL Pro Forma SM. Invoice";
        OnBeforePrintProformaFromServiceOrder(ServiceHeader);
        ReportSelection.PrintWithDialogForCust(ReportUsage, ServiceHeader, GuiAllowed(), ServiceHeader.FieldNo("Bill-to Customer No."));
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePrintProformaFromServiceOrder(var ServiceHeader: Record "Service Header")
    begin
    end;
}
