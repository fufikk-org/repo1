namespace Weibel.API;

page 70165 "COL JobManStampJournalLine"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'jobManStampJournalLine';
    EntitySetName = 'jobManStampJournalLines';
    PageType = API;
    SourceTable = JobManStampJournalLine;
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(employeeNo; Rec.EmployeeNo)
                {
                }
                field(profileDate; Rec.ProfileDate)
                {
                }
                field(pilotNo; Rec.PilotNo)
                {
                }
                field(lineSequence; Rec.LineSequence)
                {
                }
                field(sourceIdentification; Rec.SourceIdentification)
                {
                }
                field(autoRegistration; Rec.AutoRegistration)
                {
                }
                field(startDateTime; Rec.StartDateTime)
                {
                }
                field(stopDateTime; Rec.StopDateTime)
                {
                }
                field(regHours; Rec.RegHours)
                {
                }
                field(timeOffsetUTC; Rec.TimeOffsetUTC)
                {
                }
                field(workTypeCode; Rec.WorkTypeCode)
                {
                }
                field(active; Rec.Active)
                {
                }
                field(jobNo; Rec.JobNo)
                {
                }
                field(jobType; Rec.JobType)
                {
                }
                field(stampType; Rec.StampType)
                {
                }
                field(allowScrap; Rec.AllowScrap)
                {
                }
                field(allowItemConsumption; Rec.AllowItemConsumption)
                {
                }
                field(allowWorkType; Rec.AllowWorkType)
                {
                }
                field(allowPostingDescription; Rec.AllowPostingDescription)
                {
                }
                field(allowFeedback; Rec.AllowFeedback)
                {
                }
                field(reportFinish; Rec.ReportFinish)
                {
                }
                field(reportQtyGood; Rec.ReportQtyGood)
                {
                }
                field(reportQtyScrap; Rec.ReportQtyScrap)
                {
                }
                field(rateType; Rec.RateType)
                {
                }
                field(bundleStartDateTime; Rec.BundleStartDateTime)
                {
                }
                field(bundleStopDateTime; Rec.BundleStopDateTime)
                {
                }
                field(bundleLineSequence; Rec.BundleLineSequence)
                {
                }
                field(preApproved; Rec.PreApproved)
                {
                }
                field(preApprovedBy; Rec.PreApprovedBy)
                {
                }
                field(preApproveGroupNo; Rec.PreApproveGroupNo)
                {
                }
                field(postingDescription1; Rec.PostingDescription1)
                {
                }
                field(postingDescription2; Rec.PostingDescription2)
                {
                }
                field(sumActualTimeDecimal; Rec.SumActualTimeDecimal)
                {
                }
                field(sumGrossTimeDecimal; Rec.SumGrossTimeDecimal)
                {
                }
                field(sumNetTimeDecimal; Rec.SumNetTimeDecimal)
                {
                }
                field(postingTimeType; Rec.PostingTimeType)
                {
                }
                field(postingTimeFactor; Rec.PostingTimeFactor)
                {
                }
                field(jobDescription; Rec.JobDescription)
                {
                }
                field(attention; Rec.Attention)
                {
                }
                field(openEvents; Rec.OpenEvents)
                {
                }
                field(countBlobStorage; Rec.CountBlobStorage)
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
                field(prodLineNo; Rec.ProdLineNo)
                {
                }
                field(prodOperationNo; Rec.ProdOperationNo)
                {
                }
                field(machineCenterNo; Rec.MachineCenterNo)
                {
                }
                field(workCenterNo; Rec.WorkCenterNo)
                {
                }
                field(prodItemDescription; Rec.ProdItemDescription)
                {
                }
                field(prodRoutingNo; Rec.ProdRoutingNo)
                {
                }
                field(prodStandardTaskCode; Rec.ProdStandardTaskCode)
                {
                }
                field(resourceNo; Rec.ResourceNo)
                {
                }
                field(resourceGroupNo; Rec.ResourceGroupNo)
                {
                }
                field(nowReported; Rec.NowReported)
                {
                }
                field(nowReportQtyGood; Rec.NowReportQtyGood)
                {
                }
                field(nowReportQtyScrap; Rec.NowReportQtyScrap)
                {
                }
                field(sumReportQtyGood; Rec.SumReportQtyGood)
                {
                }
                field(sumReportQtyScrap; Rec.SumReportQtyScrap)
                {
                }
                field(hasMileage; Rec.HasMileage)
                {
                }
                field(hasAddon; Rec.HasAddon)
                {
                }
                field(hasItemConsumption; Rec.HasItemConsumption)
                {
                }
                field(calculated; Rec.Calculated)
                {
                }
                field(approved; Rec.Approved)
                {
                }
                field(transferred; Rec.Transferred)
                {
                }
                field(calculatedUserID; Rec.CalculatedUserID)
                {
                }
                field(triggerAddonCode; Rec.TriggerAddonCode)
                {
                }
                field(triggerAddonStartLineSequence; Rec.TriggerAddonStartLineSequence)
                {
                }
                field(triggerAddonStopLineSequence; Rec.TriggerAddonStopLineSequence)
                {
                }
                field(sumActualTimeDecimalCentiHours; Rec.SumActualTimeDecimalCentiHours)
                {
                }
                field(sumGrossTimeDecimalCentiHours; Rec.SumGrossTimeDecimalCentiHours)
                {
                }
                field(sumNetTimeDecimalCentiHours; Rec.SumNetTimeDecimalCentiHours)
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
