namespace Weibel.Manufacturing.Routing;

using Microsoft.Manufacturing.Routing;
using System.Text;

pageextension 70104 "COL Routing Links" extends "Routing Links"
{
    procedure COLGetSelectionFilter(): Text;
    var
        RoutingLink: Record "Routing Link";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
    begin
        CurrPage.SetSelectionFilter(RoutingLink);
        RecRef.GetTable(RoutingLink);
        exit(SelectionFilterManagement.GetSelectionFilter(RecRef, RoutingLink.FieldNo(Code)));
    end;
}