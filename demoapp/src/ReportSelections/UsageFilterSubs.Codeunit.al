codeunit 70114 "COL Usage Filter Subs"
{
    [EventSubscriber(ObjectType::Page, Page::"Report Selection - Sales", OnSetUsageFilterOnAfterSetFiltersByReportUsage, '', false, false)]
    local procedure "Report Selection - Sales_OnSetUsageFilterOnAfterSetFiltersByReportUsage"(var Rec: Record "Report Selections"; ReportUsage2: Option)
    begin
        case ReportUsage2 of
            Enum::"Report Selection Usage Sales"::"COL Shipment Label".AsInteger():
                Rec.SetRange(Usage, Enum::"Report Selection Usage"::"COL S.Shipment Label");
            Enum::"Report Selection Usage Sales"::"COL IC Sales Invoice".AsInteger():
                Rec.SetRange(Usage, Enum::"Report Selection Usage"::"COL IC Sales Invoice");
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Report Selection - Service", OnSetUsageFilterOnAfterSetFiltersByReportUsage, '', false, false)]
    local procedure "Report Selection - Service_OnSetUsageFilterOnAfterSetFiltersByReportUsage"(var Rec: Record "Report Selections"; ReportUsage2: Enum "Report Selection Usage Service")
    begin
        case ReportUsage2 of
            Enum::"Report Selection Usage Service"::"COL Shipment Label":
                Rec.SetRange(Usage, Enum::"Report Selection Usage"::"COL SM.Shipment Label");
            Enum::"Report Selection Usage Service"::"COL Pro Forma Invoice":
                Rec.SetRange(Usage, Enum::"Report Selection Usage"::"COL Pro Forma SM. Invoice");
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Report Selection - Purchase", 'OnSetUsageFilterOnAfterSetFiltersByReportUsage', '', false, false)]
    local procedure "Report Selection - Purchase_OnSetUsageFilterOnAfterSetFiltersByReportUsage"(var Rec: Record "Report Selections"; ReportUsage2: Enum "Report Selection Usage Purchase")
    begin
        case ReportUsage2 of
            Enum::"Report Selection Usage Purchase"::"COL Order - Reminder":
                Rec.SetRange(Usage, Enum::"Report Selection Usage"::"COL Order - Reminder");
        end;
    end;
}