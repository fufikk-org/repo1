namespace Weibel.Manufacturing.ProductionBOM;

using Microsoft.Manufacturing.ProductionBOM;

codeunit 70206 "COL Import BOM Subs"
{
    EventSubscriberInstance = Manual;

    [EventSubscriber(ObjectType::Table, Database::"Production BOM Line", OnBeforeValidateEvent, "Quantity per", false, false)]
    local procedure ProductionBOMLine_OnBeforeValidateEvent_QuantityPer(var Rec: Record "Production BOM Line")
    var
        NegativeErr: Label 'Quantity should not be negative: %1', Comment = '%1 = quantity';
    begin
        if Rec."Quantity per" < 0 then
            Error(ErrorInfo.Create(StrSubstNo(NegativeErr, Rec."Quantity per"), true));
    end;
}