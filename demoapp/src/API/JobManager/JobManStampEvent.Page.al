namespace Weibel.API;

page 70163 "COL JobManStampEvent"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'jobManStampEvent';
    EntitySetName = 'jobManStampEvents';
    PageType = API;
    SourceTable = JobManStampEvent;
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(lineSequence; Rec.LineSequence)
                {
                }
                field(lineSequenceJournalLine; Rec.LineSequenceJournalLine)
                {
                }
                field(eventTimestamp; Rec.EventTimestamp)
                {
                }
                field(eventType; Rec.EventType)
                {
                }
                field(eventStatus; Rec.EventStatus)
                {
                }
                field(eventStatusAsInt; Format(Rec.EventStatus, 0, '<Number>'))
                {
                }
                field(sourceIdentification; Rec.SourceIdentification)
                {
                }
                field(employeeNo; Rec.EmployeeNo)
                {
                }
                field(jobNo; Rec.JobNo)
                {
                }
                field(jobType; Rec.JobType)
                {
                }
                field(jobTypeAsInt; Format(Rec.JobType, 0, '<Number>'))
                {
                }
                field(stampType; Rec.StampType)
                {
                }
                field(stampTypeAsInt; Format(Rec.StampType, 0, '<Number>'))
                {
                }
                field(workTypeCode; Rec.WorkTypeCode)
                {
                }
                field(refType; Rec.RefType)
                {
                }
                field(refTypeAsInt; Format(Rec.RefType, 0, '<Number>'))
                {
                }
                field(refNo; Rec.RefNo)
                {
                }
                field(refSubNo; Rec.RefSubNo)
                {
                }
                field(profileDate; Rec.ProfileDate)
                {
                }
                field(prodLineNo; Rec.ProdLineNo)
                {
                }
                field(postingAttempts; Rec.PostingAttempts)
                {
                }
                field(errorDateTime; Rec.ErrorDateTime)
                {
                }
                field(postedMethod; Rec.PostedMethod)
                {
                }
                field(postedMethodAsInt; Format(Rec.PostedMethod, 0, '<Number>'))
                {
                }
                field(postedByUserID; Rec.PostedByUserID)
                {
                }
                field(postedDateTime; Rec.PostedDateTime)
                {
                }
                field(postedJobQueueEntryID; Rec.PostedJobQueueEntryID)
                {
                }
                field(postedDocumentNo; Rec.PostedDocumentNo)
                {
                }
                field(postedDocumentNoCancel; Rec.PostedDocumentNoCancel)
                {
                }
                field(postedAssemblyLineNo; Rec.PostedAssemblyLineNo)
                {
                }
                field(postedServiceItemLineNo; Rec.PostedServiceItemLineNo)
                {
                }
                field(postedServiceLineNo; Rec.PostedServiceLineNo)
                {
                }
                field(reportFinishAsInt; Format(Rec.ReportFinish, 0, '<Number>'))
                {
                }
                field(qtyGood; Rec.QtyGood)
                {
                }
                field(qtyScrap; Rec.QtyScrap)
                {
                }
                field(actualTimeDecimal; Rec.ActualTimeDecimal)
                {
                }
                field(scrapCode; Rec.ScrapCode)
                {
                }
                field(outputSerialNo; Rec.OutputSerialNo)
                {
                }
                field(outputLotNo; Rec.OutputLotNo)
                {
                }
                field(outputPackageNo; Rec.OutputPackageNo)
                {
                }
                field(outputLocationCode; Rec.OutputLocationCode)
                {
                }
                field(outputBinCode; Rec.OutputBinCode)
                {
                }
                field(itemNo; Rec.ItemNo)
                {
                }
                field(itemQty; Rec.ItemQty)
                {
                }
                field(itemReasonCode; Rec.ItemReasonCode)
                {
                }
                field(itemNeededQty; Rec.ItemNeededQty)
                {
                }
                field(itemExpectedQty; Rec.ItemExpectedQty)
                {
                }
                field(itemReportedQty; Rec.ItemReportedQty)
                {
                }
                field(itemRefLineNo; Rec.ItemRefLineNo)
                {
                }
                field(itemFlushingMethod; Rec.ItemFlushingMethod)
                {
                }
                field(itemFlushingMethodAsInt; Format(Rec.ItemFlushingMethod, 0, '<Number>'))
                {
                }
                field(itemVariantCode; Rec.ItemVariantCode)
                {
                }
                field(itemUnitOfMeasureCode; Rec.ItemUnitOfMeasureCode)
                {
                }
                field(itemSerialNo; Rec.ItemSerialNo)
                {
                }
                field(itemLotNo; Rec.ItemLotNo)
                {
                }
                field(itemPackageNo; Rec.ItemPackageNo)
                {
                }
                field(itemLocationCode; Rec.ItemLocationCode)
                {
                }
                field(itemBinCode; Rec.ItemBinCode)
                {
                }
                field(logRegHours; Rec.LogRegHours)
                {
                }
                field(logStopDateTime; Rec.LogStopDateTime)
                {
                }
                field(actualTimeDecimalCentiHours; Rec.ActualTimeDecimalCentiHours)
                {
                }
                field(jobQueueErrorMessage1; Rec.JobQueueErrorMessage1)
                {
                }
                field(jobQueueErrorMessage2; Rec.JobQueueErrorMessage2)
                {
                }
                field(jobQueueErrorMessage3; Rec.JobQueueErrorMessage3)
                {
                }
                field(jobQueueErrorMessage4; Rec.JobQueueErrorMessage4)
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
