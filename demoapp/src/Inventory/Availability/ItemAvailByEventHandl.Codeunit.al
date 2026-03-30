codeunit 70131 "COL Item Avail.By Event Handl."
{
    [EventSubscriber(ObjectType::Page, Page::"Item Availability by Event", OnBeforeInitialize, '', false, false)]
    local procedure "Item Availability by Event_OnBeforeInitialize"(var Item: Record Item)
    begin
        Item."COL Availability Type Check" := Enum::"Item Availability Type"::"Event"; // Set the availability type to "Event" when initializing the page.
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", OnAfterFilterLinesWithItemToPlan, '', false, false)]
    local procedure "Sales Line_OnAfterFilterLinesWithItemToPlan"(var SalesLine: Record "Sales Line"; var Item: Record Item; DocumentType: Option)
    begin
        if Enum::"Sales Document Type"::Order <> Enum::"Sales Document Type".FromInteger(DocumentType) then
            exit;

        if Item."COL Availability Type Check" <> Enum::"Item Availability Type"::"Event" then
            exit;

        SalesLine.CalcFields("COL Status");
        SalesLine.SetRange("COL Status", SalesLine."COL Status"::Released);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Service Line", OnAfterFilterLinesWithItemToPlan, '', false, false)]
    local procedure "Service Line_OnAfterFilterLinesWithItemToPlan"(var ServiceLine: Record "Service Line"; var Item: Record Item)
    begin
        if Item."COL Availability Type Check" <> Enum::"Item Availability Type"::"Event" then
            exit;

        ServiceLine.CalcFields("COL Status");
        ServiceLine.SetRange("COL Status", ServiceLine."COL Status"::"Released to Ship");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Calc. Item Availability", OnAfterGetDocumentEntries, '', false, false)]
    local procedure "Calc. Item Availability_OnAfterGetDocumentEntries"(var Item: Record Item)
    begin
        Item."COL Availability Type Check" := Enum::"Item Availability Type"::"COL Empty"; // Reset the availability type to "COL Empty" when closing the inventory page data.
    end;
}