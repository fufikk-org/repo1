namespace Weibel.Manufacturing.Planning.Batch;

codeunit 70191 "COL Calc MPR"
{
    trigger OnRun()
    var
        StdBatchPlanningService: Codeunit "COL Std Batch Planning Service";
    begin
        StdBatchPlanningService.Batch_CalculateRegenerativePlanMPR();
    end;
}
