namespace Weibel.UpgradeScript;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Manufacturing.Routing;

codeunit 70176 "COL Rename Data Line"
{
    trigger OnRun()
    var
        RenameData: Record "COL Rename Data";
        ProductionBOMHeader: Record "Production BOM Header";
        RoutingHeader: Record "Routing Header";
        BomNotFoundErr: Label 'Production BOM %1 not found.', Comment = '%1 - BOM no';
        RouteNotFoundErr: Label 'Route %1 not found.', Comment = '%1 - BOM no';
    begin
        RenameData.Get(CurrEntryNo);
        if RenameData."Rename Type" = RenameData."Rename Type"::"Production BOM" then
            if ProductionBOMHeader.Get(RenameData."Old No.") then
                ProductionBOMHeader.Rename(RenameData."New No.")
            else
                Error(BomNotFoundErr, RenameData."Old No.");

        if RenameData."Rename Type" = RenameData."Rename Type"::Routing then
            if RoutingHeader.Get(RenameData."Old No.") then
                RoutingHeader.Rename(RenameData."New No.")
            else
                Error(RouteNotFoundErr, RenameData."Old No.");

    end;

    procedure SetEntryNo(EntryNo: Integer)
    begin
        CurrEntryNo := EntryNo;
    end;

    var
        CurrEntryNo: Integer;
}
