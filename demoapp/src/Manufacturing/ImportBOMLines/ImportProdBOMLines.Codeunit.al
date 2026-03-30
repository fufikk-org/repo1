namespace Weibel.Manufacturing.ProductionBOM;

using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Inventory.Location;
using System.Utilities;

codeunit 70207 "COL Import Prod. BOM Lines"
{
    procedure ImportProdBOMLines(var StockkeepingUnit: Record "Stockkeeping Unit")
    var
        ProductionBOMHeader: Record "Production BOM Header";
    begin
        StockkeepingUnit.TestField("Production BOM No.");
        ProductionBOMHeader.Get(StockkeepingUnit."Production BOM No.");
        if CheckProductionBOM(ProductionBOMHeader) then
            ImportBOMLines(ProductionBOMHeader);
    end;

    procedure ImportProdBOMLines(var ProductionBOMHeader: Record "Production BOM Header")
    begin
        ProductionBOMHeader.TestField("No.");
        if CheckProductionBOM(ProductionBOMHeader) then
            ImportBOMLines(ProductionBOMHeader);
    end;

    local procedure CheckProductionBOM(var ProductionBOMHeader: Record "Production BOM Header"): Boolean
    var
        ProductionBOMLine: Record "Production BOM Line";
        ConfirmLinesExistQst: Label 'Production BOM %1 has lines, do you want to continue with the import?', Comment = '%1 = BOM No.';
    begin
        if ProductionBOMHeader.Status = Enum::"BOM Status"::Certified then
            ProductionBOMHeader.FieldError(Status);

        ProductionBOMLine.SetRange("Production BOM No.", ProductionBOMHeader."No.");
        ProductionBOMLine.SetRange("Version Code", '');
        if not ProductionBOMLine.IsEmpty() then
            if not Confirm(ConfirmLinesExistQst, false, ProductionBOMHeader."No.") then
                exit(false);

        exit(true);
    end;

    local procedure ImportBOMLines(var ProductionBOMHeader: Record "Production BOM Header")
    var
        TempProdBOMLineBuffer: Record "COL Prod. BOM Line Buffer" temporary;
        ImportBOMLineBuffer: XmlPort "COL Import BOM Line Buffer";
    begin
        ImportBOMLineBuffer.Run();
        ImportBOMLineBuffer.GetImportedLines(TempProdBOMLineBuffer);

        ProcessImportedData(ProductionBOMHeader, TempProdBOMLineBuffer);
    end;

    [ErrorBehavior(ErrorBehavior::Collect)]
    local procedure ProcessImportedData(var ProductionBOMHeader: Record "Production BOM Header"; var TempProdBOMLineBuffer: Record "COL Prod. BOM Line Buffer" temporary)
    var
        TempErrorMessage: Record "Error Message" temporary;
        ImportBOMSubs: Codeunit "COL Import BOM Subs";
        ProcessBOMLineImport: Codeunit "COL Process BOM Line Import";
        ErrInf: ErrorInfo;
        Counter, LinesCreated, WarningCount, ErrorCount : Integer;
        Window: Dialog;
        LastUpdate: DateTime;
        ProgressLbl: Label 'Creating lines: #1#', Comment = '%1 = number of lines processed';
        ErrTextLbl: Label 'Line: %1, %2', Comment = '%1 = line no; %2 = error information';
        SummaryLbl: Label 'Lines created: %1 out of %2, Warnings: %3, Errors: %4', Comment = '%1 = no. of lines created; %2 = no of lines in the file; %3 = warning count; %4 = error count';
    begin
        Window.Open(ProgressLbl);
        LastUpdate := CurrentDateTime();

        BindSubscription(ImportBOMSubs);

        if TempProdBOMLineBuffer.FindSet() then
            repeat
                ClearCollectedErrors();
                ClearLastError();
                Clear(ProcessBOMLineImport);
                ProcessBOMLineImport.SetProductionBOMHeader(ProductionBOMHeader);
                if not ProcessBOMLineImport.Run(TempProdBOMLineBuffer) then begin
                    TempErrorMessage.ID := TempErrorMessage.ID + 1;
                    TempErrorMessage.Message := CopyStr(StrSubstNo(ErrTextLbl, TempProdBOMLineBuffer."Line No.", GetLastErrorText()), 1, MaxStrLen(TempErrorMessage.Message));
                    TempErrorMessage."Message Type" := TempErrorMessage."Message Type"::Error;
                    TempErrorMessage.Insert();
                    ErrorCount += 1;
                end else
                    LinesCreated += 1;

                if HasCollectedErrors() then
                    foreach ErrInf in GetCollectedErrors() do begin
                        TempErrorMessage.ID := TempErrorMessage.ID + 1;
                        TempErrorMessage.Message := CopyStr(StrSubstNo(ErrTextLbl, TempProdBOMLineBuffer."Line No.", ErrInf.Message()), 1, MaxStrLen(TempErrorMessage.Message));
                        TempErrorMessage."Message Type" := TempErrorMessage."Message Type"::Warning;
                        TempErrorMessage.Insert();
                        WarningCount += 1;
                    end;

                Counter += 1;
                if LastUpdate - CurrentDateTime() > 500 then begin
                    Window.Update(1, Counter);
                    LastUpdate := CurrentDateTime();
                end;
            until TempProdBOMLineBuffer.Next() = 0;

        UnbindSubscription(ImportBOMSubs);
        Window.Close();

        TempErrorMessage.ID := TempErrorMessage.ID + 1;
        TempErrorMessage.Message := CopyStr(StrSubstNo(SummaryLbl, LinesCreated, TempProdBOMLineBuffer.Count(), WarningCount, ErrorCount), 1, MaxStrLen(TempErrorMessage.Message));
        TempErrorMessage."Message Type" := TempErrorMessage."Message Type"::Information;
        TempErrorMessage.Validate("Context Record ID", ProductionBOMHeader.RecordId());
        TempErrorMessage.Validate("Record ID", ProductionBOMHeader.RecordId());
        TempErrorMessage.Insert();

        ClearCollectedErrors();
        ClearLastError();

        Page.RunModal(Page::"Error Messages", TempErrorMessage);
    end;
}
