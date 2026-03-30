namespace Weibel.Manufacturing.Planning.Batch;

codeunit 70189 "COL Calc Low Level Code"
{
    trigger OnRun()
    var
        StdBatchPlanningService: Codeunit "COL Std Batch Planning Service";
    begin
        StdBatchPlanningService.Batch_CalcLowLevelCode();
    end;
}
