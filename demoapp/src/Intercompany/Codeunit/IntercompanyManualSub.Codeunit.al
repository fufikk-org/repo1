namespace Weibel.Intercompany;

using Microsoft.Finance.GeneralLedger.Posting;
using Microsoft.Finance.GeneralLedger.Journal;

codeunit 70142 "COL Intercompany Manual Sub."
{
    EventSubscriberInstance = Manual;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post", 'OnBeforeCode', '', false, false)]
    local procedure OnBeforeCode(var GenJournalLine: Record "Gen. Journal Line"; var HideDialog: Boolean)
    begin
        HideDialog := true;
    end;
}
