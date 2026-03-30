namespace Weibel.API;

page 70162 "COL JobManJob"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'jobManJob';
    EntitySetName = 'jobManJobs';
    PageType = API;
    SourceTable = JobManJob;
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(jobNo; Rec.JobNo)
                {
                }
                field(jobType; Rec.JobType)
                {
                }
                field(refType; Rec.RefType)
                {
                }
                field(refNo; Rec.RefNo)
                {
                }
                field(refSubNo; Rec.RefSubNo)
                {
                }
                field(resourceNo; Rec.ResourceNo)
                {
                }
                field(resourceGroupNo; Rec.ResourceGroupNo)
                {
                }
                field(machineCenterNo; Rec.MachineCenterNo)
                {
                }
                field(workCenterNo; Rec.WorkCenterNo)
                {
                }
                field(description; Rec.Description)
                {
                }
                field(startDate; Rec.StartDate)
                {
                }
                field(startTime; Rec.StartTime)
                {
                }
                field(stopDate; Rec.StopDate)
                {
                }
                field(stopTime; Rec.StopTime)
                {
                }
                field(jobLink; Rec.JobLink)
                {
                }
                field(workTypeCode; Rec.WorkTypeCode)
                {
                }
                field(prioDate; Rec.PrioDate)
                {
                }
                field(prioNo; Rec.PrioNo)
                {
                }
                field(allowFeedback; Rec.AllowFeedback)
                {
                }
                field(disableRegistration; Rec.DisableRegistration)
                {
                }
                field(allowPostingDescription; Rec.AllowPostingDescription)
                {
                }
                field(allowWorkType; Rec.AllowWorkType)
                {
                }
                field(allowScrap; Rec.AllowScrap)
                {
                }
                field(allowItemConsumption; Rec.AllowItemConsumption)
                {
                }
                field(rateType; Rec.RateType)
                {
                }
                field(reportedFinished; Rec.ReportedFinished)
                {
                }
                field(reportedStarted; Rec.ReportedStarted)
                {
                }
                field(bundleFactor; Rec.BundleFactor)
                {
                }
                field(sumActualTimeDecimal; Rec.SumActualTimeDecimal)
                {
                }
                field(calculatedTimeDecimal; Rec.CalculatedTimeDecimal)
                {
                }
                field(postingTimeType; Rec.PostingTimeType)
                {
                }
                field(postingTimeFactor; Rec.PostingTimeFactor)
                {
                }
                field(countBlobStorage; Rec.CountBlobStorage)
                {
                }
                field(noSeries; Rec.NoSeries)
                {
                }
                field(sumReportQtyGood; Rec.SumReportQtyGood)
                {
                }
                field(sumReportQtyScrap; Rec.SumReportQtyScrap)
                {
                }
                field(lastJournalLineDate; Rec.LastJournalLineDate)
                {
                }
                field(prodStatus; Rec.ProdStatus)
                {
                }
                field(prodRoutingNo; Rec.ProdRoutingNo)
                {
                }
                field(prodRoutingReferenceNo; Rec.ProdRoutingReferenceNo)
                {
                }
                field(prodLineNo; Rec.ProdLineNo)
                {
                }
                field(prodOperationNo; Rec.ProdOperationNo)
                {
                }
                field(prodStandardTaskCode; Rec.ProdStandardTaskCode)
                {
                }
                field(prodDescription; Rec.ProdDescription)
                {
                }
                field(prodRoutingDescription; Rec.ProdRoutingDescription)
                {
                }
                field(prodRoutingStatus; Rec.ProdRoutingStatus)
                {
                }
                field(prodQuantity; Rec.ProdQuantity)
                {
                }
                field(prodUnitOfMeasureCode; Rec.ProdUnitOfMeasureCode)
                {
                }
                field(prodLineDescription; Rec.ProdLineDescription)
                {
                }
                field(prodItemDescription; Rec.ProdItemDescription)
                {
                }
                field(prodRoutingVersionCode; Rec.ProdRoutingVersionCode)
                {
                }
                field(prodNextOperationNo; Rec.ProdNextOperationNo)
                {
                }
                field(prodPrevOperationNo; Rec.ProdPrevOperationNo)
                {
                }
                field(prodRoutingLinkCode; Rec.ProdRoutingLinkCode)
                {
                }
                field(prodRoutingFlushingMethod; Rec.ProdRoutingFlushingMethod)
                {
                }
                field(prodLineVariantCode; Rec.ProdLineVariantCode)
                {
                }
                field(prodRoutingStatusPrev; Rec.ProdRoutingStatus_Prev)
                {
                }
                field(ipcStampType; Rec.IpcStampType)
                {
                }
                field(ipcCategoryDescription; Rec.IpcCategoryDescription)
                {
                }
                field(jobPlanLineNo; Rec.JobPlanLineNo)
                {
                }
                field(jobPlanLineType; Rec.JobPlanLineType)
                {
                }
                field(jobDescription; Rec.JobDescription)
                {
                }
                field(jobDescription2; Rec.JobDescription2)
                {
                }
                field(jobTaskDescription; Rec.JobTaskDescription)
                {
                }
                field(jobPlanLineUsageLink; Rec.JobPlanLineUsageLink)
                {
                }
                field(jobCustomerNo; Rec.JobCustomerNo)
                {
                }
                field(serviceDocumentType; Rec.ServiceDocumentType)
                {
                }
                field(serviceItemLineNo; Rec.ServiceItemLineNo)
                {
                }
                field(serviceLineNo; Rec.ServiceLineNo)
                {
                }
                field(serviceOrderAllocEntryNo; Rec.ServiceOrderAllocEntryNo)
                {
                }
                field(serviceItemLineDescription; Rec.ServiceItemLineDescription)
                {
                }
                field(serviceItemLineRepairStatus; Rec.ServiceItemLineRepairStatus)
                {
                }
                field(serviceItemLineServiceItemNo; Rec.ServiceItemLineServiceItemNo)
                {
                }
                field(serviceLineDescription; Rec.ServiceLineDescription)
                {
                }
                field(serviceLineDescription2; Rec.ServiceLineDescription2)
                {
                }
                field(serviceOrderAllocDescription; Rec.ServiceOrderAllocDescription)
                {
                }
                field(serviceCustomerNo; Rec.ServiceCustomerNo)
                {
                }
                field(assemblyDocumentType; Rec.AssemblyDocumentType)
                {
                }
                field(assemblyLineNo; Rec.AssemblyLineNo)
                {
                }
                field(assembleToOrder; Rec.AssembleToOrder)
                {
                }
                field(assemblyItemDescription; Rec.AssemblyItemDescription)
                {
                }
                field(assemblyDescription; Rec.AssemblyDescription)
                {
                }
                field(assemblyDescription2; Rec.AssemblyDescription2)
                {
                }
                field(assemblyLineDescription; Rec.AssemblyLineDescription)
                {
                }
                field(assemblyLineDescription2; Rec.AssemblyLineDescription2)
                {
                }
                field(sumActualTimeDecimalCentiHours; Rec.SumActualTimeDecimalCentiHours)
                {
                }
                field(customText01; Rec.CustomText01)
                {
                }
                field(customText02; Rec.CustomText02)
                {
                }
                field(customText03; Rec.CustomText03)
                {
                }
                field(customText04; Rec.CustomText04)
                {
                }
                field(customText05; Rec.CustomText05)
                {
                }
                field(customInteger01; Rec.CustomInteger01)
                {
                }
                field(customInteger02; Rec.CustomInteger02)
                {
                }
                field(customInteger03; Rec.CustomInteger03)
                {
                }
                field(customDecimal01; Rec.CustomDecimal01)
                {
                }
                field(customDecimal02; Rec.CustomDecimal02)
                {
                }
                field(customDecimal03; Rec.CustomDecimal03)
                {
                }
                field(customDecimal04; Rec.CustomDecimal04)
                {
                }
                field(customDecimal05; Rec.CustomDecimal05)
                {
                }
                field(customDate01; Rec.CustomDate01)
                {
                }
                field(customDate02; Rec.CustomDate02)
                {
                }
                field(customDate03; Rec.CustomDate03)
                {
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                }
                field(systemId; Rec.SystemId)
                {
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                }
            }
        }
    }
}
