namespace Weibel.Projects.Project.Job;

using Microsoft.Projects.Project.Planning;
using Microsoft.Sales.Document;
using Microsoft.Projects.Project.Job;

codeunit 70113 "COL Job Event Sub."
{
    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Job Create-Invoice", 'OnBeforeUpdateSalesHeader', '', false, false)]
    local procedure OnBeforeUpdateSalesHeader(var SalesHeader: Record "Sales Header"; Job: Record Job; var IsHandled: Boolean)
    begin
        SalesHeader."COL Original Contractual Date" := Job."COL Original Contractual Date";
    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Job Create-Invoice", 'OnBeforeInsertSalesHeader', '', false, false)]
    local procedure OnBeforeInsertSalesHeader(var SalesHeader: Record "Sales Header"; Job: Record Job; JobPlanningLine: Record "Job Planning Line")
    begin
        SalesHeader."COL Original Contractual Date" := Job."COL Original Contractual Date";
    end;

    [EventSubscriber(ObjectType::Page, Page::"Project Budget Journal (PGS)", 'OnBeforeActionEvent', 'Post', false, false)]
    local procedure OnBeforeActionEventPost(var Rec: Record "Project Budget Jour Line (PGS)")
    var
        JobCommonMethod: Codeunit "COL Job Common Method";
    begin
        JobCommonMethod.FillChangeReason(Rec);
    end;
}
