namespace Weibel.Purchases.Subs;

using System.Security.User;
using Microsoft.Purchases.Setup;
using Microsoft.Inventory.Requisition;
using Microsoft.Purchases.Document;
using Microsoft.CRM.Team;

codeunit 70209 "COL Set Purchaser Code Subs."
{
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnBeforeSetPurchaserCode, '', false, false)]
    local procedure "Purchase Header_OnBeforeSetPurchaserCode"(var PurchaseHeader: Record "Purchase Header"; PurchaserCodeToCheck: Code[20]; var PurchaserCodeToAssign: Code[20]; var IsHandled: Boolean)
    begin
        if this.UseUserPurchaserCode() then
            this.SetPurchaserCode(PurchaseHeader, IsHandled);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Requisition Line", OnBeforeSetPurchaserCode, '', false, false)]
    local procedure "Requisition Line_OnBeforeSetPurchaserCode"(var RequisitionLine: Record "Requisition Line"; PurchaserCodeToCheck: Code[20]; var PurchaserCodeToAssign: Code[20]; var IsHandled: Boolean)
    begin
        if this.UseUserPurchaserCode() then
            this.SetPurchaserCode(RequisitionLine, IsHandled);
    end;

    internal procedure SetPurchaserCode(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        PurchaserCodeToCheck, PurchaserCodeToAssign : Code[20];
    begin
        IsHandled := true;
        PurchaserCodeToCheck := this.GetUserSetupPurchaserCode();

        if SalespersonPurchaser.Get(PurchaserCodeToCheck) then begin
            if SalespersonPurchaser.VerifySalesPersonPurchaserPrivacyBlocked(SalespersonPurchaser) then
                PurchaserCodeToAssign := ''
            else
                PurchaserCodeToAssign := PurchaserCodeToCheck;
        end else
            PurchaserCodeToAssign := '';

        PurchaseHeader.Validate("Purchaser Code", PurchaserCodeToAssign);
    end;

    internal procedure SetPurchaserCode(var RequisitionLine: Record "Requisition Line"; var IsHandled: Boolean)
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        PurchaserCodeToCheck, PurchaserCodeToAssign : Code[20];
    begin
        IsHandled := true;
        PurchaserCodeToCheck := this.GetUserSetupPurchaserCode();

        if SalespersonPurchaser.Get(PurchaserCodeToCheck) then begin
            if SalespersonPurchaser.VerifySalesPersonPurchaserPrivacyBlocked(SalespersonPurchaser) then
                PurchaserCodeToAssign := ''
            else
                PurchaserCodeToAssign := PurchaserCodeToCheck;
        end else
            PurchaserCodeToAssign := '';

        RequisitionLine.Validate("Purchaser Code", PurchaserCodeToAssign);
    end;

    local procedure UseUserPurchaserCode(): Boolean
    begin
        this.PurchasesPayablesSetup.GetRecordOnce();
        exit(this.PurchasesPayablesSetup."COL Use User Purchaser Code");
    end;

    local procedure GetUserSetupPurchaserCode(): Code[20]
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.SetLoadFields("Salespers./Purch. Code");
        if not UserSetup.Get(UserId) then
            exit('');

        exit(UserSetup."Salespers./Purch. Code");
    end;
}