namespace Weibel.API;

page 70160 "COL JobManEmployee"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'jobManEmployee';
    EntitySetName = 'jobManEmployees';
    PageType = API;
    SourceTable = JobManEmployee;
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
                field(activeDELETE; Rec.Active_DELETE)
                {
                }
                field(calcNo; Rec.CalcNo)
                {
                }
                field(alternativeNo; Rec.AlternativeNo)
                {
                }
                field(agreeNo; Rec.AgreeNo)
                {
                }
                field(calculateGroupNo; Rec.CalculateGroupNo)
                {
                }
                field(approveGroupNo; Rec.ApproveGroupNo)
                {
                }
                field(defaultRefType; Rec.DefaultRefType)
                {
                }
                field(preApproveGroupNo; Rec.PreApproveGroupNo)
                {
                }
                field(prePayAgreeNo; Rec.PrePayAgreeNo)
                {
                }
                field(excludeSignInOut; Rec.ExcludeSignInOut)
                {
                }
                field(isMachine; Rec.IsMachine)
                {
                }
                field(seniorityDate; Rec.SeniorityDate)
                {
                }
                field(defaultLocationCode; Rec.DefaultLocationCode)
                {
                }
                field(defaultBinCode; Rec.DefaultBinCode)
                {
                }
                field(password; Rec.Password)
                {
                }
                field(employeeUserID; Rec.EmployeeUserID)
                {
                }
                field(filterOption; Rec.FilterOption)
                {
                }
                field(filterResourceNo; Rec.FilterResourceNo)
                {
                }
                field(filterResourceGroupNo; Rec.FilterResourceGroupNo)
                {
                }
                field(filterMachineCenterNo; Rec.FilterMachineCenterNo)
                {
                }
                field(filterWorkCenterNo; Rec.FilterWorkCenterNo)
                {
                }
                field(filterActivityNo; Rec.FilterActivityNo)
                {
                }
                field(filterCategoryNo; Rec.FilterCategoryNo)
                {
                }
                field(filterAddon; Rec.FilterAddon)
                {
                }
                field(filterWorkType; Rec.FilterWorkType)
                {
                }
                field(defaultPayTypeNo; Rec.DefaultPayTypeNo)
                {
                }
                field(systemKey; Rec.SystemKey)
                {
                }
                field(firstName; Rec.FirstName)
                {
                }
                field(middleName; Rec.MiddleName)
                {
                }
                field(lastName; Rec.LastName)
                {
                }
                field(globalDimension1Code; Rec.GlobalDimension1Code)
                {
                }
                field(globalDimension2Code; Rec.GlobalDimension2Code)
                {
                }
                field(identifierCount; Rec.IdentifierCount)
                {
                }
                field(units; Rec.Units)
                {
                }
                field(twoFactorCode; Rec.TwoFactorCode)
                {
                }
                field(twoFactorTimestamp; Rec.TwoFactorTimestamp)
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
