namespace Weibel.API;

page 70164 "COL JobManStampHeader"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'jobManStampHeader';
    EntitySetName = 'jobManStampHeaders';
    PageType = API;
    SourceTable = JobManStampHeader;
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
                field(usedCalcNo; Rec.UsedCalcNo)
                {
                }
                field(timeScheduleNo; Rec.TimeScheduleNo)
                {
                }
                field(shiftNo; Rec.ShiftNo)
                {
                }
                field(calculateGroupNo; Rec.CalculateGroupNo)
                {
                }
                field(approveGroupNo; Rec.ApproveGroupNo)
                {
                }
                field(calculateGroupDelegate; Rec.CalculateGroupDelegate)
                {
                }
                field(approveGroupDelegate; Rec.ApproveGroupDelegate)
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
                field(approvedUserID; Rec.ApprovedUserID)
                {
                }
                field(transferredUserID; Rec.TransferredUserID)
                {
                }
                field(openJournal; Rec.OpenJournal)
                {
                }
                field(calculatedErrorTxt; Rec.CalculatedErrorTxt)
                {
                }
                field(dayName; Rec.DayName)
                {
                }
                field(missingPreApprove; Rec.MissingPreApprove)
                {
                }
                field(countJobManStampJournalLine; Rec.CountJobManStampJournalLine)
                {
                }
                field(usedTimeScheduleNo; Rec.UsedTimeScheduleNo)
                {
                }
                field(usedShiftNo; Rec.UsedShiftNo)
                {
                }
                field(usedPrePayAgreeNo; Rec.UsedPrePayAgreeNo)
                {
                }
                field(usedAgreeNo; Rec.UsedAgreeNo)
                {
                }
                field(usedPayGroupNo; Rec.UsedPayGroupNo)
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
