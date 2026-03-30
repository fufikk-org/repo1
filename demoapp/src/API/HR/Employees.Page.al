namespace Weibel.API;

using Microsoft.HumanResources.Employee;

page 70157 "COL Employees"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'employee';
    EntitySetName = 'employees';
    PageType = API;
    SourceTable = Employee;
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                }
                field(firstName; Rec."First Name")
                {
                }
                field(middleName; Rec."Middle Name")
                {
                }
                field(lastName; Rec."Last Name")
                {
                }
                field(initials; Rec.Initials)
                {
                }
                field(jobTitle; Rec."Job Title")
                {
                }
                field(searchName; Rec."Search Name")
                {
                }
                field(address; Rec.Address)
                {
                }
                field(address2; Rec."Address 2")
                {
                }
                field(city; Rec.City)
                {
                }
                field(postCode; Rec."Post Code")
                {
                }
                field(county; Rec.County)
                {
                }
                field(phoneNo; Rec."Phone No.")
                {
                }
                field(mobilePhoneNo; Rec."Mobile Phone No.")
                {
                }
                field(eMail; Rec."E-Mail")
                {
                }
                field(altAddressCode; Rec."Alt. Address Code")
                {
                }
                field(altAddressStartDate; Rec."Alt. Address Start Date")
                {
                }
                field(altAddressEndDate; Rec."Alt. Address End Date")
                {
                }
                field(birthDate; Rec."Birth Date")
                {
                }
                field(socialSecurityNo; Rec."Social Security No.")
                {
                }
                field(unionCode; Rec."Union Code")
                {
                }
                field(unionMembershipNo; Rec."Union Membership No.")
                {
                }
                field(gender; Rec.Gender)
                {
                }
                field(countryRegionCode; Rec."Country/Region Code")
                {
                }
                field(managerNo; Rec."Manager No.")
                {
                }
                field(emplymtContractCode; Rec."Emplymt. Contract Code")
                {
                }
                field(statisticsGroupCode; Rec."Statistics Group Code")
                {
                }
                field(employmentDate; Rec."Employment Date")
                {
                }
                field(status; Rec.Status)
                {
                }
                field(inactiveDate; Rec."Inactive Date")
                {
                }
                field(causeOfInactivityCode; Rec."Cause of Inactivity Code")
                {
                }
                field(terminationDate; Rec."Termination Date")
                {
                }
                field(groundsForTermCode; Rec."Grounds for Term. Code")
                {
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                }
                field(resourceNo; Rec."Resource No.")
                {
                }
                field(comment; Rec.Comment)
                {
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                }
                field(totalAbsenceBase; Rec."Total Absence (Base)")
                {
                }
                field(extension; Rec.Extension)
                {
                }
                field(pager; Rec.Pager)
                {
                }
                field(faxNo; Rec."Fax No.")
                {
                }
                field(companyEMail; Rec."Company E-Mail")
                {
                }
                field(title; Rec.Title)
                {
                }
                field(salespersPurchCode; Rec."Salespers./Purch. Code")
                {
                }
                field(noSeries; Rec."No. Series")
                {
                }
                field(lastModifiedDateTime; Rec."Last Modified Date Time")
                {
                }
                field(employeePostingGroup; Rec."Employee Posting Group")
                {
                }
                field(bankBranchNo; Rec."Bank Branch No.")
                {
                }
                field(bankAccountNo; Rec."Bank Account No.")
                {
                }
                field(iban; Rec.IBAN)
                {
                }
                field(balance; Rec.Balance)
                {
                }
                field(swiftCode; Rec."SWIFT Code")
                {
                }
                field(balanceLCY; Rec."Balance (LCY)")
                {
                }
                field(currencyCode; Rec."Currency Code")
                {
                }
                field(applicationMethod; Rec."Application Method")
                {
                }
                field(image; Rec.Image)
                {
                }
                field(privacyBlocked; Rec."Privacy Blocked")
                {
                }
                field(costCenterCode; Rec."Cost Center Code")
                {
                }
                field(costObjectCode; Rec."Cost Object Code")
                {
                }
                field(vatBusPostingGroupPGS; Rec."VAT Bus. Posting Group PGS")
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
