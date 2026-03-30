namespace Weibel.Manufacturing.Document;

using Weibel.Common;
using Microsoft.Manufacturing.Document;
using Weibel.Inventory.Item;
using Weibel.Inventory.Ledger;
using Microsoft.Inventory.Costing;

pageextension 70165 "COL Released Prod. Order Lines" extends "Released Prod. Order Lines"
{
    layout
    {
        addafter("Variant Code")
        {
            field("COL Product Life Cycle"; Rec."COL Product Life Cycle")
            {
                ApplicationArea = Suite;
                Importance = Additional;
            }
        }
        addafter("Remaining Quantity")
        {
            field(COL_ActScrapQtyCtr; ActScrapQty)
            {
                ApplicationArea = All;
                Caption = 'Scrap Quantity';
                ToolTip = 'The total scrap quantity for the operation.';
                Editable = false;
                DecimalPlaces = 0 : 5;
            }
        }
    }

    actions
    {
        addafter(ProductionJournal)
        {
            action("COL Print Label")
            {
                ApplicationArea = All;
                Caption = 'Print Label';
                Image = Print;
                ToolTip = 'Print Label for selected line.';

                trigger OnAction()
                var
                    WeibelItemODCLabel: Report "COL Weibel Item ODC Label";
                begin
                    WeibelItemODCLabel.InitFrom(Rec);
                    WeibelItemODCLabel.RunModal();
                end;
            }
            action("COL Print Cable")
            {
                ApplicationArea = All;
                Caption = 'Print Cable Label';
                Image = Print;
                ToolTip = 'Print Cable Labels';

                trigger OnAction()
                var
                    CableLabel: Report "COL Cable Label2";
                begin
                    CableLabel.SetData(Rec);
                    CableLabel.RunModal();
                end;
            }

        }
    }


    trigger OnModifyRecord(): Boolean
    var
        ProductionOrder: Record "Production Order";
        FieldSelect: Codeunit "COL Field Select Mgt";
    begin
        if not GuiAllowed() then
            exit;

        ProductionOrder.Get(Rec.Status, Rec."Prod. Order No.");
        if (ProductionOrder."COL Internal Status" = ProductionOrder."COL Internal Status"::Released) then
            FieldSelect.CheckIfModifyAllowed(Rec, xRec);
    end;

    trigger OnAfterGetRecord()
    begin
        CalcCapTotals()
    end;

    var

        ActRunTime: Decimal;
        ActSetupTime: Decimal;
        ActOutputQty: Decimal;
        ActScrapQty: Decimal;

    local procedure CalcCapTotals()
    var
        ProdOrderRtngLine: Record "Prod. Order Routing Line";
        MfgCostCalculationMgt: Codeunit "Mfg. Cost Calculation Mgt.";
        OperationFound: Boolean;
    begin
        ActRunTime := 0;
        ActSetupTime := 0;
        ActOutputQty := 0;
        ActScrapQty := 0;
        OperationFound := false;

        ProdOrderRtngLine.Reset();
        ProdOrderRtngLine.SetRange("Prod. Order No.", Rec."Prod. Order No.");
        ProdOrderRtngLine.SetRange("Routing No.", Rec."Routing No.");
        ProdOrderRtngLine.SetRange(Status, Rec.Status);
        ProdOrderRtngLine.SetRange("Routing Reference No.", Rec."Routing Reference No.");
        if ProdOrderRtngLine.FindSet() then
            repeat
                OperationFound := true;
                MfgCostCalculationMgt.CalcActTimeAndQtyBase(
                        Rec, ProdOrderRtngLine."Operation No.", ActRunTime, ActSetupTime, ActOutputQty, ActScrapQty);
            until ProdOrderRtngLine.Next() = 0;

        if not OperationFound then
            MfgCostCalculationMgt.CalcActTimeAndQtyBase(
              Rec, '', ActRunTime, ActSetupTime, ActOutputQty, ActScrapQty);
    end;
}
