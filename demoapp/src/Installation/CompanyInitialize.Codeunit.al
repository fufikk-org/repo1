namespace Weibel.Foundation.Company;

using Microsoft.Foundation.Company;
using Weibel.AppManagement;

codeunit 70162 "COL Company Initialize"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Company-Initialize", OnCompanyInitialize, '', false, false)]
    local procedure "Company-Initialize_OnCompanyInitialize"()
    var
        InstallApp: Codeunit "COL Install App";
    begin
        InstallApp.PopulateAllowedFieldsForProductionOrders();
    end;

}