codeunit 70116 "COL Shipment Lbl Report Subs"
{
    EventSubscriberInstance = Manual;

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", OnBeforePrintDocument, '', false, false)]
    local procedure "Report Selections_OnBeforePrintDocument"(TempReportSelections: Record "Report Selections" temporary; IsGUI: Boolean; var RecVarToPrint: Variant; var IsHandled: Boolean)
    var
        SalesHeader: Record "Sales Header";
        ServiceHeader: Record "Service Header";
        ShipmentLabelReport: Report "COL Shipment Label";
        RecRef: RecordRef;
        DocumentNo: Code[20];
        DocumentType: Enum "COL Shipment Label Doc. Type";
        NotSupportedErr: Label 'Table %1 is not supported for shipment label report.', Comment = '%1 = table no.';
    begin
        if TempReportSelections."Report ID" = Report::"COL Shipment Label" then begin
            IsHandled := true;
            RecRef.GetTable(RecVarToPrint);
            case RecRef.Number() of
                Database::"Sales Header":
                    begin
                        DocumentNo := RecRef.Field(SalesHeader.FieldNo("No.")).Value();
                        DocumentType := Enum::"COL Shipment Label Doc. Type"::"Sales Order";
                    end;
                Database::"Service Header":
                    begin
                        DocumentNo := RecRef.Field(ServiceHeader.FieldNo("No.")).Value();
                        DocumentType := Enum::"COL Shipment Label Doc. Type"::"Service Order";
                    end;
                else
                    Error(NotSupportedErr, RecRef.Number());
            end;
            ShipmentLabelReport.InitRequest(DocumentType, DocumentNo);
            ShipmentLabelReport.RunModal();
        end;
    end;

}