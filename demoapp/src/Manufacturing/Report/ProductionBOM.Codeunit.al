namespace Weibel.Foundation.Reporting;

using Microsoft.Foundation.Reporting;
using Weibel.Manufacturing.Reports;
using Microsoft.Manufacturing.ProductionBOM;
using System.IO;

codeunit 70163 "COL Production BOM"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, OnGetFilename, '', false, false)]
    local procedure ReportManagement_OnGetFilename(ReportID: Integer; Caption: Text[250]; ObjectPayload: JsonObject; FileExtension: Text[30]; ReportRecordRef: RecordRef; var Filename: Text; var Success: Boolean)
    begin
        if ReportID = Report::"COL Production BOM" then
            Success := GetFileName(Filename, Filename, Caption, ReportRecordRef, FileExtension);
    end;

    [TryFunction]
    local procedure GetFileName(var NewFileName: Text; OldFileName: Text; ReportCaption: Text; var ReportRecordRef: RecordRef; FileExtension: Text[30])
    var
        ProductionBOMHeader: Record "Production BOM Header";
        FileManagement: Codeunit "File Management";
        FileNameLbl: Label '%1 %2', Locked = true;
        FileName2Lbl: Label '%1%2', Locked = true;
    begin
        NewFileName := OldFileName;
        if ReportRecordRef.Number > 0 then
            NewFileName := StrSubstNo(FileName2Lbl, FileManagement.GetSafeFileName(StrSubstNo(FileNameLbl, ReportCaption, ReportRecordRef.Field(ProductionBOMHeader.FieldNo("No.")).GetFilter())), FileExtension);
    end;

}