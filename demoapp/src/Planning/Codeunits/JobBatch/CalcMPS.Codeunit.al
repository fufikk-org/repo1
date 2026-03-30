namespace Weibel.Manufacturing.Planning.Batch;

codeunit 70190 "COL Calc MPS"
{
    trigger OnRun()
    var
        StdBatchPlanningService: Codeunit "COL Std Batch Planning Service";
    begin
        StdBatchPlanningService.Batch_CalculateRegenerativePlanMPS();
    end;
}
