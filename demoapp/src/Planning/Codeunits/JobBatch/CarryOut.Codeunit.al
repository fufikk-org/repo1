namespace Weibel.Manufacturing.Planning.Batch;

codeunit 70192 "COL Carry Out"
{
    trigger OnRun()
    var
        StdBatchPlanningService: Codeunit "COL Std Batch Planning Service";
    begin
        StdBatchPlanningService.Batch_CarryOut();
    end;
}
