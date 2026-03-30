namespace Weibel.Manufacturing.Planning.Batch;

codeunit 70193 "COL Calculate Reg. Plan"
{
    trigger OnRun()
    var
        StdBatchPlanningService: Codeunit "COL Std Batch Planning Service";
    begin
        StdBatchPlanningService.Batch_CalculateRegenerativePlanBoth();
    end;
}
