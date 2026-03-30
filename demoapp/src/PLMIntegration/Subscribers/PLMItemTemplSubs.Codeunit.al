codeunit 70120 "COL PLM Item Templ. Subs"
{
    EventSubscriberInstance = Manual;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Templ. Mgt.", OnBeforeSetBaseUoM, '', false, false)]
    local procedure "Item Templ. Mgt._OnBeforeSetBaseUoM"(var Item: Record Item; var ItemTempl: Record "Item Templ."; var IsHandled: Boolean)
    begin
        if Item."Base Unit of Measure" <> '' then
            IsHandled := true;
    end;

}