namespace Weibel.System.Automation;

using Microsoft.Service.Document;
using System.Automation;

codeunit 70111 "COL Service Record Restr. Mgt."
{
    var
        RestrictionMgt: Codeunit "Record Restriction Mgt.";

    [EventSubscriber(ObjectType::Table, Database::"Service Header", 'COLOnCheckServicePostRestrictions', '', false, false)]
    local procedure ServiceHeaderCheckServicePostRestrictions(var Sender: Record "Service Header")
    begin
        RestrictionMgt.CheckRecordHasUsageRestrictions(Sender);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Service Header", 'COLOnCheckServiceReleaseRestrictions', '', false, false)]
    local procedure ServiceHeaderCheckServiceReleaseRestrictions(var Sender: Record "Service Header")
    begin
        RestrictionMgt.CheckRecordHasUsageRestrictions(Sender);
    end;
}