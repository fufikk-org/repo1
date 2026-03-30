namespace Weibel.Manufacturing.BlockProduction;

using Microsoft.Manufacturing.Document;

codeunit 70155 "COL Prod. Order Block Calc."
{
    var
        BlockProductionMgt: Codeunit "COL Block Production Mgt.";

    internal procedure CalcNoOfBlockedOutput(var ProductionOrder: Record "Production Order") BlockedLines: Integer
    var
        ProdOrderLine: Record "Prod. Order Line";
        ErrMsg: Text;
    begin
        Clear(BlockedLines);
        ProdOrderLine.ReadIsolation := IsolationLevel::ReadUncommitted;
        ProdOrderLine.SetBaseLoadFields();
        ProdOrderLine.SetRange(Status, ProductionOrder.Status);
        ProdOrderLine.SetRange("Prod. Order No.", ProductionOrder."No.");
        if ProdOrderLine.FindSet() then
            repeat
                if not BlockProductionMgt.CheckProductionOrderLine(ProdOrderLine, false, ErrMsg) then
                    BlockedLines += 1;
            until ProdOrderLine.Next() = 0;
    end;

    internal procedure ShowBlockedOutput(var ProductionOrder: Record "Production Order")
    var
        ProdOrderLine: Record "Prod. Order Line";
        TempProdOrderLine: Record "Prod. Order Line" temporary;
        ErrMsg: Text;
    begin
        ProdOrderLine.ReadIsolation := IsolationLevel::ReadUncommitted;
        ProdOrderLine.SetRange(Status, ProductionOrder.Status);
        ProdOrderLine.SetRange("Prod. Order No.", ProductionOrder."No.");
        if ProdOrderLine.FindSet() then
            repeat
                if not BlockProductionMgt.CheckProductionOrderLine(ProdOrderLine, false, ErrMsg) then begin
                    TempProdOrderLine := ProdOrderLine;
                    TempProdOrderLine.Insert(false)
                end;
            until ProdOrderLine.Next() = 0;

        if TempProdOrderLine.FindFirst() then
            Page.Run(0, TempProdOrderLine)
    end;

    internal procedure CalcNoOfBlockedComponents(var ProductionOrder: Record "Production Order") BlockedLines: Integer
    var
        ProdOrderComponent: Record "Prod. Order Component";
        ErrMsg: Text;
    begin
        Clear(BlockedLines);
        ProdOrderComponent.ReadIsolation := IsolationLevel::ReadUncommitted;
        ProdOrderComponent.SetBaseLoadFields();
        ProdOrderComponent.SetRange(Status, ProductionOrder.Status);
        ProdOrderComponent.SetRange("Prod. Order No.", ProductionOrder."No.");
        if ProdOrderComponent.FindSet() then
            repeat
                if not BlockProductionMgt.CheckProductionOrderComponentLine(ProdOrderComponent, false, ErrMsg) then
                    BlockedLines += 1;
            until ProdOrderComponent.Next() = 0;
    end;

    internal procedure ShowBlockedComponents(var ProductionOrder: Record "Production Order")
    var
        ProdOrderComponent: Record "Prod. Order Component";
        TempProdOrderComponent: Record "Prod. Order Component" temporary;
        ErrMsg: Text;
    begin
        ProdOrderComponent.ReadIsolation := IsolationLevel::ReadUncommitted;
        ProdOrderComponent.SetRange(Status, ProductionOrder.Status);
        ProdOrderComponent.SetRange("Prod. Order No.", ProductionOrder."No.");
        if ProdOrderComponent.FindSet() then
            repeat
                if not BlockProductionMgt.CheckProductionOrderComponentLine(ProdOrderComponent, false, ErrMsg) then begin
                    TempProdOrderComponent := ProdOrderComponent;
                    TempProdOrderComponent.Insert(false);
                end;
            until ProdOrderComponent.Next() = 0;

        if TempProdOrderComponent.FindFirst() then
            Page.Run(0, TempProdOrderComponent)
    end;
}