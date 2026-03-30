namespace Weibel.Inventory.Posting;

using Microsoft.Inventory.Posting;
using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Journal;

codeunit 70179 "COL Routing Stat. Log. Subs"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Mfg. Item Jnl.-Post Line", OnPostOutputOnBeforeProdOrderRtngLineModify, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnPostOutputOnBeforeProdOrderRtngLineModify"(var ProdOrderRoutingLine: Record "Prod. Order Routing Line"; var ProdOrderLine: Record "Prod. Order Line"; var ItemJournalLine: Record "Item Journal Line"; var LastOperation: Boolean)
    begin
        ProdOrderRoutingLine.COLUpdateRoutingStatusLogFields();
    end;
}