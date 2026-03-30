namespace Weibel.Warehouse.Structure;

using Microsoft.Warehouse.Structure;
using Microsoft.Warehouse.Journal;
using Microsoft.Warehouse.Ledger;

codeunit 70235 "COL Bin Event Sub."
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse. Jnl.-Register Line", 'OnBeforeBinContentInsert', '', true, true)]
    local procedure OnBeforeBinContentInsert(var BinContent: Record "Bin Content"; WarehouseEntry: Record "Warehouse Entry"; Bin: Record Bin);
    begin
        BinContent.Fixed := false;
        BinContent.Default := false;
    end;

}
