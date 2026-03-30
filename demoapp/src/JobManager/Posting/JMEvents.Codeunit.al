codeunit 70198 "COL JM Events"
{
    EventSubscriberInstance = Manual;

    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnBeforeConfirmOutputOnFinishedOperation, '', false, false)]
    local procedure "Item Journal Line_OnBeforeConfirmOutputOnFinishedOperation"(var ItemJournalLine: Record "Item Journal Line"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

}