codeunit 70146 "COL Service Print Subs."
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Serv. Document Print", OnBeforeCalcServDisc, '', false, false)]
    local procedure "Serv. Document Print_OnBeforeCalcServDisc"(var ServiceHeader: Record "Service Header"; var IsHandled: Boolean)
    begin
        this.SkipIfNoLines(ServiceHeader, IsHandled);
    end;

    internal procedure SkipIfNoLines(var ServiceHeader: Record "Service Header"; var IsHandled: Boolean)
    var
        ServiceLine: Record "Service Line";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        SalesReceivablesSetup.Get();
        if not SalesReceivablesSetup."Calc. Inv. Discount" then
            exit;

        ServiceLine.SetRange("Document Type", ServiceHeader."Document Type");
        ServiceLine.SetRange("Document No.", ServiceHeader."No.");
        IsHandled := ServiceLine.IsEmpty();
    end;
}