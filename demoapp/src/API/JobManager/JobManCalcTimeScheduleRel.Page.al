namespace Weibel.API;

page 70159 "COL JobManCalcTimeScheduleRel."
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'jobManCalcTimeScheduleRelation';
    EntitySetName = 'jobManCalcTimeScheduleRelations';
    PageType = API;
    SourceTable = JobManCalcTimeScheduleRelation;
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(refType; Rec.RefType)
                {
                }
                field(refNumber; Rec.RefNumber)
                {
                }
                field(fromDate; Rec.FromDate)
                {
                }
                field(toDate; Rec.ToDate)
                {
                }
                field(prioritized; Rec.Prioritized)
                {
                }
                field(calcNo; Rec.CalcNo)
                {
                }
                field(timeScheduleNo; Rec.TimeScheduleNo)
                {
                }
                field(shiftNo; Rec.ShiftNo)
                {
                }
                field(absenceScheduleNo; Rec.AbsenceScheduleNo)
                {
                }
                field(absenceShiftNo; Rec.AbsenceShiftNo)
                {
                }
                field(recurringInterval; Rec.RecurringInterval)
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
