namespace Weibel.Manufacturing.Planning.Batch;

using Microsoft.Inventory.Requisition;

reportextension 70104 "COL Carry Out Action Msg.Plan." extends "Carry Out Action Msg. - Plan."
{
    // dataset
    // {
    //     modify("Requisition Line")
    //     {
    //         trigger OnBeforePreDataItem()
    //         begin
    //             if not RunFromBatch then
    //                 exit;

    //             if not FindReqLines() then
    //                 CurrReport.Quit();
    //         end;
    //     }
    // }

    // trigger OnPreReport()
    // begin
    //     if not RunFromBatch then
    //         exit;

    //     ManufacturingSetup.Get();
    //     "Requisition Line"."Worksheet Template Name" := ManufacturingSetup."COL Plan. Worksheet Temp. Name";
    //     "Requisition Line"."Journal Batch Name" := GetJournalBatchName();

    //     SetReqWkshLine("Requisition Line");
    //     ProdOrderChoice := ProdOrderChoice::Planned;
    //     PurchOrderChoice := PurchOrderChoice::" ";
    //     TransOrderChoice := TransOrderChoice::" ";
    // end;

    // var
    //     ManufacturingSetup: Record "Manufacturing Setup";
    //     RunFromBatch: Boolean;

    // local procedure GetJournalBatchName(): Code[10]
    // begin
    //     case ManufacturingSetup."COL Batch Plan On" of
    //         Enum::"COL Batch Plan On"::" ":
    //             CurrReport.Quit();
    //         Enum::"COL Batch Plan On"::"Net. Plan":
    //             exit(ManufacturingSetup."COL Net. Plan Jnl. Batch Name");
    //         Enum::"COL Batch Plan On"::"Std. Plan":
    //             exit(ManufacturingSetup."COL Std. Plan Jnl. Batch Name");
    //     end;
    // end;

    // procedure COLRunFromBatchPlanning(pRunFromBatch: Boolean)
    // begin
    //     RunFromBatch := pRunFromBatch;
    // end;

    // local procedure FindReqLines(): Boolean
    // var
    //     RequisitionLine: Record "Requisition Line";
    // begin
    //     RequisitionLine.ReadIsolation := IsolationLevel::ReadUncommitted;
    //     RequisitionLine.SetRange("Worksheet Template Name", CurrReqWkshTemp);
    //     RequisitionLine.SetRange("Journal Batch Name", CurrReqWkshName);
    //     RequisitionLine.SetRange(Type, RequisitionLine.Type::Item);
    //     RequisitionLine.SetRange("Accept Action Message", true);
    //     RequisitionLine.SetRange("Replenishment System", RequisitionLine."Replenishment System"::Purchase);
    //     exit(not RequisitionLine.IsEmpty());
    // end;

    // procedure COLMarkAAMReqLines()
    // var
    //     RequisitionLine: Record "Requisition Line";
    // begin
    //     RequisitionLine.ReadIsolation := IsolationLevel::ReadUncommitted;
    //     RequisitionLine.SetRange("Worksheet Template Name", CurrReqWkshTemp);
    //     RequisitionLine.SetRange("Journal Batch Name", CurrReqWkshName);
    //     RequisitionLine.SetRange(Type, RequisitionLine.Type::Item);
    //     RequisitionLine.SetRange("Accept Action Message", false);
    //     RequisitionLine.SetRange("Replenishment System", RequisitionLine."Replenishment System"::Purchase);
    //     RequisitionLine.ModifyAll("Accept Action Message", true);
    // end;

    procedure COLSetErrorShow(pNoPlanningResiliency: Boolean)
    begin
        NoPlanningResiliency := pNoPlanningResiliency;
    end;
}